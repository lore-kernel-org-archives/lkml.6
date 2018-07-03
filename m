Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D058FC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F1021EF7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o5QLMD6V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F1021EF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934201AbeGCQkD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:40:03 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34940 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933792AbeGCQj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:39:56 -0400
Received: by mail-wr0-f193.google.com with SMTP id h40-v6so2639784wrh.2;
        Tue, 03 Jul 2018 09:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zF9DIBok57XqHV+ud9iSf6qvwCYIFxr4fRpiTiniPj0=;
        b=o5QLMD6V/41QzXr4/34yAmj6+PVqUvG779ukfryM4hGfofg4ESLBEiui1yJR80J4TW
         t93T4geGRlSYEZ18CzOIymodfJ4gM7puPINgxR7/RmYo3gCHit37R0v8ihCJQkCuzp6m
         sIxAibHPgs4v6XLbH19odWZhqdEfXGq6S+R+MFrjh+2468EIMEPy7vifC5RON8p8Edi3
         cF1GfkptZf1LVJQWr6RYbdRJTTPlSXczXzsNLa9Qrz6ZYQsbO0Zk4XQnKayrYFHMb71P
         KU45vM3aJpuCF0mvuIFCPG5nmb5yRG/s13hbuLepwVXMoW7Nhby+jdH1COtjHAxDrP4t
         EB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=zF9DIBok57XqHV+ud9iSf6qvwCYIFxr4fRpiTiniPj0=;
        b=ORM8qNBG0ExlPJepja/p8LEyxP23MYaDDYO/9xRK/Cj//0ExK5m/alsfX5FmcVtNXs
         rfDikDErcZfK+Wc+M8tAJAwK6e+DNV1nIGh1+hlM6iKrnFAvhGi1eLaPtCS3z+1ACcFr
         MvN+F7JagGaoe61/6bb7dPa46iB5xeRdFwQQRxfdUMnn9CATf7f/aaAfvpffTxHKok3e
         z92s3BL3JiibN4phjZWSvhVKXduoxm3f4NBgko8S8yNZiN70Xc2Incux2qGSk3aKxB1c
         +tZrbXmQ7tBLF65c7s0t7NUfUakR08cJbk3WQlw3wOuxDxzp2YVgZ3t4e2elK7mzGQJF
         q1fA==
X-Gm-Message-State: APt69E2v0EN//3gk/uQSCgw/ddyqlM7Bm+0U5rPmaUFfXvWc4eX+Qq6l
        pUFSHWrHwvUcHnFoK67AMYQ=
X-Google-Smtp-Source: AAOMgpczbcXwdGUT8MUzsvRnB2o02eiZhV1q/Xc14sM+/gqBOTcBq2KXX66ZIT5DewK20f9Lxf7tUg==
X-Received: by 2002:adf:8188:: with SMTP id 8-v6mr24324320wra.89.1530635994138;
        Tue, 03 Jul 2018 09:39:54 -0700 (PDT)
Received: from [192.168.1.14] (ARennes-658-1-257-227.w92-135.abo.wanadoo.fr. [92.135.240.227])
        by smtp.gmail.com with ESMTPSA id n5-v6sm2184821wrp.69.2018.07.03.09.39.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 09:39:52 -0700 (PDT)
Subject: Re: [PATCH v4 08/18] net: davinci_emac: potentially get the MAC
 address from MTD
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180629094039.7543-1-brgl@bgdev.pl>
 <20180629094039.7543-9-brgl@bgdev.pl>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <03b77e24-9ab9-fa01-2387-9de0408a9942@gmail.com>
Date:   Tue, 3 Jul 2018 09:39:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180629094039.7543-9-brgl@bgdev.pl>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/29/2018 02:40 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> On da850-evm board we can read the MAC address from MTD. It's currently
> done in the relevant board file, but we want to get rid of all the MAC
> reading callbacks from the board file (SPI and NAND). Move the reading
> of the MAC address from SPI to the emac driver's probe function.

This should be made something generic to all drivers, not just something
the davinci_emac driver does, something like this actually:

https://lkml.org/lkml/2018/3/24/312

> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/net/ethernet/ti/davinci_emac.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
> index a1a6445b5a7e..48e6a7755811 100644
> --- a/drivers/net/ethernet/ti/davinci_emac.c
> +++ b/drivers/net/ethernet/ti/davinci_emac.c
> @@ -67,7 +67,7 @@
>  #include <linux/of_irq.h>
>  #include <linux/of_net.h>
>  #include <linux/mfd/syscon.h>
> -
> +#include <linux/mtd/mtd.h>
>  #include <asm/irq.h>
>  #include <asm/page.h>
>  
> @@ -1783,7 +1783,10 @@ static int davinci_emac_probe(struct platform_device *pdev)
>  	struct cpdma_params dma_params;
>  	struct clk *emac_clk;
>  	unsigned long emac_bus_frequency;
> -
> +#ifdef CONFIG_MTD
> +	size_t mac_addr_len;
> +	struct mtd_info *mtd;
> +#endif /* CONFIG_MTD */
>  
>  	/* obtain emac clock from kernel */
>  	emac_clk = devm_clk_get(&pdev->dev, NULL);
> @@ -1815,6 +1818,19 @@ static int davinci_emac_probe(struct platform_device *pdev)
>  		goto err_free_netdev;
>  	}
>  
> +#ifdef CONFIG_MTD
> +	mtd = get_mtd_device_nm("MAC-Address");
> +	if (!IS_ERR(mtd)) {
> +		rc = mtd_read(mtd, 0, ETH_ALEN,
> +			      &mac_addr_len, priv->mac_addr);
> +		if (rc == 0)
> +			dev_info(&pdev->dev,
> +				 "Read MAC addr from SPI Flash: %pM\n",
> +				 priv->mac_addr);
> +		put_mtd_device(mtd);
> +	}
> +#endif /* CONFIG_MTD */
> +
>  	/* MAC addr and PHY mask , RMII enable info from platform_data */
>  	memcpy(priv->mac_addr, pdata->mac_addr, ETH_ALEN);
>  	priv->phy_id = pdata->phy_id;
> 

-- 
Florian
