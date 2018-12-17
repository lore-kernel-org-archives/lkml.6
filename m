Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6631AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA2C214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545086435;
	bh=kvnOypopyo0Vi1aJl4bH8hykmih2+uZWGHpxocZeKdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kNmIbw+4qb26XkVGN8a+rg5IhMLWaPlZVGhuQFZ86dS9hY/AMEDG02sAIcLxBeMwK
	 dJDjXF2gg60bJH8mHXU8kZDki90girQOxb4fZQAfnISoz19RX0EmQAD5bQt/fsZL/r
	 ZEjPUukCRAON+e/twuI33biQ7bzQAjdwPFgyzo8k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731916AbeLQWke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 17:40:34 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34690 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731839AbeLQWkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 17:40:32 -0500
Received: by mail-ot1-f68.google.com with SMTP id t5so13853525otk.1;
        Mon, 17 Dec 2018 14:40:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mEAS4MezIjzeA5G16TWWm47+YRxhB8ztg14s4WDr+7E=;
        b=j0aQwSH3X5Zl4K1zn/6565fzjVxbpkrznRHgNSOOdixlGc+eJR2M9Z9IZ61npkMiGl
         Y2COKd73a1kOqUXGVN1BPnvWz0c/zKRXGyRL7Wg7bOr34WXXfyAFRnje3JGA5mlL3MaJ
         Mz8Qa0u45N/+t0TAalLd96lebtWbJRX7/N1ax9hCn7+TYyyjn0brPrpWCZj+IJmjrKv3
         eOV/2HRk40e7XNDgnN1dcVaIDBbV5VZwFE03YBdjrPUrwstb43CrYHRthhMM+an/Zvyz
         Eud5r+RTh9Pe1cqbUjVu4uhnNuEjqRDTQAg7dUDFrMxRu3QTEKoFWdDWzuhr6OD6+/Q6
         OqOw==
X-Gm-Message-State: AA+aEWZw191QGCK7rBap/pog6jkyli/9lOrTXWgPMSJRedajqc78izDy
        +0M74WhqjiMB4tESGzIcvw==
X-Google-Smtp-Source: AFSGD/U6T301qm3gsFFqPpHxIUtsJYNJze757M7ulvO7gfNHnzepHiskPJ2qqZ3L2rJGetUvaJjajQ==
X-Received: by 2002:a9d:332:: with SMTP id 47mr11488402otv.260.1545086430879;
        Mon, 17 Dec 2018 14:40:30 -0800 (PST)
Received: from localhost (cpe-70-114-214-127.austin.res.rr.com. [70.114.214.127])
        by smtp.gmail.com with ESMTPSA id z94sm8940567ota.58.2018.12.17.14.40.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 14:40:30 -0800 (PST)
Date:   Mon, 17 Dec 2018 16:40:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Mark Rutland <mark.rutland@arm.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] dt-bindings: leds: Add pattern initialization
 from Device Tree
Message-ID: <20181217224029.GA16132@bogus>
References: <1544613406-27026-1-git-send-email-krzk@kernel.org>
 <1544613406-27026-2-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544613406-27026-2-git-send-email-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 12:16:42PM +0100, Krzysztof Kozlowski wrote:
> Document new linux,trigger-pattern property for initialization of LED
> pattern trigger.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/leds/common.txt | 36 +++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Documentation/devicetree/bindings/leds/common.txt
> index aa1399814a2a..3daccd4ea8a3 100644
> --- a/Documentation/devicetree/bindings/leds/common.txt
> +++ b/Documentation/devicetree/bindings/leds/common.txt
> @@ -37,6 +37,42 @@ Optional properties for child nodes:
>       "ide-disk" - LED indicates IDE disk activity (deprecated),
>                    in new implementations use "disk-activity"
>       "timer" - LED flashes at a fixed, configurable rate
> +     "pattern" - LED alters the brightness for the specified duration with one
> +                 software timer (requires "led-pattern" property)
> +
> +- led-pattern : String with default pattern for certain triggers. Each trigger
> +                may parse this string differently:
> +                - one-shot : two numbers specifying delay on and delay off,
> +                - timer : two numbers specifying delay on and delay off,

I misunderstood that these triggers applied to this. Is there any point 
to supporting these modes? Aren't they just a subset or simplification 
of a pattern?

Can we control the timer frequency from DT? The pattern could address 
that limitation.

> +                - pattern : The pattern is given by a series of tuples, of

Don't you need one-shot vs. repeat modes for patterns too?

I could imagine you'd want a pattern for any trigger. 

> +                  brightness and duration (ms).  The LED is expected to traverse
> +                  the series and each brightness value for the specified
> +                  duration.  Duration of 0 means brightness should immediately
> +                  change to new value.
> +
> +                  1. For gradual dimming, the dimming interval now is set as 50
> +                  milliseconds. So the tuple with duration less than dimming
> +                  interval (50ms) is treated as a step change of brightness,
> +                  i.e. the subsequent brightness will be applied without adding
> +                  intervening dimming intervals.
> +
> +                  The gradual dimming format of the software pattern values should be:
> +                  "brightness_1 duration_1 brightness_2 duration_2 brightness_3
> +                  duration_3 ...".
> +                  For example "0 1000 255 2000" will make the LED go gradually
> +                  from zero-intensity to max (255) intensity in 1000
> +                  milliseconds, then back to zero intensity in 2000
> +                  milliseconds.
> +
> +                  2. To make the LED go instantly from one brightness value to
> +                  another, pattern should use zero-time lengths (the brightness
> +                  must be same as the previous tuple's). So the format should be:
> +                  "brightness_1 duration_1 brightness_1 0 brightness_2
> +                  duration_2 brightness_2 0 ...".
> +                  For example "0 1000 0 0 255 2000 255 0" will make the LED
> +                  stay off for one second, then stay at max brightness for two
> +                  seconds.
> +
>  
>  - led-max-microamp : Maximum LED supply current in microamperes. This property
>                       can be made mandatory for the board configurations
> -- 
> 2.7.4
> 
