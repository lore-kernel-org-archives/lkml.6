Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39633C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09BFE21920
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1BSLK/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfBGTOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:14:23 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41994 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfBGTOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 14:14:22 -0500
Received: by mail-lf1-f66.google.com with SMTP id l10so723290lfh.9;
        Thu, 07 Feb 2019 11:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XHvZKnLp+24vVGMa4GQVlfe4Oial4omvH49Q3K/OGu0=;
        b=B1BSLK/UWFeWIUWOIUJQW66OPXKjWlfpLVoLyoc85/Mpj52CTHRcoUwNEVa/WsYTPa
         OlidwKXjk6kk05mrPouSDsI3HQB/DsdtjpjLmPVJdtt8k3980Isd68DHBzYu8CEu2u+i
         GCMIfpWHXkXkAu4JDyQDkFdEVETc2owZIZwZso8Qs/zq1cNwdqmcKqP8sM+eHny+YVV2
         6zLva/YtSa2z41yfDp9WHWAKWyZ678QKqPzEqDnC5K8XdqU5PEvUmEGzMn5UkTh3vpAa
         QBcMUBlArnAORAsL00SB5pkiPeV4BiAJTHazdlcu/jbgOB4MVV3ue2kPgOhRPK5ZLr7t
         yrdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XHvZKnLp+24vVGMa4GQVlfe4Oial4omvH49Q3K/OGu0=;
        b=RFknRP214t+rfCUrVjwPEmOanlHucC2KHaltFJI4AzpDKORZ7LCL0oey1sQKRRTOuX
         B3hfOES2Jg0TSRt8zvfQIK+gZnPD3cEeJD9Q+yVywWfoPqg8fzMrbMFCnZhZnpoEOfiQ
         Yj0Yyd+xnzscvVsflA3BzPtzhAKkSeswyu6NBTdpVOh45J109hHI1rtV+HxhgN9L9p2G
         0j/mbn87rzevWQf/n+/qf7u6NkS5RAXnyTkMpHsTTf9ixLvtQCVAu7XoIhX6ZvPyyVrT
         oyZmhYchlnosoCBx/wIt1OLgL41tHaj5Vgr1oa+VJW/5ZOpOKP0xLTJ2bPE+IyPUrMmq
         +c4w==
X-Gm-Message-State: AHQUAuZLde7ZomeQQb8gZQcKrTTIuop4GUPu1nRNB0CvgotUyk0AwiSt
        u5uNbGc90G7lwzjByqEadp7P9qJW
X-Google-Smtp-Source: AHgI3Iau46uCRCK5k5VZf+GxkCvWzKPOvVepBcmlcNE5WFonPute2OPdvRAx43ZYC5n8vpYhaUPxag==
X-Received: by 2002:a19:4847:: with SMTP id v68mr1541099lfa.136.1549566859625;
        Thu, 07 Feb 2019 11:14:19 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id f18sm5490729lfk.18.2019.02.07.11.14.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 11:14:18 -0800 (PST)
Subject: Re: [PATCH V14 3/5] i2c: tegra: Add DMA support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1549480569-24860-1-git-send-email-skomatineni@nvidia.com>
 <1549480569-24860-3-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c6484ae8-65c7-885a-fe37-0666182cff29@gmail.com>
Date:   Thu, 7 Feb 2019 22:14:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549480569-24860-3-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.02.2019 22:16, Sowjanya Komatineni пишет:
> +static void tegra_i2c_config_fifo_trig(struct tegra_i2c_dev *i2c_dev,
> +				       size_t len)
> +{
> +	u32 val = 0, reg;
> +	u8 dma_burst = 0;
> +	struct dma_slave_config slv_config = {0};
> +	struct dma_chan *chan;
> +	int ret;
> +	unsigned long reg_offset;
> +
> +	if (i2c_dev->hw->has_mst_fifo)
> +		reg = I2C_MST_FIFO_CONTROL;
> +	else
> +		reg = I2C_FIFO_CONTROL;
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
> +			reg_offset = tegra_i2c_reg_addr(i2c_dev, I2C_RX_FIFO);
> +			slv_config.src_addr = i2c_dev->base_phys + reg_offset;
> +			slv_config.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +			slv_config.src_maxburst = dma_burst;
> +
> +			if (i2c_dev->hw->has_mst_fifo)
> +				val |= I2C_MST_FIFO_CONTROL_RX_TRIG(dma_burst);
> +			else
> +				val |= I2C_FIFO_CONTROL_RX_TRIG(dma_burst);
> +		} else {
> +			chan = i2c_dev->tx_dma_chan;
> +			reg_offset = tegra_i2c_reg_addr(i2c_dev, I2C_TX_FIFO);
> +			slv_config.dst_addr = i2c_dev->base_phys + reg_offset;
> +			slv_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +			slv_config.dst_maxburst = dma_burst;
> +
> +			if (i2c_dev->hw->has_mst_fifo)
> +				val |= I2C_MST_FIFO_CONTROL_TX_TRIG(dma_burst);
> +			else
> +				val |= I2C_FIFO_CONTROL_TX_TRIG(dma_burst);
> +		}

Minor nit: let's replace "|=" with "=" for consistency, and then "u32 val = 0," to just "u32 val,".

> +
> +		slv_config.device_fc = true;
> +		ret = dmaengine_slave_config(chan, &slv_config);
> +		if (ret < 0) {
> +			dev_err(i2c_dev->dev, "DMA slave config failed: %d\n",
> +				ret);
> +			dev_err(i2c_dev->dev, "fallbacking to PIO\n");
> +			tegra_i2c_release_dma(i2c_dev);
> +			i2c_dev->is_curr_dma_xfer = false;
> +		} else {
> +			goto out;
> +		}
> +	}
> +
> +	if (i2c_dev->hw->has_mst_fifo)
> +		val = I2C_MST_FIFO_CONTROL_TX_TRIG(8) |
> +		      I2C_MST_FIFO_CONTROL_RX_TRIG(1);
> +	else
> +		val = I2C_FIFO_CONTROL_TX_TRIG(8) |
> +		      I2C_FIFO_CONTROL_RX_TRIG(1);
> +out:
> +	i2c_writel(i2c_dev, val, reg);
> +}
