Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8419BC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4928E2146D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfg1yV8d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4928E2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbeLCTZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 14:25:20 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42916 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeLCTZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 14:25:20 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so2149912plp.9;
        Mon, 03 Dec 2018 11:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JhQbvturfEJAgpWJJ/zAnmOIMrf1H4aU+0pEteqZDAs=;
        b=hfg1yV8drF5dn9sHTMQqE3bc9WcjLsKcCsPGTNy5C+tJdnFkqOao/+8Gx2ZwAKEZBj
         sK29HLmvQpkStkoOSPnuNut61LFgl8GAtzhIGuvt/+GssMtCOgTzWG0sF6J0xRob2KP/
         2/yY6x/1YNBmf8YS1/2mGIoxeKZy8G2nV/kutZpeUEqqzGZb9F+VYmV22QjPr1aTnjHU
         DBlNOIrGcrw+GXpMyVTEaM5UQFIVmRvIvK+/TY930w+Xh1NiUyatSCnshSp2c+k/yp+B
         E/aTAugfLY+SRHzmHa9y/txFHrwSUpN56sIgrlqEtr8N10Zlv4ADQtiRYyjE1+VVyXEe
         5ACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JhQbvturfEJAgpWJJ/zAnmOIMrf1H4aU+0pEteqZDAs=;
        b=Js2AK22eSRJS6hgoCNxSM8P6jh0alxgEeUcDiF3h3pfcJGIp0OutPqZNC8bJ2gbMXc
         sznx9rP1fPOhej4D/svt5WTHgm+rKbiFCKoi2DCWczmj8t01GWM90MGWJDL5rpQ0gQDq
         o+GXvSyVLwFgOSGMFNL1m5LzU7fBRSy1J+bYaG7f9zUPQzhD1+KgM/sq9GKlLLv87j6Y
         CenbN41ZP6cBVTJxtv/Xk7tJbZ7rnz7xOplijs+Z0dMAon0Tnz1WUMnwe4jrdnJUEw+9
         wcn3YonW16F6nRntsk10mu4A3MrrIDblorDo5VXzzziQhrEqF8EceeimSCepu0FeiCBo
         pW1w==
X-Gm-Message-State: AA+aEWacw6VBHdqkUJAQLuWi8wLi5ZABJ9c42IZTLodQ5gIWeDDZOTGi
        TVLxe3vfVGXbM/uP8Cyarro=
X-Google-Smtp-Source: AFSGD/WRpL1qCWOmsvQfm8yImvpMuZAj1bug0XzkgLGQXCVMU4AabwUIy72dI4i9dpwbQ2oKtBWAuA==
X-Received: by 2002:a17:902:9a9:: with SMTP id 38mr16834961pln.204.1543865114849;
        Mon, 03 Dec 2018 11:25:14 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id s9sm15963380pgl.88.2018.12.03.11.25.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 11:25:14 -0800 (PST)
Date:   Mon, 3 Dec 2018 11:25:11 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, Axel Haslam <axelhaslam@ti.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Illia Smyrnov <illia.smyrnov@ti.com>,
        Marcel Partap <mpartap@gmx.net>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Michael Scott <hashcode0f@gmail.com>,
        NeKit <nekit1000@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/2] Input: omap-keypad: Fix keyboard debounce
 configuration
Message-ID: <20181203192511.GC257010@dtor-ws>
References: <20181203012933.6647-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203012933.6647-1-tony@atomide.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2018 at 05:29:32PM -0800, Tony Lindgren wrote:
> I noticed that the Android v3.0.8 kernel on droid4 is using different
> keypad values from the mainline kernel and does not have issues with
> keys occasionally being stuck until pressed again. Turns out there was
> an earlier patch posted to fix this as "Input: omap-keypad: errata i689:
> Correct debounce time", but it was never reposted to fix use macros
> for timing calculations.
> 
> This updated version is using macros, and also fixes the use of the
> input clock rate to use 32768KiHz instead of 32000KiHz. And we want to
> use the known good Android kernel values of 3 and 6 instead of 2 and 6
> in the earlier patch.
> 
> Cc: Axel Haslam <axelhaslam@ti.com>
> Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
> Cc: Illia Smyrnov <illia.smyrnov@ti.com>
> Cc: Marcel Partap <mpartap@gmx.net>
> Cc: Merlijn Wajer <merlijn@wizzup.org>
> Cc: Michael Scott <hashcode0f@gmail.com>
> Cc: NeKit <nekit1000@gmail.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Sebastian Reichel <sre@kernel.org>
> Reported-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Applied, thank you.

> ---
>  drivers/input/keyboard/omap4-keypad.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
> --- a/drivers/input/keyboard/omap4-keypad.c
> +++ b/drivers/input/keyboard/omap4-keypad.c
> @@ -60,8 +60,18 @@
>  
>  /* OMAP4 values */
>  #define OMAP4_VAL_IRQDISABLE		0x0
> -#define OMAP4_VAL_DEBOUNCINGTIME	0x7
> -#define OMAP4_VAL_PVT			0x7
> +
> +/*
> + * Errata i689: If a key is released for a time shorter than debounce time,
> + * the keyboard will idle and never detect the key release. The workaround
> + * is to use at least a 12ms debounce time. See omap5432 TRM chapter
> + * "26.4.6.2 Keyboard Controller Timer" for more information.
> + */
> +#define OMAP4_KEYPAD_PTV_DIV_128        0x6
> +#define OMAP4_KEYPAD_DEBOUNCINGTIME_MS(dbms, ptv)     \
> +	((((dbms) * 1000) / ((1 << ((ptv) + 1)) * (1000000 / 32768))) - 1)
> +#define OMAP4_VAL_DEBOUNCINGTIME_16MS					\
> +	OMAP4_KEYPAD_DEBOUNCINGTIME_MS(16, OMAP4_KEYPAD_PTV_DIV_128)
>  
>  enum {
>  	KBD_REVISION_OMAP4 = 0,
> @@ -181,9 +191,9 @@ static int omap4_keypad_open(struct input_dev *input)
>  
>  	kbd_writel(keypad_data, OMAP4_KBD_CTRL,
>  			OMAP4_DEF_CTRL_NOSOFTMODE |
> -			(OMAP4_VAL_PVT << OMAP4_DEF_CTRL_PTV_SHIFT));
> +			(OMAP4_KEYPAD_PTV_DIV_128 << OMAP4_DEF_CTRL_PTV_SHIFT));
>  	kbd_writel(keypad_data, OMAP4_KBD_DEBOUNCINGTIME,
> -			OMAP4_VAL_DEBOUNCINGTIME);
> +			OMAP4_VAL_DEBOUNCINGTIME_16MS);
>  	/* clear pending interrupts */
>  	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS,
>  			 kbd_read_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS));
> -- 
> 2.19.2

-- 
Dmitry
