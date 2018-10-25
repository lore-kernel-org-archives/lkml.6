Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EFEC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C38F420848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FCYdn55I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C38F420848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeJZAqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:46:06 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52820 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbeJZAqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1JkPSRVnJ9l2rDtS6I6TOh3aAEkxlLLc03SoHV/cc4k=; b=FCYdn55IIuZOVBl7G0BABPZ28x
        OqsZXj3e6mQp7H/GUm1CzXNSsl/fUUkSDUQIgl9VGiechU+Q9uOKMz7WRbW4MyoaV2P16A+8tCLEz
        fU85SYVOM0Ob9ig2tcJ5fnkYEjqgEwMMtO/BlGovw9Azauliw2jaSP11436WVn1GCMOPQEN01JFgy
        TRJ0Rkcu2APou0dJWVO3z96FYygb9PIAXzVDz0EySb80eedOVIbLCVUDskGBSV/sPXky6JBFa8PSs
        ob+bx1q9IDtCehz7ntUHfWEA0kO6s9e93w6joEKiCF01aBR+Pi8Pl+MjINZUqWtp6v96bpaiJNVT4
        R7YntScg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gFiFO-0006Hr-69; Thu, 25 Oct 2018 16:12:34 +0000
Subject: Re: [PATCH v7 2/2] ThunderX2, perf : Add Cavium ThunderX2 SoC UNCORE
 PMU driver
To:     "Kulkarni, Ganapatrao" <Ganapatrao.Kulkarni@cavium.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     "Will.Deacon@arm.com" <Will.Deacon@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>,
        "Richter, Robert" <Robert.Richter@cavium.com>,
        "Lomovtsev, Vadim" <Vadim.Lomovtsev@cavium.com>,
        Jan Glauber <Jan.Glauber@cavium.com>,
        "gklkml16@gmail.com" <gklkml16@gmail.com>
References: <20181025055833.28471-1-ganapatrao.kulkarni@cavium.com>
 <20181025055833.28471-3-ganapatrao.kulkarni@cavium.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <84978a48-bd25-eede-519a-a4e9991c5c3d@infradead.org>
Date:   Thu, 25 Oct 2018 09:12:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181025055833.28471-3-ganapatrao.kulkarni@cavium.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/18 10:59 PM, Kulkarni, Ganapatrao wrote:
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 08ebaf7cca8b..c1956b1af2bb 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -87,6 +87,15 @@ config QCOM_L3_PMU
>  	   Adds the L3 cache PMU into the perf events subsystem for
>  	   monitoring L3 cache events.
>  
> +config THUNDERX2_PMU
> +        tristate "Cavium ThunderX2 SoC PMU UNCORE"
> +	depends on ARCH_THUNDER2 && ARM64 && ACPI && NUMA
> +        default m
> +	help
> +	  Provides support for ThunderX2 UNCORE events.
> +	  The SoC has PMU support in its L3 cache controller (L3C) and
> +	  in the DDR4 Memory Controller (DMC).
> +
>  config XGENE_PMU
>          depends on ARCH_XGENE
>          bool "APM X-Gene SoC PMU"

Please fix the Kconfig indentation.  Use one tab (not spaces) for each of
tristate, depends, default, and help.  (yes, some of them are tabs and some
are spaces.)


-- 
~Randy
