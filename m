Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5552C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6639F208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmPmZbii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6639F208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731997AbeGaMqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 08:46:12 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55644 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731503AbeGaMqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 08:46:12 -0400
Received: by mail-wm0-f66.google.com with SMTP id f21-v6so2589780wmc.5;
        Tue, 31 Jul 2018 04:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tSKqY4HyIWCDZ1sJ2ljh/LfVFMdC2Mqlldjoy3L1TXg=;
        b=OmPmZbiiobnzmffj/1W0aWHFpqyOJxj8iiokTlpIU0H1LCyp6j9Lg4M7nQ6kCD4ceq
         YBMZ1FfTEJMoXAUWYtVviAGIxXklKenBGst2tnYHbjn8HJyuYskasHcKNWldQh1Na977
         s8nS3n5yrherace2tGgBn6TQXiQ0uH7DRI7wvrYob1kdFTbrnLoL3gDgE8+kamUjah4g
         NprS9cwQVX8yHrCAp/smgJ1l88R44mo4YP1XG5/r5MIH2nUStTzt8OtNpjpSpCAusBdK
         /XOeS4Z+abTas1wQgSYrNTRHLY9wn95cerszBy3BfZcXm0ZCGdmASV8RIEY98lgq9uDV
         S2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tSKqY4HyIWCDZ1sJ2ljh/LfVFMdC2Mqlldjoy3L1TXg=;
        b=apQo+u+huZEUOVt//vP2C9nKrj528RLyxEr9AgIVaLGeb3rcU6ggFY9UmeMJhxee3r
         Q2q8B1TS95rSoFWWCHpc0Fuv3cv/DyFczrd3LpsH+LOBwbPpEYiwjhRqZNuaYTN9T+9k
         Ygb4Ydn2621N5U9Rk4oCV9M9m+BsXP3TNcoqm9qd6sOaveLBCRiba5s61U2fXrspzG78
         TVONff1ZbLGZGE4BoLgxGC1BWPvm1/XS+EeP59Vy/sYlbxongIr9NJrak/Rptu4Qtdjo
         72j/QuptF7ZIxh9lgpZzLJiks9J8Vu59QW1GthnuOZUqPQqfqjYP47FxfVoBhJfO932I
         xacg==
X-Gm-Message-State: AOUpUlFD0Rnd6EYEGQlvjt2By6HVcqv3Sk8TIepIkzEqibIOBgHuBa0v
        M8KSwj6vW9F/LaX8Z8Kh6tGhqLG/
X-Google-Smtp-Source: AAOMgpcKrpi181d0tN8t+PXNKFd5OS8I7a24xsfHGYKwfzVUkMhaaqJcgz0ss7Js+F8yCBpdBMSU4A==
X-Received: by 2002:a1c:5c7:: with SMTP id 190-v6mr2045827wmf.24.1533035182975;
        Tue, 31 Jul 2018 04:06:22 -0700 (PDT)
Received: from [192.168.1.18] (bli209.neoplus.adsl.tpnet.pl. [83.28.202.209])
        by smtp.gmail.com with ESMTPSA id c15-v6sm1456282wmb.2.2018.07.31.04.06.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 04:06:22 -0700 (PDT)
Subject: Re: [PATCH] leds: add APU3 dmi information to leds-apu
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     pavel@ucw.cz, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eckert.Florian@googlemail.com
References: <20180730091108.30098-1-fe@dev.tdt.de>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <fd75e782-c18d-d1b8-981b-714f2b1080f3@gmail.com>
Date:   Tue, 31 Jul 2018 13:06:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180730091108.30098-1-fe@dev.tdt.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

Thank you for the patch.

Please check the patch, which is in linux-next already:

https://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds.git/commit/?h=for-next&id=8cb21086cc6359c6d4f003a788050308afb211ad

It seems to have added the support you want.

Best regards,
Jacek Anaszewski

On 07/30/2018 11:11 AM, Florian Eckert wrote:
> This driver should also get loaded if this is a APU3 from PC Engines.
> It has the same pin layout for leds.
> 
> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> ---
>  drivers/leds/leds-apu.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/leds/leds-apu.c b/drivers/leds/leds-apu.c
> index 8c93d68964c7..1ed1c5a5dc77 100644
> --- a/drivers/leds/leds-apu.c
> +++ b/drivers/leds/leds-apu.c
> @@ -134,6 +134,14 @@ static const struct dmi_system_id apu_led_dmi_table[] __initconst = {
>  			DMI_MATCH(DMI_BOARD_NAME, "PC Engines apu2")
>  		}
>  	},
> +	/* PC Engines APU3 with "Legancy" bios >= 4.0.7 */
> +	{
> +		.ident = "apu3",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
> +			DMI_MATCH(DMI_BOARD_NAME, "APU3")
> +		}
> +	},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(dmi, apu_led_dmi_table);
> @@ -229,6 +237,7 @@ static int __init apu_led_probe(struct platform_device *pdev)
>  		apu_led->num_led_instances = ARRAY_SIZE(apu1_led_profile);
>  		apu_led->iosize = APU1_IOSIZE;
>  	} else if (dmi_match(DMI_BOARD_NAME, "APU2") ||
> +		   dmi_match(DMI_BOARD_NAME, "APU3") ||
>  		   dmi_match(DMI_BOARD_NAME, "apu2") ||
>  		   dmi_match(DMI_BOARD_NAME, "PC Engines apu2")) {
>  		apu_led->profile = apu2_led_profile;
> @@ -258,6 +267,7 @@ static int __init apu_led_init(void)
>  	}
>  	if (!(dmi_match(DMI_PRODUCT_NAME, "APU") ||
>  	      dmi_match(DMI_PRODUCT_NAME, "APU2") ||
> +	      dmi_match(DMI_PRODUCT_NAME, "APU3") ||
>  	      dmi_match(DMI_PRODUCT_NAME, "apu2") ||
>  	      dmi_match(DMI_PRODUCT_NAME, "PC Engines apu2"))) {
>  		pr_err("Unknown PC Engines board: %s\n",
> 

