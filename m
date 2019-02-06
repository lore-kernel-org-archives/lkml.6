Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF80C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126E9218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLqJ/ClN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbfBFRhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:37:42 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43101 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfBFRhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:37:42 -0500
Received: by mail-lf1-f67.google.com with SMTP id j1so5969499lfb.10;
        Wed, 06 Feb 2019 09:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eiA+nquUohrcMhCmVnLnA5keHX4ZVJWgecRMh5gT8qY=;
        b=dLqJ/ClNRj7YxeEbwwCC9s/Dw3tYvGeTvZA99aUBaB2pY6CzhXGgoiYXs/bayeQ0P5
         MXQ7EI8mskvjNyiOl26r3V7MtBU4/qf9WWvJOD9bo+SQJyBPO1cUwL/XJSrGslWHtJL5
         3OtIndIfLIy4RXbxfLJGo+vyS0cklYMiDZOMKFaXHOaRJL4te2OcNOvfAb5pIoc8euDe
         Ft36TApyyHRlNRoQvwCuB+/LNEGGc2nAj5mZyPXYPXjrxA4d2wix/y2pmlhaWtP4yL1z
         SwFtL95hiF/GhLXqcvQL0LLxA2dtRHw2SzNgbTZaJLIOSLsjJgfSvt9o8zthihRb9Oib
         tS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eiA+nquUohrcMhCmVnLnA5keHX4ZVJWgecRMh5gT8qY=;
        b=C3OysYT2Pn/cbC4FGb8CGiT6funor634/ETy45a2X5INxdySc3ftp5JUVGb+i+TTvk
         zcXoaBUF+Aw6Qm6kIRkQ4dG6bdSDSm7IExzRaill8XT82tNHvzI3wI2dhJdON+QiiFHA
         X2J7XM/7IZiWR1MosruyulCJ/1WW85O62rHMTfUzFJ/JDaVHJXgdYwEKd+iPoA0hfqyr
         MQOAVG2GJ6RQy61UBwR6lalSpocCxgqMtpOP8khj2RNGV7ivE3OWX7J7cuD/aTw6F4nV
         LQ8cuiu3CsDGA+jLcO3aEvDJZwqAO8G6dG7jGRI0EobiFOi/Hfm6FGBMh1MY1P41tHjS
         Eynw==
X-Gm-Message-State: AHQUAubJZu/qEYlG287KB+01FZtMXJ8Pl9Sr4Fv5Wc0Tc334mm9i1kCn
        PdQGdYUJJG+VeUO+UEb9XQtf6pJL
X-Google-Smtp-Source: AHgI3IaGL17S37UjZhQrHfq6hq3JjOU+JE/gxuIJPRbFQyDzn/82xVljxlKygSIp+Fa8mIPKqg3BIQ==
X-Received: by 2002:a19:6514:: with SMTP id z20mr7409153lfb.31.1549474658817;
        Wed, 06 Feb 2019 09:37:38 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id n19sm957725lfe.64.2019.02.06.09.37.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 09:37:37 -0800 (PST)
Subject: Re: [PATCH V11 3/5] i2c: tegra: Add DMA support
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     jonathanh@nvidia.com, mkarthik@nvidia.com, smohammed@nvidia.com,
        talho@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
References: <1549356985-25726-1-git-send-email-skomatineni@nvidia.com>
 <1549356985-25726-3-git-send-email-skomatineni@nvidia.com>
 <a9e264e2-87c9-e263-808a-b561e8ed4073@gmail.com> <20190206145343.GA3651@ulmo>
 <5e66803c-b13b-cb00-e2ff-d096a1650612@gmail.com>
Message-ID: <37987664-d354-4f89-cc60-9cc37ca87322@gmail.com>
Date:   Wed, 6 Feb 2019 20:37:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <5e66803c-b13b-cb00-e2ff-d096a1650612@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.02.2019 17:56, Dmitry Osipenko пишет:
> 06.02.2019 17:53, Thierry Reding пишет:
>> On Tue, Feb 05, 2019 at 05:26:25PM +0300, Dmitry Osipenko wrote:
>> [...]
>>> Oh, another important moment is that physically contiguous dma_buf
>>> allocation isn't guaranteed by the DMA API. This may become a problem
>>> for T186+ that can transfer up to 64K. We need to enforce the
>>> contiguous-allocation requirement by using
>>> dma_alloc_attrs(DMA_ATTR_FORCE_CONTIGUOUS) instead of the
>>> dma_alloc_coherent(), please see my other comment below.
>>
>> Actually I don't think that's necessary here. DMA_ATTR_FORCE_CONTIGUOUS
>> only seems relevant if you've got an IOMMU attached to the device to
>> make sure the physical memory is also contiguous.
>>
>> See this extract from Documentation/DMA-attributes.txt:
>>
>> | DMA_ATTR_FORCE_CONTIGUOUS
>> | -------------------------
>> | 
>> | By default DMA-mapping subsystem is allowed to assemble the buffer
>> | allocated by dma_alloc_attrs() function from individual pages if it can
>> | be mapped as contiguous chunk into device dma address space. By
>> | specifying this attribute the allocated buffer is forced to be contiguous
>> | also in physical memory.
>>
>> We don't have an IOMMU attached to I2C or APBDMA, so this can't happen
>> and even if we had an IOMMU attached, all we care about is the device's
>> DMA address space, which means IOVA space, and that would still be
>> guaranteed to be contiguous, according to the above.
> 
> Yes, but doesn't T186+ have IOMMU support for the DMA controller?
> 

Ah, sorry I probably skimmed way too quickly thorough the message. Hmm.. well, seems I was wrong.

Sowjanya, after all looks like it should be fine to use the default dma_alloc_coherent() helper. Please put it back in v14.
