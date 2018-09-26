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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DB3C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC972089D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbBLSLQj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC972089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbeIZNwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 09:52:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50222 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeIZNwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 09:52:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id s12-v6so1133247wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 00:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MR76ju5ntvPzM9tyloYEqcTpzy2ZBhLG0E9zKjzUrsw=;
        b=TbBLSLQj8k/J6HfFQ93vMd+qP3vTtZOiXwo6ERXEjBZX6c0XY+Ji+78YoU+SZZt6I8
         dLfTi0CHomDKXS5OUv+9/qUaDnBxw4O45lZMhv56QMh2FgQiY+j9lgoPJaGXscApplcy
         rlS3PN5+9uB51/+YPPXOjUwsyuyYh7t9mZtmdKjJgJQJjjpY0yS6cjQDIp/YVDO6MKCO
         GCg3aKLjy4yAc/AotzAUQ/9Y9AEhJHvJubeN6L1DibdNqE4vxUIOotkhKLRdqPNDQrKi
         VEj/BxxThNb7K3wt52v9JS50TwN8CZFgCbL4lAxpKXCf8xeeMnv/vtAbBaFsViv0V+zm
         pzGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MR76ju5ntvPzM9tyloYEqcTpzy2ZBhLG0E9zKjzUrsw=;
        b=BxSBcc4WDNXcoQsrAAXzaOTrXMTGWKtF1E46QeGW/yCaAVJc/9MiA/eMgTHxE3Qe04
         jDYBe2+YVn3hsPPk5nek6mXtU0W6tVzMJ7lVr5hDd/enpJbqIbHNmaXsk3FbDDNM892L
         aefzm7capjW1JJKqfWzF8EedihB1bs/TJZy4VHWQyuyD8X7NOQI6yFYT0UgWXaQI+GTk
         iOSdRe7fHCO5U+KSsMwRc8ardWen5RUOT6A2yJhvT+DgyFxHFctzBh5VC44S7THSYdC7
         6ZEsjCpo9AWr//KK9g96b3JqEJnhjZEumC4t5QeW41aNK0K/8IaXCSTXkuV+Hri175kB
         QKlg==
X-Gm-Message-State: ABuFfogbMT5f6ChR5DZ1ZqbDQBByBYzVLQv5TbTCBPqe/F3aG3QZ0pe9
        60dt/MuyG9KKuCrE9RYQzRM=
X-Google-Smtp-Source: ACcGV61+1AgNPiDxE0ZVQR+rcPpTX5BO+7isKuapriAKOQDUrbtTT+GlfOTVNW+48TUbhlOILEsUVA==
X-Received: by 2002:a1c:c708:: with SMTP id x8-v6mr3241070wmf.146.1537947676093;
        Wed, 26 Sep 2018 00:41:16 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id c12-v6sm4659346wrr.6.2018.09.26.00.41.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 00:41:15 -0700 (PDT)
Date:   Wed, 26 Sep 2018 00:41:14 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] staging: rtl8723bs: Mark ACPI table declaration as maybe
 unused
Message-ID: <20180926074114.GA4966@flashbox>
References: <20180926070208.16924-1-natechancellor@gmail.com>
 <20180926071359.GA22855@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926071359.GA22855@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 09:13:59AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Sep 26, 2018 at 12:02:09AM -0700, Nathan Chancellor wrote:
> > Clang emits the following warning:
> > 
> > drivers/staging/rtl8723bs/os_dep/sdio_intf.c:25:36: warning: variable
> > 'acpi_ids' is not needed and will not be emitted
> > [-Wunneeded-internal-declaration]
> > static const struct acpi_device_id acpi_ids[] = {
> >                                    ^
> > 1 warning generated.
> > 
> > Mark the declaration as maybe unused like a few other instances of this
> > construct in the kernel.
> > 
> > Link: https://github.com/ClangBuiltLinux/linux/issues/169
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> > index 6d02904de63f..3285bf36291b 100644
> > --- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> > +++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> > @@ -22,7 +22,7 @@ static const struct sdio_device_id sdio_ids[] =
> >  	{ SDIO_DEVICE(0x024c, 0xb723), },
> >  	{ /* end: all zeroes */				},
> >  };
> > -static const struct acpi_device_id acpi_ids[] = {
> > +static const struct acpi_device_id acpi_ids[] __maybe_unused = {
> 
> But it is used.  No "maybe" at all here.  The MODULE_DEVICE_TABLE()
> macro does a functional thing.  Why is gcc not reporting an issue with
> this and clang is?
> 
> thanks,
> 
> greg k-h

I am not entirely sure, I've added Nick to this thread to see what he
thinks. I'm by no means a Clang expert at the moment.

Thanks,
Nathan
