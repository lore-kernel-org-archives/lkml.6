Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78767C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3343B26B84
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="QJ4u+Aww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3343B26B84
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965598AbeFZNiR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 09:38:17 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:44846 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935412AbeFZNiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 09:38:15 -0400
Received: by mail-io0-f174.google.com with SMTP id g7-v6so15972475ioh.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 06:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oSsjhn6c5Q30e97BzO+OVKHHym1Ua66criidToCG5m0=;
        b=QJ4u+Awwue+DqX/WWDF9TOJlwyM2aWqVpUjNat2+k+ijC/+VHekZrW5TmaaOVGD9J1
         q+cfACNmVx7k47x4uU+/LilqZFY5GMVBfYRsSxj2z7PmD7o3aelvNCbPyuWsDaEn1fkI
         o42y0fPIxO56mi8pSwleoDGUDSghOuqsET4PKDLcCR64o/GMCWW5o02Ix2Vcq2jEgmxu
         aY6/Bq4HLOHX/mz5CCvsGPkFLmUfEHxgXTKEv4GnwhtpCws0aM6QBHYOi1mzJ1iVKs8i
         SVwtM0Nw0l/3kYV5nlxjcBjTffpmvrqm0QcyV90XWuQPNPpBVjJjzfE9E6B2RH5kvhhX
         tBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oSsjhn6c5Q30e97BzO+OVKHHym1Ua66criidToCG5m0=;
        b=uhCjBJX4mFAdpwepryariu/aA8J03EGSir2GRR0AvxevLtPD9xvAXi4pjFDv/iE7Su
         zxXJRARct3/3eJeb24YZBnJo6kFVCsn1EcDtuxZ0G+0tk2GiwZb2pubqP+JQ6MHROV0i
         Vvw6Hbjm433c36XgTQKsY0gqVk0zrU/2CbL9+0/5qHkO2ZavPReIybsoGCTqR96J1KHf
         MFZAXx1ORV+kpyy/fDehZMiVMatAsi9pLCGG0O3/hoJ0k4XEF5ze6l/MKO7VL8xZEsVK
         Q1TlVwBJB5Mvys7qK20Gg/xqSVWj/2J1n1Zdpkv89M7PJQAlxnk5P29pwhkEPbAfDoHV
         C6qQ==
X-Gm-Message-State: APt69E01SmxqW6W5ifruSxtS/LIp2DKO5aO6kXVfjkQP8GiSmKeTF6Rt
        U4Q9hJu4ZJTrUNo2kQUOyDdaS6ViLe7+3ZK4KYZuFA==
X-Google-Smtp-Source: AAOMgpfUgUv75OGh1deWyuvkT7cTC+fUPvn8w+3PQpR/rMCi1TorHdMvvkDnPz+6/+rdKR1Ro1NZvxynLooH+wasWWk=
X-Received: by 2002:a6b:6515:: with SMTP id z21-v6mr1243894iob.258.1530020295143;
 Tue, 26 Jun 2018 06:38:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:9c51:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 06:38:14
 -0700 (PDT)
In-Reply-To: <20180626132154.GA5064@lunn.ch>
References: <20180625155025.12567-1-brgl@bgdev.pl> <20180625174024.GB17417@lunn.ch>
 <CAMRc=MdEn74G5SJAaGLAfNSS7Zy7wqH04aN5CMZ45UXqhu_58g@mail.gmail.com>
 <20180625180237.GC17417@lunn.ch> <CAMRc=MejDn=t6EPbKOfhMfRAb_O-5hxtWRyjAWH1mb5BUySrDA@mail.gmail.com>
 <20180626083823.GA28068@lunn.ch> <CAMRc=Mdvh+1enpD3qDoamhPfaBPin2v3amneQELApgoC0bS2FQ@mail.gmail.com>
 <20180626132154.GA5064@lunn.ch>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 26 Jun 2018 15:38:14 +0200
Message-ID: <CAMRc=McCk6fz5x5vJmjYkYx-i6XfGPAZPm9ctg2fuCCfkvKpLQ@mail.gmail.com>
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

2018-06-26 15:21 GMT+02:00 Andrew Lunn <andrew@lunn.ch>:
>> I see. I see it this way: the setup callback comes from the time when
>> we didn't have nvmem and should go away. I will protest loud whenever
>> someone will try to use it again and will work towards removing it as
>> soon as possible.
>
> The setup() callback could be moved into the nvmem framework, rather
> than in the at24 driver. Make the call when the cells have been
> connected to the backing store.
>

This would at least make it more generic. And maybe I could also get
rid of the setup callback from the mityomapl138 board file.

Bart

>> I will give your problem a thought and will try to get back with some
>> proposals - maybe we should, as you suggested, extend nvmem even
>> further to allow to remove nvmem info entries etc.
>
> That does not help me too much. I have the same problem with i2c and
> MDIO. So i actually prefer to keep this the same as all others.
>
>         Andrew
