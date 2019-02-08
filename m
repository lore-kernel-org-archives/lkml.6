Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC86C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 483722146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPwHVIFL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbfBHRgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:36:51 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40265 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbfBHRgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:36:49 -0500
Received: by mail-pf1-f193.google.com with SMTP id i12so1978090pfo.7;
        Fri, 08 Feb 2019 09:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oFXzCXgXx3A+sEu0hlDst0Stllur/UsLVMRoyon0kkU=;
        b=sPwHVIFLno62ybfiHRZ0I4BhRpBGBC1iDk5ae2DVLQ9XQTA7for3069zobJZHHC63s
         JJVz1Br6OX4Ca+dqekUh2FVjYYvyG2/PlcHufrxIsAgxh2uq7+NjL77vizZmoyjkrzO3
         y5SKRRODOr7PcPsUOjNf+KXZkmMrYp6TUZGpAnhWeG85y+8zvG3toeT439BSwdxRc1vz
         pOy3QP3ZVzkAaxG2YaGsNhtKDC4IMfogb3L6JCkVdO79yAze+lKjeds1GGCIsexrdr7m
         FZvSPOPdE5adY0LVjKjamrzEyRshlA2GFebED7JdLvVSgxVy6t4oKU27He/PNt3QLxH2
         AP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oFXzCXgXx3A+sEu0hlDst0Stllur/UsLVMRoyon0kkU=;
        b=oh/6BZVuFu1jrVzB+nRETQw5r84J3z/6PQv0ALoWqIRcvXtobp5ejxwJgyXh9391ZZ
         +jcpkiweP0qJjgDGGdXld7mX4qJ3NqTjafbmvGaIE83HxYELfbC78nNS2GbLDHvLAuay
         9dL1yQCsrvSGsJzhunsmLnGxBd+PByM6KZbHhpVm4+Vr5/rj5m0HcQLKTOJ5qvu/8jOg
         Ue5LraHj9f1VxegwyvVI12RKlCTmiCgLOk55QLghNkMGYFnH/P4q7gQfYZTdlr7AJE4Z
         5rBQzmKB+Y3kqCVCciP17PbD/Cj+ctK3re26yN/atKSocOme/ltZ4jdbVSnOYEkLMbOh
         mo5w==
X-Gm-Message-State: AHQUAuYqk5wo0ytD2iyGDd5bBYyxBggHXLt4OoKNxL6lW78BSZZMIv4p
        O+2xk12pz8OUHYiOtrfqCsCIH/G2
X-Google-Smtp-Source: AHgI3IYZtlTaSxZgxpgyqxwqbo4V9oT1EJ+co9nEAnafl6QO7+wIEddo/RSlCtuH6MGPexeF+Uxr3A==
X-Received: by 2002:a62:6143:: with SMTP id v64mr23365371pfb.142.1549647408353;
        Fri, 08 Feb 2019 09:36:48 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id e65sm4300719pfc.184.2019.02.08.09.36.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 09:36:47 -0800 (PST)
Subject: Re: [PATCH V16 4/6] i2c: tegra: Add DMA support
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
References: <1549644314-1481-1-git-send-email-skomatineni@nvidia.com>
 <1549644314-1481-4-git-send-email-skomatineni@nvidia.com>
 <dd2899ab-1a5f-834c-ab97-1654845c7de2@gmail.com>
 <BYAPR12MB33980494FB2E5C439210124FC2690@BYAPR12MB3398.namprd12.prod.outlook.com>
 <BYAPR12MB33987BF143F5903AE5DA196AC2690@BYAPR12MB3398.namprd12.prod.outlook.com>
 <4ba38a07-1953-9393-8756-ce555557017a@gmail.com>
 <BYAPR12MB33984E76B8BE19ED0CB0BE17C2690@BYAPR12MB3398.namprd12.prod.outlook.com>
 <3ac41d68-976d-4674-9a31-708195d58eeb@gmail.com>
Message-ID: <a4cfa59f-39d0-4a80-bbdd-d558d2d09dcc@gmail.com>
Date:   Fri, 8 Feb 2019 20:36:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <3ac41d68-976d-4674-9a31-708195d58eeb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

08.02.2019 20:34, Dmitry Osipenko пишет:
> 08.02.2019 20:29, Sowjanya Komatineni пишет:
>>
>>>>
>>>>> I'm still also suggesting to squash "fix maximum transfer size" into this patch because it is really part of DMA-support enabling.
>>>>
>>>> Max transfer length limits apply to PIO also but for DMA its more needed to prevent crash.
>>>> So had this as patch before DMA as its applicable for both DMA & PIO.
>>>
>>> Oh, so the packet_header size also shall be excluded for the PIO as well, really? It looked to me that PIO doesn't have that restriction and we only need to exclude the header size for DMA..
>>>
>>>> We exchanged on this yesterday, so thought the reason you want to squash separate patch and include in this is due to max msg len limit and when moved into hw feature.
>>>
>>> If PIO limits are incorrect, then it's absolutely fine to do it in the separate patch. I probably just misunderstood your point.
>>>
>>>> Sorry should have verified before sending. Please confirm if I leave max transfer as separate patch or add to this DMA support. Will update along with dma buf size fix.
>>>>
>>>> But max transfer limit applied to PIO also and that’s why added it before DMA patch to show its dependency
>>>>
>>>
>>> And then you need to explicitly tell in the commit message that PIO limits are incorrect.
>> Commit message says Tegra I2C max limit per packets transfer meaning that’s interface transfer limit so applies to both PIO & DMA.
>> Will add explicitly indicating applicable for both PIO & DMA to be more clear
> 
> Thank you.
> 
>>>
>>> It also probably worth to add a stable-tag to the commit message to request backporting of the limits-fixing patch to the stable kernels:
>>>
>>> Cc: stable@vger.kernel.org
>>>
>> Sorry I am new to upstream submissions. By adding stable-tag to commit message, do you mean explicitly mentioning this patch applicable to old kernel and adding in patch CC stable@vger.kernel.org?
>>
> 
> You just need to add "Cc: stable@vger.kernel.org" to the commit message, like you did for the "Reviewed-by:". Don't add "stable@vger.kernel.org" to the email recipients. See for example [0]. 
> 
> [0] https://lore.kernel.org/patchwork/patch/1001991/
> 

And yes, it will mean that patch is applicable for older kernels.
