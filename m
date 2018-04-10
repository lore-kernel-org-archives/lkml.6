Return-Path: <mylene.josserand@bootlin.com>
X-Google-Smtp-Source: AIpwx489Cu7TLAtj0cDcIae7p1rbjNHX3rdcfco8pwxmHynFnO5BT0esyQXcNew3qRJOI9v9kFB1
ARC-Seal: i=1; a=rsa-sha256; t=1523391591; cv=none;
        d=google.com; s=arc-20160816;
        b=JJXbp2iSgBlj86T5v6WBb/zJcd0tYguM4NJJE1+1IuwGmqDKSgaUuDCDq5QmsT4FMW
         mw/rMpXdfGWP+jYyAD8MnbgDlbT47mMarcud1ZyUJ8Q0We16COzHL+aUPnpyNcsa1SS/
         fKc41SgFF1gqG5bukC2+Xmd9115lkUfkVblddEjFkyADI0/CUGAV54yBKfaJE1r0gwvY
         sxblUxLU/mqiscszaD4QNW1n6XiqV96Ptekf3a1GWmsRZul1rC55PvFrOZedslfCKiSb
         npfayToEmTVA7gYKvJvSS1W9y7su5v3e4gOkCYWGUS9dlkcbCqJHECnnspGHzJPmlbGo
         T9yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=3QI00msk8n+Ui4gcU+1+nK7wWKDT5hMNNKimEjQE7H4=;
        b=uD69kA8tMHP9B23nXM2WE304svZHPizUDmPJ9Q78Z9ZZQ6oY7pLZhdGXa4ZF9AyKs/
         KbxXgzHi4dLQ3Az+mes5zg2QJLpsvq5zXTHHifshQACQ8elYxdC1yZNOh+3zWBSodmqt
         YgL32NKRiLVtFU9B0iRHdNsddwjNLq8LBz5+VhSmlWzaIDyn52YMN2AF6dxV8ZVtL4KJ
         ITv3eAf/xvqMlDZf14DZPt7yEz+AOT/EbjZdi4Kn9zZtV9a0S4SkKu8M8uouaP0JV2Bw
         zrUTjd4kRLiuD4P3y2JY6r8PNu4unlZoV9OgDBDo+aBugvZ7g9RmgCCx8y0l7zaxuVM0
         q3ZA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mylene.josserand@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=mylene.josserand@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mylene.josserand@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=mylene.josserand@bootlin.com
Date: Tue, 10 Apr 2018 22:19:49 +0200
From: =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@bootlin.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Vladimir Murzin
 <vladimir.murzin@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Russell King <linux@armlinux.org.uk>, open list
 <linux-kernel@vger.kernel.org>, Doug Berger <opendmb@gmail.com>,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>, Gregory Fong
 <gregory.0xf0@gmail.com>, Philippe Ombredanne <pombredanne@nexb.com>, Brian
 Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH 1/4] ARM: Allow this header to be included by assembly
 files
Message-ID: <20180410221949.0be82368@dell-desktop.home>
In-Reply-To: <20180223210923.544-2-f.fainelli@gmail.com>
References: <20180223210923.544-1-f.fainelli@gmail.com>
	<20180223210923.544-2-f.fainelli@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593227540099720483?=
X-GMAIL-MSGID: =?utf-8?q?1597391861509712125?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

On Fri, 23 Feb 2018 13:09:20 -0800
Florian Fainelli <f.fainelli@gmail.com> wrote:

> From: Doug Berger <opendmb@gmail.com>
>=20
> The constants defined in this file are equally useful in assembly and C
> source files. The arm64 architecture version of this file allows
> inclusion in both assembly and C source files, so this this commit adds
> that capability to the arm architecture version so that the constants
> don't need to be defined in multiple places.
>=20
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm/include/asm/cputype.h | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputyp=
e.h
> index cb546425da8a..e7632f536633 100644
> --- a/arch/arm/include/asm/cputype.h
> +++ b/arch/arm/include/asm/cputype.h
> @@ -2,9 +2,6 @@
>  #ifndef __ASM_ARM_CPUTYPE_H
>  #define __ASM_ARM_CPUTYPE_H
> =20
> -#include <linux/stringify.h>
> -#include <linux/kernel.h>
> -
>  #define CPUID_ID	0
>  #define CPUID_CACHETYPE	1
>  #define CPUID_TCM	2
> @@ -98,6 +95,11 @@
>  /* Qualcomm implemented cores */
>  #define ARM_CPU_PART_SCORPION		0x510002d0
> =20
> +#ifndef __ASSEMBLY__
> +
> +#include <linux/stringify.h>
> +#include <linux/kernel.h>
> +
>  extern unsigned int processor_id;
> =20
>  #ifdef CONFIG_CPU_CP15
> @@ -326,4 +328,6 @@ static inline int __attribute_const__ cpuid_feature_e=
xtract_field(u32 features,
>  #define cpuid_feature_extract(reg, field) \
>  	cpuid_feature_extract_field(read_cpuid_ext(reg), field)
> =20
> +#endif /* __ASSEMBLY__ */
> +
>  #endif

Tested-by: Myl=C3=A8ne Josserand <mylene.josserand@bootlin.com>

Thanks!

Best regards,

--=20
Myl=C3=A8ne Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
