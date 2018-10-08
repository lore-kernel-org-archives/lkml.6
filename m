Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69732C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C502064E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C502064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbeJHRUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:20:06 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:42725 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbeJHRUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:20:06 -0400
Received: from 79.184.255.62.ipv4.supernova.orange.pl (79.184.255.62) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id 1f0a8dd1ce5b11ab; Mon, 8 Oct 2018 12:09:07 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the tip tree with the pm tree
Date:   Mon, 08 Oct 2018 12:06:02 +0200
Message-ID: <4344904.ysa79Efigr@aspire.rjw.lan>
In-Reply-To: <20181008134449.64aad97e@canb.auug.org.au>
References: <20181008134449.64aad97e@canb.auug.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, October 8, 2018 4:44:49 AM CEST Stephen Rothwell wrote:
> 
> --Sig_/bNRy8ryxcqLmcoGqvlETGhp
> Content-Type: text/plain; charset=US-ASCII
> Content-Transfer-Encoding: quoted-printable
> 
> Hi all,
> 
> Today's linux-next merge of the tip tree got a conflict in:
> 
>   drivers/powercap/intel_rapl.c
> 
> between commit:
> 
>   17ed15183c24 ("powercap: RAPL: Get rid of custom RAPL_CPU() macro")
> 
> from the pm tree and commit:
> 
>   f2c4db1bd807 ("x86/cpu: Sanitize FAM6_ATOM naming")
> 
> from the tip tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> --=20
> Cheers,
> Stephen Rothwell
> 
> diff --cc drivers/powercap/intel_rapl.c
> index bb92874b1175,8cbfcce57a06..000000000000
> --- a/drivers/powercap/intel_rapl.c
> +++ b/drivers/powercap/intel_rapl.c
> @@@ -1133,40 -1133,47 +1133,40 @@@ static const struct rapl_defaults rapl_
>   	.compute_time_window =3D rapl_compute_time_window_atom,
>   };
>  =20
>  -#define RAPL_CPU(_model, _ops) {			\
>  -		.vendor =3D X86_VENDOR_INTEL,		\
>  -		.family =3D 6,				\
>  -		.model =3D _model,			\
>  -		.driver_data =3D (kernel_ulong_t)&_ops,	\
>  -		}
>  -
>   static const struct x86_cpu_id rapl_ids[] __initconst =3D {
>  -	RAPL_CPU(INTEL_FAM6_SANDYBRIDGE,	rapl_defaults_core),
>  -	RAPL_CPU(INTEL_FAM6_SANDYBRIDGE_X,	rapl_defaults_core),
>  -
>  -	RAPL_CPU(INTEL_FAM6_IVYBRIDGE,		rapl_defaults_core),
>  -	RAPL_CPU(INTEL_FAM6_IVYBRIDGE_X,	rapl_defaults_core),
>  -
>  -	RAPL_CPU(INTEL_FAM6_HASWELL_CORE,	rapl_defaults_core),
>  -	RAPL_CPU(INTEL_FAM6_HASWELL_ULT,	rapl_defaults_core),
>  -	RAPL_CPU(INTEL_FAM6_HASWELL_GT3E,	rapl_defaults_core),
>  -	RAPL_CPU(INTEL_FAM6_HASWELL_X,		rapl_defaults_hsw_server),
>  -
>  -	RAPL_CPU(INTEL_FAM6_BROADWELL_CORE,	rapl_defaults_core),
>  -	RAPL_CPU(INTEL_FAM6_BROADWELL_GT3E,	rapl_defaults_core),
>  -	RAPL_CPU(INTEL_FAM6_BROADWELL_XEON_D,	rapl_defaults_core),
>  -	RAPL_CPU(INTEL_FAM6_BROADWELL_X,	rapl_defaults_hsw_server),
>  -
>  -	RAPL_CPU(INTEL_FAM6_SKYLAKE_DESKTOP,	rapl_defaults_core),
>  -	RAPL_CPU(INTEL_FAM6_SKYLAKE_MOBILE,	rapl_defaults_core),
>  -	RAPL_CPU(INTEL_FAM6_SKYLAKE_X,		rapl_defaults_hsw_server),
>  -	RAPL_CPU(INTEL_FAM6_KABYLAKE_MOBILE,	rapl_defaults_core),
>  -	RAPL_CPU(INTEL_FAM6_KABYLAKE_DESKTOP,	rapl_defaults_core),
>  -	RAPL_CPU(INTEL_FAM6_CANNONLAKE_MOBILE,	rapl_defaults_core),
>  -
>  -	RAPL_CPU(INTEL_FAM6_ATOM_SILVERMONT,	rapl_defaults_byt),
>  -	RAPL_CPU(INTEL_FAM6_ATOM_AIRMONT,	rapl_defaults_cht),
>  -	RAPL_CPU(INTEL_FAM6_ATOM_SILVERMONT_MID,	rapl_defaults_tng),
>  -	RAPL_CPU(INTEL_FAM6_ATOM_AIRMONT_MID,	rapl_defaults_ann),
>  -	RAPL_CPU(INTEL_FAM6_ATOM_GOLDMONT,	rapl_defaults_core),
>  -	RAPL_CPU(INTEL_FAM6_ATOM_GOLDMONT_PLUS,	rapl_defaults_core),
>  -	RAPL_CPU(INTEL_FAM6_ATOM_GOLDMONT_X,	rapl_defaults_core),
>  -
>  -	RAPL_CPU(INTEL_FAM6_XEON_PHI_KNL,	rapl_defaults_hsw_server),
>  -	RAPL_CPU(INTEL_FAM6_XEON_PHI_KNM,	rapl_defaults_hsw_server),
>  +	INTEL_CPU_FAM6(SANDYBRIDGE,		rapl_defaults_core),
>  +	INTEL_CPU_FAM6(SANDYBRIDGE_X,		rapl_defaults_core),
>  +
>  +	INTEL_CPU_FAM6(IVYBRIDGE,		rapl_defaults_core),
>  +	INTEL_CPU_FAM6(IVYBRIDGE_X,		rapl_defaults_core),
>  +
>  +	INTEL_CPU_FAM6(HASWELL_CORE,		rapl_defaults_core),
>  +	INTEL_CPU_FAM6(HASWELL_ULT,		rapl_defaults_core),
>  +	INTEL_CPU_FAM6(HASWELL_GT3E,		rapl_defaults_core),
>  +	INTEL_CPU_FAM6(HASWELL_X,		rapl_defaults_hsw_server),
>  +
>  +	INTEL_CPU_FAM6(BROADWELL_CORE,		rapl_defaults_core),
>  +	INTEL_CPU_FAM6(BROADWELL_GT3E,		rapl_defaults_core),
>  +	INTEL_CPU_FAM6(BROADWELL_XEON_D,	rapl_defaults_core),
>  +	INTEL_CPU_FAM6(BROADWELL_X,		rapl_defaults_hsw_server),
>  +
>  +	INTEL_CPU_FAM6(SKYLAKE_DESKTOP,		rapl_defaults_core),
>  +	INTEL_CPU_FAM6(SKYLAKE_MOBILE,		rapl_defaults_core),
>  +	INTEL_CPU_FAM6(SKYLAKE_X,		rapl_defaults_hsw_server),
>  +	INTEL_CPU_FAM6(KABYLAKE_MOBILE,		rapl_defaults_core),
>  +	INTEL_CPU_FAM6(KABYLAKE_DESKTOP,	rapl_defaults_core),
>  +	INTEL_CPU_FAM6(CANNONLAKE_MOBILE,	rapl_defaults_core),
>  +
> - 	INTEL_CPU_FAM6(ATOM_SILVERMONT1,	rapl_defaults_byt),
> ++	INTEL_CPU_FAM6(ATOM_SILVERMONT,		rapl_defaults_byt),
>  +	INTEL_CPU_FAM6(ATOM_AIRMONT,		rapl_defaults_cht),
> - 	INTEL_CPU_FAM6(ATOM_MERRIFIELD,		rapl_defaults_tng),
> - 	INTEL_CPU_FAM6(ATOM_MOOREFIELD,		rapl_defaults_ann),
> ++	INTEL_CPU_FAM6(ATOM_SILVERMONT_MID,	rapl_defaults_tng),
> ++	INTEL_CPU_FAM6(ATOM_AIRMONT_MID,	rapl_defaults_ann),
>  +	INTEL_CPU_FAM6(ATOM_GOLDMONT,		rapl_defaults_core),
> - 	INTEL_CPU_FAM6(ATOM_GEMINI_LAKE,	rapl_defaults_core),
> - 	INTEL_CPU_FAM6(ATOM_DENVERTON,		rapl_defaults_core),
> ++	INTEL_CPU_FAM6(ATOM_GOLDMONT_PLUS,	rapl_defaults_core),
> ++	INTEL_CPU_FAM6(ATOM_GOLDMONT_X,		rapl_defaults_core),
>  +
>  +	INTEL_CPU_FAM6(XEON_PHI_KNL,		rapl_defaults_hsw_server),
>  +	INTEL_CPU_FAM6(XEON_PHI_KNM,		rapl_defaults_hsw_server),
>   	{}
>   };
>   MODULE_DEVICE_TABLE(x86cpu, rapl_ids);
> 
> --Sig_/bNRy8ryxcqLmcoGqvlETGhp
> Content-Type: application/pgp-signature
> Content-Description: OpenPGP digital signature
> 
> 
> --Sig_/bNRy8ryxcqLmcoGqvlETGhp--

This looks good to me too.  Andy, any concerns?


