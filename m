Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487A2C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14B5F222CC
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyUFTwIq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730719AbfBLUZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:25:50 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41408 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728246AbfBLUZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 15:25:49 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so4179187wrs.8;
        Tue, 12 Feb 2019 12:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Op7D3RyeropJ2gTor0dH4QwJnRQgbQRDRxT5hIZm1eE=;
        b=CyUFTwIqBI0wihhbe3w59R6CgV4idTLki3RaCVcYmnmHEfhi+Mh+ZoZ0bgzhphKwL8
         5f2r7zjrzyFESKHpZQ9KqMsWpJAsza9q72AgtVMQFHAuyiM/ixd6Rkkz62ckSA2XOgGl
         UWLprQAGm/paIf0w6snZtVGmUKFVSL6d6HEJPTAGVNicfTiAYhhQvkEkdFgoAjnvzpQj
         +crtRnvptqK8aTKPWmeT/B0E/sO/MSrDYszZEtVBzYKnD51VUBfds//9QN1h5xoLZbZT
         XaRmUkCv8Ip5a6BmnOGnXR6sVGnGWWU/8Uezvzqi3XhEU1HoSeVHWMZNvkax+nvXG3XB
         jPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Op7D3RyeropJ2gTor0dH4QwJnRQgbQRDRxT5hIZm1eE=;
        b=iRlMqEYDLLTx7Cj53RyDyo6OdiwK8mxhsxQ4/bZvvj7gvWz3kpw6hsTKA3QOowY5jH
         1QxM047L/8QLfAbyt0Eayrw2kz+Dz53Pi3KhlGeoRK39mCHUnSXvyu/+Yyal3psxNZxP
         yGX7gWhct8nnkl+Zxzy/RSoQB9LDNPe44TPZK/93XKEsEf99v4lcC2uQUMdKVLzl+ogA
         Dk8m/TYlTYz0j0aDw7coybKQuxtsZIRufUUBbx1ouhVnfsYCg9WvFIgtkreS019T0Pai
         T9abl6B3YoBMSxQwQ1q9xt+vQYTZFgFBqtiMOF4CumOR5warfiFshx5x0SJgbD1swPmF
         bJMQ==
X-Gm-Message-State: AHQUAuafbuq7jKZamgmiROW/QxxLhSefhiLbMwtmDz2v4YhsG+CCwTmG
        doI9QSFx5CNe9sXS96NcAU4=
X-Google-Smtp-Source: AHgI3IZwrNlzmX2r1WvPUZEd/NWtutSSgNOGSFO0jXw2QpoV+FDbSYINqJXydADyyzKwgKkHQ1i6dQ==
X-Received: by 2002:adf:e8ca:: with SMTP id k10mr4324442wrn.191.1550003147889;
        Tue, 12 Feb 2019 12:25:47 -0800 (PST)
Received: from localhost.localdomain ([46.216.128.70])
        by smtp.gmail.com with ESMTPSA id z14sm10306861wrm.48.2019.02.12.12.25.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 12:25:47 -0800 (PST)
Received: from [127.0.0.1] (helo=jeknote.loshitsa1.net)
        by localhost.localdomain with esmtp (Exim 4.92-RC4)
        (envelope-from <jekhor@gmail.com>)
        id 1gtecj-0002tZ-In; Tue, 12 Feb 2019 23:25:45 +0300
Date:   Tue, 12 Feb 2019 23:25:45 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/2] leds: Add Intel Cherry Trail Whiskey Cove PMIC LEDs
Message-ID: <20190212202545.GD5213@jeknote.loshitsa1.net>
References: <20190209221213.24052-1-jekhor@gmail.com>
 <20190209221213.24052-2-jekhor@gmail.com>
 <20190211131726.GA11067@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211131726.GA11067@amd>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 02:17:26PM +0100, Pavel Machek wrote:
> Hi!
> 
> > +static struct cht_wc_led cht_wc_leds[] = {
> > +	{
> > +		.name = "pmic::charge",
> > +		.ctrl_reg = CHT_WC_LED1_CTRL,
> > +		.fsm_reg = CHT_WC_LED1_FSM,
> > +		.pwm_reg = CHT_WC_LED1_PWM,
> > +		.enable_mask = CHT_WC_LED1_ON,
> > +	},
> > +	{
> > +		.name = "pmic::gpled",
> > +		.ctrl_reg = CHT_WC_LED2_CTRL,
> > +		.fsm_reg = CHT_WC_LED2_FSM,
> > +		.pwm_reg = CHT_WC_LED2_PWM,
> > +		.enable_mask = CHT_WC_LED2_ON,
> > +	},
> > +};
> 
> Unfortunately, these LED names will not be too useful for
> userspace. What about "platform::charging" and "status-led::"?

That sounds reasonable.

> 
> Should we have some default triggers?

I don't know which triggers may be suitable for this. There are no
generic "is charging now" triggers in kernel. I can set default trigger
of charging led to 'bq27542-0-charging-blink-full-solid' as example but
it will valid for platforms with bq27542 battery fuel gauge, of course.

For status led, 'default-on' should be reasonable.

> 								Pavel

-- 
Yauhen Kharuzhy
