Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09770C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF42218F0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tXI5lyxz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731383AbfBATWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 14:22:30 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46234 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfBATW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 14:22:29 -0500
Received: by mail-lf1-f68.google.com with SMTP id f5so5854352lfc.13;
        Fri, 01 Feb 2019 11:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jcHEnwfAZuHLTMg4V9t3DKGfozIaFiYprA0Dz/mQ3oY=;
        b=tXI5lyxzJhyx7b8n8GSPDfrAMap9b+609i1xnFOX1442aGjFHEBFJhPAjey2o4k4lu
         H3qRC5CoRLLxFxQwUEa68emcb6Zh6ZbMq5Xe7cIuiSLo+DbXjPBdBr8A0f+ruoOCa5sf
         wWWqazznIVFilJey+nmVUP3PuYYLvAEu7B2xJ8BAlkdFuVcOAF3nt/5g1B7EJXq9orCE
         cgiIVTAxCd2cCzXAufxXmVXfVBwewok0yJAxqLmW2aboA3zXUufBlug60yVrKcIq0zXr
         Xqpmxt81b5aDjN3YFMB/mYs9SFWtI3/FvEvDAk0rmyxiZXoB/Ya9eBRiTU7gVDfbqFl9
         +LYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jcHEnwfAZuHLTMg4V9t3DKGfozIaFiYprA0Dz/mQ3oY=;
        b=jzna0yy+LY7pUs8iOoCm3iQSzpNbMoLWIK6gFXEyDSbxQgjtkvb37dGPK8ufKYtvso
         QtxtTtG9hVFIAzcnGnBOCLVQfov2APtEfM1nB1nK5akCSxydhkAFcbbGBJqRDXXSZXX2
         6zz4bL9OhCfVFA1E4+z2qP8TlFHVjSxa0WVICyX3zDhwBJdzES0R1h+GO48FxYQ6bGoJ
         f6JJeV41lUTcAV1SOSq5SBpT+o8/+iSSgIOrkTLIjNkukUTN2981VFWtwoiJvLnJmP/O
         UV2267m/KbQYcjvMj9srjGEQ051dxKcLdlweeBFAs9e36hFVZ2ECrmZ//tRrOvnJOer1
         ZFHg==
X-Gm-Message-State: AJcUukfATBTGkubJpzvdeyB6YaZHmUeoPzt4ZbUQwn6KxQOm6DfM1HMq
        dAXBVCfgG5qn/h/6Y945ZkEaNW2D
X-Google-Smtp-Source: ALg8bN7fCRj9UgP51fwCc19DBm+gLLLINhDrTSHNkiwPJZdRWwN5e6yziSbD7uaoYiWNMEcA65gGFw==
X-Received: by 2002:a19:cd50:: with SMTP id d77mr31654887lfg.125.1549048947153;
        Fri, 01 Feb 2019 11:22:27 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id t23sm1512654lfl.59.2019.02.01.11.22.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 11:22:26 -0800 (PST)
Subject: Re: [PATCH V9 3/5] i2c: tegra: Add DMA support
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <6150de70-6ca8-944a-780a-4574ff2b21c7@gmail.com>
Date:   Fri, 1 Feb 2019 22:22:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB33984FB81B8BB1EC8C0C4908C2920@BYAPR12MB3398.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

01.02.2019 22:20, Sowjanya Komatineni пишет:
> 
>>> +static int tegra_i2c_init_dma(struct tegra_i2c_dev *i2c_dev) {
>>> +	struct dma_chan *dma_chan;
>>> +	u32 *dma_buf;
>>> +	dma_addr_t dma_phys;
>>> +	int err = 0;
>>> +
>>> +	if (!IS_ENABLED(CONFIG_TEGRA20_APB_DMA))
>>> +		return -ENODEV;
>>
>> Driver shall not fail to probe if DMA driver is disabled, but to continue with the PIO-only mode available.
>>
>> Should be:
>>
>> 	if (!IS_ENABLED(CONFIG_TEGRA20_APB_DMA))
>> 		return 0;
>>
> Except EPROBE_DEFER, anything else returned from tegra_i2c_init_dma (ENODEV/ENOMEM) is ignored in i2c_probe
> DMA mode decision is based on xfer size and availability of dma channel or can be changed based on valid dma buf to shorten the line.
> 

Ah, sorry. I missed that, seems good then.
