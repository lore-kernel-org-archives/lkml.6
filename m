Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1539C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 05:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F0622077C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 05:36:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F0622077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbeJHMqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 08:46:19 -0400
Received: from mout.gmx.net ([212.227.15.19]:50185 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbeJHMqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 08:46:19 -0400
Received: from [192.168.20.60] ([92.116.184.237]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lxxrw-1ffSlg05zQ-015Fxs; Mon, 08
 Oct 2018 07:36:16 +0200
Received: from [192.168.20.60] ([92.116.184.237]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lxxrw-1ffSlg05zQ-015Fxs; Mon, 08
 Oct 2018 07:36:16 +0200
Subject: Re: [PATCH v3 5/6] parisc: wire up rseq system call
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
 <1538975801-13735-6-git-send-email-firoz.khan@linaro.org>
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
Message-ID: <feb53cb6-e20b-42c3-5b53-8b310c772545@gmx.de>
Date:   Mon, 8 Oct 2018 07:36:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1538975801-13735-6-git-send-email-firoz.khan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ff3YJU0j/Bj6msgBVnetsNeV9Lb+V1uKHaMnLVIs0G6io6k0WQK
 nEGCpCdy7ECoPvlIXWY5bRI44SytkmTzECXrl5V6e5xppvIC6GW7WszTkW+3CP/RMjAmXOP
 /lrgdprWXnnWcOt5Ph+cHp9eene5KVIX9FN9O6JaIsg5DYrdf3jIjDo1GFh8W9iADsB3dII
 yGdNo74my3DbX9czp7WIA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mgM+aIwBloE=:F/R32vSY48h/OxcHCZRB+R
 DxcaJKYz3FJZLvip0Glwv8vwySzozWOQm01VxlPeUgs3vVOICHMpkXwvqhbtZiX8qmSMyYoKe
 zwgYBIOBJDvDbHQPTta+dxU++3bLmMx/kwdGNndBnC74tUK9l9CBUFnHd8V1PX++DqzRpRc46
 8AttZTZsAhtKYLYvVP8XqmKwgb68FNwh3dKLNkjMIqypm2Fg7LlHTGJjUWsbtYB1Rq+Db3U5/
 QYr5kjjm28xwp0FlmQdzCXhrxj5nORst7gR/N8G2U7mKqX7kkNUQdTrGuJptxod30kOPs6BE4
 Q2nBGwkOy3U3dZZf9vvuon/b4DbyTbFXqcZ/dVJkBiGI3SyJos+HW17ugWwur+NPXqYvPsLBs
 adLTqWEzcVVd8THkYJ1dk+K3nqFcAVR/s6iFi69c5iF84PivZlTPO1CSNxMr2Xkulom/Fs3yH
 ZBoC8TOfJsnxytd0U+2LwtxAIsm5ZWRVK6h5rMFtP0EDT3HXW95h9sHSGqvr+ydoY5HIWnaRk
 EIc6Dc86v5eKeiObL4dVykzzRpYkA2rIVPmqzks/nZDhRP4g80Uydpwk8Ac3ccGZC1VDeWWqZ
 XYzjaJncNcrNC0lsRdgvcPLmOawgTIpiWEiTbT/lZar9S+qEDVchoBpK8pTIiwyO9RvE7Dl5M
 dB90Av3cA5KZnDzatvPTZShUDVJD7J1AjegNRUPHfWFHSPUDZasJUvkTnXTgBmWxhRih/7mll
 GVA5VV0tayVdUolN8GuS0qS+IFw8STIsyIZ3Za5g8zyiPUR3CodKm5MJvU2njDavKk1E34hDD
 yrLPI0fzxRN1bQ0jC8A3An/a7durhm10X/8QgryUN7V5eIGERQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.10.2018 07:16, Firoz Khan wrote:
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> ---
>  arch/parisc/kernel/syscalls/syscall.tbl | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
> index 4e85293..4334bb7 100644
> --- a/arch/parisc/kernel/syscalls/syscall.tbl
> +++ b/arch/parisc/kernel/syscalls/syscall.tbl
> @@ -349,4 +349,5 @@
>  347     common  preadv2                         sys_preadv2                     compat_sys_preadv2
>  348     common  pwritev2                        sys_pwritev2                    compat_sys_pwritev2
>  349     common  statx                           sys_statx
> -350	common  io_pgetevents			sys_io_pgetevents		compat_sys_io_pgetevents
> \ No newline at end of file
> +350	common  io_pgetevents			sys_io_pgetevents		compat_sys_io_pgetevents
> +351	common	rseq				sys_rseq			compat_sys_rseq

You can't add the rseq syscall for parisc yet.
It needs additional code in the kernel for parisc which hasn't been tested yet.
See my initial untested patch at https://patchwork.kernel.org/patch/10495209/

Helge
