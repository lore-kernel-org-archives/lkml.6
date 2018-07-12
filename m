Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6E5C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3016721476
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="imcu5/HI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3016721476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbeGLFU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:20:57 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40197 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeGLFU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:20:57 -0400
Received: by mail-pf0-f194.google.com with SMTP id e13-v6so6487584pff.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 22:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qWDiiv/6u6GDVVv9qc8AzB7ZrIkyfGkk/QIkomHcMKw=;
        b=imcu5/HI7axd+fVuuA7zdMPzsaWiK4NJt3JFAnkcc9nVcF4d0QiT9CWJ2kVsHoFWB5
         nx65Lfj2eHf2VJSfg/wPGQL5EsSecw4Fqpe4Fn93IYZmkXY0Vcdy5bz4tY8LtXiB1uzz
         Z0dxy/MG3tjAw/kiVCeEJgWgatO+jRxVp3KyAssjRs8IEU0hNAr/99BamBzZQYoCr/EV
         KoO8JRrKGWqcLoAB0YrP96Jg6PJEUZSGfeCzftf2R4OteiY5B0bFmmdyXg9A5HDx0s5F
         0BHUFof2Fy5i28CGKQ51TOftxRabm/FRKVy7q1amX+CaqwKZY3Q8Ku+VMV4Nl4+Nydb1
         seaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qWDiiv/6u6GDVVv9qc8AzB7ZrIkyfGkk/QIkomHcMKw=;
        b=AXzCs7n8CDfmhkPrkvWy3MmxbSUhveVgYQJkt8vuaG0Ds6StP19yv/4o4zGH2gom7u
         jEs64nxKEsli+oxZxoYNNeNeYtHnZ1LBu5Pq8Vs4tChZMzCDitLO0QARZXoTO/ZcjD7D
         /eePLmfZB+IkgNAanAP3h9/U9GItrYbWYCFNLYg2twcFgc1XM6XIUI8fVoX86UqsJesz
         w4jsRHKYWPiuCdciQ+srZoANDRbrYuwmNpUICXI8i9J0SikGsALp59/VcN1wtT740o5m
         p07K+BJAi7raFTNTn3cdsMwGvIc6uyRS3OKXJtYtM0Mfll4L7/VjLf44AKnZSJ633RS6
         WX/Q==
X-Gm-Message-State: AOUpUlFUgnoRRJekUexa/QSYDIjN9KUZegjJtvxqnc4D82l0sHM7ELbL
        4GlX3Cns1dDyOywZy2OfQyQVM6ZzO2o=
X-Google-Smtp-Source: AAOMgpdU5tHeF8/qCdOMxwW1b0TXWwThmdDSgznl6ExCIwUsGqcwbqOf2Ym//DEMqXrTvSgu9P8NZw==
X-Received: by 2002:a63:530b:: with SMTP id h11-v6mr721020pgb.139.1531372386704;
        Wed, 11 Jul 2018 22:13:06 -0700 (PDT)
Received: from aik.ozlabs.ibm.com ([122.99.82.10])
        by smtp.googlemail.com with ESMTPSA id d11-v6sm33725733pfo.135.2018.07.11.22.13.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 22:13:06 -0700 (PDT)
Date:   Thu, 12 Jul 2018 15:12:59 +1000
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Russell Currey <ruscur@russell.cc>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel] powerpc/powernv/ioda2: Add 256M IOMMU page size
 to the default POWER8 case
Message-ID: <20180712151259.44f2f6ee@aik.ozlabs.ibm.com>
In-Reply-To: <20180702074205.12837-1-aik@ozlabs.ru>
References: <20180702074205.12837-1-aik@ozlabs.ru>
X-Mailer: Claws Mail 3.16.0git213 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  2 Jul 2018 17:42:05 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> The sketchy bypass uses 256M pages so add this page size as well.
> 
> This should cause no behavioral change but will be used later.
> 
> Fixes: 477afd6ea6 "powerpc/ioda: Use ibm,supported-tce-sizes for IOMMU page size mask"
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 5bd0eb6..557c11d 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2925,7 +2925,7 @@ static unsigned long pnv_ioda_parse_tce_sizes(struct pnv_phb *phb)
>  		/* Add 16M for POWER8 by default */
>  		if (cpu_has_feature(CPU_FTR_ARCH_207S) &&
>  				!cpu_has_feature(CPU_FTR_ARCH_300))
> -			mask |= SZ_16M;
> +			mask |= SZ_16M | SZ_256M;


Ping?

>  		return mask;
>  	}
>  
> -- 
> 2.11.0
> 



--
Alexey
