Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3969DC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C9A222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlmZV0XS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732143AbfBLTuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 14:50:32 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53641 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730586AbfBLTuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 14:50:32 -0500
Received: by mail-wm1-f65.google.com with SMTP id d15so4377847wmb.3;
        Tue, 12 Feb 2019 11:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/TIbpNaeBt6DInuwNLeLigPgyWbFZFCl5A0LfoZ2ru8=;
        b=PlmZV0XS2oswu+nN3QxKIffnExQmomods3gLOjofB4Bwld1RIlv2gqmurvyOVkZ1eQ
         STpAGIGxabsNzgmBYxxtpteV9sc8fUpdjn+je5teOEDzx0UdoeYuJlUDElqSxjVHJ/Xh
         v8LLHG7xAyOStST5oA+Ft9aVYOgpvxNIP03/EWFTbu7ja4BJdA+s8CMd6niX9PYUUlGl
         E/WVFqurTSkFVGe2m5C9mGiLXQDlN1GaYzDH1YNVOUGZBk/vIvZrwWWNOjM/bG/OtkYs
         q6ANLRVD0QUdCr3kw2bZ7IZM1BSpJggV4dcLlg1lKehdnGFsu4wsnamRaUVoftX03fDr
         N3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/TIbpNaeBt6DInuwNLeLigPgyWbFZFCl5A0LfoZ2ru8=;
        b=WlSdAHoTZG3s+/woKLvO9pfipkeJtA+UZPhjCpE1uEFahpJ2Mcsk3OmmtOMJ3KY5xd
         0UxCiKw0wB2uoTdRDHBr2TDDHlDwHWDCGhWXR7GUi6ubDWdniQdpVpVYDZ3WT86+6GVh
         qj3swWzKvyNFRiRa29mk3VaCimQlcg10OG4RCa90QLhpNNahsDJv2KIGWspaZO5eGpV0
         S5TSQkNDSa95ZI6qAb9c6M/rkcg+P5O0xT8PE83ujWNshLNECSIlQUxPr+5CpDjib4tk
         48hk/bubOFE98d/t1MM5Ts8pWHcmHsJV31kaQn0BSQL9s/jKeBE5JCfnCdObVBaa8fVs
         zAkA==
X-Gm-Message-State: AHQUAuaQj7MmRN5NznRiYylIoASEGkyHuzjv1WhuA40PHTeXK6o+aZZR
        X3DreoGHpYqyRlXXvZ9dRyA=
X-Google-Smtp-Source: AHgI3IZKWaSQbMbJ+NxbSo4OrH8++mjKUv0pGJjjVm/iOWxuqDEf7/0xsaDtX2/F93Zh4ZNXX+w2nw==
X-Received: by 2002:a7b:cb0a:: with SMTP id u10mr455276wmj.0.1550001029494;
        Tue, 12 Feb 2019 11:50:29 -0800 (PST)
Received: from localhost.localdomain ([46.216.128.70])
        by smtp.gmail.com with ESMTPSA id e27sm28794119wra.67.2019.02.12.11.50.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 11:50:28 -0800 (PST)
Received: from [127.0.0.1] (helo=jeknote.loshitsa1.net)
        by localhost.localdomain with esmtp (Exim 4.92-RC4)
        (envelope-from <jekhor@gmail.com>)
        id 1gte4Y-0002JJ-Fp; Tue, 12 Feb 2019 22:50:26 +0300
Date:   Tue, 12 Feb 2019 22:50:26 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/2] leds: Add Intel Cherry Trail Whiskey Cove PMIC LEDs
Message-ID: <20190212195026.GB5213@jeknote.loshitsa1.net>
References: <20190209221213.24052-1-jekhor@gmail.com>
 <20190209221213.24052-2-jekhor@gmail.com>
 <9319c977-b8d4-98cc-d719-b21df5ef5a88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9319c977-b8d4-98cc-d719-b21df5ef5a88@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 10:36:30PM +0100, Jacek Anaszewski wrote:
> Hi Yauhen,
> 
> Thank you for the patch.
> 
> Please find few comments in the code.
> 
> On 2/9/19 11:12 PM, Yauhen Kharuzhy wrote:
> > diff --git a/drivers/leds/leds-cht-wcove.c b/drivers/leds/leds-cht-wcove.c
> > new file mode 100644
> > index 000000000000..82ed0845bf72
> > --- /dev/null
> > +++ b/drivers/leds/leds-cht-wcove.c
> > @@ -0,0 +1,278 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Driver for LEDs connected to the Intel Cherry Trail Whiskey Cove PMIC
> > + *
> > + * Copyright 2019 Yauhen Kharuzhy <jekhor@gmail.com>
> > + *
> > + * Based on Lenovo Yoga Book Android kernel sources
> > + */
> 
> Please use uniform "//" comment style above.

OK.

> > +
> > +static int cht_wc_leds_brightness_set(struct led_classdev *cdev,
> > +				      enum led_brightness value)
> > +{
> > +	struct cht_wc_led *led = container_of(cdev, struct cht_wc_led, cdev);
> > +	int ret;
> 
> You need mutex protection here. Think of the cases where brightness
> is set from sysfs and the call from trigger jumps in the middle.

Agree.

> > +enum led_brightness cht_wc_leds_brightness_get(struct led_classdev *cdev)
> > +{
> > +	struct cht_wc_led *led = container_of(cdev, struct cht_wc_led, cdev);
> > +	int ret;
> > +	unsigned int val;
> 
> Ditto.

OK

> > +static int cht_wc_leds_blink_set(struct led_classdev *cdev,
> > +				 unsigned long *delay_on,
> > +				 unsigned long *delay_off)
> > +{
> > +	struct cht_wc_led *led = container_of(cdev, struct cht_wc_led, cdev);
> > +	unsigned int ctrl;
> > +	int ret;
> 
> mutex needed as well.

OK

> 
> > +	if (!*delay_on && !*delay_off) {
> > +		/* Return current settings */
> > +		ret = regmap_read(led->pmic->regmap, led->ctrl_reg, &ctrl);
> 
> Why read? This op sets blinking. Please refer to the blink_set semantics
> description from include/linux/leds.h:
> 
> /*
>  * Activate hardware accelerated blink, delays are in milliseconds
>  * and if both are zero then a sensible default should be chosen.
>  * The call should adjust the timings in that case and if it can't
>  * match the values specified exactly.
>  * Deactivate blinking again when the brightness is set to LED_OFF
>  * via the brightness_set() callback.
>  */
> int             (*blink_set)(struct led_classdev *led_cdev,
>                              unsigned long *delay_on,
>                              unsigned long *delay_off);
> 
> Please compare how other LED class drivers do that.

Hmm... This was attempt to set 'reasonable default' to current blink
settings from hardware. But if this is too unpredictable behaviour for
LED class, I will change it to constant values.

> > +MODULE_DESCRIPTION("Intel Cherrytrail Whiskey Cove PMIC LEDs driver");
> > +MODULE_AUTHOR("Yauhen Kharuzhy <jekhor@gmail.com>");
> > +MODULE_LICENSE("GPL");
> 
> s/GPL/GPL v2/

OK.

-- 
Yauhen Kharuzhy
