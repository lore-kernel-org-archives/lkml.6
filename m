Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0832C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 04:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABAFF21904
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 04:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apiSj1nc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfBNEHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 23:07:05 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35022 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbfBNEHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 23:07:05 -0500
Received: by mail-ot1-f66.google.com with SMTP id z19so8349503otm.2;
        Wed, 13 Feb 2019 20:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3d26dYfwVGiOgp5yoqBa//OJjF3UCcHfaZEftm1Vo9U=;
        b=apiSj1ncDu4V+B7iDlGuHuKhemp6arU3K96gJlLgO2KY2lK4DQQEQ798zExdFb+0ds
         R5T0NeBKYEftfl5IIMnUA2r20hwu35wqUS1ow6S9iM0iL/V/XQm27cnIA5Eb1vAVJ0kQ
         r4sIFnRIDJYkjo21j0P4NbwxGE8wsFnlO6gHl7s7Sj9iIfQjoAHPEsbxbuVwYBbSBhVo
         iGPkA5+qr8NbVqj+tWLP2ikvhI4BQWEBec55K+lqSjcHosFKiEDVqe5uSHvc/PO24CIP
         kWHvRGhFXPxkQp7xIY9Bx/S1MGXlnb8dt/5QRNU0/fjHFCofhYxuhwHIpUoftSHA6o12
         LFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3d26dYfwVGiOgp5yoqBa//OJjF3UCcHfaZEftm1Vo9U=;
        b=Gz+WKAfuwd9T67svi0OkkDnpPiaovRPnryuRgUY40tt451okjg0SZ3S/akuzSh2qX0
         SXbTkvM5bsyJ0io2d8jcr7Kt+EmQMamAwiH2YfeoXHJDesh7M64qhkhSaP5kXlbIiyZp
         gX2lqlGUHllEnk6LyYFvN9M2H/oIooMMn9AtLj9dpDnWZw4Jj6bHOfBKIf37z6B4Eu/F
         RlE1BdPKdVbIW4GRZR3AUcCDxi/pd0UbiR6xi0kRb89oah0q6pZci4YRg7D2Gpr+gx4D
         tm4LD9NZSOERSw/M4Gpui0d3OQk88SIE4RvjBcBBrWqD8S4kC0uqucnGJqIvvU+2J5tG
         V8bw==
X-Gm-Message-State: AHQUAuaVEk3z3rMmR4QQAsnsUxpo8rs6gMkfbVDD9tOuM3++LfFrEmdm
        H1NUQBByU1FRk3bDQhwpRnI=
X-Google-Smtp-Source: AHgI3IZVmYA7Xki1vqxUrq0fdJgLSmXXxv0olTnPyqgiTkVfjdOJJ54iiA06goZ39k5AmOjSeEOmuA==
X-Received: by 2002:aca:720c:: with SMTP id p12mr1040227oic.15.1550117223594;
        Wed, 13 Feb 2019 20:07:03 -0800 (PST)
Received: from [192.168.1.3] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id g19sm572746otl.26.2019.02.13.20.07.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 20:07:02 -0800 (PST)
Subject: Re: [PATCH net-next 1/2] net: phy: marvell: add new m88e1510 LED
 configuration
To:     Jian Shen <shenjian15@huawei.com>, andrew@lunn.ch,
        hkallweit1@gmail.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
References: <1550118667-119947-1-git-send-email-shenjian15@huawei.com>
 <1550118667-119947-2-git-send-email-shenjian15@huawei.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 w0j9Sw==
Message-ID: <da37103d-ad41-7e27-bd6e-3a402bbaf096@gmail.com>
Date:   Wed, 13 Feb 2019 20:06:56 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1550118667-119947-2-git-send-email-shenjian15@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/13/2019 8:31 PM, Jian Shen wrote:
> The default m88e1510 LED configuration is 0x1177, used LED[0]
> for 1000M link, LED[1] for 100M link, and LED[2] for active.
> But for our boards, we want to use 0x1040, which use LED[0] for
> link, and LED[1] for active.
> 
> This patch adds a new m88e1510 LED configuration for it.

There appears to be a precedent with the DNS323 flag that was defined
for the same purpose, but this unfortunately does not scale we cannot
have every new platform come up with its own LED configuration without
having a more structured approach to representing the LED configuration.

Maybe we can encode the desired LED behavior in a more generic way and
utilize the 32 flag bits available to denote a selection, e.g.:

MARVELL_PHY_FLAG_LED0_100M	BIT(3)
MARVELL_PHY_FLAG_LED0_1000M	BIT(4)

etc.

or maybe even better would be to expose the LEDs using the standard LEDs
class subsystem and allow configuring different triggers. We have some
amount of support for PHY LEDs already in tree, but AFAIR what we do not
have support for is a "hardware blinking" trigger which those LEDs are.

> 
> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> ---
>  drivers/net/phy/marvell.c   | 22 +++++++++++++++++++++-
>  include/linux/marvell_phy.h |  1 +
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
> index 3ccba37..c195286 100644
> --- a/drivers/net/phy/marvell.c
> +++ b/drivers/net/phy/marvell.c
> @@ -128,6 +128,10 @@
>  #define MII_PHY_LED_CTRL	        16
>  #define MII_88E1121_PHY_LED_DEF		0x0030
>  #define MII_88E1510_PHY_LED_DEF		0x1177
> +#define MII_88E1510_PHY_HNS3_LED_DEF	0x1040
> +
> +#define MII_88E1510_PHY_LED_POLARITY_CTRL	0x11
> +#define MII_88E1510_PHY_HNS3_LED_POLARITY	0x4415
>  
>  #define MII_M1011_PHY_STATUS		0x11
>  #define MII_M1011_PHY_STATUS_1000	0x8000
> @@ -619,12 +623,19 @@ static void marvell_config_led(struct phy_device *phydev)
>  		def_config = MII_88E1121_PHY_LED_DEF;
>  		break;
>  	/* Default PHY LED config:
> +	 * For hns3:
> +	 * LED[0] .. Link
> +	 * LED[1] .. Activity
> +	 * For others:
>  	 * LED[0] .. 1000Mbps Link
>  	 * LED[1] .. 100Mbps Link
>  	 * LED[2] .. Blink, Activity
>  	 */
>  	case MARVELL_PHY_FAMILY_ID(MARVELL_PHY_ID_88E1510):
> -		def_config = MII_88E1510_PHY_LED_DEF;
> +		if (phydev->dev_flags & MARVELL_PHY_M1510_HNS3_LEDS)
> +			def_config = MII_88E1510_PHY_HNS3_LED_DEF;
> +		else
> +			def_config = MII_88E1510_PHY_LED_DEF;
>  		break;
>  	default:
>  		return;
> @@ -634,6 +645,15 @@ static void marvell_config_led(struct phy_device *phydev)
>  			      def_config);
>  	if (err < 0)
>  		phydev_warn(phydev, "Fail to config marvell phy LED.\n");
> +
> +	if (phydev->dev_flags & MARVELL_PHY_M1510_HNS3_LEDS) {
> +		err = phy_write_paged(phydev, MII_MARVELL_LED_PAGE,
> +				      MII_88E1510_PHY_LED_POLARITY_CTRL,
> +				      MII_88E1510_PHY_HNS3_LED_POLARITY);
> +		if (err < 0)
> +			phydev_warn(phydev,
> +				    "Fail to config marvell phy LED polarity.\n");
> +	}
>  }
>  
>  static int marvell_config_init(struct phy_device *phydev)
> diff --git a/include/linux/marvell_phy.h b/include/linux/marvell_phy.h
> index 1eb6f24..99e0bbb 100644
> --- a/include/linux/marvell_phy.h
> +++ b/include/linux/marvell_phy.h
> @@ -32,5 +32,6 @@
>  /* struct phy_device dev_flags definitions */
>  #define MARVELL_PHY_M1145_FLAGS_RESISTANCE	0x00000001
>  #define MARVELL_PHY_M1118_DNS323_LEDS		0x00000002
> +#define MARVELL_PHY_M1510_HNS3_LEDS		0x00000004
>  
>  #endif /* _MARVELL_PHY_H */
> 

-- 
Florian
