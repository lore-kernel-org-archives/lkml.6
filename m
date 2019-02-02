Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945C0C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 14:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC2720818
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 14:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8ePuoKK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbfBBOOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 09:14:06 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45193 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbfBBOOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 09:14:05 -0500
Received: by mail-pl1-f193.google.com with SMTP id a14so4696128plm.12;
        Sat, 02 Feb 2019 06:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ouHJu/unsJl465c+z79h7VVIWAY5itWlOAZt3zhhB2k=;
        b=f8ePuoKKJREeuh8NrdWg4dyx0AhGH+KD515nxVsWILjpaoN2geWCGB2VLWTskItx2J
         CCcMisAQw/juZ+657izPrJxArRvCdBNG1BmyXbkHxSrR5KuUH+AZ4qH/ZYy0CiXPHKf5
         CGtgiGgf1GbiTKYZjugfhhTp2rnE6kJwZ8MX2Mg8lRO6Q4LdApMmWYhfJorFsNEcNkHm
         WtB58e225QlGz+DgPUN/FJgJX4M7W+48ziwx/oIdxB9NGPIdd3g2mInHe8kpQmUa2ncQ
         2i/E1ZEvRSpwfsrKfz+2eA2sZ1bO582DKLOiVJwyS98w//bTBTewvzAHq88rvr2g/tZ+
         X6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ouHJu/unsJl465c+z79h7VVIWAY5itWlOAZt3zhhB2k=;
        b=pAipzHkYbEXY4wJXpvTf+A6bQh/4VFwKR4ncjYxsnALNHO2jbL1kc0RmfD5pCqRuq2
         osgeVPLeOoXh5l8haBJpe73e5mEdL0i+wuT6Cz53te1mBPIQYbh7xdTZBSLtIvUmiSeb
         z8yRLl0SfYa/ju2gjDS5DmA9eo4EVt6rwwNF1zIkjKbLkWwZaaJTEdXIXwBia2GEqBfC
         jFkTZAzAF/5ConCdSRrM/6UqviajVGaxfi/SMnOt9mKPhIA5vZUp3JuU1YgNmG5uswep
         o4FgfdanGQcXVjg9lbEplqB+WGKUpMOP0l9P/G3z4CRYzQGKs6pTKXmfqJQ+atfDAsV2
         +DQw==
X-Gm-Message-State: AJcUukew3/sSaRaVMBoaH5WbdKiYqFsJnXFkn+rMKyyxufFPf57xET20
        0Cc+1gKztifx157xqUnHlqhl8Q3B
X-Google-Smtp-Source: ALg8bN4yIjKJi5V5KxbLMlutL5GMvS6uxGFwIMLBcTYGAlyFoPwdoDb+RVBiBHNhL9bEBzj0iqCWfQ==
X-Received: by 2002:a17:902:8d94:: with SMTP id v20mr43745607plo.194.1549116844623;
        Sat, 02 Feb 2019 06:14:04 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id u68sm24902312pfj.180.2019.02.02.06.13.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 06:14:04 -0800 (PST)
Subject: Re: [PATCH V9 3/5] i2c: tegra: Add DMA support
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
Cc:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
References: <1549040867-18149-1-git-send-email-skomatineni@nvidia.com>
 <1549040867-18149-3-git-send-email-skomatineni@nvidia.com>
 <951cf1f5-ba3a-94ef-0399-2259effebc99@gmail.com>
 <BYAPR12MB33984FB81B8BB1EC8C0C4908C2920@BYAPR12MB3398.namprd12.prod.outlook.com>
 <6150de70-6ca8-944a-780a-4574ff2b21c7@gmail.com>
Message-ID: <f667ab55-c7c7-4ac1-100a-7f7ade87708d@gmail.com>
Date:   Sat, 2 Feb 2019 17:13:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <6150de70-6ca8-944a-780a-4574ff2b21c7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

01.02.2019 22:22, Dmitry Osipenko пишет:
> 01.02.2019 22:20, Sowjanya Komatineni пишет:
>>
>>>> +static int tegra_i2c_init_dma(struct tegra_i2c_dev *i2c_dev) {
>>>> +	struct dma_chan *dma_chan;
>>>> +	u32 *dma_buf;
>>>> +	dma_addr_t dma_phys;
>>>> +	int err = 0;
>>>> +
>>>> +	if (!IS_ENABLED(CONFIG_TEGRA20_APB_DMA))
>>>> +		return -ENODEV;
>>>
>>> Driver shall not fail to probe if DMA driver is disabled, but to continue with the PIO-only mode available.
>>>
>>> Should be:
>>>
>>> 	if (!IS_ENABLED(CONFIG_TEGRA20_APB_DMA))
>>> 		return 0;
>>>
>> Except EPROBE_DEFER, anything else returned from tegra_i2c_init_dma (ENODEV/ENOMEM) is ignored in i2c_probe
>> DMA mode decision is based on xfer size and availability of dma channel or can be changed based on valid dma buf to shorten the line.
>>
> 
> Ah, sorry. I missed that, seems good then.
> 

BTW, it may be worthwhile to move out the error code handling into tegra_i2c_init_dma() for clarity. It also won't hurt to not ignore errors other than -ENODEV.

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 32d5744bce45..684a0689ac8d 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -397,7 +397,7 @@ static int tegra_i2c_init_dma(struct tegra_i2c_dev *i2c_dev)
 	int err = 0;
 
 	if (!IS_ENABLED(CONFIG_TEGRA20_APB_DMA))
-		return -ENODEV;
+		return 0;
 
 	dma_chan = dma_request_slave_channel_reason(i2c_dev->dev, "rx");
 	if (IS_ERR(dma_chan))
@@ -434,6 +434,13 @@ static int tegra_i2c_init_dma(struct tegra_i2c_dev *i2c_dev)
 	if (i2c_dev->rx_dma_chan)
 		dma_release_channel(i2c_dev->rx_dma_chan);
 
+	/*
+	 * -ENODEV is likely due to a missing "dmas" property, driver falls
+	 * back to PIO in this case.
+	 */
+	if (err == -ENODEV)
+		return 0;
+
 	return err;
 }
 
@@ -1553,7 +1560,7 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 	}
 
 	ret = tegra_i2c_init_dma(i2c_dev);
-	if (ret == -EPROBE_DEFER)
+	if (ret)
 		goto disable_div_clk;
 
 	ret = tegra_i2c_init(i2c_dev, false);

