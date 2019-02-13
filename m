Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D138BC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CBB6222BE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Il8S2LIQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389594AbfBMH1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:27:21 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50239 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbfBMH1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:27:20 -0500
Received: by mail-wm1-f68.google.com with SMTP id x7so1246686wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 23:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ougDmMsACf0IXoScSd8bSpPQfh5iP2Vt3unj4CIa8E8=;
        b=Il8S2LIQg33Qcq8+uP7U/u3imYzP54lQZDAEEM5CF+kzID+q9sgm0f1PMHhfWqZiXS
         sh4DwdtHssUQrTbvsgx/oN/zcldkDP8Y8AeZzzRpPf1/injx//G+/Cf2r9GxWr4arkMl
         qCn6fydje/0+xe2IbXvOI0key5mboqPkQuUJ2aw8uOlM4sJVE1UARhZIKvW7hordAhSn
         +mVl08ksWPLgh21Ba7GdUgWYDOSD17cDkb57YKWs1Q69ULviavQangrTgmzX8DKCm5F1
         2hv9/wSO2ZgTfUhXjLdT/7j08glaH7922e9zMgNG7RB4Gf+HoF3hv0LQiWm+LqwXzCuu
         0qiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ougDmMsACf0IXoScSd8bSpPQfh5iP2Vt3unj4CIa8E8=;
        b=bcELhR8wkNWTYJf70M/wR/6TfMtgGF6k77FVF7eDG4HawiFo/HhiS0xVeuuu7Q7H2E
         55mF2YDKc/WyQPPSdhnIU4HEP7EwbLfCeNyPj4J6cTBnEAC/t+syHxj7wJ8J+EEH/U/1
         EY2DYZnAD5NtCW73jvnmjmnBtVn/Z64jMuzrH9BNAfZ/TZVLeDRyp0+YzinhzkkMgT2G
         zwD9xHMmKVr1GgfG1ai0PCS+qR3D6SwALNa/o6tA+tKtc0caw+fAN/pFNuiOiUDbiimZ
         o93BZFbrFoUeXf6zk2wu6hQXRyD3VA23UySbSX13kE3Vdyzqk0vG+2agV9hIycNyJIK0
         xOkg==
X-Gm-Message-State: AHQUAuZMoX/0h9pQoFzUYL6vsNevoD7kkKA/IW4/4XUVU7P8jM7abvof
        zCh9NSsw42tSI0W/AvWD2R5vrA==
X-Google-Smtp-Source: AHgI3IbW4eZ4PSEG6OMXvEyDow8gFmlqHoPShqVgICSkNax3h+8NXljNYO2fYKDgGUm+UxblAX9GyA==
X-Received: by 2002:a1c:c441:: with SMTP id u62mr2202451wmf.69.1550042838527;
        Tue, 12 Feb 2019 23:27:18 -0800 (PST)
Received: from dell ([2.27.35.171])
        by smtp.gmail.com with ESMTPSA id n9sm12417168wrx.80.2019.02.12.23.27.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 23:27:17 -0800 (PST)
Date:   Wed, 13 Feb 2019 07:27:16 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        x86@kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/12] dma-mapping: improve selection of
 dma_declare_coherent availability
Message-ID: <20190213072716.GC1863@dell>
References: <20190211133554.30055-1-hch@lst.de>
 <20190211133554.30055-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190211133554.30055-7-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2019, Christoph Hellwig wrote:

> This API is primarily used through DT entries, but two architectures
> and two drivers call it directly.  So instead of selecting the config
> symbol for random architectures pull it in implicitly for the actual
> users.  Also rename the Kconfig option to describe the feature better.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arc/Kconfig            | 1 -
>  arch/arm/Kconfig            | 2 +-
>  arch/arm64/Kconfig          | 1 -
>  arch/csky/Kconfig           | 1 -
>  arch/mips/Kconfig           | 1 -
>  arch/riscv/Kconfig          | 1 -
>  arch/sh/Kconfig             | 2 +-
>  arch/unicore32/Kconfig      | 1 -
>  arch/x86/Kconfig            | 1 -

>  drivers/mfd/Kconfig         | 2 ++

If everyone else is happy with these changes, then so am I.

  Acked-by: Lee Jones <lee.jones@linaro.org>

>  drivers/of/Kconfig          | 3 ++-
>  include/linux/device.h      | 2 +-
>  include/linux/dma-mapping.h | 8 ++++----
>  kernel/dma/Kconfig          | 2 +-
>  kernel/dma/Makefile         | 2 +-
>  15 files changed, 13 insertions(+), 17 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
