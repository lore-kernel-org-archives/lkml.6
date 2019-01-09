Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE655C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 20:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F826206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 20:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sG5oGGUc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfAIUoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 15:44:54 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42775 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfAIUox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 15:44:53 -0500
Received: by mail-lf1-f66.google.com with SMTP id l10so6657075lfh.9;
        Wed, 09 Jan 2019 12:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=OLjqU9bL4poo46UYVwtOrxwZtc4+u0gUnOg5UI1xpUY=;
        b=sG5oGGUcy1kPCxs64dWdNr3DM4hr/JVZwsP4dL2OUcavsoz8GhZuLyCovyoAhx4UN/
         dqJYlY8hIEYVHOhIMezsj+bRHLIRb1gfQkSkqWWP58bHdWpL26buXgDYhDd5zM/PcuOV
         VsMFu3Ke5UFPZTvAQUkuvdBpaf2jIBliLkCfE5wHiTK5XsJE91/uBiJUI+DFRQJuMXGL
         ncX6mlmoBs9WuNvVIjz8vvO92qz6La7TM232vbB6tohZSs62AuhsycofGb5W5b/0wMjR
         z0LWG5eXOrNRGgnN9ALJp/t3l6k865mixz/TOAW6JdtJCYX2m0+Y+zswKul/EvzpYxZH
         0GFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OLjqU9bL4poo46UYVwtOrxwZtc4+u0gUnOg5UI1xpUY=;
        b=PiLAka9h8MI5H/JfP1kd6fdLk0E5uXy7iLMAGGNi/lrqD3TDqVoSK20oBYU9Rr2fq/
         gvAv5l8eN8FojGGJSvIfSbuxrz2TDM+OCrIFvkbiOcPIVtIEvKda5Nuwe7Ps5lbdi0dE
         Dyfyw+N1QTIXPn4nNNz258j62qSxk9Wkz5zQiaTU9HqGwkzyTSraWyOYinOWvcL2oPFd
         v0EnWGHQVLHo3RMeQO7XI+F/tTHsD+yztW2XFrl7yp1DYfEcnedHXR6EI8KIc1QCzLBP
         ZBTJ9xLNZQXLyKBGtHI5cXRjWqq+dtFsnXcdg92Ym1a2XTflWDGAmbxJjIuYhjb40Cyo
         2cuA==
X-Gm-Message-State: AJcUukdAGpen9OcwfcFf9mM4PiqZshh/z4b9oNdGI84A3+/CXKuWvtLr
        F3W7StBiuHK1ldGp0LINObVo2nb9
X-Google-Smtp-Source: ALg8bN4emq5F2IR23gNE9ntKBH7U1sXVISvAAt+DmRSA6n9zZSUi5ckFaVvRRlJfq0TS/ZHAn4UL0A==
X-Received: by 2002:a19:c7c2:: with SMTP id x185mr4558267lff.123.1547066689544;
        Wed, 09 Jan 2019 12:44:49 -0800 (PST)
Received: from [192.168.1.18] (chc231.neoplus.adsl.tpnet.pl. [83.31.0.231])
        by smtp.gmail.com with ESMTPSA id h82sm2768529lfg.94.2019.01.09.12.44.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 12:44:48 -0800 (PST)
Subject: Re: [PATCH v7 1/5] dt-bindings: leds: Add pattern initialization from
 Device Tree
To:     Krzysztof Kozlowski <krzk@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1547045089-19128-1-git-send-email-krzk@kernel.org>
 <1547045089-19128-2-git-send-email-krzk@kernel.org>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <d15cffc9-45c7-11ab-5be0-4fcdaa9b388c@gmail.com>
Date:   Wed, 9 Jan 2019 21:44:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1547045089-19128-2-git-send-email-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thank you for the update.

Patch set looks good to me.

Now we're missing only ack from Rob for this patch.

Best regards,
Jacek Anaszewski

On 1/9/19 3:44 PM, Krzysztof Kozlowski wrote:
> Document new led-pattern property for initialization of LED triggers.
> The property format is trigger-specific (except being array of
> integers).  For pattern trigger, the explanation of pattern format was
> moved to a common file shared with sysfs ABI.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> ---
>   .../ABI/testing/sysfs-class-led-trigger-pattern    | 51 ++--------------------
>   Documentation/devicetree/bindings/leds/common.txt  | 12 +++++
>   .../bindings/leds/leds-trigger-pattern.txt         | 49 +++++++++++++++++++++
>   3 files changed, 64 insertions(+), 48 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/leds/leds-trigger-pattern.txt
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
> index 1e5d172e0646..bd92ef9d6faa 100644
> --- a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
> +++ b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
> @@ -7,55 +7,10 @@ Description:
>   		timer. It can do gradual dimming and step change of brightness.
>   
>   		The pattern is given by a series of tuples, of brightness and
> -		duration (ms). The LED is expected to traverse the series and
> -		each brightness value for the specified duration. Duration of
> -		0 means brightness should immediately change to new value, and
> -		writing malformed pattern deactivates any active one.
> +		duration (ms).
>   
> -		1. For gradual dimming, the dimming interval now is set as 50
> -		milliseconds. So the tuple with duration less than dimming
> -		interval (50ms) is treated as a step change of brightness,
> -		i.e. the subsequent brightness will be applied without adding
> -		intervening dimming intervals.
> -
> -		The gradual dimming format of the software pattern values should be:
> -		"brightness_1 duration_1 brightness_2 duration_2 brightness_3
> -		duration_3 ...". For example:
> -
> -		echo 0 1000 255 2000 > pattern
> -
> -		It will make the LED go gradually from zero-intensity to max (255)
> -		intensity in 1000 milliseconds, then back to zero intensity in 2000
> -		milliseconds:
> -
> -		LED brightness
> -		    ^
> -		255-|       / \            / \            /
> -		    |      /    \         /    \         /
> -		    |     /       \      /       \      /
> -		    |    /          \   /          \   /
> -		  0-|   /             \/             \/
> -		    +---0----1----2----3----4----5----6------------> time (s)
> -
> -		2. To make the LED go instantly from one brightness value to another,
> -		we should use zero-time lengths (the brightness must be same as
> -		the previous tuple's). So the format should be:
> -		"brightness_1 duration_1 brightness_1 0 brightness_2 duration_2
> -		brightness_2 0 ...". For example:
> -
> -		echo 0 1000 0 0 255 2000 255 0 > pattern
> -
> -		It will make the LED stay off for one second, then stay at max brightness
> -		for two seconds:
> -
> -		LED brightness
> -		    ^
> -		255-|        +---------+    +---------+
> -		    |        |         |    |         |
> -		    |        |         |    |         |
> -		    |        |         |    |         |
> -		  0-|   -----+         +----+         +----
> -		    +---0----1----2----3----4----5----6------------> time (s)
> +		The exact format is described in:
> +		Documentation/devicetree/bindings/leds/leds-trigger-pattern.txt
>   
>   What:		/sys/class/leds/<led>/hw_pattern
>   Date:		September 2018
> diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Documentation/devicetree/bindings/leds/common.txt
> index aa1399814a2a..70876ac11367 100644
> --- a/Documentation/devicetree/bindings/leds/common.txt
> +++ b/Documentation/devicetree/bindings/leds/common.txt
> @@ -37,6 +37,18 @@ Optional properties for child nodes:
>        "ide-disk" - LED indicates IDE disk activity (deprecated),
>                     in new implementations use "disk-activity"
>        "timer" - LED flashes at a fixed, configurable rate
> +     "pattern" - LED alters the brightness for the specified duration with one
> +                 software timer (requires "led-pattern" property)
> +
> +- led-pattern : Array of integers with default pattern for certain triggers.
> +                Each trigger may parse this property differently:
> +                - one-shot : two numbers specifying delay on and delay off (in ms),
> +                - timer : two numbers specifying delay on and delay off (in ms),
> +                - pattern : the pattern is given by a series of tuples, of
> +                  brightness and duration (in ms).  The exact format is
> +                  described in:
> +                  Documentation/devicetree/bindings/leds/leds-trigger-pattern.txt
> +
>   
>   - led-max-microamp : Maximum LED supply current in microamperes. This property
>                        can be made mandatory for the board configurations
> diff --git a/Documentation/devicetree/bindings/leds/leds-trigger-pattern.txt b/Documentation/devicetree/bindings/leds/leds-trigger-pattern.txt
> new file mode 100644
> index 000000000000..d3696680bfc8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-trigger-pattern.txt
> @@ -0,0 +1,49 @@
> +* Pattern format for LED pattern trigger
> +
> +The pattern is given by a series of tuples, of brightness and duration (ms).
> +The LED is expected to traverse the series and each brightness value for the
> +specified duration. Duration of 0 means brightness should immediately change to
> +new value, and writing malformed pattern deactivates any active one.
> +
> +1. For gradual dimming, the dimming interval now is set as 50 milliseconds. So
> +the tuple with duration less than dimming interval (50ms) is treated as a step
> +change of brightness, i.e. the subsequent brightness will be applied without
> +adding intervening dimming intervals.
> +
> +The gradual dimming format of the software pattern values should be:
> +"brightness_1 duration_1 brightness_2 duration_2 brightness_3 duration_3 ...".
> +For example (using sysfs interface):
> +
> +echo 0 1000 255 2000 > pattern
> +
> +It will make the LED go gradually from zero-intensity to max (255) intensity in
> +1000 milliseconds, then back to zero intensity in 2000 milliseconds:
> +
> +LED brightness
> +    ^
> +255-|       / \            / \            /
> +    |      /    \         /    \         /
> +    |     /       \      /       \      /
> +    |    /          \   /          \   /
> +  0-|   /             \/             \/
> +    +---0----1----2----3----4----5----6------------> time (s)
> +
> +2. To make the LED go instantly from one brightness value to another, we should
> +use zero-time lengths (the brightness must be same as the previous tuple's). So
> +the format should be: "brightness_1 duration_1 brightness_1 0 brightness_2
> +duration_2 brightness_2 0 ...".
> +For example (using sysfs interface):
> +
> +echo 0 1000 0 0 255 2000 255 0 > pattern
> +
> +It will make the LED stay off for one second, then stay at max brightness for
> +two seconds:
> +
> +LED brightness
> +    ^
> +255-|        +---------+    +---------+
> +    |        |         |    |         |
> +    |        |         |    |         |
> +    |        |         |    |         |
> +  0-|   -----+         +----+         +----
> +    +---0----1----2----3----4----5----6------------> time (s)
> 

