Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C11DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2195720859
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2j2ISJL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfBTT1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 14:27:21 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:41086 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfBTT1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 14:27:21 -0500
Received: by mail-yw1-f65.google.com with SMTP id q128so9653694ywg.8;
        Wed, 20 Feb 2019 11:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xCI00tWHjkjEaxoNefh7kDpFNez/D6hVvwaXy1jPZeA=;
        b=n2j2ISJLXzRf7FReWTsS55B3hf/JzSr0dR5BLjxB5DXb8ye3wJsePfSIXnU49VItCx
         nOcHTGYmziq1f9CaY8g141qExF4JdNfhRbfxfJ5XwMRco1LQ1j3k1ZArnKvYoHMQ3NCY
         1P4o5YY/1eOC8Gws87y7Pj3jkEDQsFWGq2PrWLqVCm7g9nswUPRg2JKBhzQ2hVbf2vyu
         dY/ft5vJQv/v1uEPrw7bWbBmms/XGC86REUWBLZNipIj80GT4HLJwktqHW8NTXIveL/5
         1tmOuyJqiOdQeG9lhUEVmsaBGeykFEzhmY3Qf+Zhx4j7kp46T2fnOGU3lRMZtVHHuVzq
         myGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xCI00tWHjkjEaxoNefh7kDpFNez/D6hVvwaXy1jPZeA=;
        b=NvxSOv6wmJ/c7yOMG/bdC+/Zk8H24t4KklJgqjs/dS4wEZwPmQllb/uRvkQgdQK53T
         lR5dUeuf1qkZxlB3gZbAx/aBXVuBsm/27atddIMJwhkALp90BNQHBQUS+hdgTs2CRkWi
         BSoHyIDvIKH6oYvhnML9LQ76mCCXyAnlt0HsgrZOCpmlgph4SZlCFYs6R0Ehm4MABuNA
         ci5WD+6pKieesitFpODQm6y24icz5D7008U/WBan4G+HVAest3P8qmbBM5sxKUp5xAKV
         +8lV23AUoIjdD5rXpRTzjSJMyknDJutlwxQ2HmZXskyg9WAtp9mdQrU9H/BWIe1EXapx
         nOfA==
X-Gm-Message-State: AHQUAuYVRFkE7MDKkeev2CA+oW6afiX/JngaKFWnMyzxSGPrYhSFoeJu
        Laa0JXFKE3+m32Dn1T0W0zE=
X-Google-Smtp-Source: AHgI3IZgg/GUST1/dCwKOeqJVBvLbAIrierCIj5JQkgZgKFRyjRHUBgfslIMGATMZJcsOd+R6ToODA==
X-Received: by 2002:a81:6044:: with SMTP id u65mr28544918ywb.88.1550690839449;
        Wed, 20 Feb 2019 11:27:19 -0800 (PST)
Received: from [10.67.49.97] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id t136sm9688406ywe.101.2019.02.20.11.27.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 11:27:18 -0800 (PST)
Subject: Re: [PATCH] net: dsa: add missing phy address offset
To:     Marcel Reichmuth <Marcel.Reichmuth@netmodule.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc:     "andrew@lunn.ch" <andrew@lunn.ch>,
        "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>
References: <20190220181426.2970-1-marcel.reichmuth@netmodule.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <d4e6e37b-01c2-3141-8e30-b7e8c252c0ef@gmail.com>
Date:   Wed, 20 Feb 2019 11:27:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190220181426.2970-1-marcel.reichmuth@netmodule.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/19 10:15 AM, Marcel Reichmuth wrote:
> When phys do not start at address 0 like on the mv88e6341 the wrong
> phy address is used and therefore the slave ports can not be
> initialized. This patch adds the proper offset to the phy address.
> 
> Signed-off-by: Marcel Reichmuth <marcel.reichmuth@netmodule.com>

You are supposed to describe the port to PHY mapping using the binding,
so for instance:

ports {
	port@0 {
		reg = <0>;
		phy-handle = <&phy1>;
	};

};

mdio {
	phy1: phy@1 {
		reg = <1>;
	};
};

etc. is not that working for you?

> ---
>  drivers/net/dsa/mv88e6xxx/chip.c | 3 +++
>  include/net/dsa.h                | 1 +
>  net/dsa/slave.c                  | 3 ++-
>  3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
> index 12fd7ce3f1ff..0ca649f784d2 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.c
> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> @@ -2198,12 +2198,15 @@ static int mv88e6xxx_setup_upstream_port(struct mv88e6xxx_chip *chip, int port)
>  static int mv88e6xxx_setup_port(struct mv88e6xxx_chip *chip, int port)
>  {
>  	struct dsa_switch *ds = chip->ds;
> +	struct dsa_port *dp = &ds->ports[port];
>  	int err;
>  	u16 reg;
>  
>  	chip->ports[port].chip = chip;
>  	chip->ports[port].port = port;
>  
> +	dp->phy_base_addr = chip->info->phy_base_addr;
> +
>  	/* MAC Forcing register: don't force link, speed, duplex or flow control
>  	 * state to any particular values on physical ports, but force the CPU
>  	 * port and all DSA ports to their maximum bandwidth and full duplex.
> diff --git a/include/net/dsa.h b/include/net/dsa.h
> index b3eefe8e18fd..f9c9dc1f6d21 100644
> --- a/include/net/dsa.h
> +++ b/include/net/dsa.h
> @@ -196,6 +196,7 @@ struct dsa_port {
>  
>  	struct dsa_switch	*ds;
>  	unsigned int		index;
> +	unsigned int		phy_base_addr;
>  	const char		*name;
>  	const struct dsa_port	*cpu_dp;
>  	struct device_node	*dn;
> diff --git a/net/dsa/slave.c b/net/dsa/slave.c
> index a1c9fe155057..4f67dff34a3b 100644
> --- a/net/dsa/slave.c
> +++ b/net/dsa/slave.c
> @@ -1221,7 +1221,8 @@ static int dsa_slave_phy_setup(struct net_device *slave_dev)
>  		/* We could not connect to a designated PHY or SFP, so use the
>  		 * switch internal MDIO bus instead
>  		 */
> -		ret = dsa_slave_phy_connect(slave_dev, dp->index);
> +		ret = dsa_slave_phy_connect(slave_dev, dp->phy_base_addr +
> +			dp->index);
>  		if (ret) {
>  			netdev_err(slave_dev,
>  				   "failed to connect to port %d: %d\n",
> 


-- 
Florian
