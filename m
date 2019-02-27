Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F75FC00319
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7094A2184A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbfB0SzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 13:55:14 -0500
Received: from mout.gmx.net ([212.227.17.20]:59851 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726356AbfB0SzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 13:55:14 -0500
Received: from [192.168.20.60] ([92.116.177.218]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MPlMc-1gu6XT2w54-0054hD; Wed, 27
 Feb 2019 19:54:25 +0100
Subject: Re: [PATCH v3 15/34] parisc: mm: Add p?d_large() definitions
To:     Steven Price <steven.price@arm.com>, linux-mm@kvack.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        linux-parisc@vger.kernel.org
References: <20190227170608.27963-1-steven.price@arm.com>
 <20190227170608.27963-16-steven.price@arm.com>
From:   Helge Deller <deller@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=deller@gmx.de; keydata=
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
Message-ID: <fa3072ba-f02b-fee5-dc16-d575a5308d4b@gmx.de>
Date:   Wed, 27 Feb 2019 19:54:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190227170608.27963-16-steven.price@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:GVERcQi2HwefwpmfHh/gl3DFsRldSfy2pf2hJBcZTGIy3DVEKKP
 iI0xMty44p8fvwZbS6tsPODCGUwOfyenBilXMM44uOd9qK46YCPdIsjllMaR1EK2XX2ukac
 VLlKFN3HVFeyP3BpD3oHrWIH9wBGPA9L46C+g2TckhBhGxaGg47rYbM+w4wT1jfG47lx+08
 4XbF3H3dqbUxhLoEsZxrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:I17FZP7GeCA=:20s2XPNDi2rIeeD4TKdf7S
 XStYTqQmB7W1BoMbCZlSLPjFn/L5Exg6hSBbQ9RJ2c6Nr9Db9gE1YVMLZpA9xiQtfFxGWI6FV
 izt+wCTUCCEzacex+ajK4zhL8YOJ939t6aKYewciyDLqQfmqIwhReescv5kPVbAfpTv7xoLSW
 nFJ/w8glvICJ0WP8covqOiSRCdx07jbXQmCxO1hlZm+BiAraLoUhvrPtZGvIkKaM+mzNODeig
 aS5Fssved6V57ePHgJ9WYik+AOcf8P80swmdBNuYmI1a139q28uvjidJC7demxm6SbKFWfcN1
 DPKTk+JckiyRsHJhtQl1y8jX1uEZ3LqJ4HjS3e6yVMr9a6oXfnmyGjAD8v2ZHulAH4zhs3TJG
 xcESTTxmnUDIhvhx86WoPY6f7igNgcIOosc8ju/2q6eBI4mIVGNusIRwB895HZf0yNTd+mKX1
 zZe4uPNT+Q2Lb1PnJAfjyV4BKlOckIndJmRm1xy68itf5dcbGiQoze6YtzQtyt7xLsErQBoa0
 hO4w4RYnSFAkmEznz834741Sr/5LNoxO7BpV+R29GeCjXvReG1WaRVOZejW5vrERbBeg5Ujxj
 JrcED3jhQt53+rApp3I5Rh8qyfWW0Vh4gugEhqbuIbDJbKG/tCptd5sVGepF3vUnNh0Y4xe+k
 YMY947PEN2DV7bf+JnMxPYUAtlSqTxr/GP4liACn+ji3Hv5ceEsNAzbvrFvKrlR7yOpjocCWi
 TkweZT2GLZMAly1wEEY0OyrH6lnntkPyVl+8iuGqG7rFxXJ9sJlREisA5TSuK1gOgS/S6WXXR
 NFQ1C7N3wKSvA2bt5GaF5gzelNESKWEr5TsSkf6fGNrUiZwFcE6JKQ0XbyILdlGdHGViywYUL
 UF+vUg/wlOCW9cxuNPqMH4Sf/jnS121HU6celPN1nrEZbqELTQj2BkQ6crLCDIMkkYaS5NbKQ
 s+3KzNAA1L0Tq5PaFHKgoItIiSa3FAMe6ha3HpGg54SXHk1GmZdifGx+5J0wn1lWEfWYimbI1
 38SV8Us5P9BcIJZCo2HOG0E=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.02.19 18:05, Steven Price wrote:
> walk_page_range() is going to be allowed to walk page tables other than
> those of user space. For this it needs to know when it has reached a
> 'leaf' entry in the page tables. This information is provided by the
> p?d_large() functions/macros.
> 
> For parisc, we don't support large pages, so add stubs returning 0.

We do support huge pages on parisc, but not yet on those levels.
So, you may add

Acked-by: Helge Deller <deller@gmx.de> # parisc
 
Helge

> CC: "James E.J. Bottomley" <jejb@parisc-linux.org>
> CC: Helge Deller <deller@gmx.de>
> CC: linux-parisc@vger.kernel.org
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  arch/parisc/include/asm/pgtable.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
> index c7bb74e22436..1f38c85a9530 100644
> --- a/arch/parisc/include/asm/pgtable.h
> +++ b/arch/parisc/include/asm/pgtable.h
> @@ -302,6 +302,7 @@ extern unsigned long *empty_zero_page;
>  #endif
>  #define pmd_bad(x)	(!(pmd_flag(x) & PxD_FLAG_VALID))
>  #define pmd_present(x)	(pmd_flag(x) & PxD_FLAG_PRESENT)
> +#define pmd_large(x)	(0)
>  static inline void pmd_clear(pmd_t *pmd) {
>  #if CONFIG_PGTABLE_LEVELS == 3
>  	if (pmd_flag(*pmd) & PxD_FLAG_ATTACHED)
> @@ -324,6 +325,7 @@ static inline void pmd_clear(pmd_t *pmd) {
>  #define pgd_none(x)     (!pgd_val(x))
>  #define pgd_bad(x)      (!(pgd_flag(x) & PxD_FLAG_VALID))
>  #define pgd_present(x)  (pgd_flag(x) & PxD_FLAG_PRESENT)
> +#define pgd_large(x)	(0)
>  static inline void pgd_clear(pgd_t *pgd) {
>  #if CONFIG_PGTABLE_LEVELS == 3
>  	if(pgd_flag(*pgd) & PxD_FLAG_ATTACHED)
> @@ -342,6 +344,7 @@ static inline void pgd_clear(pgd_t *pgd) {
>  static inline int pgd_none(pgd_t pgd)		{ return 0; }
>  static inline int pgd_bad(pgd_t pgd)		{ return 0; }
>  static inline int pgd_present(pgd_t pgd)	{ return 1; }
> +static inline int pgd_large(pgd_t pgd)		{ return 0; }
>  static inline void pgd_clear(pgd_t * pgdp)	{ }
>  #endif
>  
> 

