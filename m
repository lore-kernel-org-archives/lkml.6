Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82157C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524B020855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qBgs9Wxm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfBHSBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 13:01:48 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35749 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbfBHSBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 13:01:47 -0500
Received: by mail-pl1-f193.google.com with SMTP id p8so2054648plo.2;
        Fri, 08 Feb 2019 10:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e9SsariyMP4aISMXLuVonEdgR7WiBu+Kzh3JlQtEUw0=;
        b=qBgs9WxmoIZHsRC4MVTmIBlbFzBNmw6m/QEpGIr+WW6Ug1VX9MJGVQlz+6fWN3YfFP
         GYLUjslXp4m6abGWwgNMY/0+3CmqiuZm5EWh9PZSHDANE5ssohnS1nLrFeJoEV2dCYJT
         3O6PysM15ohyMptmwAJsHTIQTjdd2rArKBj2/3WgMGbCEMm6ibubW9gu4Hvc5+riuCY/
         HmzTyrcqdIa3KUbjAvpFIew1E1qvT9KMVTFUXHCIXHhSn++mdJSk29mNp8T2l+zjPHvx
         kfhathcVfMPYgFNCQTLuXG/2rkfvHn/A3T8R6lGbKXPHTCreVALzy7FRXTHV9CVfdo9h
         JIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e9SsariyMP4aISMXLuVonEdgR7WiBu+Kzh3JlQtEUw0=;
        b=H5JkBwVxtw+aFNdGmCJ7GpcmBX8HYMtavAEWtU5gUBt+E5mIq9ZdnF8oaWCdsoNVDT
         NS46fjGXzUUcrwhkKiCFwqE8SDEBZCpPRVfXTcv+GkTv1Z7fkeWl7lzj9nPlXSqnIcCT
         R197z1UMZ+5FWFjElVlTUokDWUBMskD9gVXR2rqS3xjQHr8GTIb+TN2WnNNAFBuUkzsn
         l3wyy/SJJIGeyZxn9fe5pEUP76Xl3OYEWepK86OIgp4i+wZI7Nm0s4Qm/z5frU06qdTt
         4nTprg5DSiYKGjVyag1agrGzLtUQutiORCgONEbilj0uGSO0tmgBj2KEjwQInlC8m7d2
         YeOw==
X-Gm-Message-State: AHQUAuZdtR29FBvknZZbhp1stvMzBDvSjpG7zIFFYT8TJqjbtjT93WZG
        ZtSeBpC6JpayrJNeiufbHc3OxeCx
X-Google-Smtp-Source: AHgI3IZQb1ttpO4fm4xGG69LKEkrkX1omLVQTyV/X5EHceXOHm4mLkMn3GbbGiX2Ap5AUD4A++ZGyw==
X-Received: by 2002:a17:902:15a8:: with SMTP id m37mr24205981pla.129.1549648906522;
        Fri, 08 Feb 2019 10:01:46 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id l5sm3357868pgl.51.2019.02.08.10.01.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 10:01:45 -0800 (PST)
Subject: Re: [PATCH V16 4/6] i2c: tegra: Add DMA support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
Cc:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
References: <1549644314-1481-1-git-send-email-skomatineni@nvidia.com>
 <1549644314-1481-4-git-send-email-skomatineni@nvidia.com>
 <dd2899ab-1a5f-834c-ab97-1654845c7de2@gmail.com>
 <BYAPR12MB33980494FB2E5C439210124FC2690@BYAPR12MB3398.namprd12.prod.outlook.com>
 <BYAPR12MB33987BF143F5903AE5DA196AC2690@BYAPR12MB3398.namprd12.prod.outlook.com>
 <4ba38a07-1953-9393-8756-ce555557017a@gmail.com>
 <BYAPR12MB33984E76B8BE19ED0CB0BE17C2690@BYAPR12MB3398.namprd12.prod.outlook.com>
 <3ac41d68-976d-4674-9a31-708195d58eeb@gmail.com>
 <a4cfa59f-39d0-4a80-bbdd-d558d2d09dcc@gmail.com>
 <BYAPR12MB33987C73B01ACDC11CFAFE6DC2690@BYAPR12MB3398.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b7d3655d-288a-ac5f-a2ec-b49d150f0357@gmail.com>
Date:   Fri, 8 Feb 2019 21:01:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB33987C73B01ACDC11CFAFE6DC2690@BYAPR12MB3398.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

08.02.2019 20:53, Sowjanya Komatineni пишет:
>>>>>>
>>>>>>> I'm still also suggesting to squash "fix maximum transfer size" into this patch because it is really part of DMA-support enabling.
>>>>>>
>>>>>> Max transfer length limits apply to PIO also but for DMA its more needed to prevent crash.
>>>>>> So had this as patch before DMA as its applicable for both DMA & PIO.
>>>>>
>>>>> Oh, so the packet_header size also shall be excluded for the PIO as well, really? It looked to me that PIO doesn't have that restriction and we only need to exclude the header size for DMA..
>>>>>
>>>>>> We exchanged on this yesterday, so thought the reason you want to squash separate patch and include in this is due to max msg len limit and when moved into hw feature.
>>>>>
>>>>> If PIO limits are incorrect, then it's absolutely fine to do it in the separate patch. I probably just misunderstood your point.
>>>>>
>>>>>> Sorry should have verified before sending. Please confirm if I leave max transfer as separate patch or add to this DMA support. Will update along with dma buf size fix.
>>>>>>
>>>>>> But max transfer limit applied to PIO also and that’s why added it before DMA patch to show its dependency
>>>>>>
>>>>>
>>>>> And then you need to explicitly tell in the commit message that PIO limits are incorrect.
>>>> Commit message says Tegra I2C max limit per packets transfer meaning that’s interface transfer limit so applies to both PIO & DMA.
>>>> Will add explicitly indicating applicable for both PIO & DMA to be more clear
>>>
>>> Thank you.
>>>
>>>>>
>>>>> It also probably worth to add a stable-tag to the commit message to request backporting of the limits-fixing patch to the stable kernels:
>>>>>
>>>>> Cc: stable@vger.kernel.org
>>>>>
>>>> Sorry I am new to upstream submissions. By adding stable-tag to commit message, do you mean explicitly mentioning this patch applicable to old kernel and adding in patch CC stable@vger.kernel.org?
>>>>
>>>
>>> You just need to add "Cc: stable@vger.kernel.org" to the commit message, like you did for the "Reviewed-by:". Don't add "stable@vger.kernel.org" to the email recipients. See for example [0]. 
>>>
>>> [0] https://lore.kernel.org/patchwork/patch/1001991/
>>>
>>
>> And yes, it will mean that patch is applicable for older kernels.
> 
> Thanks Dmitry. Added Cc: stable@vger.kernel.org
> Also has to use 65535 instead of 64K because when buf size is computed using max_write_len with addition of packet header it will be exact 64K but max msg len is 65535
> So 1 byte less 64K should be OK

It is absolutely fine for dma_buf size to be larger than the message len. The max_write_len is off by one byte from the correct value by using 65535 - PACKET_HEADER_SIZE, I'd recommend to keep the SZ_64K.
