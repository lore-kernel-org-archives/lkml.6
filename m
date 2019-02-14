Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38864C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC627222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kl0RHk1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406400AbfBNKIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:08:31 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46494 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfBNKIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:08:30 -0500
Received: by mail-ed1-f68.google.com with SMTP id f2so4487868edy.13;
        Thu, 14 Feb 2019 02:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IxqvFI34pxXQ1ei64vBDwPDN2Kzh/92SEvE8bDnCUTo=;
        b=kl0RHk1kK6zYP2ZMIBii890/qliYCeQy+EwvwOGasZ1x/bUxS/bBv8J2DWj9zztyJJ
         YQBTPLLNl9qWVH90aUjTY1yM6qSGXZmKz0qyBP6XmkMsSLF8w0DEwpf70kGiJPpwOgDS
         g/a5dbdMM//96JnNvBdudpXL/Qf+qoUWFnXmqBIm+YNzchF+xUlvfMyUxzVsckkhM5eL
         7K4qXLx5Pvh10lESE62H4p/3E53p7tyNeswJlXkd4/8Mmu8DIEwyHupjXiuiUtRs0Sxz
         SffFv5F8PiccPd0KsBHmDzsO/PhtWSn641xpCspHwykDCLJJAF9Rxl9gaRX4Db0JNSKa
         EQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IxqvFI34pxXQ1ei64vBDwPDN2Kzh/92SEvE8bDnCUTo=;
        b=e2RdByMEeLBfvfe8SIhxJtpGgMoUJmZFXnz+FiYnAmusysRCXe4ZBuJMpFXPjd6Don
         4aX21WnqKdkIwMr1dxOSh8F6hLv/GfCmCahDQQ265/BY9nPWn2PwwYrTHEyix8zFXazK
         yMXzi1xdCjG05DlB83MHX9/NSEosFAxu3sYEyrovqmbTxGAfVTIuP+QlS2G48Js1yhHT
         CKjcyO9EO8mISG5VYZGSAVotfrKy773OloBG0ZRSggypRTgQeXxc3BGaXP6i62K+flnV
         z76Bo670kc4jQJbVgHX1GXEeeiOvwI8yDtlYmtpT6yzcwk4ziEHG06rLSsXgHFAJNJQ6
         yqRA==
X-Gm-Message-State: AHQUAuYzFbBOHcRWfGIlPyzY01svwesvwzY0cY/DeRxI1PvGuJn2m0b4
        5f76HT2PfeciwT0SfQ+QMyU=
X-Google-Smtp-Source: AHgI3IbUTCAClqpNLZXE4Gj3kswTSXNNulL7Kz2ULZ862UX8DMdYENkF1P4Qc6J1xIpcZVXM34hQlA==
X-Received: by 2002:a05:6402:1852:: with SMTP id v18mr2348302edy.198.1550138906584;
        Thu, 14 Feb 2019 02:08:26 -0800 (PST)
Received: from ziggy.stardust ([37.223.146.9])
        by smtp.gmail.com with ESMTPSA id g35sm395019ede.28.2019.02.14.02.08.24
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 02:08:25 -0800 (PST)
Subject: Re: [PATCH v10 1/3] dmaengine: 8250_mtk_dma: add MediaTek uart DMA
 support
To:     Long Cheng <long.cheng@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sean Wang <sean.wang@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sean Wang <sean.wang@mediatek.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, srv_heupstream@mediatek.com,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Zhenbao Liu <zhenbao.liu@mediatek.com>
References: <1547781016-890-1-git-send-email-long.cheng@mediatek.com>
 <1547781016-890-2-git-send-email-long.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 jrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <56da4c16-2f47-0033-fe60-ad49ccd0758d@gmail.com>
Date:   Thu, 14 Feb 2019 11:08:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <1547781016-890-2-git-send-email-long.cheng@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/01/2019 04:10, Long Cheng wrote:
> In DMA engine framework, add 8250 uart dma to support MediaTek uart.
> If MediaTek uart enabled(SERIAL_8250_MT6577), and want to improve
> the performance, can enable the function.
> 
> Signed-off-by: Long Cheng <long.cheng@mediatek.com>
> ---
>  drivers/dma/mediatek/Kconfig          |   11 +
>  drivers/dma/mediatek/Makefile         |    1 +
>  drivers/dma/mediatek/mtk-uart-apdma.c |  669 +++++++++++++++++++++++++++++++++
>  3 files changed, 681 insertions(+)
>  create mode 100644 drivers/dma/mediatek/mtk-uart-apdma.c
> 
[...]
> +
> +static int mtk_uart_apdma_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct mtk_uart_apdmadev *mtkd;
> +	struct resource *res;
> +	struct mtk_chan *c;
> +	int bit_mask = 32, rc;
> +	unsigned int i;
> +
> +	mtkd = devm_kzalloc(&pdev->dev, sizeof(*mtkd), GFP_KERNEL);
> +	if (!mtkd)
> +		return -ENOMEM;
> +
> +	mtkd->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(mtkd->clk)) {
> +		dev_err(&pdev->dev, "No clock specified\n");
> +		rc = PTR_ERR(mtkd->clk);
> +		return rc;
> +	}
> +
> +	if (of_property_read_bool(np, "dma-33bits"))
> +		mtkd->support_33bits = true;

dma-33bits not defined in the binding description.

> +
> +	if (mtkd->support_33bits)
> +		bit_mask = 33;
> +
> +	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(bit_mask));
> +	if (rc)
> +		return rc;
> +
> +	dma_cap_set(DMA_SLAVE, mtkd->ddev.cap_mask);
> +	mtkd->ddev.device_alloc_chan_resources =
> +				mtk_uart_apdma_alloc_chan_resources;
> +	mtkd->ddev.device_free_chan_resources =
> +				mtk_uart_apdma_free_chan_resources;
> +	mtkd->ddev.device_tx_status = mtk_uart_apdma_tx_status;
> +	mtkd->ddev.device_issue_pending = mtk_uart_apdma_issue_pending;
> +	mtkd->ddev.device_prep_slave_sg = mtk_uart_apdma_prep_slave_sg;
> +	mtkd->ddev.device_config = mtk_uart_apdma_slave_config;
> +	mtkd->ddev.device_pause = mtk_uart_apdma_device_pause;
> +	mtkd->ddev.device_terminate_all = mtk_uart_apdma_terminate_all;
> +	mtkd->ddev.src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE);
> +	mtkd->ddev.dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE);
> +	mtkd->ddev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
> +	mtkd->ddev.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
> +	mtkd->ddev.dev = &pdev->dev;
> +	INIT_LIST_HEAD(&mtkd->ddev.channels);
> +
> +	mtkd->dma_requests = MTK_UART_APDMA_NR_VCHANS;

Do this if dma-requests property is not present.

> +	if (of_property_read_u32(np, "dma-requests", &mtkd->dma_requests)) {

It's quite obvious what this does, but IMHO it should be reflected in the binding.

Regards,
Matthias

> +		dev_info(&pdev->dev,
> +			 "Using %u as missing dma-requests property\n",
> +			 MTK_UART_APDMA_NR_VCHANS);
> +	}
> +
> +	mtkd->dma_irq = devm_kcalloc(&pdev->dev, mtkd->dma_requests,
> +				 sizeof(*mtkd->dma_irq), GFP_KERNEL);
> +	if (!mtkd->dma_irq)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < mtkd->dma_requests; i++) {
> +		c = devm_kzalloc(mtkd->ddev.dev, sizeof(*c), GFP_KERNEL);
> +		if (!c) {
> +			rc = -ENODEV;
> +			goto err_no_dma;
> +		}
> +
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
> +		if (!res) {
> +			rc = -ENODEV;
> +			goto err_no_dma;
> +		}
> +
> +		c->base = devm_ioremap_resource(&pdev->dev, res);
> +		if (IS_ERR(c->base)) {
> +			rc = PTR_ERR(c->base);
> +			goto err_no_dma;
> +		}
> +		c->requested = false;
> +		c->vc.desc_free = mtk_uart_apdma_desc_free;
> +		vchan_init(&c->vc, &mtkd->ddev);
> +
> +		mtkd->dma_irq[i] = platform_get_irq(pdev, i);
> +		if ((int)mtkd->dma_irq[i] < 0) {
> +			dev_err(&pdev->dev, "failed to get IRQ[%d]\n", i);
> +			rc = -EINVAL;
> +			goto err_no_dma;
> +		}
> +	}
> +
> +	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_set_active(&pdev->dev);
> +
> +	rc = dma_async_device_register(&mtkd->ddev);
> +	if (rc)
> +		goto rpm_disable;
> +
> +	platform_set_drvdata(pdev, mtkd);
> +
> +	/* Device-tree DMA controller registration */
> +	rc = of_dma_controller_register(np, of_dma_xlate_by_chan_id, mtkd);
> +	if (rc)
> +		goto dma_remove;
> +
> +	return rc;
> +
> +dma_remove:
> +	dma_async_device_unregister(&mtkd->ddev);
> +rpm_disable:
> +	pm_runtime_disable(&pdev->dev);
> +err_no_dma:
> +	mtk_uart_apdma_free(mtkd);
> +	return rc;
> +}
> +
> +static int mtk_uart_apdma_remove(struct platform_device *pdev)
> +{
> +	struct mtk_uart_apdmadev *mtkd = platform_get_drvdata(pdev);
> +
> +	if (pdev->dev.of_node)
> +		of_dma_controller_free(pdev->dev.of_node);
> +
> +	pm_runtime_disable(&pdev->dev);
> +	pm_runtime_put_noidle(&pdev->dev);
> +
> +	dma_async_device_unregister(&mtkd->ddev);
> +	mtk_uart_apdma_free(mtkd);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int mtk_uart_apdma_suspend(struct device *dev)
> +{
> +	struct mtk_uart_apdmadev *mtkd = dev_get_drvdata(dev);
> +
> +	if (!pm_runtime_suspended(dev))
> +		clk_disable_unprepare(mtkd->clk);
> +
> +	return 0;
> +}
> +
> +static int mtk_uart_apdma_resume(struct device *dev)
> +{
> +	int ret;
> +	struct mtk_uart_apdmadev *mtkd = dev_get_drvdata(dev);
> +
> +	if (!pm_runtime_suspended(dev)) {
> +		ret = clk_prepare_enable(mtkd->clk);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +#endif /* CONFIG_PM_SLEEP */
> +
> +#ifdef CONFIG_PM
> +static int mtk_uart_apdma_runtime_suspend(struct device *dev)
> +{
> +	struct mtk_uart_apdmadev *mtkd = dev_get_drvdata(dev);
> +
> +	clk_disable_unprepare(mtkd->clk);
> +
> +	return 0;
> +}
> +
> +static int mtk_uart_apdma_runtime_resume(struct device *dev)
> +{
> +	int ret;
> +	struct mtk_uart_apdmadev *mtkd = dev_get_drvdata(dev);
> +
> +	ret = clk_prepare_enable(mtkd->clk);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +#endif /* CONFIG_PM */
> +
> +static const struct dev_pm_ops mtk_uart_apdma_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(mtk_uart_apdma_suspend, mtk_uart_apdma_resume)
> +	SET_RUNTIME_PM_OPS(mtk_uart_apdma_runtime_suspend,
> +			   mtk_uart_apdma_runtime_resume, NULL)
> +};
> +
> +static struct platform_driver mtk_uart_apdma_driver = {
> +	.probe	= mtk_uart_apdma_probe,
> +	.remove	= mtk_uart_apdma_remove,
> +	.driver = {
> +		.name		= KBUILD_MODNAME,
> +		.pm		= &mtk_uart_apdma_pm_ops,
> +		.of_match_table = of_match_ptr(mtk_uart_apdma_match),
> +	},
> +};
> +
> +module_platform_driver(mtk_uart_apdma_driver);
> +
> +MODULE_DESCRIPTION("MediaTek UART APDMA Controller Driver");
> +MODULE_AUTHOR("Long Cheng <long.cheng@mediatek.com>");
> +MODULE_LICENSE("GPL v2");
> +
> 
