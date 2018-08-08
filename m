Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7C1C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4EF721A32
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="x7uAGFLv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4EF721A32
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbeHHTMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:12:37 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:35411 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbeHHTMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:12:37 -0400
Received: by mail-it0-f66.google.com with SMTP id 139-v6so4493959itf.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 09:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wO9b7oopa7y5h5ev1Fonk/EaaEw5uVfOuvyXm5rH2HM=;
        b=x7uAGFLvUx+G3XyYBPAYexaS1Gx9XA4XZYCgxe9D6MnWPeeMw0/r/jMZ5VwDpjDi7w
         +gG8/VS3Z8kLK0Dx+TRoFOcqEgucRqmNnEAnICRtAYrDdret78s/PkMQluo/JgLXnr5k
         Fs6vMC+uuYQ0r9vj8D4q77xIhc6Ku2BZzxpWq8kdFwsjtJZRCjq9eXIwUrLO0Y5EmQ1u
         EMH1W0ag+cor6nzHcMQii/racbvHO+fR1nr7TFXGgux5KJm1FgCa/oXEJBGFvc26xnYZ
         P4p4NW+52/2yx3U9BO2ZUiRJ0Aetk61G4eXYTjyryhspJBKI0frIR6qZcP3gk+irh/xp
         WApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wO9b7oopa7y5h5ev1Fonk/EaaEw5uVfOuvyXm5rH2HM=;
        b=I5Fng6hx9cE9EX5ImT4oPpTmR5SjCXtBCXSkiykYhN7hRmKBleMRGhcgC36vMJXh8y
         wXzoLMCTRbu6eruguNlwyxp6+6255wurKcvf+ZwZPfHqOkByKUR+jmcbecri+5BqVhnY
         zDlDmUSWUSay79XXOsVr5M9OSSqnWjRO9NRNAPDuM0Tlos8crxvSYOlUEzUjoCW2Dewr
         lwNk/DIcs7dHV1p/tCmwVcCes30RlyweHu9+aoFcbN3wrcqy4Ok5DCMbgeYI76fvFeP1
         T+gAP6ndE+lfK6M3VwkOtNdK4viFbjUeyU/AVrw/+aKRaKOFD2gVX9EfBtxBAHdmaH03
         zx3A==
X-Gm-Message-State: AOUpUlHvqu/eT2lxJmTYm691SBielMWRT1BuwVFWRK5ijudF1lVBsPbL
        Sp8TT1k6UzhwEDQxUNJFSujEIEv0BPg1qg6Phnj21A==
X-Google-Smtp-Source: AA+uWPyaUdcvwYHlFj2Y7hgkQZwm1cE/2VK3Kj8+WAztDzHYzHc0kJUfkHLHnen5qubcxojJzaCE7mitDt4sDj7dLeY=
X-Received: by 2002:a24:e48c:: with SMTP id o134-v6mr2982849ith.125.1533747124850;
 Wed, 08 Aug 2018 09:52:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5e:9403:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 09:52:04 -0700 (PDT)
In-Reply-To: <20180808164402.GH7275@lunn.ch>
References: <20180808153150.23444-1-brgl@bgdev.pl> <20180808155548.s7p4xqsjywz3psrj@ninjato>
 <CAMpxmJXVNiyqF4qaYtNhPUG3mSZVdvBSGUqDYK-nh59BKeh=Gw@mail.gmail.com> <20180808164402.GH7275@lunn.ch>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 8 Aug 2018 18:52:04 +0200
Message-ID: <CAMRc=McfSZQvdXgrKDagb_TE1g-WzEhSpst1z_o5Z994cv3MjA@mail.gmail.com>
Subject: Re: [PATCH 00/28] at24: remove at24_platform_data
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Naren <naren.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Sven Van Asbroeck <svendev@arcx.com>,
        Paolo Abeni <pabeni@redhat.com>, Alban Bedel <albeu@free.fr>,
        Rob Herring <robh@kernel.org>,
        David Lechner <david@lechnology.com>,
        linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        linux-mtd@lists.infradead.org,
        Linux-OMAP <linux-omap@vger.kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-08 18:44 GMT+02:00 Andrew Lunn <andrew@lunn.ch>:
> On Wed, Aug 08, 2018 at 06:27:25PM +0200, Bartosz Golaszewski wrote:
>> 2018-08-08 17:55 GMT+02:00 Wolfram Sang <wsa@the-dreams.de>:
>> > On Wed, Aug 08, 2018 at 05:31:22PM +0200, Bartosz Golaszewski wrote:
>> >> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> >>
>> >> This is a follow-up to the previously rejected series[1] which partially
>> >> removed the at24_platform_data structure. After further development and
>> >> taking reviews into account, this series finally removes that struct
>> >> completely but not without touching many different parts of the code
>> >> base.
>> >>
>> >> Since I took over maintainership of the at24 driver I've been working
>> >> towards removing at24_platform_data in favor for device properties.
>> >
>> > Wooha, nice work. I can't really comment on it but wondered how you want
>> > to upstream it (after reviews)? Pull request of an immutable branch for
>> > nvmem-tree sounds best to me. Then I could also pull it in if i2c needs
>> > it. Probably same situation for arm-soc...
>> >
>>
>> I initially wanted to merge small parts of it starting with v4.18, but
>> there were some voices against merging APIs without users. I'm not
>> sure how it should go in. There'll be a need for multiple immutable
>> branches most probably...
>
> Hi Bartosz
>
> What this series does is show all the different parts are now
> available, and can be reviewed as a whole. Once that review is
> completed, merging in parts then becomes possible.
>
> It looks like you could probably merge the nvmem, mtd and net parts
> independently via there maintainers for 4.20, since i don't think
> there are any dependencies. The arm-soc changes in 4.21, and the
> removal of the platform data in 4.22?
>
>      Andrew

We need the first batch of SoC changes for the net part and then the
second batch depends on those net changes. Also: dragging the merge
for this over a year is a bit overkill.

Sekhar: I know you're usually provided with immutable branches from
framework maintainers for the SoC changes - is it ok for you to
provide the net maintainers with an immutable branch after applying
the first part of davinci board file changes?

Bart
