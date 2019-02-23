Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEC3C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 387AF20675
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbfBWNGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 08:06:55 -0500
Received: from mgwkm03.jp.fujitsu.com ([202.219.69.170]:42711 "EHLO
        mgwkm03.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbfBWNGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 08:06:55 -0500
Received: from ttb-m2.gw.nic.fujitsu.com (unknown [192.168.231.164]) by mgwkm03.jp.fujitsu.com with smtp
         id 0587_fab6_28a694dd_2478_40ca_9010_7beaf1cce546;
        Sat, 23 Feb 2019 22:06:48 +0900
Received: from g01jpfmpwkw02.exch.g01.fujitsu.local (g01jpfmpwkw02.exch.g01.fujitsu.local [10.0.193.56])
        by ttb-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 6155640C0425
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 22:06:47 +0900 (JST)
Received: from G01JPEXCHKW14.g01.fujitsu.local (G01JPEXCHKW14.g01.fujitsu.local [10.0.194.53])
        by g01jpfmpwkw02.exch.g01.fujitsu.local (Postfix) with ESMTP id CCE723283A0;
        Sat, 23 Feb 2019 22:06:46 +0900 (JST)
Received: from G01JPEXMBKW03.g01.fujitsu.local ([10.0.194.67]) by
 g01jpexchkw14 ([10.0.194.53]) with mapi id 14.03.0415.000; Sat, 23 Feb 2019
 22:06:46 +0900
From:   "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
To:     'James Morse' <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
CC:     'Catalin Marinas' <catalin.marinas@arm.com>,
        'Will Deacon' <will.deacon@arm.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4] arm64: Add workaround for Fujitsu A64FX erratum
 010001
Thread-Topic: [PATCH v4] arm64: Add workaround for Fujitsu A64FX erratum
 010001
Thread-Index: AdTENhuVebuKtHOoRzCPb6sZ5vznO///+H8AgAAo/wD//jk2sP/v2FHA
Date:   Sat, 23 Feb 2019 13:06:45 +0000
Message-ID: <8898674D84E3B24BA3A2D289B872026A6A319D26@G01JPEXMBKW03>
References: <8898674D84E3B24BA3A2D289B872026A6A311EAE@G01JPEXMBKW03>
 <20190214155605.GC27547@lakrids.cambridge.arm.com>
 <90347cf4-4d7b-d553-d4db-1bacd000ff75@arm.com>
 <8898674D84E3B24BA3A2D289B872026A6A313313@G01JPEXMBKW03>
In-Reply-To: <8898674D84E3B24BA3A2D289B872026A6A313313@G01JPEXMBKW03>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.2.3
x-shieldmailcheckerpolicyversion: FJ-ISEC-20140219
x-originating-ip: [10.18.70.198]
Content-Type: text/plain; charset="iso-2022-jp"
MIME-Version: 1.0
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

> -----Original Message-----
> From: linux-arm-kernel <linux-arm-kernel-bounces@lists.infradead.org> On
> Behalf Of Zhang, Lei
> Sent: Friday, February 15, 2019 9:36 PM
> To: 'James Morse' <james.morse@arm.com>; Mark Rutland
> <mark.rutland@arm.com>
> Cc: 'Catalin Marinas' <catalin.marinas@arm.com>; 'Will Deacon'
> <will.deacon@arm.com>; 'linux-kernel@vger.kernel.org'
> <linux-kernel@vger.kernel.org>; 'linux-arm-kernel@lists.infradead.org'
> <linux-arm-kernel@lists.infradead.org>
> Subject: RE: [PATCH v4] arm64: Add workaround for Fujitsu A64FX erratum
> 010001
> 
> 
> I think you mean it may be a problem to modify the KPTI trampoline because
> some patches about KPTI will be merged to mainline in the near future.
> I understood that.
> I should discuss with my colleagues whether we can set NFDx=0 all of time on
> A64FX.

The result of our investigation also supports your suggestion. 
We surely agree with you that your proposed method (never set NFDx=1 on A64FX)
is the best to resolve this erratum.
	
For this erratum, James's patch should be merged to mainline
instead of my previous patches (v1 to v4).
Since KPTI fully covers the effect of NFD1 for A64FX, KPTI is
recommended to be used in conjunction with James’s patch.

> And thanks for your patch.
> If we can set NFDx=0 all of time, I will review, test and report the result.

I have already tested James's patch on A64FX, and the result is no problem at all.

Tested-by:zhang.lei<zhang.lei@jp.fujitsu.com>


> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig index
> a4168d366127..b0b7f1c4e816 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -643,6 +643,25 @@ config QCOM_FALKOR_ERRATUM_E1041
> 
>  	  If unsure, say Y.
> 
> +config FUJITSU_ERRATUM_010001
> +	bool "Fujitsu-A64FX erratum E#010001: Undefined fault may occur wrongly"
> +	default y
> +	help
> +	  This option adds workaround for Fujitsu-A64FX erratum E#010001.
> +	  On some variants of the Fujitsu-A64FX cores version (1.0, 1.1), memory
> +	  accesses may cause undefined fault (Data abort, DFSC=0b111111).
> +	  This fault occurs under a specific hardware condition when a
> +	  load/store instruction performs an address translation using:
> +	  case-1  TTBR0_EL1 with TCR_EL1.NFD0 == 1.
> +	  case-2  TTBR0_EL2 with TCR_EL2.NFD0 == 1.
> +	  case-3  TTBR1_EL1 with TCR_EL1.NFD1 == 1.
> +	  case-4  TTBR1_EL2 with TCR_EL2.NFD1 == 1.
> +
> +	  The workaround is to ensure these bits are clear in TCR_ELx.
> +	  The workaround only affect the Fujitsu-A64FX.

I think it is better to add a notice here as follows:

  Recommend to enable KPTI (UNMAP_KERNEL_AT_EL0 = y).

> +
> +	  If unsure, say Y.
> +
>  endmenu

Thanks a lot.

Best Regards,
Zhang Lei 

