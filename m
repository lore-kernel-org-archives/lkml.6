Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BC6C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29EEE2175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcjoyenQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbfBFPCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:02:46 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42084 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfBFPCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 10:02:46 -0500
Received: by mail-lj1-f193.google.com with SMTP id l15-v6so6311501lja.9;
        Wed, 06 Feb 2019 07:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CxjTQIgc4FCSmshSDplM238VCdltbdFhiHCTx3q7MQk=;
        b=GcjoyenQaeIFcGHLKkkVFmlnatIDkd9z1Kp9zx4p5QRt2eTXqXf9q9HQ1d4sP3Kb+z
         OZNyCGXD4503XTcoDmYFObvmOX0oZkImUatniFsgE1k+cme1VEvxz7uOOn3lM7c4xFyE
         qnJ4nnQ+HLRPmHLf0cEffbHIjcyuOlJMPlU14BGOuQC7OfQcwqZ8vZ7oufhKcWQ8HNmr
         MhLSWDg2TG72KrkkM7VM4qLklI3iOWQJsSD3+hvZhheQnIfKbbdLdcJQqqdB8O8VJPiR
         ywc4t/kl7CtqwD0xIxVQfp/Lor0e/t/gDfLB8biHYrYEBzmTL5yyufyYf9pa9mWiR4eK
         OW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CxjTQIgc4FCSmshSDplM238VCdltbdFhiHCTx3q7MQk=;
        b=Q/bFmCa3nvC7k/dRbjU7el3eN18apddA/uGFOWIn8TsFv3sseQteH7ZWnXMSjMTr1L
         AborBm/JsNLh7KlgIs3cY/7Z/d+udJ+lqYIoD+ExJ7xcaji5pH1oF8y3Mga+e22SaBk4
         wiuXYZraR2DqIbTjRF5IPYvTvYJbwQgFXukXD9mNlL2EpXM4AGsvjvua8aMPCODIW0MC
         IKwnkXNx2y9rN0QBEJBNYSrDnsxADhf+fsw872B+Q/lMPgrxhRQmspoVUUXrXhNXB8DM
         hpaLTasbOH/LrtjFCnJuV8C9Q7trkb1W83+8zsDW0pqNB+FVSoAFw+wBA0bIGdaXynmF
         lFxg==
X-Gm-Message-State: AHQUAuZ21Og59JWCKBssCIKM9v0tsR54OXw3osbFNw90sAx7KcW6yRCb
        RQSung29BAu9+cnaiXKsbzm50jzz
X-Google-Smtp-Source: AHgI3IbaidujTYCIhillyUIGPQwZ+SLDWCkcMYoALRGrZ17A2ghRbJ9xgG+6V4tGp8HlbZZ3dHwwmg==
X-Received: by 2002:a2e:b1cb:: with SMTP id e11-v6mr3483614lja.67.1549465363701;
        Wed, 06 Feb 2019 07:02:43 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id 67-v6sm3853477ljc.26.2019.02.06.07.02.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 07:02:43 -0800 (PST)
Subject: Re: [PATCH V13 3/5] i2c: tegra: Add DMA support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1549464441-1836-1-git-send-email-skomatineni@nvidia.com>
 <1549464441-1836-3-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4ecd3894-a1cb-20dd-8675-26e6e84254e7@gmail.com>
Date:   Wed, 6 Feb 2019 18:02:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549464441-1836-3-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.02.2019 17:47, Sowjanya Komatineni пишет:
> This patch adds DMA support for Tegra I2C.
> 
> Tegra I2C TX and RX FIFO depth is 8 words. PIO mode is used for
> transfer size of the max FIFO depth and DMA mode is used for
> transfer size higher than max FIFO depth to save CPU overhead.
> 
> PIO mode needs full intervention of CPU to fill or empty FIFO's
> and also need to service multiple data requests interrupt for the
> same transaction. This adds delay between data bytes of the same
> transfer when CPU is fully loaded and some slave devices has
> internal timeout for no bus activity and stops transaction to
> avoid bus hang. DMA mode is helpful in such cases.
> 
> DMA mode is also helpful for Large transfers during downloading or
> uploading FW over I2C to some external devices.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---

[snip]

> +static void tegra_i2c_config_fifo_trig(struct tegra_i2c_dev *i2c_dev,
> +				       size_t len)
> +{
> +	u32 val, reg;
> +	u8 dma_burst = 0;
> +	struct dma_slave_config slv_config = {0};
> +	struct dma_chan *chan;
> +	int ret;
> +
> +	if (i2c_dev->hw->has_mst_fifo)
> +		reg = I2C_MST_FIFO_CONTROL;
> +	else
> +		reg = I2C_FIFO_CONTROL;
> +	val = i2c_readl(i2c_dev, reg);
> +
> +	if (i2c_dev->is_curr_dma_xfer) {
> +		if (len & 0xF)
> +			dma_burst = 1;
> +		else if (len & 0x10)
> +			dma_burst = 4;
> +		else
> +			dma_burst = 8;
> +
> +		if (i2c_dev->msg_read) {
> +			chan = i2c_dev->rx_dma_chan;
> +			slv_config.src_addr = i2c_dev->base_phys +
> +					      tegra_i2c_reg_addr(i2c_dev, I2C_RX_FIFO);
> +			slv_config.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +			slv_config.src_maxburst = dma_burst;
> +
> +			if (i2c_dev->hw->has_mst_fifo)
> +				val |= I2C_MST_FIFO_CONTROL_RX_TRIG(dma_burst);
> +			else
> +				val |= I2C_FIFO_CONTROL_RX_TRIG(dma_burst);
> +		} else {
> +			chan = i2c_dev->tx_dma_chan;
> +			slv_config.dst_addr = i2c_dev->base_phys +
> +					      tegra_i2c_reg_addr(i2c_dev, I2C_TX_FIFO);;

Two ";;" at the end.

[snip]

Good news: DVC I2C works now and tps6586x probes fine! :)
Bad news: atmel-touch still has same problems as in V12 :(

DMA-only V13: http://dpaste.com/0XJ1Z8G.txt
