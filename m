Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A66C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2AA026080
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYLePEi1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2AA026080
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935055AbeFYTnu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 15:43:50 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35019 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934940AbeFYTns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 15:43:48 -0400
Received: by mail-wm0-f67.google.com with SMTP id z137-v6so5546944wmc.0;
        Mon, 25 Jun 2018 12:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rbFwR5NlZETs2vq6gCc8v/L2RpPJd+sKpkMeSXDFaeY=;
        b=UYLePEi1J5Fonv3xflzrrLFG5G7P95JD9rQhvkcBXdmGtMFE3qh9I9ZZ0mFFMe6vyQ
         b365UUKsXR6pQ/L1/E3hcrgnAxdOshLR7z2xM3ycHFHKx5+vtJBvXzcW3JyngGo6JPoo
         i2kVWKfB8fBnFX92KsLqy80wG4WMtDwmiHJWJaZpQtrspgbgQNJit8mix4P2irsduNR8
         U11DZR8QxNKZkL5yDMseRJjZyryBnoXRgiUAgCzMiPt0X82nen8gEQkw9pTiWIAzmi8Y
         T9qaNZnh5G3K5Z6uDDLEoG5ynldMiVjFo+BfVv9kFcK/ibenuig+A5WTPMRRbevM4Lnd
         ylfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rbFwR5NlZETs2vq6gCc8v/L2RpPJd+sKpkMeSXDFaeY=;
        b=W5kdCTWNTP/5bm0iCyNNMKVzy2ea5lcW9dkPhRk9pchuoEJIBlt8ndfRdwywr0XRWY
         yC0Jr7nPm9WBpqs9CG5t7BI95bUcAQRnUeiM6uzQFYbz8Xqu+XD/LP0fmkcrSxxdK3tP
         P8cejuCi2ml8XOCn4eKZ6c4zS0jEXrcZjYLofzP3GHWS6U3nw99ikQFPXSLPb1EiyYvN
         i7UYFZXm/tTN7RQIb5HBUgXQEj5sSxomBzf6QQdkCW0OIdQ8Td/4TzEih1dg+1o6CqTP
         R7q52SFE1qs9ByukrUc9jj/J55Y3VGcccq8+0rIF8gyBP6Nh38381fMxj060gSITffcc
         ArNw==
X-Gm-Message-State: APt69E1FL17eL2BfkW5IivkkYUI8TVx/+J53Ecx1vbbBO1pqR8j2rJ5C
        ylC7bd3ZSW0BJjH6JRSMxFBBwita
X-Google-Smtp-Source: ADUXVKJBQENIdFq7dGeT663L2hAI+vCSMJaGV2VspPbNr1C+A/LHceBTWaTcyEE73SFR9wLouGWVxQ==
X-Received: by 2002:a1c:5b4e:: with SMTP id p75-v6mr2180144wmb.3.1529955827275;
        Mon, 25 Jun 2018 12:43:47 -0700 (PDT)
Received: from [192.168.1.18] (bld23.neoplus.adsl.tpnet.pl. [83.28.197.23])
        by smtp.gmail.com with ESMTPSA id y18-v6sm18106996wrn.68.2018.06.25.12.43.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 12:43:46 -0700 (PDT)
Subject: Re: [PATCH] leds: Modify PC Engines apu/apu2 driver to support apu3
To:     "Raffaello D. Di Napoli" <rafdev@dinapo.li>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <5b30f692.1c69fb81.dbc7.ac34SMTPIN_ADDED_MISSING@mx.google.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <ff2d3a46-d425-3963-8353-c1a7c78788de@gmail.com>
Date:   Mon, 25 Jun 2018 21:43:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <5b30f692.1c69fb81.dbc7.ac34SMTPIN_ADDED_MISSING@mx.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Raffaello,

Thank you for the patch.

On 06/25/2018 02:50 PM, Raffaello D. Di Napoli wrote:
> PC Engines apu3 is an improved version of the apu2, using the same SoC
> and almost everything else.
> 
> This patch reuses as much as possible from the apu2 definitions, to
> avoid redundancy.
> 
> Signed-off-by: Raffaello D. Di Napoli <rafdev@dinapo.li>
> ---
>   drivers/leds/Kconfig    |  5 +++--
>   drivers/leds/leds-apu.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 6e3a998f..44097a3e 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -57,12 +57,13 @@ config LEDS_AAT1290
>   	depends on PINCTRL
>   	help
>   	 This option enables support for the LEDs on the AAT1290.
> +
>   config LEDS_APU
> -	tristate "Front panel LED support for PC Engines APU/APU2 boards"
> +	tristate "Front panel LED support for PC Engines APU/APU2/APU3 boards"
>   	depends on LEDS_CLASS
>   	depends on X86 && DMI
>   	help
> -	  This driver makes the PC Engines APU/APU2 front panel LEDs
> +	  This driver makes the PC Engines APU/APU2/APU3 front panel LEDs
>   	  accessible from userspace programs through the LED subsystem.
>   
>   	  To compile this driver as a module, choose M here: the
> diff --git a/drivers/leds/leds-apu.c b/drivers/leds/leds-apu.c
> index 8c93d689..8d42e46e 100644
> --- a/drivers/leds/leds-apu.c
> +++ b/drivers/leds/leds-apu.c
> @@ -102,6 +102,13 @@ static const struct apu_led_profile apu2_led_profile[] = {
>   	{ "apu2:green:3", LED_OFF, APU2_FCH_GPIO_BASE + 70 * APU2_IOSIZE },
>   };
>   
> +/* Same as apu2_led_profile, but with "3" in the LED names. */
> +static const struct apu_led_profile apu3_led_profile[] = {
> +	{ "apu3:green:1", LED_ON,  APU2_FCH_GPIO_BASE + 68 * APU2_IOSIZE },
> +	{ "apu3:green:2", LED_OFF, APU2_FCH_GPIO_BASE + 69 * APU2_IOSIZE },
> +	{ "apu3:green:3", LED_OFF, APU2_FCH_GPIO_BASE + 70 * APU2_IOSIZE },
> +};
> +
>   static const struct dmi_system_id apu_led_dmi_table[] __initconst = {
>   	{
>   		.ident = "apu",
> @@ -134,6 +141,30 @@ static const struct dmi_system_id apu_led_dmi_table[] __initconst = {
>   			DMI_MATCH(DMI_BOARD_NAME, "PC Engines apu2")
>   		}
>   	},
> +	/* PC Engines APU3 with "Legacy" bios < 4.0.8 */
> +	{
> +		.ident = "apu3",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
> +			DMI_MATCH(DMI_BOARD_NAME, "APU3")
> +		}
> +	},
> +	/* PC Engines APU3 with "Legacy" bios >= 4.0.8 */
> +	{
> +		.ident = "apu3",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
> +			DMI_MATCH(DMI_BOARD_NAME, "apu3")
> +		}
> +	},
> +	/* PC Engines APU2 with "Mainline" bios */
> +	{
> +		.ident = "apu3",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PC Engines apu3")
> +		}
> +	},
>   	{}
>   };
>   MODULE_DEVICE_TABLE(dmi, apu_led_dmi_table);
> @@ -235,6 +266,14 @@ static int __init apu_led_probe(struct platform_device *pdev)
>   		apu_led->platform = APU2_LED_PLATFORM;
>   		apu_led->num_led_instances = ARRAY_SIZE(apu2_led_profile);
>   		apu_led->iosize = APU2_IOSIZE;
> +	} else if (dmi_match(DMI_BOARD_NAME, "APU3") ||
> +		   dmi_match(DMI_BOARD_NAME, "apu3") ||
> +		   dmi_match(DMI_BOARD_NAME, "PC Engines apu3")) {
> +		apu_led->profile = apu3_led_profile;
> +		/* Otherwise identical to APU2. */
> +		apu_led->platform = APU2_LED_PLATFORM;
> +		apu_led->num_led_instances = ARRAY_SIZE(apu3_led_profile);
> +		apu_led->iosize = APU2_IOSIZE;
>   	}
>   
>   	spin_lock_init(&apu_led->lock);
> @@ -259,7 +298,10 @@ static int __init apu_led_init(void)
>   	if (!(dmi_match(DMI_PRODUCT_NAME, "APU") ||
>   	      dmi_match(DMI_PRODUCT_NAME, "APU2") ||
>   	      dmi_match(DMI_PRODUCT_NAME, "apu2") ||
> -	      dmi_match(DMI_PRODUCT_NAME, "PC Engines apu2"))) {
> +	      dmi_match(DMI_PRODUCT_NAME, "PC Engines apu2") ||
> +	      dmi_match(DMI_PRODUCT_NAME, "APU3") ||
> +	      dmi_match(DMI_PRODUCT_NAME, "apu3") ||
> +	      dmi_match(DMI_PRODUCT_NAME, "PC Engines apu3"))) {
>   		pr_err("Unknown PC Engines board: %s\n",
>   				dmi_get_system_info(DMI_PRODUCT_NAME));
>   		return -ENODEV;
> 

Applied.

-- 
Best regards,
Jacek Anaszewski
