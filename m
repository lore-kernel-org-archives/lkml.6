Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B46C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F63520652
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lR9tMH7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F63520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbeIAADo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 20:03:44 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36044 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbeIAADo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 20:03:44 -0400
Received: by mail-pl1-f193.google.com with SMTP id e11-v6so5930516plb.3;
        Fri, 31 Aug 2018 12:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O2+RyoXwP1vFHEXqc+YrucjUc4oPR7efDkfHldZt5TM=;
        b=lR9tMH7wpDejLio/+R0E9VZCb6BceDPmAiL8C7ZBwYnDsPLOEkZ8YdVCO0xBBkdipi
         ckxh16xGx94g2qhF5oQbXhZVbqZIVrRy3hIs9ETp7V7Z2INxW7vvqnYUOymGstfQP7EI
         AjLC9ctJyXbYZgT0iMufVJsv3IxOHN6rAXfOGqz6UOzs4AWtqbUMe1Isfpy6oT31igtk
         IRnx3ceLnuXCPH9gyr86VDOJmvkXD5EaROIzAwcdf/k8xrIIZg9OQnLMh7x3bGlSuLLm
         2bb/SVrf2RcAf25ce8M1LcentHObTio9MdPorAx5rPHdqYDyYV3WolhxJS/mlktnyiB0
         I60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O2+RyoXwP1vFHEXqc+YrucjUc4oPR7efDkfHldZt5TM=;
        b=ecl1BLBEFTJPmPRzEtOY/x2QaEukTwgi2OmUpzuuhpzZBYgEEHK+qXXNumKmnrcAGy
         +FSbWv3w90c5CJf7zWNigJLVanD9RY34011zhZ5PC3v1pr6pTZp34kDHHCRHEfxKDsjR
         k2qfCMPWA3qeTP18qru+p3ks+WrCxXr9wQ0U/TdZ5x1racKvPZtAhADKhcfaUg8Gn2GX
         Tr09D6Ks702wWE1HlrskHREsZORrVpSFgxeciRb5+F00kaAZ72LsHYYkwzjXuo4U3IOR
         rv71gsAMO4L3O9QzwBZ3yG14f+WPUxVojYsI4u3abxCYGa3UQAjvgPmfvWwV3BWX79gL
         7Isw==
X-Gm-Message-State: APzg51Df+nu5qlAeqxyzMyd7RRNl3zxPJqNcUsqUNwqNX6wslq6sVp4N
        Zw5VpO1DoC5exCu7HXoS2oE=
X-Google-Smtp-Source: ANB0VdZ6FqscmiFh+C7oNaRDSvl7ALQE1Y3zvDzHv1dFnm0a35gZTit2/SSreZiPXCc4SNdb6uFU7A==
X-Received: by 2002:a17:902:ac8f:: with SMTP id h15-v6mr16850921plr.161.1535745283381;
        Fri, 31 Aug 2018 12:54:43 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id u13-v6sm14094929pfn.59.2018.08.31.12.54.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 12:54:42 -0700 (PDT)
Date:   Fri, 31 Aug 2018 12:54:39 -0700
From:   Brian Norris <computersforpeace@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Naren <naren.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Sven Van Asbroeck <svendev@arcx.com>,
        Paolo Abeni <pabeni@redhat.com>, Alban Bedel <albeu@free.fr>,
        Rob Herring <robh@kernel.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        briannorris@chromium.org
Subject: Re: [PATCH v2 15/29] net: split eth_platform_get_mac_address() into
 subroutines
Message-ID: <20180831195439.GB62862@ban.mtv.corp.google.com>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180810080526.27207-16-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810080526.27207-16-brgl@bgdev.pl>
User-Agent: Mutt/1.10.1+48 (1f3a9df87d11) (2018-07-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I responded to the cover letter, but I'll put some notes here too.

On Fri, Aug 10, 2018 at 10:05:12AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We want do add more sources from which to read the MAC address. In
> order to avoid bloating this function too much, start by splitting it
> into subroutines, each of which takes care of reading the MAC from
> one source.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  net/ethernet/eth.c | 44 ++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 36 insertions(+), 8 deletions(-)
> 
> diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
> index 7f08105402c8..d01dd55de037 100644
> --- a/net/ethernet/eth.c
> +++ b/net/ethernet/eth.c
> @@ -525,22 +525,50 @@ unsigned char * __weak arch_get_platform_mac_address(void)
>  	return NULL;
>  }
>  
> -int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
> +static int mac_address_from_of(struct device *dev, u8 *mac_addr)
>  {
>  	const unsigned char *addr;
> -	struct device_node *dp;
> +	struct device_node *np;
>  
> -	dp = dev->of_node;
> -	addr = NULL;
> -	if (dp)
> -		addr = of_get_mac_address(dp);
> -	if (!addr)
> -		addr = arch_get_platform_mac_address();
> +	np = dev->of_node;
> +	if (!np)
> +		return -ENODEV;
>  
> +	addr = of_get_mac_address(np);
>  	if (!addr)
>  		return -ENODEV;
>  
> +	if (!addr || !is_valid_ether_addr(addr))
> +		return -ENODEV;
> +
>  	ether_addr_copy(mac_addr, addr);
>  	return 0;
>  }
> +
> +static int mac_address_from_arch(u8 *mac_addr)
> +{
> +	const unsigned char *addr;
> +
> +	addr = arch_get_platform_mac_address();
> +	if (!addr || !is_valid_ether_addr(addr))
> +		return -ENODEV;
> +
> +	ether_addr_copy(mac_addr, addr);
> +	return 0;
> +}
> +
> +int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
> +{
> +	int rv;
> +
> +	rv = mac_address_from_of(dev, mac_addr);

This could just be replaced with device_get_mac_address(). Then you
should be extending either fwnode_get_device_mac_address() or
device_get_mac_addres() in the next patch, not
eth_platform_get_mac_address().

Regards,
Brian

> +	if (!rv)
> +		return 0;
> +
> +	rv = mac_address_from_arch(mac_addr);
> +	if (!rv)
> +		return 0;
> +
> +	return -ENODEV;
> +}
>  EXPORT_SYMBOL(eth_platform_get_mac_address);
> -- 
> 2.18.0
> 
