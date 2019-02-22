Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3E2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E3C205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPZWTvmk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfBVSmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:42:39 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39584 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfBVSmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:42:39 -0500
Received: by mail-wr1-f68.google.com with SMTP id l5so3440635wrw.6;
        Fri, 22 Feb 2019 10:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TGjiaNf+TchAJ9Gtpr3tqaggBXdzik2vcZtd+3yyA38=;
        b=IPZWTvmkrMYwaPO/jRG33qshvJWYRMqruTRJb+clDaZnpI1ghbvZl64rmb5HxoRNOp
         a5kZTm8JqKmiSEAeOXqKsyEWhulm7q9Ms2hpTSk949IG9Ol0his9RW6x/yNc7i4vRz7t
         MUzNEyA/hgoBVGC2R5ZD+N2JIbxydJ2I9jagvflxQyZEwzfmvYY/nIiD5jVyuTiG8+x1
         4im4orCPAke8lJpk98ZZEJq7yFWp16SZIm2ckWtGsAHP92CL4fKOQk13e9YB/rCThKgF
         fwVH1VFaUp5PfrraFfpbVNwWTImzMP9ZWZrjyizCgYDyOWWhwkDdGiVat9Rl5M6mOcRi
         G2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TGjiaNf+TchAJ9Gtpr3tqaggBXdzik2vcZtd+3yyA38=;
        b=g3KYTdURBNUuk34DWM3jqiIEvYgC6adSwJtwGlJkWoBDqfbEYbvEfKaUUOCv574OAA
         EtTwgiFwdcXz8lvSOWLxRE/mwxtuSb7IEBHzc4L1+Y5qrcBOBWj0tCcBF+6kVw7xMPK9
         aR00aHrFGBjrYMm0j4yU4vX6kyUowkm7R9oQ/TlD06T5FtDafswv+f4ssgSkaL4aTmuB
         KRuL+7eXoDLiAY0Sab4gHnS9xGED2a4zUA7WJa7Abe74LSbbSa8IgDoI8oN8MTXXBN9Y
         joOyIJF4F6XHRs19UCOQIfqdFkc1qK3Swt+bIJ2EsXwmpeYcNfKX9hPyV/RNrb8FiRGH
         aTAA==
X-Gm-Message-State: AHQUAuYLItLxN8hqNIz17ktL1SviXHXruTxMkcqOBd9k1SpVsMsRvEGG
        k+0n1S7eCMdFrrAa2ULF1p8=
X-Google-Smtp-Source: AHgI3IZdPsGfCh6i9nnFkKpECl3oQ3s6Gqev41iTPMDF0ifz+gaFIftr3h+jrl0+XBpICN2zVS13/w==
X-Received: by 2002:adf:ff81:: with SMTP id j1mr4038281wrr.261.1550860956942;
        Fri, 22 Feb 2019 10:42:36 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:881a:e62a:a902:5b57? (p200300EA8BF1E200881AE62AA9025B57.dip0.t-ipconnect.de. [2003:ea:8bf1:e200:881a:e62a:a902:5b57])
        by smtp.googlemail.com with ESMTPSA id m26sm1148509wmg.13.2019.02.22.10.42.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 10:42:35 -0800 (PST)
Subject: Re: [PATCH net-next 1/7] net: phy: marvell10g: Use get_features to
 get the PHY abilities
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com
References: <20190221095128.28188-1-maxime.chevallier@bootlin.com>
 <20190221095128.28188-2-maxime.chevallier@bootlin.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <a69da540-fe5c-e9a7-d848-2f2c61011f21@gmail.com>
Date:   Fri, 22 Feb 2019 19:42:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190221095128.28188-2-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.02.2019 10:51, Maxime Chevallier wrote:
> The Alaska family of 10G PHYs has more abilities than the ones listed in
> PHY_10GBIT_FULL_FEATURES, the exact list depending on the model.
> 
> Make use of the newly introduced .get_features call to build this list,
> using genphy_c45_pma_read_abilities to build the list of supported
> linkmodes, and adding autoneg ability based on what's reported by the AN
> MMD.
> 
> .config_init is still used to validate the interface_mode.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  drivers/net/phy/marvell10g.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
> index 9ea27acf05ad..65ef469adf58 100644
> --- a/drivers/net/phy/marvell10g.c
> +++ b/drivers/net/phy/marvell10g.c
> @@ -233,8 +233,6 @@ static int mv3310_resume(struct phy_device *phydev)
>  
>  static int mv3310_config_init(struct phy_device *phydev)
>  {
> -	int ret, val;
> -
>  	/* Check that the PHY interface type is compatible */
>  	if (phydev->interface != PHY_INTERFACE_MODE_SGMII &&
>  	    phydev->interface != PHY_INTERFACE_MODE_XAUI &&
> @@ -242,6 +240,12 @@ static int mv3310_config_init(struct phy_device *phydev)
>  	    phydev->interface != PHY_INTERFACE_MODE_10GKR)
>  		return -ENODEV;
>  
> +	return 0;
> +}
> +
> +static int mv3310_get_features(struct phy_device *phydev)
> +{

After my just submitted patch to include the aneg capability checking in
genphy_c45_pma_read_abilities() function mv3310_get_features() isn't
needed any longer and can be replaced with the generic one.
But we can make this change afterwards, then you don't have to
rework your series.

Also I'm not sure whether there will be a 5.0-rc8 or whether beginning
of next week we'll see 5.0. In the latter case we're a little bit in a
hurry because the merge window will start very soon.

> +	int ret, val;
>  	if (phydev->c45_ids.devices_in_package & MDIO_DEVS_AN) {
>  		val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_STAT1);
>  		if (val < 0)
> @@ -429,7 +433,7 @@ static struct phy_driver mv3310_drivers[] = {
>  		.phy_id		= 0x002b09aa,
>  		.phy_id_mask	= MARVELL_PHY_ID_MASK,
>  		.name		= "mv88x3310",
> -		.features	= PHY_10GBIT_FEATURES,
> +		.get_features	= mv3310_get_features,
>  		.soft_reset	= gen10g_no_soft_reset,
>  		.config_init	= mv3310_config_init,
>  		.probe		= mv3310_probe,
> 

