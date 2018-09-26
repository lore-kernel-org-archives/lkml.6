Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3150CC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A21208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lb9Ok+XP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A21208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbeIZM4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 08:56:05 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35915 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbeIZM4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 08:56:05 -0400
Received: by mail-wm1-f68.google.com with SMTP id y13-v6so956710wmi.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 23:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xzSl8jcWZXXE7IWJy19WIPqNWECta9PYHniM6A+wiK0=;
        b=lb9Ok+XPk6YMAfh8HMBFSlrO1aPuZI2LlCOf6c9Ie/XjQKTX/oBhW99UqXTPgzSvWu
         kbYQG45k61URnbq4UYClqxU+hUuym3RRanQgY+1sSYEfLH2cIfD+cC1jX3KHplKAUxng
         QPNXuM1OgAbUMwyFR8N1uVT4naR2f4HXbylQWi2TO7EqlOdJOHCROZV6xHPWIclqqzwZ
         Hn3AUELea9pYMxSSRyOqqg6kAfkhmJsA2NyjcLu5zmFoM5sJtX9kcoqvAiL7Fo6DOpLd
         RXC4v2N35iXaF3BcDpmoe3d0stPH66EQlhoPJAC2Z9kYF6JL5Gn3kSgBehmft6z4FUxq
         cwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xzSl8jcWZXXE7IWJy19WIPqNWECta9PYHniM6A+wiK0=;
        b=cLQrSXP+lQ7jY4Wj4rkGkrMjdJrVJnwqsGAonW7HcAOhtImQSOg+D9/7ddHw/aLmt3
         8TBf7Lk4/roIrMc8BEk2Au3AXEbklUmopkcjD3fQfHvzWz/GthlTL4RI5jEZpL31kKgz
         NTUyeCZr0SEZuwo7ZKwW638LJrwco4XHjCWZzA9eR143hVEjnEOf/JrfvNNpg4sT5pow
         I2to+RW1EXL6624gwwIOAoaAzPjLvdO4aLvkBUaGbyXc4IsrLPhyGSL0MC2EEsvIXrd2
         PiUAsIrgS1l4IHv2ma46pLiX9WKCoyA+u7hAILBAamQHtk4B6JoQvAji0XhZ9Jn3Au33
         ZfJQ==
X-Gm-Message-State: ABuFfohnpiHgBwTBSuDJizCZu7CfhjYW4cYyTEagRDlF5ZID8WC9GEie
        E+7EWbOkDxA/pwz92ltJKI0=
X-Google-Smtp-Source: ACcGV60NnDl76anuxbsb0nD+wxFTOmmBTJl3gxuIzUh6YQ2ld5sYESQwGxyr5bTf590ATGDHqiRlDA==
X-Received: by 2002:a1c:dc45:: with SMTP id t66-v6mr3012340wmg.148.1537944279694;
        Tue, 25 Sep 2018 23:44:39 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id g2-v6sm3479818wmh.16.2018.09.25.23.44.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 23:44:39 -0700 (PDT)
Date:   Tue, 25 Sep 2018 23:44:37 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Remove ACPI table declaration
Message-ID: <20180926064437.GA29417@flashbox>
References: <20180926053910.26833-1-natechancellor@gmail.com>
 <20180926062245.GA5937@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926062245.GA5937@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 08:22:45AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Sep 25, 2018 at 10:39:10PM -0700, Nathan Chancellor wrote:
> > Clang warns that the acpi_id declaration is not going to be emitted
> > in the final assembly:
> > 
> > drivers/staging/rtl8723bs/os_dep/sdio_intf.c:25:36: warning: variable
> > 'acpi_ids' is not needed and will not be emitted
> > [-Wunneeded-internal-declaration]
> > static const struct acpi_device_id acpi_ids[] = {
> >                                    ^
> > 1 warning generated.
> > 
> > This is because it's marked as static const and it is not used anywhere
> > in this file. Doing a git grep on this driver for 'acpi' shows that this
> > declaration has been unused since the driver's initial induction. Remove
> > it since it's not doing anything.
> > 
> > Link: https://github.com/ClangBuiltLinux/linux/issues/169
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 6 ------
> >  1 file changed, 6 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> > index 6d02904de63f..d473f9bd08c3 100644
> > --- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> > +++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> > @@ -22,13 +22,7 @@ static const struct sdio_device_id sdio_ids[] =
> >  	{ SDIO_DEVICE(0x024c, 0xb723), },
> >  	{ /* end: all zeroes */				},
> >  };
> > -static const struct acpi_device_id acpi_ids[] = {
> > -	{"OBDA8723", 0x0000},
> > -	{}
> > -};
> > -
> >  MODULE_DEVICE_TABLE(sdio, sdio_ids);
> > -MODULE_DEVICE_TABLE(acpi, acpi_ids);
> 
> You just removed the ability for the driver to be automatically loaded
> if that acpi id is present.
> 

I am not sure I understand. Every instance of acpi_device_id that I
looked at in the kernel before sending this patch uses MODULE_DEVICE_TABLE
but then that acpi_device_id declaration is always used in the driver
definition either under the acpi_match_table member or ids member
depending on what type of driver it is. Should this one do that as well?
Is that even possible with an sdio driver? I apologize if I am not
making sense, I'm not super familiar with these interfaces.

I also read 'Documentation/acpi/enumeration.txt' which makes it seem
like the declaration needs to be added to the device definition as well.

> Not good :(
> 
> I think you need to fix up your scripts, this is valid code...
> 

No scripts here, just a human interpreting warnings manually.

> greg k-h

Thanks for the review,
Nathan
