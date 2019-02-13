Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF96AC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB765222BE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hKu2VKHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389636AbfBMH3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:29:36 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36265 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732822AbfBMH3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:29:35 -0500
Received: by mail-wr1-f68.google.com with SMTP id o17so1275325wrw.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 23:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=p1ubNWXGHPnF8cNyX5xYmowXhYPVRyQWPlZNKdwfTas=;
        b=hKu2VKHT8ANYSMZfbVUfV7u6JKn6aZ8519m5/Q+ilXS/t8uBxsgQi92Uvx0cchs0k6
         0GS0R8muSud7PJBYF6mhzHEBfe9kHAnBnFfxPan9BeHGfzI//T9ez9hqA3oo816RRmZW
         wpYHbtKPgeW+Ifb3dvO/LCCJgnFyIF4Rj5sXrvmMVbgCDp3Cd5JuqWaO5h2+dhhJag22
         rf+lcITHUlTRnVPG0zKzo+0KtAz8LJKbeIrmRs8fVe5sfktMNzOu0VCf0FAn+CSFdDBx
         KCnYic2FHcgfPwIGxWieKHFvujUmy2bI44eRBnrSvNtkc+swOHwWm7gkl9cWoGDlDU6G
         LxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=p1ubNWXGHPnF8cNyX5xYmowXhYPVRyQWPlZNKdwfTas=;
        b=mCk3CNEMxUE/QiSAdzuSC9TTDuriq9YTed9XgTde9M2+t4S7whaRsjIpBmfBcRFaFG
         QOFEzZKVDiMRCcG4BIHp2hMUE0nj+VOYy2pCDnjpSBcb7DVH7RbsFHaqM2dFBmwc+Zg3
         VsxttF8lLgN1h5xobTP+CobWVLolurHQRQY1BT7HSnO6Ce422TtlSkNPJJlAfM+hzjuQ
         MfjM+OMoTcbhXCV/kcnz4wfR7csgLWWMYEahs5yMphLPQ7w1vx41agdZgP4+0O1TCoVZ
         EYUcBGM7pMIvx7nW0fpQuWp1J2qQHfAT2Q7ESV6L45y0au0c6b/d4MkP9eaDxBGzc2tW
         bgSg==
X-Gm-Message-State: AHQUAuYmhmh0VIzJvLJCuZMznl5bfiApBF0M7SR3E6OOpGSUqzk4Gq/P
        0VaGMaBwbBCeeBdmQmSrO+EMFjfYS9Q=
X-Google-Smtp-Source: AHgI3IZcd4zu/3yvHzkl49HGJ4yreQu5p0YiXKGToLp9LNR1JCXvFQTZLzDX27/8lOJeVrKoRHhVcQ==
X-Received: by 2002:a05:6000:6:: with SMTP id h6mr5767032wrx.68.1550042973913;
        Tue, 12 Feb 2019 23:29:33 -0800 (PST)
Received: from dell ([2.27.35.171])
        by smtp.gmail.com with ESMTPSA id q24sm4487482wmq.16.2019.02.12.23.29.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 23:29:33 -0800 (PST)
Date:   Wed, 13 Feb 2019 07:29:31 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        x86@kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] mfd/sm501: depend on HAS_DMA
Message-ID: <20190213072931.GD1863@dell>
References: <20190211133554.30055-1-hch@lst.de>
 <20190211133554.30055-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190211133554.30055-2-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2019, Christoph Hellwig wrote:

> Currently the sm501 mfd driver can be compiled without any dependencies,
> but through the use of dma_declare_coherent it really depends on
> having DMA and iomem support.  Normally we don't explicitly require DMA
> support as we have stubs for it if on UML, but in this case the driver
> selects support for dma_declare_coherent and thus also requires
> memmap support.  Guard this by an explicit dependency.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/mfd/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index f461460a2aeb..f15f6489803d 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1066,6 +1066,7 @@ config MFD_SI476X_CORE
>  
>  config MFD_SM501
>  	tristate "Silicon Motion SM501"
> +	depends on HAS_DMA
>  	 ---help---
>  	  This is the core driver for the Silicon Motion SM501 multimedia
>  	  companion chip. This device is a multifunction device which may

I would normally have taken this, but I fear it will conflict with
[PATCH 06/12].  For that reason, just take my:

  Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
