Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E72C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910D02077B
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="AFP4a2EV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 910D02077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbeKJJZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 04:25:34 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:36560 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbeKJJZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 04:25:33 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 95B1010C1133;
        Fri,  9 Nov 2018 15:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1541806962; bh=c/Gvakzv00juYXznJh8gGDU5tll83+dNjMdfEE9UwgE=;
        h=From:To:CC:Subject:Date:References:From;
        b=AFP4a2EVrFP+7DM3E2QAy1g8ZwHY9sxz3xLY7G9KhA0bV8r7u1Zgw3SFj//kmc+Hb
         FIBrRo5LB84D6WSmVHJfY2ZByb+cMJreIw0s56GSMTB5u7KKNGnSKL2gpBX8QYpsSU
         /Hd6lPxUEkBVZdIMNMGzz/tcBhFqGY7IHbEohCKXyz2xj+uSINC0msgx7c0CAENaz6
         XtkGJK8/AkFA/7HhRdMUDfSMjbEssTYKQcrUtktHOvLtnW4gYREmCXw6fDAQTB23ZD
         aeOLgOUQL5AFdJxWe4AUBQT6luuj2baoTwhZKX70r8sX//sFGEk8MyCassBDq8j8DW
         u/KJhmrMo2Dbg==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 87D4457D5;
        Fri,  9 Nov 2018 15:42:42 -0800 (PST)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.228]) by
 us01wehtc1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Fri, 9
 Nov 2018 15:42:42 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     "Dmitry V. Levin" <ldv@altlinux.org>,
        Andy Lutomirski <luto@kernel.org>
CC:     Elvira Khabirova <lineprinter@altlinux.org>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/13 v2] Move EM_ARCOMPACT and EM_ARCV2 to
 uapi/linux/elf-em.h
Thread-Topic: [PATCH 02/13 v2] Move EM_ARCOMPACT and EM_ARCV2 to
 uapi/linux/elf-em.h
Thread-Index: AQHUeISdB9NL+B8fI0iDrdKf7mBIdg==
Date:   Fri, 9 Nov 2018 23:42:41 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075013A592551@us01wembx1.internal.synopsys.com>
References: <20181109031536.GB21511@altlinux.org>
 <C2D7FE5348E1B147BCA15975FBA23075013A59237C@us01wembx1.internal.synopsys.com>
 <20181109214422.GB1907@altlinux.org> <20181109233323.GB2710@altlinux.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.104]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/18 3:33 PM, Dmitry V. Levin wrote:=0A=
> These should never have been defined in the arch tree to begin with, and=
=0A=
> now uapi/linux/audit.h header is going to use EM_ARCOMPACT and EM_ARCV2 i=
n=0A=
> order to define AUDIT_ARCH_ARCOMPACT and AUDIT_ARCH_ARCV2 which are neede=
d=0A=
> to implement syscall_get_arch() which in turn is required to extend the=
=0A=
> generic ptrace API with PTRACE_GET_SYSCALL_INFO request.=0A=
>=0A=
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>=0A=
> ---=0A=
> v2: do not add EM_ARC, move EM_ARCOMPACT and EM_ARCV2 instead.=0A=
>=0A=
>  arch/arc/include/asm/elf.h  | 6 +-----=0A=
>  include/uapi/linux/elf-em.h | 2 ++=0A=
>  2 files changed, 3 insertions(+), 5 deletions(-)=0A=
>=0A=
> diff --git a/arch/arc/include/asm/elf.h b/arch/arc/include/asm/elf.h=0A=
> index aa2d6da9d187..2b80c184c9c8 100644=0A=
> --- a/arch/arc/include/asm/elf.h=0A=
> +++ b/arch/arc/include/asm/elf.h=0A=
> @@ -10,13 +10,9 @@=0A=
>  #define __ASM_ARC_ELF_H=0A=
>  =0A=
>  #include <linux/types.h>=0A=
> +#include <linux/elf-em.h>=0A=
>  #include <uapi/asm/elf.h>=0A=
>  =0A=
> -/* These ELF defines belong to uapi but libc elf.h already defines them =
*/=0A=
> -#define EM_ARCOMPACT		93=0A=
> -=0A=
> -#define EM_ARCV2		195	/* ARCv2 Cores */=0A=
> -=0A=
>  #define EM_ARC_INUSE		(IS_ENABLED(CONFIG_ISA_ARCOMPACT) ? \=0A=
>  					EM_ARCOMPACT : EM_ARCV2)=0A=
>  =0A=
> diff --git a/include/uapi/linux/elf-em.h b/include/uapi/linux/elf-em.h=0A=
> index ba3696e3d694..91b33833630b 100644=0A=
> --- a/include/uapi/linux/elf-em.h=0A=
> +++ b/include/uapi/linux/elf-em.h=0A=
> @@ -34,6 +34,7 @@=0A=
>  #define EM_M32R		88	/* Renesas M32R */=0A=
>  #define EM_MN10300	89	/* Panasonic/MEI MN10300, AM33 */=0A=
>  #define EM_OPENRISC     92     /* OpenRISC 32-bit embedded processor */=
=0A=
> +#define EM_ARCOMPACT	93	/* ARCompact processor */=0A=
>  #define EM_BLACKFIN     106     /* ADI Blackfin Processor */=0A=
>  #define EM_ALTERA_NIOS2	113	/* Altera Nios II soft-core processor */=0A=
>  #define EM_TI_C6000	140	/* TI C6X DSPs */=0A=
> @@ -42,6 +43,7 @@=0A=
>  #define EM_TILEPRO	188	/* Tilera TILEPro */=0A=
>  #define EM_MICROBLAZE	189	/* Xilinx MicroBlaze */=0A=
>  #define EM_TILEGX	191	/* Tilera TILE-Gx */=0A=
> +#define EM_ARCV2	195	/* ARCv2 Cores */=0A=
>  #define EM_RISCV	243	/* RISC-V */=0A=
>  #define EM_BPF		247	/* Linux BPF - in-kernel virtual machine */=0A=
>  #define EM_FRV		0x5441	/* Fujitsu FR-V */=0A=
=0A=
Seems OK in theory - but now we are exporting these to uapi and per my orig=
inal=0A=
comment there were redef errors with libc elf.h atleast. Perhaps this being=
 a=0A=
different header might be OK !=0A=
=0A=
Acked-by: Vineet Gupta <vgupta@synopsys.com>=0A=
=0A=
=0A=
=0A=
