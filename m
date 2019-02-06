Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25ADC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9D92073F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AALbfhzb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730934AbfBFO4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 09:56:07 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40439 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfBFO4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 09:56:06 -0500
Received: by mail-lj1-f196.google.com with SMTP id n18-v6so6302993lji.7;
        Wed, 06 Feb 2019 06:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sYD+4x7D/riHr95LzbpFXFWdRHGv1pyolcQUSjsCBPI=;
        b=AALbfhzbA7Bm3FnnlW4tiFdbFI9+h67aAUFoqWGb2P6qNC5D3DDinbPam+0DYXUnYR
         V5Aby5srdZCtVOz5ca6BE1THoACjV8+7zoFH7HR+PfMMksd5D9IY8FPkeSNoTgQ3hNC4
         vu1Ccwl2SFX9jFkhUw9twk4OIJCwdxT+HG+nYkOqTdRzPA4MAPlhlRg2w96e3zrzRPR9
         W1x6vAllbk0k6DUIPU69Dyi9zkyzMJVFj+S93avxAf0ywMIHrRZgZJ+KlpXcMYfdjx+r
         ZjGOWWA68S9+P+31H3IYEl7cQ49UuUTtsMarZhBadIN1gqelc5mi8A6Gxq5Hp4r7l/Rd
         n4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sYD+4x7D/riHr95LzbpFXFWdRHGv1pyolcQUSjsCBPI=;
        b=HqqUI3fWGpMPQgbau6DnZo2zUJWkREModNrrkFAzEiXq2y7t4cgOV7HtIkEvxjaQHV
         iBwX2D2Gs8l+Bdk4v47bfRwd8Vh8ygnZ9ICIs/XD7Ak8AUBvTWEXqrnaCAzCYpp9+hmF
         U3K1ja451T/bziia66T2FsV0dZMNf8rikZTNGhTUMWn3AWpUZxwxw19tBXY9qebPUBoY
         y4OKPWvL3O52/MhOavDPIpHfB2oPJO/Ioe9gcU7pY8fkpn2tBNccBgwX6cmg/Giw4fsL
         SeSuH6fV3TgMDzlsEJQgEp1kAejMp3NeaFJEYgkkeDpq4P4IIrC0A7JFN0RgTleTB8Y2
         GtRw==
X-Gm-Message-State: AHQUAubVVjzJ6ybQKyd2VCKA7P1RJ7nxrsbhGR42KM5Qebo0gCOu3tyk
        mGNMkNg32sVFkmYoSCA4lC3jBiM6
X-Google-Smtp-Source: AHgI3IaJ0VWK2QRIZTAsd+MaOTUg08tt1VvEvd8EV8Dl5TXATDSctvhA4Km5ITewBL39QzmK3w2wbw==
X-Received: by 2002:a2e:750a:: with SMTP id q10-v6mr6040094ljc.39.1549464963876;
        Wed, 06 Feb 2019 06:56:03 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id y1-v6sm3759804ljh.39.2019.02.06.06.56.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 06:56:03 -0800 (PST)
Subject: Re: [PATCH V11 3/5] i2c: tegra: Add DMA support
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1549356985-25726-1-git-send-email-skomatineni@nvidia.com>
 <1549356985-25726-3-git-send-email-skomatineni@nvidia.com>
 <a9e264e2-87c9-e263-808a-b561e8ed4073@gmail.com> <20190206145343.GA3651@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <5e66803c-b13b-cb00-e2ff-d096a1650612@gmail.com>
Date:   Wed, 6 Feb 2019 17:56:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190206145343.GA3651@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.02.2019 17:53, Thierry Reding пишет:
> On Tue, Feb 05, 2019 at 05:26:25PM +0300, Dmitry Osipenko wrote:
> [...]
>> Oh, another important moment is that physically contiguous dma_buf
>> allocation isn't guaranteed by the DMA API. This may become a problem
>> for T186+ that can transfer up to 64K. We need to enforce the
>> contiguous-allocation requirement by using
>> dma_alloc_attrs(DMA_ATTR_FORCE_CONTIGUOUS) instead of the
>> dma_alloc_coherent(), please see my other comment below.
> 
> Actually I don't think that's necessary here. DMA_ATTR_FORCE_CONTIGUOUS
> only seems relevant if you've got an IOMMU attached to the device to
> make sure the physical memory is also contiguous.
> 
> See this extract from Documentation/DMA-attributes.txt:
> 
> | DMA_ATTR_FORCE_CONTIGUOUS
> | -------------------------
> | 
> | By default DMA-mapping subsystem is allowed to assemble the buffer
> | allocated by dma_alloc_attrs() function from individual pages if it can
> | be mapped as contiguous chunk into device dma address space. By
> | specifying this attribute the allocated buffer is forced to be contiguous
> | also in physical memory.
> 
> We don't have an IOMMU attached to I2C or APBDMA, so this can't happen
> and even if we had an IOMMU attached, all we care about is the device's
> DMA address space, which means IOVA space, and that would still be
> guaranteed to be contiguous, according to the above.

Yes, but doesn't T186+ have IOMMU support for the DMA controller?
