Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C822FC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCBF2147C
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrVjOWlj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CCBF2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbeLAE4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:56:53 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35947 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbeLAE4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 23:56:52 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so2811632pgm.3;
        Fri, 30 Nov 2018 09:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1E36S0GdqXyVW3DouMqy62XGgB3yVS1T3flzBMUaBUc=;
        b=mrVjOWljI7vd5Wvcz7zWogREHlPfpr52VfPHo6hb5V+I+YEl3hhlBvp5ppWt/Vi2iJ
         jji5iSXyHPXJjnPSa2VMLUsWFILuelHy0j5bIqB0cV3XKFXdP8SSpN/qV2pLhTMb8aUQ
         DsmKH8sDrCOOeSSXxvKGsM/qGz6KO+dxDwmZv4kXQ2SdJv79VibCmbaN2K9RbY0Wxs2U
         8HEoUAoXm0mtZuW8JLWGYvZwSQ65yi7+La4pVTzZq2ch2K4NACQFsW98qi5FukRDt4kd
         7kT/yTyZ/mAsXb1v4taVzB0O0zhQoNLXj68M6NO4HcpLwVS4mpkhDS8w+gxvX9apB/Ed
         UfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1E36S0GdqXyVW3DouMqy62XGgB3yVS1T3flzBMUaBUc=;
        b=Lh+WZNQ+sV7wNoCNuphpljH44SppEoQCGUAcWP+ClQ2nyPEWEECh5Tuko0FhaC23BJ
         09WrQmooJhzRszzeaNY1u6WJn/N8zSDqtIHlghwzN0/r8LhRELeKtwmMVRa2iqGe7jvo
         bD16Vb3JjrHjoVTvlxLxkz2Egtr1zChhpm+QPQcS0KVu+mPOraxpmejRcrcmvLCwb8K/
         xW3wKumc+fwCKgc/jdbMYJAGy7inp0pKJdzlhzQP7boa4EsIz6J3Y9jsSLBKP8pxxwPD
         MD8q21bJrSMANzsth9kJKID4gHrxySZdViwLw7B6sWDZ/gGj8Sg5cU6a1fX20GTT0ii9
         iEVQ==
X-Gm-Message-State: AA+aEWZXPAto/RKhsuEh+KlZNwdASaw/W9dxIJROrOHCsRrKwelMOZBv
        6wSjbYU7j7xL1qxZjBIs0JxN1K/C
X-Google-Smtp-Source: AFSGD/VaBZrCuOfIGircS68keshEw1U9myenXzTP7IUHUbH7CvD6cZaJoOx4skJD6ycURlQiZAxfRw==
X-Received: by 2002:a62:2f06:: with SMTP id v6mr6621052pfv.216.1543600009465;
        Fri, 30 Nov 2018 09:46:49 -0800 (PST)
Received: from [10.69.78.41] (igp-prod-emp-gw.vpn.broadcom.com. [192.19.223.250])
        by smtp.gmail.com with ESMTPSA id 4sm9271225pfq.10.2018.11.30.09.46.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 09:46:48 -0800 (PST)
Subject: Re: [RFC PATCH net v2] net: phy: Fix the issue that netif always
 links up after resuming
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1543569916-8714-1-git-send-email-hayashi.kunihiko@socionext.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 w0j9Sw==
Message-ID: <26e04d2e-16e5-ac0b-daab-931b8f5a0103@gmail.com>
Date:   Fri, 30 Nov 2018 09:46:42 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <1543569916-8714-1-git-send-email-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/30/2018 1:25 AM, Kunihiko Hayashi wrote:
> Even though the link is down before entering hibernation,
> there is an issue that the network interface always links up after resuming
> from hibernation.
> 
> The phydev->state is PHY_READY before enabling the network interface, so
> the link is down. After resuming from hibernation, the phydev->state is
> forcibly set to PHY_UP in mdio_bus_phy_restore(), and the link becomes up.
> 
> This patch adds a new convenient function to check whether the PHY is in
> a started state, and expects to solve the issue by changing phydev->state
> to PHY_UP and calling phy_start_machine() only when the PHY is started.
> 
> Suggested-by: Heiner Kallweit <hkallweit1@gmail.com>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/net/phy/phy.c        |  2 +-
>  drivers/net/phy/phy_device.c |  9 +++++----
>  include/linux/phy.h          | 10 ++++++++++
>  3 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index 1d73ac3..f484d03 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -670,7 +670,7 @@ void phy_stop_machine(struct phy_device *phydev)
>  	cancel_delayed_work_sync(&phydev->state_queue);
>  
>  	mutex_lock(&phydev->lock);
> -	if (phydev->state > PHY_UP && phydev->state != PHY_HALTED)
> +	if (phy_is_started(phydev))
>  		phydev->state = PHY_UP;
>  	mutex_unlock(&phydev->lock);
>  }
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index ab33d17..2c39717 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -309,10 +309,11 @@ static int mdio_bus_phy_restore(struct device *dev)
>  		return ret;
>  
>  	/* The PHY needs to renegotiate. */
> -	phydev->link = 0;
> -	phydev->state = PHY_UP;
> -
> -	phy_start_machine(phydev);
> +	if (phy_is_started(phydev)) {
> +		phydev->link = 0;
> +		phydev->state = PHY_UP;
> +		phy_start_machine(phydev);
> +	}

Don't you need some of these steps to be performed under phydev->lock
being held? See comment below.

>  
>  	return 0;
>  }
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 3ea87f7..c194b45 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -898,6 +898,16 @@ static inline bool phy_is_pseudo_fixed_link(struct phy_device *phydev)
>  }
>  
>  /**
> + * phy_is_started - Convenience function for testing whether a PHY is in
> + * a started state
> + * @phydev: the phy_device struct
> + */
> +static inline bool phy_is_started(struct phy_device *phydev)
> +{

An assert with the phydev->lock mutex being held here would greatly
help, because otherwise this is possibly racy.

> +	return phydev->state >= PHY_UP && phydev->state != PHY_HALTED;
> +}
> +
> +/**
>   * phy_write_mmd - Convenience function for writing a register
>   * on an MMD on a given PHY.
>   * @phydev: The phy_device struct
> 

-- 
Florian
