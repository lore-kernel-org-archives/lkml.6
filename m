Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5D5C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A9020882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OGDVVpef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbfA2Vot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 16:44:49 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:47730 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfA2Vot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 16:44:49 -0500
Received: from mailhost.synopsys.com (dc2-mailhost1.synopsys.com [10.12.135.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id B772310C1382;
        Tue, 29 Jan 2019 13:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1548798288; bh=DRprCnG4eBsABgj4bMUuvy1aRMokWEQjtv2TWu5cWXU=;
        h=From:To:CC:Subject:Date:References:From;
        b=OGDVVpefWMcbcyickIoADp9uB2H/dGfT+ooQEnN4nK65qBX5htGJijOkxZgCkbrX7
         dTZT3iYqyfHs6VsyaorRuuI112Jnduiulo3LWGRUJmCrKitcjHrrZGJx1xoZqaqt8G
         2KfW2YGrsrnDGVvCArb434qsCAl1bnr3nSmVuLV7B5AVha1O9ZFxXRPmdnO/yhUZjS
         LAMZN+/JgnE8yDVLKd1qrXqizAMYISi2iV1zNCkvqvHvQvGjf19PURwNGOD1GfsVoe
         FE6sALQ2RQqaglGRTPwhfCazL1h00Dfdf/hgYe2qOhlRyZ9fI+oCR7yEhttXwHrbxC
         Ghxd/orvhtugA==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 6209DA008B;
        Tue, 29 Jan 2019 21:44:47 +0000 (UTC)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by us01wehtc1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Tue,
 29 Jan 2019 13:44:45 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <alexey.brodkin@synopsys.com>
Subject: Re: [PATCH 2/5] ARCv2: introduce unaligned access under a Kconfig
 option
Thread-Topic: [PATCH 2/5] ARCv2: introduce unaligned access under a Kconfig
 option
Thread-Index: AQHUt8BdV97GEf2KMUGRvvMb2YNphA==
Date:   Tue, 29 Jan 2019 21:44:44 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075014642D58D@US01WEMBX2.internal.synopsys.com>
References: <20190129104942.31705-1-Eugeniy.Paltsev@synopsys.com>
 <20190129104942.31705-3-Eugeniy.Paltsev@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.106]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/19 2:49 AM, Eugeniy Paltsev wrote:=0A=
> As of today we enable unaligned access unconditionally on ARCv2.=0A=
> Lets move it under Kconfig option so we can disable it in case of=0A=
> using HW configuration which lacks of it.=0A=
>=0A=
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>=0A=
> ---=0A=
>  arch/arc/Kconfig                      | 8 ++++++++=0A=
>  arch/arc/include/asm/irqflags-arcv2.h | 4 ++++=0A=
>  arch/arc/kernel/intc-arcv2.c          | 4 +++-=0A=
>  3 files changed, 15 insertions(+), 1 deletion(-)=0A=
>=0A=
> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig=0A=
> index 376366a7db81..37c8aeefa3a5 100644=0A=
> --- a/arch/arc/Kconfig=0A=
> +++ b/arch/arc/Kconfig=0A=
> @@ -387,6 +387,14 @@ config ARC_HAS_SWAPE=0A=
>  =0A=
>  if ISA_ARCV2=0A=
>  =0A=
> +config ARC_USE_UNALIGNED_MEM_ACCESS=0A=
> +	bool "Handle unaligned access in HW and use it"=0A=
> +	default y=0A=
> +	help=0A=
> +	  The ARC HS architecture supports unaligned memory access=0A=
> +	  which is disabled by default. Enable unaligned access in=0A=
> +	  hardware and use it in software.=0A=
> +=0A=
>  config ARC_HAS_LL64=0A=
>  	bool "Insn: 64bit LDD/STD"=0A=
>  	help=0A=
> diff --git a/arch/arc/include/asm/irqflags-arcv2.h b/arch/arc/include/asm=
/irqflags-arcv2.h=0A=
> index 8a4f77ea3238..9b911e2c6b31 100644=0A=
> --- a/arch/arc/include/asm/irqflags-arcv2.h=0A=
> +++ b/arch/arc/include/asm/irqflags-arcv2.h=0A=
> @@ -44,8 +44,12 @@=0A=
>  #define ARCV2_IRQ_DEF_PRIO	1=0A=
>  =0A=
>  /* seed value for status register */=0A=
> +#ifdef CONFIG_ARC_USE_UNALIGNED_MEM_ACCESS=0A=
>  #define ISA_INIT_STATUS_BITS	(STATUS_IE_MASK | STATUS_AD_MASK | \=0A=
>  					(ARCV2_IRQ_DEF_PRIO << 1))=0A=
> +#else=0A=
> +#define ISA_INIT_STATUS_BITS	(STATUS_IE_MASK | (ARCV2_IRQ_DEF_PRIO << 1)=
)=0A=
> +#endif /* CONFIG_ARC_USE_UNALIGNED_MEM_ACCESS */=0A=
=0A=
I'd prefer to change the define of STATUS_AD_MASK itself and keep all of th=
is=0A=
unchanged !=0A=
=0A=
>  =0A=
>  #ifndef __ASSEMBLY__=0A=
>  =0A=
> diff --git a/arch/arc/kernel/intc-arcv2.c b/arch/arc/kernel/intc-arcv2.c=
=0A=
> index 067ea362fb3e..84b1c7157d1b 100644=0A=
> --- a/arch/arc/kernel/intc-arcv2.c=0A=
> +++ b/arch/arc/kernel/intc-arcv2.c=0A=
> @@ -93,7 +93,9 @@ void arc_init_IRQ(void)=0A=
>  =0A=
>  	/* setup status32, don't enable intr yet as kernel doesn't want */=0A=
>  	tmp =3D read_aux_reg(ARC_REG_STATUS32);=0A=
> -	tmp |=3D STATUS_AD_MASK | (ARCV2_IRQ_DEF_PRIO << 1);=0A=
> +	if (IS_ENABLED(ARC_USE_UNALIGNED_MEM_ACCESS))=0A=
> +		tmp |=3D STATUS_AD_MASK;=0A=
> +	tmp |=3D ARCV2_IRQ_DEF_PRIO << 1;=0A=
=0A=
This will change after rebase as we just need to delete the code here, done=
 in head.S=0A=
=0A=
>  	tmp &=3D ~STATUS_IE_MASK;=0A=
>  	asm volatile("kflag %0	\n"::"r"(tmp));=0A=
>  }=0A=
=0A=
