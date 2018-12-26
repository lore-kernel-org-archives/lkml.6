Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29897C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 19:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E09FD20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 19:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObuG0I5u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbeLZT5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 14:57:24 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46397 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbeLZT5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 14:57:24 -0500
Received: by mail-pl1-f195.google.com with SMTP id t13so7855600ply.13;
        Wed, 26 Dec 2018 11:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jSyuTP5sG90RpqsjLo4PqWMowrBpDi+cmbo/670dFxY=;
        b=ObuG0I5uOXFMVdRUmKoznlgDrHcJhH0nrGo6XnOeKDFUij59opLfT8XnES9SFQixxJ
         NcoDb4vCptIAy10u0t1bQNPcgNhfFUNmyegoL8SNa8/uPnu74EaevhDb2WY9gc+nn8J3
         Cq8kDGZ7NtSzaeq0gZ5iphj3LyO3Ah6cgVDIHZOFC5LyKtb2KohXtguJA9oz2e/n2LA+
         41I5eOXeFWk1ICtkPcEYppP9vG6l8gaWUZsWMW/A9PrERi6obVxHB3+jZbK8OcJ/p/Pq
         UT3KlRTCLHZLL1eiwUrr8MGtKdT5eUfk0OPr0s041cno6usMqp/SdldwmThQaz4LTvI4
         +eSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jSyuTP5sG90RpqsjLo4PqWMowrBpDi+cmbo/670dFxY=;
        b=skLBhagPjTMpTVLumXSGh9UL+dDhQp+qMSnwBlztl/YRtjuT5csIwDw6IeYgBiNQPU
         kbjuacZuQzhMve9HIlwcS0IrkpPTbtCWfjy6h1QSLp8RZ8aIJiPS/JlA8uKy0KZkJ6oa
         1P0mpyF7VSt9gJejlOC+46YECtQHPvApQ9QTif6VNxiPDwHty9tPMFrCOUohtlw7JDvG
         VkzHWT6chPCQuf2tho5zcHt0arMPHoOn+xtVIqQ+Baec/HNPXjj+Sy77Akat9UQLzNpd
         SF9S7Qy/uxJSaSXZ2Dyd7uPy3EutkS46X7ppPRPW+WI5AMGkN+bTOyosaytPH8wdJR9O
         lWPw==
X-Gm-Message-State: AJcUukeXrV0A4CIgaL1w9LD6J7IoQDdwhWtMHIdeaS5unm9LQ4FMzxnH
        GLNn2m+potD/8E+R9WuyXl8=
X-Google-Smtp-Source: ALg8bN7X4YShPwZ4wkacyYHt1m1h8jVZXzizL+F04OJEbObuLZr8zJC6dkTtdohTrdhlNdSxGUVvPw==
X-Received: by 2002:a17:902:820d:: with SMTP id x13mr21611518pln.229.1545854243329;
        Wed, 26 Dec 2018 11:57:23 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id b2sm66920157pfm.3.2018.12.26.11.57.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Dec 2018 11:57:22 -0800 (PST)
Date:   Wed, 26 Dec 2018 11:57:20 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Kees Cook <keescook@chromium.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] keyboard: (samsung) fix a missing check of return value
Message-ID: <20181226195720.GA5999@dtor-ws>
References: <20181226015131.71198-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181226015131.71198-1-kjlu@umn.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 25, 2018 at 07:51:29PM -0600, Kangjie Lu wrote:
> of_device_is_compatible() returns false if the device is incompatible.
> The fix adds a check for its return value;
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/input/keyboard/samsung-keypad.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
> index 1fe1aa2adf85..5ba940f3f76e 100644
> --- a/drivers/input/keyboard/samsung-keypad.c
> +++ b/drivers/input/keyboard/samsung-keypad.c
> @@ -387,9 +387,13 @@ static int samsung_keypad_probe(struct platform_device *pdev)
>  	keypad->stopped = true;
>  	init_waitqueue_head(&keypad->wait);
>  
> -	if (pdev->dev.of_node)
> -		keypad->type = of_device_is_compatible(pdev->dev.of_node,
> -					"samsung,s5pv210-keypad");
> +	if (pdev->dev.of_node) {
> +		error = of_device_is_compatible(pdev->dev.of_node,
> +				"samsung,s5pv210-keypad");
> +		if (!error)
> +			return -EINVAL;

What makes you think that not matching on this compatible is an error?
Have you looked at the rest of the dirver?

> +		keypad->type = error;
> +	}
>  	else
>  		keypad->type = platform_get_device_id(pdev)->driver_data;
>  
> -- 
> 2.17.2 (Apple Git-113)
> 

-- 
Dmitry
