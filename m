Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74BFC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61DC9218D9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dl7ykdol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfBFWlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 17:41:46 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43517 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfBFWlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 17:41:46 -0500
Received: by mail-pg1-f193.google.com with SMTP id v28so3574102pgk.10;
        Wed, 06 Feb 2019 14:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C3cIXs3PBKgBwELU3PhWk3i8UkgItaf96hNL1qRLLXY=;
        b=Dl7ykdolPrfmaHQ4Xk8YINktAl7t/lX5ZEoeZx7wdK8lLsPrf3akN5gVscH15hv9a5
         M9BX5VKPjhQcOvfdfILpl6L9emSEc+pNXfStEvqipwJME6Sv5voEAgLflB0AhzRBClOO
         jQOj2w/BBNVj4U+w0a+5mBT71vqyFuqKB31q1jU3XjmqH5RgIReycqI4FWY7TgkQlepe
         s2dgybWNpyUM5DGM6hF1rc62kfdulXW+1xOPNSDf/Fn0yqgoo0J05+0kk0yXhjSWlFKt
         unssHPBbR4x4ABvyp3B4OlpjhI9QOoYn9dW5cHqcr/h1b5niiTh8M50A4j4+rN7Vx6xb
         aAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=C3cIXs3PBKgBwELU3PhWk3i8UkgItaf96hNL1qRLLXY=;
        b=nES++4d+U4LzjIfDdJT9R4bpYyM9T+6JCkkmkFDBwKULxxBPsO8x7mJrXJRda7ZvOk
         Za2OA75IzkC9Tr5zcsS+bPkQd+dzk+sIm0vyrGMTM6tDMHLx/dfO2ttdk0ZHkZ+vb1a1
         7/ysTAzW9PYQnbbwxlxjeNwQYMzEbyQSM1fweLCscPmqWwnP4bdzzONeJ8jVKNwVFPEm
         zjUeM73VE9NI9wMp8mY0rwg9jb9jOIXw/9P1R6WGgJQ44UM7S5Sj2mFrSK1Xb00Le17v
         r097rNd8mzGvlOCw1n8S8CQ5WRCynrzfiNSTmXDd6s0vZC8149EmlHYxXKmZSplhm/JQ
         jzJw==
X-Gm-Message-State: AHQUAuYxSedIFIip4n5IY9bccxoho65b+ZzjfMGo/eTlXIWvxiLq39XB
        oPC9fdpTTk0sGe6wLwQGihY=
X-Google-Smtp-Source: AHgI3IYAu8clKdyoLmOHGbjG5wRJ+2itnW23OCyOHBjpxqTQCvN4krZVEQOapjIuYuj1Fo5d38xOdw==
X-Received: by 2002:a63:c503:: with SMTP id f3mr11618336pgd.431.1549492905015;
        Wed, 06 Feb 2019 14:41:45 -0800 (PST)
Received: from [10.67.48.231] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id d11sm8754455pgi.25.2019.02.06.14.41.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 14:41:44 -0800 (PST)
Subject: Re: [RFC net-next] net: fixed_phy: Move the DT based link GPIO
 parsing to of_mdio.c
To:     Moritz Fischer <mdf@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, colin.king@canonical.com,
        linus.walleij@linaro.org, yuehaibing@huawei.com, mcgrof@kernel.org,
        frowand.list@gmail.com, robh+dt@kernel.org,
        UNGLinuxDriver@microchip.com, woojung.huh@microchip.com,
        hkallweit1@gmail.com, davem@davemloft.net,
        vivien.didelot@gmail.com, moritz@ettus.com, alex.williams@ni.com
References: <20190206205106.11517-1-mdf@kernel.org>
 <20190206215322.GC32483@lunn.ch> <20190206223846.GA22321@archbook>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <bc0321e5-5842-6941-b620-7075a3ef4d71@gmail.com>
Date:   Wed, 6 Feb 2019 14:41:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190206223846.GA22321@archbook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/19 2:38 PM, Moritz Fischer wrote:
> Hi Andrew,
> 
> thanks for your feedback.
> 
> On Wed, Feb 06, 2019 at 10:53:22PM +0100, Andrew Lunn wrote:
>> On Wed, Feb 06, 2019 at 12:51:06PM -0800, Moritz Fischer wrote:
>>> Move the DT based link GPIO parsing to of_mdio and let the places
>>> that register a fixed_phy pass in a GPIO descriptor or NULL.
>>>
>>> This allows fixed_phy on non-DT platforms to have link GPIOs, too.
>>>
>>> Signed-off-by: Moritz Fischer <mdf@kernel.org>
>>> ---
>>>  drivers/net/dsa/dsa_loop.c                   |  2 +-
>>>  drivers/net/ethernet/broadcom/bgmac.c        |  2 +-
>>>  drivers/net/ethernet/broadcom/genet/bcmmii.c |  2 +-
>>>  drivers/net/phy/fixed_phy.c                  | 48 ++------------------
>>>  drivers/net/usb/lan78xx.c                    |  2 +-
>>>  drivers/of/of_mdio.c                         | 15 +++++-
>>>  include/linux/phy_fixed.h                    |  3 +-
>>>  7 files changed, 23 insertions(+), 51 deletions(-)
>>>
>>> diff --git a/drivers/net/dsa/dsa_loop.c b/drivers/net/dsa/dsa_loop.c
>>> index 17482ae09aa5..7f124c620092 100644
>>> --- a/drivers/net/dsa/dsa_loop.c
>>> +++ b/drivers/net/dsa/dsa_loop.c
>>> @@ -343,7 +343,7 @@ static int __init dsa_loop_init(void)
>>>  	unsigned int i;
>>>  
>>>  	for (i = 0; i < NUM_FIXED_PHYS; i++)
>>> -		phydevs[i] = fixed_phy_register(PHY_POLL, &status, NULL);
>>> +		phydevs[i] = fixed_phy_register(PHY_POLL, &status, NULL, NULL);
>>>  
>>>  	return mdio_driver_register(&dsa_loop_drv);
>>>  }
>>> diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
>>> index 4632dd5dbad1..bce644dec5c2 100644
>>> --- a/drivers/net/ethernet/broadcom/bgmac.c
>>> +++ b/drivers/net/ethernet/broadcom/bgmac.c
>>> @@ -1446,7 +1446,7 @@ int bgmac_phy_connect_direct(struct bgmac *bgmac)
>>>  	struct phy_device *phy_dev;
>>>  	int err;
>>>  
>>> -	phy_dev = fixed_phy_register(PHY_POLL, &fphy_status, NULL);
>>> +	phy_dev = fixed_phy_register(PHY_POLL, &fphy_status, NULL, NULL);
>>>  	if (!phy_dev || IS_ERR(phy_dev)) {
>>>  		dev_err(bgmac->dev, "Failed to register fixed PHY device\n");
>>>  		return -ENODEV;
>>> diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
>>> index 51880d83131a..7cbd737aba80 100644
>>> --- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
>>> +++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
>>> @@ -525,7 +525,7 @@ static int bcmgenet_mii_pd_init(struct bcmgenet_priv *priv)
>>>  			.asym_pause = 0,
>>>  		};
>>>  
>>> -		phydev = fixed_phy_register(PHY_POLL, &fphy_status, NULL);
>>> +		phydev = fixed_phy_register(PHY_POLL, &fphy_status, NULL, NULL);
>>>  		if (!phydev || IS_ERR(phydev)) {
>>>  			dev_err(kdev, "failed to register fixed PHY device\n");
>>>  			return -ENODEV;
>>> diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
>>> index d810f914aaa4..845bd7c2065a 100644
>>> --- a/drivers/net/phy/fixed_phy.c
>>> +++ b/drivers/net/phy/fixed_phy.c
>>> @@ -18,6 +18,7 @@
>>>  #include <linux/err.h>
>>>  #include <linux/slab.h>
>>>  #include <linux/of.h>
>>> +#include <linux/of_mdio.h>
>>>  #include <linux/gpio/consumer.h>
>>>  #include <linux/seqlock.h>
>>>  #include <linux/idr.h>
>>> @@ -191,50 +192,12 @@ static void fixed_phy_del(int phy_addr)
>>>  	}
>>>  }
>>>  
>>> -#ifdef CONFIG_OF_GPIO
>>> -static struct gpio_desc *fixed_phy_get_gpiod(struct device_node *np)
>>> -{
>>> -	struct device_node *fixed_link_node;
>>> -	struct gpio_desc *gpiod;
>>> -
>>> -	if (!np)
>>> -		return NULL;
>>> -
>>> -	fixed_link_node = of_get_child_by_name(np, "fixed-link");
>>> -	if (!fixed_link_node)
>>> -		return NULL;
>>> -
>>> -	/*
>>> -	 * As the fixed link is just a device tree node without any
>>> -	 * Linux device associated with it, we simply have obtain
>>> -	 * the GPIO descriptor from the device tree like this.
>>> -	 */
>>> -	gpiod = gpiod_get_from_of_node(fixed_link_node, "link-gpios", 0,
>>> -				       GPIOD_IN, "mdio");
>>> -	of_node_put(fixed_link_node);
>>> -	if (IS_ERR(gpiod)) {
>>> -		if (PTR_ERR(gpiod) == -EPROBE_DEFER)
>>> -			return gpiod;
>>> -		pr_err("error getting GPIO for fixed link %pOF, proceed without\n",
>>> -		       fixed_link_node);
>>> -		gpiod = NULL;
>>> -	}
>>> -
>>> -	return gpiod;
>>> -}
>>> -#else
>>> -static struct gpio_desc *fixed_phy_get_gpiod(struct device_node *np)
>>> -{
>>> -	return NULL;
>>> -}
>>> -#endif
>>> -
>>>  struct phy_device *fixed_phy_register(unsigned int irq,
>>>  				      struct fixed_phy_status *status,
>>> -				      struct device_node *np)
>>> +				      struct device_node *np,
>>> +				      struct gpio_desc *gpiod)
>>>  {
>>>  	struct fixed_mdio_bus *fmb = &platform_fmb;
>>> -	struct gpio_desc *gpiod = NULL;
>>>  	struct phy_device *phy;
>>>  	int phy_addr;
>>>  	int ret;
>>> @@ -242,11 +205,6 @@ struct phy_device *fixed_phy_register(unsigned int irq,
>>>  	if (!fmb->mii_bus || fmb->mii_bus->state != MDIOBUS_REGISTERED)
>>>  		return ERR_PTR(-EPROBE_DEFER);
>>>  
>>> -	/* Check if we have a GPIO associated with this fixed phy */
>>> -	gpiod = fixed_phy_get_gpiod(np);
>>> -	if (IS_ERR(gpiod))
>>> -		return ERR_CAST(gpiod);
>>> -
>>>  	/* Get the next available PHY address, up to PHY_MAX_ADDR */
>>>  	phy_addr = ida_simple_get(&phy_fixed_ida, 0, PHY_MAX_ADDR, GFP_KERNEL);
>>>  	if (phy_addr < 0)
>>> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
>>> index 3d92ea6fcc02..bd88f0aef2fa 100644
>>> --- a/drivers/net/usb/lan78xx.c
>>> +++ b/drivers/net/usb/lan78xx.c
>>> @@ -2051,7 +2051,7 @@ static struct phy_device *lan7801_phy_init(struct lan78xx_net *dev)
>>>  	phydev = phy_find_first(dev->mdiobus);
>>>  	if (!phydev) {
>>>  		netdev_dbg(dev->net, "PHY Not Found!! Registering Fixed PHY\n");
>>> -		phydev = fixed_phy_register(PHY_POLL, &fphy_status, NULL);
>>> +		phydev = fixed_phy_register(PHY_POLL, &fphy_status, NULL, NULL);
>>>  		if (IS_ERR(phydev)) {
>>>  			netdev_err(dev->net, "No PHY/fixed_PHY found\n");
>>>  			return NULL;
>>> diff --git a/drivers/of/of_mdio.c b/drivers/of/of_mdio.c
>>> index de6157357e26..6be2120b5f03 100644
>>> --- a/drivers/of/of_mdio.c
>>> +++ b/drivers/of/of_mdio.c
>>> @@ -20,6 +20,7 @@
>>>  #include <linux/of_mdio.h>
>>>  #include <linux/of_net.h>
>>>  #include <linux/module.h>
>>> +#include <linux/gpio/consumer.h>
>>>  
>>>  #define DEFAULT_GPIO_RESET_DELAY	10	/* in microseconds */
>>>  
>>> @@ -460,6 +461,7 @@ int of_phy_register_fixed_link(struct device_node *np)
>>>  {
>>>  	struct fixed_phy_status status = {};
>>>  	struct device_node *fixed_link_node;
>>> +	struct gpio_desc *gpiod = NULL;
>>>  	u32 fixed_link_prop[5];
>>>  	const char *managed;
>>>  
>>> @@ -483,7 +485,17 @@ int of_phy_register_fixed_link(struct device_node *np)
>>>  		status.pause = of_property_read_bool(fixed_link_node, "pause");
>>>  		status.asym_pause = of_property_read_bool(fixed_link_node,
>>>  							  "asym-pause");
>>> +
>>> +		gpiod = gpiod_get_from_of_node(fixed_link_node, "link-gpios", 0,
>>> +				       GPIOD_IN, "mdio");
>>>  		of_node_put(fixed_link_node);
>>> +		if (IS_ERR(gpiod)) {
>>> +			if (PTR_ERR(gpiod) == -EPROBE_DEFER)
>>> +				return PTR_ERR(gpiod);
>>> +			pr_err("error getting GPIO for fixed link %pOF, proceed without\n",
>>> +			       fixed_link_node);
>>> +			gpiod = NULL;
>>>  extern struct phy_device *fixed_phy_register(unsigned int irq,
>>>  					     struct fixed_phy_status *status,
>>> -					     struct device_node *np);
>>> +					     struct device_node *np,
>>> +					     struct gpio_desc *gpiod);
>>
>> Hi Moritz
>>
>> I think it would be better to add a 
>>
>> extern struct phy_device *fixed_phy_register_gpiod(unsigned int irq,
>>      					     struct fixed_phy_status *status,
>> 					     struct gpio_desc *gpiod);
>>
>> If you are not using DT, the np is pointless. So lets keep the API
>> simple.
> 
> To clarify: Do you agree with moving the parsing to of_mdio, or do you
> want to keep the parsing as it was and just add an additional function.
> 
> In the latter case you'd have a
> static struct phy_device *__fixed_phy_register(unsigned int irq,
> 					       struct fixed_phy_status *status,
> 					       struct device_node *np,
> 					       struct gpio_desc *gpiod)
> {
> if (gpiod)
>    use that
> else
>    old behavior / scan dt?
> }
> 
> That we then call from fixed_phy_register_gpiod() with a np of NULL,
> and from fixed_phy_register() with a gpiod of NULL?

If you have existing users in tree, of something like:

foo(a, b, c)

and you want to introduce a "d" argument, it's a good practice to do:

foo(a, b, c) -> __foo(a, b, c, 0)
foo_with_d(a, b, c, d) __foo(a, b, c, d)

and have the body of foo() become __foo() while taking the new argument.

Hope this is clear.
-- 
Florian
