Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E37C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708792087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="kLwy1V2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbfARTn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 14:43:29 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45987 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729218AbfARTn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 14:43:29 -0500
Received: by mail-lj1-f195.google.com with SMTP id s5-v6so12554510ljd.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 11:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fn/ZaOA4TCft1SNkMg6+ljUMYqlYSPj3PIG9fg7fiSU=;
        b=kLwy1V2ehwDdsIG4T92DCTb2UHcz6vgw11zko6/U5r65PH12y1/9pgleiqeUFd+Rav
         ZA0cPdMYou5VTnB37xvBfUhQZ3X9JtueMqu6q/LODpUYmPOAS5/5+8VHIvxfXhALuexa
         /4YiVDHzu6QSOkLzfyr09HjiEvS/dSc4Q2Om3y3OJZNku/klYUDlbUAm45E1xv2qkJ4L
         ipQjqSyikmfAzqpjfVpG6mErcRnUHQXHGaVr6eRikBM0FXXnjdsgue01vCCElV0yhGly
         7vXiNIM3qQqnb2OmZDjLElbcjD3g/gROqlMiOyNL5OeM2/4CpQNMt+cH+0otNR3nNjYt
         dgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Fn/ZaOA4TCft1SNkMg6+ljUMYqlYSPj3PIG9fg7fiSU=;
        b=EEhIn65jkAXJ2/zFMucq8u7jmJ18eQoxdTOHB1hyIb/0OqMdPJXJz+I1ECFxd7W7gj
         VQkwNAtiCUNtG8HVpl93Toyyq0BYsnMSfeVEHBtqdjZ5VQq63/YBs+eydwWYkvGTyQYK
         JxePkpkNYePYb8mlcwWwSYAvpDPIH4ziNJMt9XRl09vBSHtqQec8S0iVhMApP7PM6Lnw
         51YWuw3xJvGfjxOhcqwODEpz/iT5wQZW4dMEwL3QtuHJrQp3PY4dPK5noPEvk5FiJtsO
         UGpZvw1EKZuOekO1g45dR4bfmLqVTNZutwwv5thaJnFW4qEw13RE2xqK834fVjVaD8We
         bcxg==
X-Gm-Message-State: AJcUukfZaLurlI8G9Mhjlri04AkrJcpl5kYZUhMrWfnBS+bXRYw5DWh2
        QV6RyFr2Hh8hfLrvB3QF8FCP/Ug0RCY=
X-Google-Smtp-Source: ALg8bN44APENG7t2RTnXHL+2fSRohyX8lkI9kciqFymMEFbwtce7F26PMgEkSQpCje/rwS/Qvelihg==
X-Received: by 2002:a2e:8951:: with SMTP id b17-v6mr2049717ljk.142.1547840606907;
        Fri, 18 Jan 2019 11:43:26 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.87.207])
        by smtp.gmail.com with ESMTPSA id p89-v6sm893729ljp.60.2019.01.18.11.43.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 11:43:25 -0800 (PST)
Subject: Re: [PATCH v6 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
To:     Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, bbrezillon@kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
References: <1547790855-22120-1-git-send-email-masonccyang@mxic.com.tw>
 <1547790855-22120-2-git-send-email-masonccyang@mxic.com.tw>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <f4665653-503c-e1a1-a211-b8b322225bd6@cogentembedded.com>
Date:   Fri, 18 Jan 2019 22:43:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1547790855-22120-2-git-send-email-masonccyang@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 01/18/2019 08:54 AM, Mason Yang wrote:

> Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
[...]
> diff --git a/drivers/spi/spi-renesas-rpc.c b/drivers/spi/spi-renesas-rpc.c
> new file mode 100644
> index 0000000..692c760
> --- /dev/null
> +++ b/drivers/spi/spi-renesas-rpc.c
> @@ -0,0 +1,800 @@
[...]
> +#define RPC_DRENR		0x001C	// R/W
> +#define RPC_DRENR_CDB(o)	(u32)((((o) & 0x3) << 30))
> +#define RPC_DRENR_OCDB(o)	(((o) & 0x3) << 28)
> +#define RPC_DRENR_ADB(o)	(((o) & 0x3) << 24)
> +#define RPC_DRENR_OPDB(o)	(((o) & 0x3) << 20)
> +#define RPC_DRENR_SPIDB(o)	(((o) & 0x3) << 16)

   Manual v1.00 calls it DRDB, not SPIDB.

[...]
> +#define RPC_SMENR		0x0030	// R/W
> +#define RPC_SMENR_CDB(o)	(((o) & 0x2) << 30)
> +#define RPC_SMENR_OCDB(o)	(((o) & 0x2) << 28)
> +#define RPC_SMENR_ADB(o)	(((o) & 0x2) << 24)
> +#define RPC_SMENR_OPDB(o)	(((o) & 0x2) << 20)
> +#define RPC_SMENR_SPIDB(o)	(((o) & 0x2) << 16)

   Ugh, s/0x2/0x3/! :-/

[...]
> +#define RPC_SMDRENR		0x0064	// R/W
> +#define RPC_SMDRENR_HYPE	(0x5 << 12)

   s/0x5/0x7/, and this is a field, not value.

[...]
> +static int rpc_spi_probe(struct platform_device *pdev)
> +{
> +	struct spi_controller *ctlr;
> +	struct resource *res;
> +	struct rpc_spi *rpc;
> +	const struct regmap_config *regmap_config;
> +	struct device_node *rpc_if;
> +	int ret;
> +
> +	rpc_if = of_find_compatible_node(pdev->dev.of_node, NULL,
> +					 "jedec,spi-nor");

   I doubt that this is a correct function to check for the child node's
"compatible" prop...

[...]
> +	regmap_config = &rpc_spi_regmap_config;

   Doesn't look like this variable is needed...

> +	rpc->regmap = devm_regmap_init_mmio(&pdev->dev, rpc->base,
> +					    regmap_config);
> +	if (IS_ERR(rpc->regmap)) {
> +		dev_err(&pdev->dev, "failed to init regmap %ld for rpc-spi\n",

   How about:

		dev_err(&pdev->dev, "failed to init regmap for rpc-spi, error %ld\n",

[...]
> +	ret = spi_register_controller(ctlr);
> +	if (ret) {
> +		dev_err(&pdev->dev, "spi_register_master failed\n");

   You forgot to update the message. :-)

[...]

MBR, Sergei
