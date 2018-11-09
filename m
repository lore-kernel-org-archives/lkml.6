Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31291C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE86120840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWOFjwju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE86120840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeKISLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 13:11:37 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41994 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbeKISLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 13:11:36 -0500
Received: by mail-lf1-f66.google.com with SMTP id q6-v6so707573lfh.9;
        Fri, 09 Nov 2018 00:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q0Mffn+Dw8p8xx5kOmUKmdoVPccueiXsAjtztr6lbvk=;
        b=aWOFjwjuQRXP2lV3qVp7HVXhrU9T+wyDyAKILTMnjly8SPAV2c5+JaQGDlR5jYWjXL
         dl4r68KFVFIzjyY4Fp8+fU8YkB+xo/2e/pFTCPtUZUxRwUTPSWDbKzUAaHHF6WRRQ0cn
         OkR4k715Lugog4a5t/wQMtVEArUWx9xLT/htxbRbM6B8KMvMjXgoxRSCkGC8SvU4owM7
         YzT+Kd5tiMCzdlR0BDEUp3tSnitgV/ABtxyO+13UGPira1sRpr5Xo3croM3t+0u9KTPO
         E4OGDS2Dmb/A25RjdxiG/OZ6SikEZ/JKtrhm7nR4iVooTfOoMns2CeJWh/9DZXbLgal8
         fHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q0Mffn+Dw8p8xx5kOmUKmdoVPccueiXsAjtztr6lbvk=;
        b=mFCo12hlXMueJeVXl34xPJF7buYtKxy5bJiz+merZX4do2szHQxnRA2XdGU5iAF3+G
         QG6WkxW13nKPiVc5YJnx8DG8kAIbXzzO/omOVPsrO9oyu5ZabAuGSJad+oZgiFaMvLuH
         1yKotDbmspQaymUf22G0UeMKb/fXmZ9aql3wbzuqo2Bri1hVPGOJiaV2s2VAwKrRQm4Z
         RKtF1dIQCvcvWpIrKWh3Y907DKVGA9N5Qz27uiqBDicjop60ABF4ID9q4t5A3lD6iZhv
         rcgaJ+8xXlsAMfA2nJj/3dCDebhqUjyuQq4BB3T/j+OtWR/XlsuAZjJEK1QYsu0Sr/lg
         7bvw==
X-Gm-Message-State: AGRZ1gLmzviQBHYRAztmqG7mRIFNJt3SFjJzpwIZUAwYNDj+r3M2BFWy
        DYgIpyRl09dh8T8Fi1fHd6g=
X-Google-Smtp-Source: AJdET5cO7b3kLZM9hlcKxIbw3lyyUGikBRUmPlyDIuyxTl1bR4WhPU8Rj8Udsysek2tSTz95+P2N0g==
X-Received: by 2002:a19:ca51:: with SMTP id h17mr4450593lfj.126.1541752323448;
        Fri, 09 Nov 2018 00:32:03 -0800 (PST)
Received: from ?IPv6:2001:14ba:8017:3300:e01c:5423:5687:da6c? (dtynxhyjydvmch1zj7l2y-3.rev.dnainternet.fi. [2001:14ba:8017:3300:e01c:5423:5687:da6c])
        by smtp.googlemail.com with ESMTPSA id b21sm1083060lfi.7.2018.11.09.00.32.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 00:32:02 -0800 (PST)
Subject: Re: [PATCH 04/24] dt-bindings: leds: Add function and color
 properties
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-5-git-send-email-jacek.anaszewski@gmail.com>
From:   =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>
Message-ID: <bdd18dc6-0dee-5957-81d4-39254c7ad74d@gmail.com>
Date:   Fri, 9 Nov 2018 10:32:01 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1541542052-10081-5-git-send-email-jacek.anaszewski@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2018 0.07, Jacek Anaszewski wrote:
> Introduce dedicated properties for conveying information about
> LED function and color. Mark old "label" property as deprecated.
> 
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Baolin Wang <baolin.wang@linaro.org>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Dan Murphy <dmurphy@ti.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Oleh Kravchenko <oleg@kaa.org.ua>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Simon Shields <simon@lineageos.org>
> Cc: Xiaotong Lu <xiaotong.lu@spreadtrum.com>
> ---
>   Documentation/devicetree/bindings/leds/common.txt | 52 +++++++++++++++++++----
>   1 file changed, 44 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Documentation/devicetree/bindings/leds/common.txt
> index aa13998..3efc826 100644
> --- a/Documentation/devicetree/bindings/leds/common.txt
> +++ b/Documentation/devicetree/bindings/leds/common.txt
> @@ -10,14 +10,20 @@ can influence the way of the LED device initialization, the LED components
>   have to be tightly coupled with the LED device binding. They are represented
>   by child nodes of the parent LED device binding.
>   
> +
>   Optional properties for child nodes:
>   - led-sources : List of device current outputs the LED is connected to. The
>   		outputs are identified by the numbers that must be defined
>   		in the LED device binding documentation.
> +- function: LED functon. Use one of the LED_FUNCTION_* prefixed definitions
> +	    from the header include/dt-bindings/leds/functions.h.
> +	    If there is no matching LED_FUNCTION available, add a new one.
> +- color : Color of the LED.

We have had for years out-of-tree patch for multi color gpio led driver 
which extends this concept with multiple colors. Then in sysfs there has 
been possibility to control the color and otherwise use blinking or 
other features.

Our need is multi color status led of the device which includes 
different kind of blinkings and colors on different situations.

Current in-tree gpio led driver just wasn't atomic enough and a bit 
clumsy interface for handling this.

Now that this is being looked at could we come up with solution that we 
could define multiple colors for one led in device tree and then we 
could work on getting the driver upstreamed?

What we did was generally:

leds-multi {
	compatible = "gpio-multi-leds";

	status {
		gpios = <...>;
		linux,default-trigger = "none";
		deafult-state = "keep";

		color-red {
			pin-mask = <0x01>;
		};

		color-green {
			pin-mask = <0x02>;
		};

		color-orange {
			pin-mask = <0x03>;
		};
	};
};

Thanks,
Vesa Jääskeläinen
