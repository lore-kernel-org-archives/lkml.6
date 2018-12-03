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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4747C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6713C2081C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEJX3a8k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6713C2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbeLCTYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 14:24:01 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39709 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbeLCTYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 14:24:01 -0500
Received: by mail-pf1-f193.google.com with SMTP id c72so6869915pfc.6;
        Mon, 03 Dec 2018 11:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O4MCKpl8Qse0Js4ynggmMDSmyT9oJSpvvigkJJAqlgA=;
        b=dEJX3a8kwDG7BRdv0SxZaTPV4Yu+mgmc/4wU6H7QR6YHQSi8W+cDDc+DA1so9zgtrs
         py415GLXtmqmXkoKMOTsg9dBcYgJohRvNfg8xx7aWfwEMXU9ccAma9QN+RF6cvJZTXEu
         p46oBt8YqXsgensrK4r/J/3APxuF6SXPjn6XEW4zu5Wnc9O5yMlK9uJYJYC15w1XstpA
         ZxRTOQocAqA19mNgj7tG35lzEBr+J03AAWIO7v1EQn77jkGdJJASFaEVliDG/icMTgIs
         xbs9zYlUH6hL6HZxm1t6cvjIkDo8nBlZ/AYbAYyKR91Kyx+96Ul2yedMa3LNhzvRnDTe
         lajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O4MCKpl8Qse0Js4ynggmMDSmyT9oJSpvvigkJJAqlgA=;
        b=kI9Wd8AwSwI6rgw8FOCGiKKG8fJDpSqIzoOAdRfGHkS+cxa1kD18qA19nlmK8oA6yZ
         Nm1OKqwOxu1dlLQGkXAvKnzF+n4pBB/2pJLx8ZDD9VaT31QEKQXrkZb0AiO1ieMXoH7t
         ocTBnnMJvXLtfOMcRfW5hk6SxIkKoIt341btK8pMM0Dbpv8C+IbwOMvexz20PAwSudxf
         WtNl4tCYtPfJPKSWTvH9ytV1gC7+j3t8RsXwcpg/ISRsCBNGHugKsj2h/2T6YUElnsZe
         N1qiVlhDHqfwQ6fugp2Lka0BzF4k7ljr4UphS5xcXmRzO9SQJQzxll3ag1BY8Jey5ZGY
         WEQQ==
X-Gm-Message-State: AA+aEWbcQEVJjR0o2tyAEYm1u6Kjxs+I7eqk2e0pegch8wrIOtFxu4VA
        tfd/q2JwriVbXCgEBXMkAuw=
X-Google-Smtp-Source: AFSGD/UBZgfURAk+WxjBMnmjDn6zX8XTv3GPRpRLGcdsHXhskzsE8hk1FzKWIUzbqDxtXtDQBuzw1A==
X-Received: by 2002:a63:ce50:: with SMTP id r16mr14269825pgi.217.1543865035342;
        Mon, 03 Dec 2018 11:23:55 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 62sm16510365pgc.61.2018.12.03.11.23.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 11:23:54 -0800 (PST)
Date:   Mon, 3 Dec 2018 11:23:51 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, Axel Haslam <axelhaslam@ti.com>,
        Illia Smyrnov <illia.smyrnov@ti.com>,
        Marcel Partap <mpartap@gmx.net>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Michael Scott <hashcode0f@gmail.com>,
        NeKit <nekit1000@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 2/2] Input: omap-keypad: Fix idle configration to not
 block SoC idle states
Message-ID: <20181203192351.GB257010@dtor-ws>
References: <20181203012933.6647-1-tony@atomide.com>
 <20181203012933.6647-2-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203012933.6647-2-tony@atomide.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2018 at 05:29:33PM -0800, Tony Lindgren wrote:
> With PM enabled, I noticed that pressing a key on the droid4 keyboard will
> block deeper idle states for the SoC. Looks like we can fix this by
> managing the idle register to gether with the interrupt similar to what
> we already do for the GPIO controller.
> 
> Note that we now must also disable OMAP4_DEF_IRQENABLE_LONGKEY as it
> should not be used together with debounce according to the TRM.
> 
> Cc: Axel Haslam <axelhaslam@ti.com>
> Cc: Illia Smyrnov <illia.smyrnov@ti.com>
> Cc: Marcel Partap <mpartap@gmx.net>
> Cc: Merlijn Wajer <merlijn@wizzup.org>
> Cc: Michael Scott <hashcode0f@gmail.com>
> Cc: NeKit <nekit1000@gmail.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Sebastian Reichel <sre@kernel.org>
> Reported-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/input/keyboard/omap4-keypad.c | 28 ++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
> --- a/drivers/input/keyboard/omap4-keypad.c
> +++ b/drivers/input/keyboard/omap4-keypad.c
> @@ -53,11 +53,12 @@
>  /* OMAP4 bit definitions */
>  #define OMAP4_DEF_IRQENABLE_EVENTEN	BIT(0)
>  #define OMAP4_DEF_IRQENABLE_LONGKEY	BIT(1)
> -#define OMAP4_DEF_WUP_EVENT_ENA		BIT(0)
> -#define OMAP4_DEF_WUP_LONG_KEY_ENA	BIT(1)
>  #define OMAP4_DEF_CTRL_NOSOFTMODE	BIT(1)
>  #define OMAP4_DEF_CTRL_PTV_SHIFT	2
>  
> +#define OMAP4_KBD_IRQ_MASK		(OMAP4_DEF_IRQENABLE_LONGKEY | \
> +					 OMAP4_DEF_IRQENABLE_EVENTEN)
> +
>  /* OMAP4 values */
>  #define OMAP4_VAL_IRQDISABLE		0x0
>  
> @@ -127,9 +128,11 @@ static irqreturn_t omap4_keypad_irq_handler(int irq, void *dev_id)
>  	struct omap4_keypad *keypad_data = dev_id;
>  
>  	if (kbd_read_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS)) {
> -		/* Disable interrupts */
> +		/* Disable interrupts and wake-up events */
>  		kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
>  				 OMAP4_VAL_IRQDISABLE);

I wonder, do we need to turn off interrupts at keyboard controller
level, or we should simply use IRQF_ONESHOT?

> +		kbd_writel(keypad_data, OMAP4_KBD_WAKEUPENABLE, 0);

So we are saying that disabling wakeup for the time between hard
interrupt firing, and when interrupt thread runs, makes much difference?
It is surprising to me... How long does it take to schedule interrupt
thread?

Thanks.

-- 
Dmitry
