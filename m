Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B23BC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF8A3265B0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ZiMVL9f3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF8A3265B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934122AbeF0Jkq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 05:40:46 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:32901 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753019AbeF0Jko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 05:40:44 -0400
Received: by mail-io0-f180.google.com with SMTP id d185-v6so1293680ioe.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 02:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eaae1S+R8Irv2buEoT0okognkVfjMoGB3sAppOST060=;
        b=ZiMVL9f34OblolcH56KRDgv4IPZZVkW9gDCGPreP/raJbhC6GhL+c5tRb/ALSTJAxf
         tGvVXd3mUxswXigvzYn8+xKP0oDLwsTzLNfVJwsMC/d7+2d6WiVB5jU966dq296knJDo
         RsNF3+YBK8fhgqWnbiBno+Aa4SdLXJ/eQV+q4/5PsvIhweqVqxT8Pey2ikuciw8KpwKs
         8YuEh4CV4rrb2MCITiKWFEoUR1yC2t2bWGMGCQ6bHFiHOgrmzahYFsx9b9b/CsdehNW9
         PqPgUcY3YT+cBEJZJ+CBpTBntuGwhchrXDawMiOxETxGrcLGwx/FT+6d7yHoyNElB660
         n3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eaae1S+R8Irv2buEoT0okognkVfjMoGB3sAppOST060=;
        b=j9InTuLbJUyOxRTCtJN5iDyCvFEF7gt50SQ4J1VZslzyaQLb2Cw5tq3bdNIfP7Aphx
         PMfIVCrzNrnxS91mSRsJEPO9n/Z62Z10iwBU2/CTjRRTJ44wRN/Si/xg1PmHJy449WOi
         tRbIjqaZG6nRLwbQu37dNi7aDk3AwhJDtms6UjiXArzeqBSs8hVw22uZg+LNk+fC8BsJ
         ceUIeTlQ9VPZIkaOZniNRy0z2AAe68HtmmBttzoRdGPjFr7BHFCrmtTZnt13TWuAR0Dz
         wI4gZaic8YWGTZN/THWie8r/I8ltUa4+8C+slMYW7rvPSV5PfpqE5egTxEAba6PxADjI
         2Ung==
X-Gm-Message-State: APt69E0gVwGMvBhEU/6GmeRl192OTTfXF17TMs9HpfqeofemXoJQehO+
        N+FmDb2Lk3LJW7GdksotsxiKs0b7xZvilIycOD3nfQ==
X-Google-Smtp-Source: AAOMgpdCEEU/zL1hhIRQ76bwCb+vfV2p3DBPciJQwHKODhr0Th3/BYlOOpdQrrqKVPYK2zfrHZYu4bbCUk4W17Ht8wI=
X-Received: by 2002:a6b:6403:: with SMTP id t3-v6mr4433664iog.111.1530092443315;
 Wed, 27 Jun 2018 02:40:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:9c51:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 02:40:42
 -0700 (PDT)
In-Reply-To: <CAMRc=McCk6fz5x5vJmjYkYx-i6XfGPAZPm9ctg2fuCCfkvKpLQ@mail.gmail.com>
References: <20180625155025.12567-1-brgl@bgdev.pl> <20180625174024.GB17417@lunn.ch>
 <CAMRc=MdEn74G5SJAaGLAfNSS7Zy7wqH04aN5CMZ45UXqhu_58g@mail.gmail.com>
 <20180625180237.GC17417@lunn.ch> <CAMRc=MejDn=t6EPbKOfhMfRAb_O-5hxtWRyjAWH1mb5BUySrDA@mail.gmail.com>
 <20180626083823.GA28068@lunn.ch> <CAMRc=Mdvh+1enpD3qDoamhPfaBPin2v3amneQELApgoC0bS2FQ@mail.gmail.com>
 <20180626132154.GA5064@lunn.ch> <CAMRc=McCk6fz5x5vJmjYkYx-i6XfGPAZPm9ctg2fuCCfkvKpLQ@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 27 Jun 2018 11:40:42 +0200
Message-ID: <CAMRc=MfWDiUsqpA0RcjYQ0QyfyfYBzSBUD45-rXbxebO-SV6GQ@mail.gmail.com>
Subject: Re: [PATCH 00/14] ARM: davinci: step towards removing at24_platform_data
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-26 15:38 GMT+02:00 Bartosz Golaszewski <brgl@bgdev.pl>:
> 2018-06-26 15:21 GMT+02:00 Andrew Lunn <andrew@lunn.ch>:
>>> I see. I see it this way: the setup callback comes from the time when
>>> we didn't have nvmem and should go away. I will protest loud whenever
>>> someone will try to use it again and will work towards removing it as
>>> soon as possible.
>>
>> The setup() callback could be moved into the nvmem framework, rather
>> than in the at24 driver. Make the call when the cells have been
>> connected to the backing store.
>>
>
> This would at least make it more generic. And maybe I could also get
> rid of the setup callback from the mityomapl138 board file.
>
> Bart
>
>>> I will give your problem a thought and will try to get back with some
>>> proposals - maybe we should, as you suggested, extend nvmem even
>>> further to allow to remove nvmem info entries etc.
>>
>> That does not help me too much. I have the same problem with i2c and
>> MDIO. So i actually prefer to keep this the same as all others.
>>
>>         Andrew

Hi Andrew,

MTD subsystem has the struct mtd_notifier and register_mtd_user(). I'm
wondering if we could implement something like this as a generic nvmem
functionality.

What do you think?

Bart
