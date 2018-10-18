Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E34ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D722098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D722098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbeJSCgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:36:53 -0400
Received: from mout.gmx.net ([212.227.15.15]:39299 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728570AbeJSCgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:36:53 -0400
Received: from [192.168.20.60] ([92.116.176.154]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MSutp-1g5l0z1slp-00RsAT; Thu, 18
 Oct 2018 20:34:28 +0200
Received: from [192.168.20.60] ([92.116.176.154]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MSutp-1g5l0z1slp-00RsAT; Thu, 18
 Oct 2018 20:34:28 +0200
Subject: Re: [PATCH v5 1/5] parisc: move __IGNORE* entries to non uapi header
To:     Firoz Khan <firoz.khan@linaro.org>, linux-parisc@vger.kernel.org,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org
References: <1539673418-7279-1-git-send-email-firoz.khan@linaro.org>
 <1539673418-7279-2-git-send-email-firoz.khan@linaro.org>
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
Message-ID: <3571b003-d603-9ec5-01e3-12dbbca692b1@gmx.de>
Date:   Thu, 18 Oct 2018 20:34:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1539673418-7279-2-git-send-email-firoz.khan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:INq853TMMxRjp3nBtE5vgG2j1RBDCLXzNMPWa6Mn4tr8JgvENUB
 AmFxOyUzDArdEgkD+WYYOcNLZzTLL7kuKdsr4XBJpZIMS9WxWfiHna201spIb/aFPhXNSlP
 vwVPqYZxvTSRCJbpCUfoYBrMr/eu3E0AXXmy5bbrMOtostX+74Bx3BopXYL8kMKtp5v7C/9
 /mr7v4Njsf50upBjK8vag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4ffzZ1gxS+0=:zNcVkLjEqS+pIMbqzl+HhW
 ILxLuIUKOL+qtDwfcBesDi+I4TBsltsAfrwFeD/710Hx7Olvp/6EpdX6ChrmT8VZMi4t3r6lR
 5SZhT7TAT+xaZjBgzPZiTRYR39gdjnn3T++IDAn3wsqksW9lIgervlclTy8t//BuG2zc9j9uT
 k8CO5iN/wbnRLGGi+15DT4ibFQhF8chTkgzSdGH2urLgWbFUWJeo4BMwQ/rQAbgc1hR0KCNR5
 wq9ZQjLJuGDIierHL+UL/L/TQ4sr9lPDMU4ZtSGdeyVEKpBZZFl1Nhq2uXWcpYW8NCO71HX8m
 gU3RcgCdeiXxHeChH0hHHBAwxncm/NCNUolOQ1dmgV+b/KdlA1ncZIni6Qf1PsM7h2YojXD7n
 1OzaVowQQTH3a4A+M/Q7lUIgMk7sW1uAdtIrIqL0PSQItKjegrY1Hdr8onW6vQxYkbWOERr5R
 qMi6MsCBWj4g2NEr22/ZciKxjGsURG/4h1M3N9xXO3JN+5L4HIPz/mF9PY+uIqQtzi4NDeSGx
 RhacU31MWpt9wNMl1LrMerJAc2krNVKv+9b5NjtHJ2n2kvuTZFg5Hjx5U88/PXTVskULPRHm7
 vnV/H/c48oFR89g5+aVw4lnHRNQe3pKzVC+ApEATT9CsycrCykkGg9XgO0ttci/gL5VAPI5MI
 knjEvQjPjr32AVM95fk7v7xjmUYLgJT2XkTSKSn4hEGgYnWdFWe2jfFY16notDgpt7yicdgT/
 WOSVFcFweJtDLBZ0bPYo9+ckgQSP/7gANI3zHd1WJOARmRdbM1nI/gsUYc1pkeRdnGQkneXDI
 m7SVGWj70KNE7u+Xk+1oq0nR1o4artiqpwzd42bKLepLIAWAgo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.10.2018 09:03, Firoz Khan wrote:
> All the __IGNORE* entries are resides in the uapi header
> file move to non uapi header asm/unistd.h as it is not
> used by any user space applications.
> 
> It is correct to keep __IGNORE* entry in non uapi header
> asm/unistd.h while uapi/asm/unistd.h must hold information
> only useful for user space applications.
> 
> One of the patch in this patch series will generate uapi
> header file. The information which directly used by the
> user space application must be present in uapi file.
> 
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>

You may add an 
Acked-by: Helge Deller <deller@gmx.de>

I've tested it by sucessfully booting a 32bit kernel.

Thanks!
Helge


> ---
>  arch/parisc/include/asm/unistd.h      | 6 ++++++
>  arch/parisc/include/uapi/asm/unistd.h | 7 -------
>  2 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/parisc/include/asm/unistd.h b/arch/parisc/include/asm/unistd.h
> index 3d507d0..93fd9f6 100644
> --- a/arch/parisc/include/asm/unistd.h
> +++ b/arch/parisc/include/asm/unistd.h
> @@ -8,6 +8,12 @@
>  
>  #define SYS_ify(syscall_name)   __NR_##syscall_name
>  
> +#define __IGNORE_select                /* newselect */
> +#define __IGNORE_fadvise64             /* fadvise64_64 */
> +#define __IGNORE_pkey_mprotect
> +#define __IGNORE_pkey_alloc
> +#define __IGNORE_pkey_free
> +
>  #ifndef ASM_LINE_SEP
>  # define ASM_LINE_SEP ;
>  #endif
> diff --git a/arch/parisc/include/uapi/asm/unistd.h b/arch/parisc/include/uapi/asm/unistd.h
> index dc77c5a..bb52e12 100644
> --- a/arch/parisc/include/uapi/asm/unistd.h
> +++ b/arch/parisc/include/uapi/asm/unistd.h
> @@ -368,13 +368,6 @@
>  
>  #define __NR_Linux_syscalls	(__NR_io_pgetevents + 1)
>  
> -
> -#define __IGNORE_select		/* newselect */
> -#define __IGNORE_fadvise64	/* fadvise64_64 */
> -#define __IGNORE_pkey_mprotect
> -#define __IGNORE_pkey_alloc
> -#define __IGNORE_pkey_free
> -
>  #define LINUX_GATEWAY_ADDR      0x100
>  
>  #endif /* _UAPI_ASM_PARISC_UNISTD_H_ */
> 

