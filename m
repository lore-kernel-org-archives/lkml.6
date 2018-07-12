Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506A7C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93FAF20883
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K2MnKCLh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93FAF20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbeGLHjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 03:39:25 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:58331 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726497AbeGLHjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 03:39:25 -0400
X-Greylist: delayed 550 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Jul 2018 03:39:25 EDT
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 2B986263;
        Thu, 12 Jul 2018 03:21:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 12 Jul 2018 03:21:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=hbhSpg
        KVeMhoiGdbisbcaq80aVBdI5Cc5iAVWemHTbQ=; b=K2MnKCLhMuGMlCz3+zq7eT
        EbwWecoI9qKory5jKlMj4nMhh7dK+dY+dESv6+9cQuri0X1SDvKmTBHE+CNM40Ae
        9lbF5WXCGjcK6Rkbh08SLQpZHbsTcsFxlDmv9/GlXP8GNyykB7ZUfGAImabm543d
        ZkDIBj9B6oxEDKCcxZEKmIJACujxh4WYiIH0/SuOSKftnJuLj9D4bxyeAKwHL5c0
        WfSlvIMdLKlbBOQH9g2ZVfAg0W1LQ9b+/1yui/FonE/y6EzcGOF5wdScDIF8F71O
        FUghURuqk5qMHx/N0T6GJFaJTfbzC6EWS++eBpJ2dP1BaoySQgsWRZH4niqUOuPQ
        ==
X-ME-Proxy: <xmx:kgFHW4sz6KAi_sx7hvw37BNYjXm31Z47GhlgDyMKoNq2BeEnpjxOWA>
    <xmx:kgFHW32ecvdYoWN1OnxgdOfH7gtx4uN_8Sd0NVliPb9YfCYBQl2urQ>
    <xmx:kgFHW-Uj0qro-3mWhEydYIhS-PiiGnBm2gWUhtc4DTWMJ8BzZ_dV1g>
    <xmx:kgFHW1tpP7xXGRczGrkL2Ro4ZZxHIGw4ZvYDW1o7zKkQSP1CkEkkcQ>
    <xmx:kgFHWxziZH7Gf0vujpsEOgeMJ_HPwProZudFZMQXAthcjEXlehhJog>
    <xmx:kwFHW3Ebb2JsN_7SeyPQo0cNdBFHxlGrkcQj8DDb0JOomO2y6C2hIQ>
X-ME-Sender: <xms:kgFHWwzD65oRzddQ1_iQ8Gpgp1-JC46lOykiOd8qNSqEtY2xADBbfA>
Received: from snap.ozlabs.ibm.com (unknown [122.99.82.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id 79D6610266;
        Thu, 12 Jul 2018 03:21:53 -0400 (EDT)
Message-ID: <9640a2ff6ce0c20d603c16ba7e8b5238d206bf26.camel@russell.cc>
Subject: Re: [PATCH kernel] powerpc/powernv/ioda2: Add 256M IOMMU page size
 to the default POWER8 case
From:   Russell Currey <ruscur@russell.cc>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 12 Jul 2018 17:21:49 +1000
In-Reply-To: <20180702074205.12837-1-aik@ozlabs.ru>
References: <20180702074205.12837-1-aik@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-02 at 17:42 +1000, Alexey Kardashevskiy wrote:
> The sketchy bypass uses 256M pages so add this page size as well.
> 
> This should cause no behavioral change but will be used later.
> 
> Fixes: 477afd6ea6 "powerpc/ioda: Use ibm,supported-tce-sizes for
> IOMMU page size mask"
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: Russell Currey <ruscur@russell.cc>

> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c
> b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 5bd0eb6..557c11d 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2925,7 +2925,7 @@ static unsigned long
> pnv_ioda_parse_tce_sizes(struct pnv_phb *phb)
>  		/* Add 16M for POWER8 by default */
>  		if (cpu_has_feature(CPU_FTR_ARCH_207S) &&
>  				!cpu_has_feature(CPU_FTR_ARCH_300))
> -			mask |= SZ_16M;
> +			mask |= SZ_16M | SZ_256M;
>  		return mask;
>  	}
>  
