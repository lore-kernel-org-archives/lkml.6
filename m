Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B143C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 18:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 116F020840
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 18:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qNc359eJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 116F020840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbeKKEZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 23:25:46 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41194 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbeKKEZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 23:25:46 -0500
Received: by mail-pl1-f196.google.com with SMTP id p16-v6so2385877plr.8;
        Sat, 10 Nov 2018 10:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B+4RL4aj72vyDIMyLQLtC/rs2rCJOjZohOT6coq0iA0=;
        b=qNc359eJ9eroU8Ts4reeOBOy1AhRl7yaY3SwPYBE8p43QDsnwFbZRh69dY7b7f4E45
         wF611YAUSyeURxDVjDLiNEZsUSIAVHd+KFWU1tivs9Vmf9JerVJfm1c6ejL3LqRscV6T
         S6gIqRaoi9EePPLJwfNpEHT/dXau/uLoHw+KERmq9cyPJn5aQetszXk/OlHZuBIpvGoj
         a0z2HLnjEdog+rAHtxtrMXCnQkWj9gF6XczpokK4O3U/M7sLcHOHT918FJWaj5lKdLxY
         J1rNYsAOB0HH7kx/YWHE2+x2GOAC9btmg4wKHo6ODaJdmQFgIhcELCfWq5h2Fs3vnYlc
         a1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B+4RL4aj72vyDIMyLQLtC/rs2rCJOjZohOT6coq0iA0=;
        b=ATKNl83l3Gmu08z/YxmUQJUBJY1R9P+hYvFYoYDAQqyIskATpHMQY75y8sDZgxWD38
         1+SAB93Us/zTLMHAd5hIvKyEDYoCaVN1Q/dLSi/RKhvEMVB/rkKyafqYBlup5dlmkcga
         +ap47pMEUn1gDm4orKC5RaIWBq+fRAvnlJgJOtXkZdGam8FzEAKOpJ/gQkwTtOuILxwk
         +cnhzSCJn0kdJrgfAQhrgqTYg/gIwTvYnI6Jk9Uw2gJL78eisKpjzdRWPUe1OvE1usa5
         m6DFhlA+hG5UFJNqUVpynKtJgTM/SI9Du/gV7d2ca+LvFo7O8mW2liMLVHPOpBGe8mfh
         ORzw==
X-Gm-Message-State: AGRZ1gIg4JL3EIAabH65gcASrxi2RtEHf6vLQ6TqXqlH8lSxhIEJFPYA
        VbYpDRvXgxDWPo9kBOFTJ9s=
X-Google-Smtp-Source: AJdET5eG+MoRTbb5MvtpAZ0hmeO2agCiIiVAQepAhO4B/LAJJby1F32obBs2cWnqtpTCzxbf8tVdLg==
X-Received: by 2002:a17:902:be0e:: with SMTP id r14-v6mr5107461pls.23.1541875189087;
        Sat, 10 Nov 2018 10:39:49 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h7-v6sm16416016pfd.35.2018.11.10.10.39.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Nov 2018 10:39:48 -0800 (PST)
Subject: Re: [PATCH v1 2/5] extcon: Return -EPROBE_DEFER when extcon device is
 not found
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Roger Quadros <rogerq@ti.com>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>
References: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com>
 <20181110181101.24557-2-andriy.shevchenko@linux.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <45b05f7f-26e4-8137-febc-de12848d30b0@roeck-us.net>
Date:   Sat, 10 Nov 2018 10:39:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181110181101.24557-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/18 10:10 AM, Andy Shevchenko wrote:
> All current users of extcon_get_extcon_dev() API considers
> an extcon device a mandatory to appear. Thus, they all convert
> NULL pointer to -EPROBE_DEFER error code.
> 
> There is one more caller anticipated with the same requirements.
> 
> To decrease a code duplication and a burden to the callers,
> return -EPROBE_DEFER directly from extcon_get_extcon_dev().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/extcon/extcon-axp288.c        | 4 ++--
>   drivers/extcon/extcon.c               | 2 +-
>   drivers/power/supply/axp288_charger.c | 8 ++++----
>   drivers/usb/phy/phy-omap-otg.c        | 6 +++---
>   drivers/usb/typec/tcpm/fusb302.c      | 4 ++--
>   5 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
> index a983708b77a6..3472d3b756ed 100644
> --- a/drivers/extcon/extcon-axp288.c
> +++ b/drivers/extcon/extcon-axp288.c
> @@ -360,8 +360,8 @@ static int axp288_extcon_probe(struct platform_device *pdev)
>   		name = acpi_dev_get_first_match_name("INT3496", NULL, -1);
>   		if (name) {
>   			info->id_extcon = extcon_get_extcon_dev(name);
> -			if (!info->id_extcon)
> -				return -EPROBE_DEFER;
> +			if (IS_ERR(info->id_extcon))
> +				return PTR_ERR(info->id_extcon);
>   
>   			dev_info(dev, "controlling USB role\n");
>   		} else {
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index 5ab0498be652..2bd0f2f33f05 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -884,7 +884,7 @@ struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name)
>   		if (!strcmp(sd->name, extcon_name))
>   			goto out;
>   	}
> -	sd = NULL;
> +	sd = ERR_PTR(-EPROBE_DEFER);
>   out:
>   	mutex_unlock(&extcon_dev_list_lock);
>   	return sd;
> diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
> index 735658ee1c60..8558577fccf5 100644
> --- a/drivers/power/supply/axp288_charger.c
> +++ b/drivers/power/supply/axp288_charger.c
> @@ -768,17 +768,17 @@ static int axp288_charger_probe(struct platform_device *pdev)
>   	info->regmap_irqc = axp20x->regmap_irqc;
>   
>   	info->cable.edev = extcon_get_extcon_dev(AXP288_EXTCON_DEV_NAME);
> -	if (info->cable.edev == NULL) {
> +	if (IS_ERR(info->cable.edev)) {
>   		dev_dbg(&pdev->dev, "%s is not ready, probe deferred\n",
>   			AXP288_EXTCON_DEV_NAME);
> -		return -EPROBE_DEFER;
> +		return PTR_ERR(info->cable.edev);
>   	}
>   
>   	if (acpi_dev_present(USB_HOST_EXTCON_HID, NULL, -1)) {
>   		info->otg.cable = extcon_get_extcon_dev(USB_HOST_EXTCON_NAME);
> -		if (info->otg.cable == NULL) {
> +		if (IS_ERR(info->otg.cable)) {
>   			dev_dbg(dev, "EXTCON_USB_HOST is not ready, probe deferred\n");
> -			return -EPROBE_DEFER;
> +			return PTR_ERR(info->otg.cable);
>   		}
>   		dev_info(&pdev->dev,
>   			 "Using " USB_HOST_EXTCON_HID " extcon for usb-id\n");
> diff --git a/drivers/usb/phy/phy-omap-otg.c b/drivers/usb/phy/phy-omap-otg.c
> index ee0863c6553e..605314ddcd3d 100644
> --- a/drivers/usb/phy/phy-omap-otg.c
> +++ b/drivers/usb/phy/phy-omap-otg.c
> @@ -91,12 +91,12 @@ static int omap_otg_probe(struct platform_device *pdev)
>   	int ret;
>   	u32 rev;
>   
> -	if (!config || !config->extcon)
> +	if (!config)
>   		return -ENODEV;
>   
>   	extcon = extcon_get_extcon_dev(config->extcon);
> -	if (!extcon)
> -		return -EPROBE_DEFER;
> +	if (IS_ERR(extcon))
> +		return PTR_ERR(extcon);
>   
>   	otg_dev = devm_kzalloc(&pdev->dev, sizeof(*otg_dev), GFP_KERNEL);
>   	if (!otg_dev)
> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> index 43b64d9309d0..6d332066202b 100644
> --- a/drivers/usb/typec/tcpm/fusb302.c
> +++ b/drivers/usb/typec/tcpm/fusb302.c
> @@ -1767,8 +1767,8 @@ static int fusb302_probe(struct i2c_client *client,
>   	 */
>   	if (device_property_read_string(dev, "fcs,extcon-name", &name) == 0) {
>   		chip->extcon = extcon_get_extcon_dev(name);
> -		if (!chip->extcon)
> -			return -EPROBE_DEFER;
> +		if (IS_ERR(chip->extcon))
> +			return PTR_ERR(chip->extcon);
>   	}
>   
>   	chip->vbus = devm_regulator_get(chip->dev, "vbus");
> 

