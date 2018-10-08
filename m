Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC0BC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51AA42089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51AA42089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbeJIC4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:56:48 -0400
Received: from mout.gmx.net ([212.227.17.22]:58197 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbeJIC4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:56:48 -0400
Received: from [192.168.20.60] ([92.116.184.237]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M3R1g-1frw3g2MIS-00r46l; Mon, 08
 Oct 2018 21:43:16 +0200
Received: from [192.168.20.60] ([92.116.184.237]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M3R1g-1frw3g2MIS-00r46l; Mon, 08
 Oct 2018 21:43:16 +0200
Subject: Re: [PATCH v3 4/6] parisc: uapi header and system call table file
 generation
To:     Firoz Khan <firoz.khan@linaro.org>, linux-parisc@vger.kernel.org,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org
References: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
 <1538975801-13735-5-git-send-email-firoz.khan@linaro.org>
From:   Helge Deller <deller@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=deller@gmx.de; prefer-encrypt=mutual; keydata=
 xsBNBFDPIPYBCAC6PdtagIE06GASPWQJtfXiIzvpBaaNbAGgmd3Iv7x+3g039EV7/zJ1do/a
 y9jNEDn29j0/jyd0A9zMzWEmNO4JRwkMd5Z0h6APvlm2D8XhI94r/8stwroXOQ8yBpBcP0yX
 +sqRm2UXgoYWL0KEGbL4XwzpDCCapt+kmarND12oFj30M1xhTjuFe0hkhyNHkLe8g6MC0xNg
 KW3x7B74Rk829TTAtj03KP7oA+dqsp5hPlt/hZO0Lr0kSAxf3kxtaNA7+Z0LLiBqZ1nUerBh
 OdiCasCF82vQ4/y8rUaKotXqdhGwD76YZry9AQ9p6ccqKaYEzWis078Wsj7p0UtHoYDbABEB
 AAHNHEhlbGdlIERlbGxlciA8ZGVsbGVyQGdteC5kZT7CwJIEEwECADwCGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAFiEE9M/0wAvkPPtRU6Boh8nBUbUeOGQFAlrHzIICGQEACgkQh8nB
 UbUeOGT1GAgAt+EeoHB4DbAx+pZoGbBYp6ZY8L6211n8fSi7wiwgM5VppucJ+C+wILoPkqiU
 +ZHKlcWRbttER2oBUvKOt0+yDfAGcoZwHS0P+iO3HtxR81h3bosOCwek+TofDXl+TH/WSQJa
 iaitof6iiPZLygzUmmW+aLSSeIAHBunpBetRpFiep1e5zujCglKagsW78Pq0DnzbWugGe26A
 288JcK2W939bT1lZc22D9NhXXRHfX2QdDdrCQY7UsI6g/dAm1d2ldeFlGleqPMdaaQMcv5+E
 vDOur20qjTlenjnR/TFm9tA1zV+K7ePh+JfwKc6BSbELK4EHv8J8WQJjfTphakYLVM7ATQRQ
 zyD2AQgA2SJJapaLvCKdz83MHiTMbyk8yj2AHsuuXdmB30LzEQXjT3JEqj1mpvcEjXrX1B3h
 +0nLUHPI2Q4XWRazrzsseNMGYqfVIhLsK6zT3URPkEAp7R1JxoSiLoh4qOBdJH6AJHex4CWu
 UaSXX5HLqxKl1sq1tO8rq2+hFxY63zbWINvgT0FUEME27Uik9A5t8l9/dmF0CdxKdmrOvGMw
 T770cTt76xUryzM3fAyjtOEVEglkFtVQNM/BN/dnq4jDE5fikLLs8eaJwsWG9k9wQUMtmLpL
 gRXeFPRRK+IT48xuG8rK0g2NOD8aW5ThTkF4apznZe74M7OWr/VbuZbYW443QQARAQABwsBf
 BBgBAgAJBQJQzyD2AhsMAAoJEIfJwVG1HjhkNTgH/idWz2WjLE8DvTi7LvfybzvnXyx6rWUs
 91tXUdCzLuOtjqWVsqBtSaZynfhAjlbqRlrFZQ8i8jRyJY1IwqgvHP6PO9s+rIxKlfFQtqhl
 kR1KUdhNGtiI90sTpi4aeXVsOyG3572KV3dKeFe47ALU6xE5ZL5U2LGhgQkbjr44I3EhPWc/
 lJ/MgLOPkfIUgjRXt0ZcZEN6pAMPU95+u1N52hmqAOQZvyoyUOJFH1siBMAFRbhgWyv+YE2Y
 ZkAyVDL2WxAedQgD/YCCJ+16yXlGYGNAKlvp07SimS6vBEIXk/3h5Vq4Hwgg0Z8+FRGtYZyD
 KrhlU0uMP9QTB5WAUvxvGy8=
Message-ID: <b1883a34-f256-0940-4e92-574ba48b5ca8@gmx.de>
Date:   Mon, 8 Oct 2018 21:43:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1538975801-13735-5-git-send-email-firoz.khan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:0ZkO1wisNQ8oXYcSH1TE1DAdXJ8h1CfD/RHlxa59/ZY70FCDGDv
 reSMa2zvRk5q0gylX19/cqy3qgO43td0bSmvEIlxAM3IbJNKTjvMoFQdEhr8mxULr2EBAeR
 tWT7cLvNyTS6IjbKmrGyjehfoTSCtUSdYtMiWIzeEm6i9poJV9C4AuKA6earYsD4qZ0wT5B
 wyCrsfYn/fR3zA6dlTgKA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:V+4fmwaAqU4=:Mb+rp4yb2YMgpF+advMcGm
 WEOcuDFNexBluveV6Dko9P4Qp9WKwYMpaTaBwd0i3TIP9Fs8jvHYwmIT9PHopetwIdNuAcKGM
 YXY1IgmC0b0k1f711hELa3Jl/CWy7GsYwapVTOxPoo9Snuqp3YwLdmduTU/3flJHyDl4+uSjf
 NxLLMH0pBpPnY58Kq+bWSJ9qwwdrNGNe//mfIRREW8ATOMCyVbY8R3AaCoZOM31IQchnALutR
 AeSnCTntLSyVYiYXlddgefM+4JJ8rqGo9QWUMWqS2eb5xKD24EsHzLUqsso6iSdJIpVvropEy
 dVb6kGimIAlaJB2qlAbjl9/8PNRyCDN6IPd/JYPPTL7pJFfiv7yfdRwsvrWozP31nGl+j5lfw
 QgMLKCUzGHuiZD1SLLpIb5NdXuOmTw+6i9UnVRC6QEtXBlbMgiNn3rqMbTDnWymuzDiukcxCP
 EfFwBV+5dp5D8hVa8kGDnNbuYEtAOfPHgPVJGjt/hhjofXqeqM4UxONK0/RI+yG5wS1wa7LpK
 K/1ZO2KCvJv1ALVg5xSW/+RwgzqPOUfhrCDk9By+P35R6vFopmHCIy1HIMxg//I6Kcyvjlyqj
 JWDMMlthV0UTkJX1VxxSGA+nPXt/4TbJ7Ne8JybSxqq4iKZA9TAt7yuwr+/1pAtqrgmtA+kZV
 YWORhX0e/eJejRnR1g8fGpNUS2IV+tvbFQtDVkohvlMsVFasbXkZHzr4xzvWUr3CHBwfgdXsE
 vG/gvGKNqGlGMCOL36O+HKqKpbUPpeiuOuhfZDxJ+MBtRi5B8FHT9l9EE0PazG/RIU1w9/qrB
 hnEo86zipnltxhu3vVUbeaBhfix5RxwTs2brT1aR5u/en9oOng=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.10.2018 07:16, Firoz Khan wrote:
> System call table generation script must be run to generate
> unistd_32/64.h and syscall_table_32/64/c32.h files. This patch
> will have changes which will invokes the script.
> 
> This patch will generate unistd_32/64.h and syscall_table_
> 32/64/c32.h files by the syscall table generation script
> invoked by arch/parisc/Makefile and the generated files against
> the removed files will be identical.
> 
> The generated uapi header file will be included in uapi/asm/
> unistd_32/64.h and generated system call table support file will
> be included by arch/sparc/kernel/syscall_table_32/64.S file.
> 
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
...
> diff --git a/arch/parisc/include/uapi/asm/unistd.h b/arch/parisc/include/uapi/asm/unistd.h
> index f10d065..76e3a3b 100644
> --- a/arch/parisc/include/uapi/asm/unistd.h
> +++ b/arch/parisc/include/uapi/asm/unistd.h
> @@ -2,374 +2,13 @@
>  #ifndef _UAPI_ASM_PARISC_UNISTD_H_
>  #define _UAPI_ASM_PARISC_UNISTD_H_
>  
...
> -
> -#ifdef __KERNEL__
> -#define __NR_syscalls           351
> +#define __NR_Linux           0
> +#ifdef CONFIG_64BIT

You can't use CONFIG_64BIT in an uapi header file.
It's only defined inside the kernel when building the kernel.
Please use
	#ifdef __LP64__
instead here.

> +#include <asm/unistd_64.h>
> +#else
> +#include <asm/unistd_32.h>
>  #endif
