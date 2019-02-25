Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43550C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B8B520684
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="VFEtUOzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbfBYQ3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:29:23 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34354 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbfBYQ3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:29:22 -0500
Received: by mail-lj1-f195.google.com with SMTP id l5so7970648lje.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 08:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=77QWyaOvI4TWPkxmGkA0CNCiytGViRfoudTqrVdJ1sA=;
        b=VFEtUOzHjjMvjKjWe28jdukO6Eqb1NTwUui0nv9p0cWKhkLU5mV6KCail7FeJ7OJIs
         AumIQ9rgIlFy3zXvPOJ0BNUgWXuP4f28CPm13HpUsgrkTU6SvLuHpQOJVNGv/KrqpvHz
         03WU+x0fKLYIuOV/ndcJ5r88dRnee8LX6k22w3b8yknMyvrMig51UUEsJML2hOPfAXph
         B/sMxl4BWKhsnVIc6bp7+8697m71pXS8Tvw+O51RGpw37Rz204Pxnzx3Q/tBLDPQCuKv
         1DHXdryAbWGkpeI5wS6+OZzrWKo37S23Ms+2USe1eew6SybQY/HDNk2VOSDSx2b3vkxi
         1yOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=77QWyaOvI4TWPkxmGkA0CNCiytGViRfoudTqrVdJ1sA=;
        b=J5WntDcKKZfOmnd9R3Rj94uxCtLNveTnlRGMSIT4q8IN7SaeZzcQQ4hU6cKWvVyG3N
         BuKUTzRk3k7vLj2sgdnm9PZMXwJiSCb1kLDaINbRZK+9OTe0uTXBg9zUetXceMBIETyL
         v3pjJzM7npHghHv+LDgAdN5/oN/dRpcE+RGm3msr6ENE2ICOQOIRgcERw+nFxJS17cwe
         sOPcP74BkuS/lq2Wo49TMScGqr/W4zrb4r/9U49DffvqdZpG57QtJxl6qX209wm9K0Fn
         EOyU88VfQdXuAXgMY0c9uHuev2BchSQCqGjDp6og0QrmsvwZ31TS3LVLZRL8QwzytkN9
         OYXg==
X-Gm-Message-State: AHQUAubbaba8UJQEU4aSFBbmJbzIgDYiPlqz2JPwxXqDwoV7zBLLyOra
        LGJIDvv5aEhb9N4soPX/KQI/LA==
X-Google-Smtp-Source: AHgI3IYYdp8ellX2609vk7mUpmN7j1raOop0Ut9baFTdGn7sWHszjVWlrWh8+ZWGmp3MGqsf4W4hrQ==
X-Received: by 2002:a2e:5d59:: with SMTP id r86mr9097130ljb.158.1551112159217;
        Mon, 25 Feb 2019 08:29:19 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.86.138])
        by smtp.gmail.com with ESMTPSA id i15sm2361409ljb.48.2019.02.25.08.29.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 08:29:18 -0800 (PST)
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [RFC PATCH 5/5] mtd: hyperbus: Add driver for TI's Hyperbus
 memory controller
To:     "Vignesh R (by way of Boris Brezillon <bbrezillon@kernel.org>)" 
        <vigneshr@ti.com>, David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        tudor.ambarus@microchip.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nsekhar@ti.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20190219063607.29949-1-vigneshr@ti.com>
 <20190219063607.29949-6-vigneshr@ti.com>
Organization: Cogent Embedded
Message-ID: <907041d1-8412-22ca-3716-109a56251850@cogentembedded.com>
Date:   Mon, 25 Feb 2019 19:29:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190219063607.29949-6-vigneshr@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 02/19/2019 09:36 AM, Vignesh R (by way of Boris Brezillon <bbrezillon@kernel.org>) wrote:

> Add driver for Hyperbus memory controller on TI's AM654 SoC. Programming
> IP is pretty simple and provides direct memory mapped access to
> connected Flash devices.

   Are you sure you posted the _complete_ driver?

> Add basic support for the IP without DMA. Second ChipSelect is not
> supported for now.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/mtd/hyperbus/hbmc_am654.c | 105 ++++++++++++++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 drivers/mtd/hyperbus/hbmc_am654.c
> 
> diff --git a/drivers/mtd/hyperbus/hbmc_am654.c b/drivers/mtd/hyperbus/hbmc_am654.c
> new file mode 100644
> index 000000000000..1f0d2dc52f9f
> --- /dev/null
> +++ b/drivers/mtd/hyperbus/hbmc_am654.c
> @@ -0,0 +1,105 @@
[...]
> +static int am654_hbmc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct am654_hbmc_priv *priv;
> +	struct resource *res;
> +	int err;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (IS_ERR(res)) {
> +		dev_err(&pdev->dev, "failed to get memory resource\n");
> +		return -ENOENT;
> +	}
> +
> +	priv->regbase = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(priv->regbase)) {
> +		dev_err(dev, "Cannot remap controller address.\n");
> +		return PTR_ERR(priv->regbase);
> +	}
> +
> +	pm_runtime_enable(&pdev->dev);
> +	err = pm_runtime_get_sync(&pdev->dev);

   That's all nice but where's the code that accesses the actual registers?

> +	if (err < 0) {
> +		pm_runtime_put_noidle(&pdev->dev);

   Calling "put" with previously failed "get" sees strange...

> +		return err;
> +	}
> +
> +	priv->hbdev.needs_calib = true;
> +	priv->hbdev.dev = &pdev->dev;
> +	priv->hbdev.np = of_get_next_child(dev->of_node, NULL);
> +	err = hb_register_device(&priv->hbdev);
> +	if (err) {
> +		dev_err(&pdev->dev, "failed to register controller\n");
> +		goto err_destroy;
> +	}
> +
> +	return 0;
> +
> +err_destroy:
> +	hb_unregister_device(&priv->hbdev);

   Calling "unregister" with "register" previously failed also looks strange...

> +	pm_runtime_put_sync(&pdev->dev);

   Why the sync() version?

> +	return err;
> +}
[...]

MBR, Sergei
