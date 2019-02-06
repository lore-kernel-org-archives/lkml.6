Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862BDC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BDED217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wz5zSI2z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfBFUCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 15:02:31 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39748 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbfBFUCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 15:02:31 -0500
Received: by mail-lj1-f194.google.com with SMTP id t9-v6so7235187ljh.6;
        Wed, 06 Feb 2019 12:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kwiNeC5Pm0FGr0gCKVWlGNEL4hZ4SSr3H994EIczZNQ=;
        b=Wz5zSI2zgv8y9HLo+uFRWqQ/tN+u5sX61yLE6enHbhS4EukjhpaZ3AE7HBMK0tfJ+J
         whX0N1B6E5TVdSuRrF6DBj9JLpdjOeQMHTf2bpX01nr8qei0QmNgFDdA+3E0utjfQzY6
         ZKEhGNYorzDVicTe0sYRfgAhC/Zb7uUA6frIVLP5j96szNLH3SSL7anEuxLsH3YRpCpN
         Vb/K1ubMzpmHOMuQRaQPJiwHXcx/BdCOO46UTWMkxBU/9aTIMUjZLnarbneDbJn48BEl
         V6NZDYca0fesTjzjBVC2sahdjbNFuU1bAHBl6cmKyw6IFpC9t+FFYf1F6+UGSty8O9NZ
         gIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kwiNeC5Pm0FGr0gCKVWlGNEL4hZ4SSr3H994EIczZNQ=;
        b=Ui8qzKc/Yr0dDLz8XDKQAdO/IjKFs0sC3NsBxR2CvaRdDzmhLXPJybq2hF9VvDje+b
         bhM+2VdO23C9mGuLXXLmuj2lzmnywrRm3+jEoYrMUJe4acovfAg6bMS4Mo0hH+Hh1Lbi
         UmCbAWUh84Ajsc8HD3BXbSK6QO2Ew9mNUKJ21BhNg0LeuwKVatqVSuO66TrYndCGNO+X
         k7iQg9CKrpAFVey5zZjqMNlJJvSxdIFQHJqNAjfjuE3vgrfMXuDwCqDmDcb50fLqFQKP
         oHgmWuOYaruyjzDq66llqgv+E3odsYjHZvMoGE1ee3jpM561dpOrZKXL8wyOkvLEw+IT
         sEJg==
X-Gm-Message-State: AHQUAuavgTMe/YYBXrsC8SmUGGR0bnyqiPqzU24MD4oScsoW56Nwy9FE
        ppiTr1C1raBtv13CtamQeejuqlgd
X-Google-Smtp-Source: AHgI3IaquxvF00ZCbYgHyWlDRjsVx/Chfy2GWwBq2A2kMfgl2dGlcj+8dZ4o/CwN4+irgEinu+HagQ==
X-Received: by 2002:a2e:a0d5:: with SMTP id f21-v6mr7506036ljm.98.1549483347971;
        Wed, 06 Feb 2019 12:02:27 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id t22sm4836708lfb.0.2019.02.06.12.02.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 12:02:27 -0800 (PST)
Subject: Re: [PATCH V11 3/5] i2c: tegra: Add DMA support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
References: <1549356985-25726-1-git-send-email-skomatineni@nvidia.com>
 <1549356985-25726-3-git-send-email-skomatineni@nvidia.com>
 <a9e264e2-87c9-e263-808a-b561e8ed4073@gmail.com> <20190206145343.GA3651@ulmo>
 <5e66803c-b13b-cb00-e2ff-d096a1650612@gmail.com>
 <37987664-d354-4f89-cc60-9cc37ca87322@gmail.com>
 <BYAPR12MB33987640AE0D0C76ADB42BF1C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <528ecd87-3f14-9e29-fb24-34802eeb0cb7@gmail.com>
Date:   Wed, 6 Feb 2019 23:02:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB33987640AE0D0C76ADB42BF1C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.02.2019 22:56, Sowjanya Komatineni пишет:
> 
>>>>> Oh, another important moment is that physically contiguous dma_buf 
>>>>> allocation isn't guaranteed by the DMA API. This may become a 
>>>>> problem for T186+ that can transfer up to 64K. We need to enforce 
>>>>> the contiguous-allocation requirement by using
>>>>> dma_alloc_attrs(DMA_ATTR_FORCE_CONTIGUOUS) instead of the 
>>>>> dma_alloc_coherent(), please see my other comment below.
>>>>
>>>> Actually I don't think that's necessary here. 
>>>> DMA_ATTR_FORCE_CONTIGUOUS only seems relevant if you've got an IOMMU 
>>>> attached to the device to make sure the physical memory is also contiguous.
>>>>
>>>> See this extract from Documentation/DMA-attributes.txt:
>>>>
>>>> | DMA_ATTR_FORCE_CONTIGUOUS
>>>> | -------------------------
>>>> | 
>>>> | By default DMA-mapping subsystem is allowed to assemble the buffer 
>>>> | allocated by dma_alloc_attrs() function from individual pages if it 
>>>> | can be mapped as contiguous chunk into device dma address space. By 
>>>> | specifying this attribute the allocated buffer is forced to be 
>>>> | contiguous also in physical memory.
>>>>
>>>> We don't have an IOMMU attached to I2C or APBDMA, so this can't 
>>>> happen and even if we had an IOMMU attached, all we care about is the 
>>>> device's DMA address space, which means IOVA space, and that would 
>>>> still be guaranteed to be contiguous, according to the above.
>>>
>>> Yes, but doesn't T186+ have IOMMU support for the DMA controller?
>>>
>>
>> Ah, sorry I probably skimmed way too quickly thorough the message. Hmm.. well, seems I was wrong.
>>
>> Sowjanya, after all looks like it should be fine to use the default dma_alloc_coherent() helper. Please put it back in v14.
> 
> Latest V14 uses dma_alloc_coherent along with below fixes.
> - Fixed fifo trig level to do register write with constructed value from scratch as flush is done prior to that and no other bits other than trig level. So writing value direct is simpler
> - Fixed to account DVC offset for FIFO register during dma slave config source and destination addresses
> - Also in 5th patch in series, updated to use interface timing flag in hw feature as tegra114 and prior doesn’t support interface timing register so allowing programming of timing register only for later tegra chips. Tegra114 and prior uses fixed TLOW and THIGH which are part of hw feature already.
> 
> Hopefully all fixes are in. Tested by forcing DMA only and PIO Only and also DMA/PIO back-to-back.

Thanks, I'll try it out tomorrow.
