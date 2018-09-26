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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73424C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2003321480
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bC1oH21W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2003321480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbeIZNKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 09:10:40 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40047 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbeIZNKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 09:10:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id o2-v6so981021wmh.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 23:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gO1L9Q5EdZ9lNjjFJCocW+/Tkb4YoxOOpZRu7ag5huc=;
        b=bC1oH21WCiYOI8uMNwuZWbb/i0G+W167+dklfi3SCTSFRy3KgYrurB+8NdILFUJNxN
         jDleUktaK+rHPSWphP095X9TkrOIyb/4IU4PFD35yk8S51yJsgSUByYF5JzqM41GU0af
         XzBcY0HJAgAcz8YrzYqX6MOcuuWkLCkM2+yCIMpqHfoORM6P7D/7dUX2X9kDDO/y32QH
         fvybU3mF4Y4II4JTLxwSDRwDekHNDiktDyxsqKF1W71u4/xtzFUR7Dc7NcjIVO8zc73N
         w6wJo6AuFReUfIaW5gVOgEWS9E9adgjRVNuloR532SQy31CfqJ9RR+eqAnvjRSIP2LCH
         3+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gO1L9Q5EdZ9lNjjFJCocW+/Tkb4YoxOOpZRu7ag5huc=;
        b=rJ8JmmWbaTNOJbJGXNF3pMMmCUmTfa1N7JAI1xQSv27kQ62n/Z5plJJvjkpXLBL2r3
         r8kUMYqEuSyScy0jOxhyx5WkwuzmuBbb8Fm32Rp/bizuinrEIisPqZkkS4mGbwp/Idse
         ZK0DFWhkPZ51kQWTqBNF5S7tmJS2y8oDHLfmuoe8yoatCXSgi0EXyrHQJdvaVg3vvS00
         eniPbOY1bXxtDesE2XnYC81hYxhIrmQtTJQdpB58s2Z9nfOGbkZbxUYHv3q7KmufAAbE
         bEdwPyhKdqqEr/huZHsnpk3LOfiFbuINyWmjQU4pJWNkC3cCGsdAvRjq9N17EtTDqpTA
         LIcQ==
X-Gm-Message-State: ABuFfojJDJwZ6DLykbmDi1UHftevsc5r5kwk6a7LPEgInLiQMhJPK50M
        2OWBK5KZ8LSGP+SyVLAWpx09YwaDadhGUg==
X-Google-Smtp-Source: ACcGV62P6IVKdXyoCvrNjuh7QULaGLrcmna8/spgQvAZl3as25m1seyLBaZnkXd4gxUCVjrf93uRnA==
X-Received: by 2002:a1c:b157:: with SMTP id a84-v6mr3092488wmf.18.1537945151667;
        Tue, 25 Sep 2018 23:59:11 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id s2-v6sm9132960wrn.83.2018.09.25.23.59.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 23:59:11 -0700 (PDT)
Date:   Tue, 25 Sep 2018 23:59:09 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Remove ACPI table declaration
Message-ID: <20180926065909.GA16012@flashbox>
References: <20180926053910.26833-1-natechancellor@gmail.com>
 <20180926062245.GA5937@kroah.com>
 <20180926064437.GA29417@flashbox>
 <20180926064915.GA20241@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926064915.GA20241@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 08:49:15AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Sep 25, 2018 at 11:44:37PM -0700, Nathan Chancellor wrote:
> > On Wed, Sep 26, 2018 at 08:22:45AM +0200, Greg Kroah-Hartman wrote:
> > > On Tue, Sep 25, 2018 at 10:39:10PM -0700, Nathan Chancellor wrote:
> > > > Clang warns that the acpi_id declaration is not going to be emitted
> > > > in the final assembly:
> > > > 
> > > > drivers/staging/rtl8723bs/os_dep/sdio_intf.c:25:36: warning: variable
> > > > 'acpi_ids' is not needed and will not be emitted
> > > > [-Wunneeded-internal-declaration]
> > > > static const struct acpi_device_id acpi_ids[] = {
> > > >                                    ^
> > > > 1 warning generated.
> > > > 
> > > > This is because it's marked as static const and it is not used anywhere
> > > > in this file. Doing a git grep on this driver for 'acpi' shows that this
> > > > declaration has been unused since the driver's initial induction. Remove
> > > > it since it's not doing anything.
> > > > 
> > > > Link: https://github.com/ClangBuiltLinux/linux/issues/169
> > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > > ---
> > > >  drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 6 ------
> > > >  1 file changed, 6 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> > > > index 6d02904de63f..d473f9bd08c3 100644
> > > > --- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> > > > +++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> > > > @@ -22,13 +22,7 @@ static const struct sdio_device_id sdio_ids[] =
> > > >  	{ SDIO_DEVICE(0x024c, 0xb723), },
> > > >  	{ /* end: all zeroes */				},
> > > >  };
> > > > -static const struct acpi_device_id acpi_ids[] = {
> > > > -	{"OBDA8723", 0x0000},
> > > > -	{}
> > > > -};
> > > > -
> > > >  MODULE_DEVICE_TABLE(sdio, sdio_ids);
> > > > -MODULE_DEVICE_TABLE(acpi, acpi_ids);
> > > 
> > > You just removed the ability for the driver to be automatically loaded
> > > if that acpi id is present.
> > > 
> > 
> > I am not sure I understand. Every instance of acpi_device_id that I
> > looked at in the kernel before sending this patch uses MODULE_DEVICE_TABLE
> > but then that acpi_device_id declaration is always used in the driver
> > definition either under the acpi_match_table member or ids member
> > depending on what type of driver it is. Should this one do that as well?
> 
> I don't know, but it's not always necessary.
> 
> > Is that even possible with an sdio driver? I apologize if I am not
> > making sense, I'm not super familiar with these interfaces.
> > 
> > I also read 'Documentation/acpi/enumeration.txt' which makes it seem
> > like the declaration needs to be added to the device definition as well.
> 
> If it is a real acpi driver, yes, you need to actually register it with
> the acpi core.
> 
> But, if it is just using the auto-load functionality of "if this acpi
> string is found, load the module!" then the code is correct as-is.
> 
> Yeah, it's a hack, but does work and helps out for auto-loading drivers
> for "odd" hardware that is not always self-describing.
> 
> thanks,
> 
> greg k-h

Thank you for the explanation, I appreciate that and I'll keep it in
mind should I run across this kind of warning in the future. I'll send a
v2 now that silences this warning through the '__maybe_unused' attribute
like a few other commits that deal with this warning.

Nathan
