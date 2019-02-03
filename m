Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADFDC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 16:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0514921773
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 16:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="re8VbfWD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfBCQsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 11:48:14 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33302 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfBCQsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 11:48:14 -0500
Received: by mail-lj1-f196.google.com with SMTP id v1-v6so9747259ljd.0;
        Sun, 03 Feb 2019 08:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+8Cc//JKiKyjVUN7McFvrcZICDs8YLpdl2wi5TD16s8=;
        b=re8VbfWDJS4OGL+/grj6OYzzPyfpHWILFZXukIEWLJQ7ADPZsWUvLFIW1dhBKjkMk4
         BOxP4uHc4oh74HS1ORxhGp2tnQaPJ8iSAiHHIOk5jVviCd9f9INLiNIkNCM3CriNO6Z5
         R0wRtiCDPqhRa+hfGbpAdJCLG8Np5RmsRMnGqpnyMT8O28cBOFOaAf7xNiaamrFvrW38
         reyZIHCvUQmSyE3KtDDfElUPaqwb/do6TX5EgNBDZ+teXgfSozXGmDtw1lESxSJo44x4
         BQN7bNCXmLhkBVdDg5VYa/b7D0M8I9pg78GC1omlxpLs38/YkSVKQuNHiL1R7mtJjNAP
         Payg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+8Cc//JKiKyjVUN7McFvrcZICDs8YLpdl2wi5TD16s8=;
        b=Q4QhftQ3QVw8EMY2gikW3bwIKA32FemigxT4NyaLckTOxIGzFaiWHx6rcw9qqPozcU
         HPtqtcf90OvA14s/D00/gVLJ/6bKf5Sia4Bqx7W7wJNow1vZkdLNWjs0fLyqL3LW1eDF
         Ewf59XLAL56VgtwP0reHTlQAYr+eA/O4fNc9KgQILrqMwDxmrvkmHMBsghuRKwM1Ai34
         YWAsVhx/0kVLfQw/GccoIpTpazORPZZ3f03hvl+/vQtV6h0kwz1Teeh3jOm/7G38Zf9I
         /IV1ez47k94TE/PNpjmyO+7s6bbnWMyFz5qpXCLwi+R4we2kPSEpr6ahpNd9JIH3iz4/
         q4FQ==
X-Gm-Message-State: AJcUuke31+KwTTf5DEq5cVOYRPO5OvbbqJJNp5ROC2HQKIwrk10039Fs
        YY8ds5MAJZ/py45OBOHPmHR/t3tF
X-Google-Smtp-Source: ALg8bN72JzONmuTMpQ6V8yBDW3+snTtknSGdsYMcizd5WZMtwPpU13xcglq79rLGW14rhGWppP0EYQ==
X-Received: by 2002:a2e:2b8d:: with SMTP id r13-v6mr33492071ljr.79.1549212491579;
        Sun, 03 Feb 2019 08:48:11 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id d19-v6sm2348828ljc.37.2019.02.03.08.48.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Feb 2019 08:48:10 -0800 (PST)
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
 <d37e901b-1c26-3d9c-7f68-29e06f4ff993@gmail.com>
 <BYAPR12MB33982BC5A58A000A0CB84F6AC2930@BYAPR12MB3398.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a5e79739-3ce5-6c22-c9d2-e9d2c709cb30@gmail.com>
Date:   Sun, 3 Feb 2019 19:48:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB33982BC5A58A000A0CB84F6AC2930@BYAPR12MB3398.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

02.02.2019 21:32, Sowjanya Komatineni пишет:
>>> This patch adds DMA support for Tegra I2C.
>>>
>>> Tegra I2C TX and RX FIFO depth is 8 words. PIO mode is used for 
>>> transfer size of the max FIFO depth and DMA mode is used for transfer 
>>> size higher than max FIFO depth to save CPU overhead.
>>>
>>> PIO mode needs full intervention of CPU to fill or empty FIFO's and 
>>> also need to service multiple data requests interrupt for the same 
>>> transaction. This adds delay between data bytes of the same transfer 
>>> when CPU is fully loaded and some slave devices has internal timeout 
>>> for no bus activity and stops transaction to avoid bus hang. DMA mode 
>>> is helpful in such cases.
>>>
>>> DMA mode is also helpful for Large transfers during downloading or 
>>> uploading FW over I2C to some external devices.
>>>
>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>> ---
>>
>>
>>> +static int tegra_i2c_init_dma(struct tegra_i2c_dev *i2c_dev) {
>>> +	struct dma_chan *dma_chan;
>>> +	u32 *dma_buf;
>>> +	dma_addr_t dma_phys;
>>> +	int err = 0;
>>> +
>>> +	if (!IS_ENABLED(CONFIG_TEGRA20_APB_DMA))
>>> +		return -ENODEV;
>>
>> Another detail is that we need to keep older kernels working on T186+ after its device-tree will get the "dmas" property, device-tree changes shall be backwards-compatible with older kernels. Hence we need to check that platform actually wants the APB DMA driver, otherwise T186+ will be failing with -EPROBE_DEFER.
> 
> Yes, that will be a separate patch later for adding DMA support for Tegra186 and later chips once we check on GPCDMA upstream
> 
> 

Sure, and there is a requirement in upstream to keep older kernel versions working with the later device-tree updates, as I pointed above. Please include the ".has_apb_dma checking" that I'm suggesting into the next version.
 
