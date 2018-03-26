Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751208AbeCZBGA (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 21:06:00 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:38447 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750838AbeCZBF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 21:05:58 -0400
X-Google-Smtp-Source: AG47ELs+q89IlBmY5JggDkeiBF1kQy2YQHCt8zKlMyE8xdFgSq8nCpsa6S+JVx49c0a7/AsWsXSYCq4/nQNqqV/aDG0=
MIME-Version: 1.0
In-Reply-To: <20180314013256epcms1p47a97f32cdcb5a7eaa9303dc4b2cb0ea9@epcms1p4>
References: <CGME20180314013256epcms1p47a97f32cdcb5a7eaa9303dc4b2cb0ea9@epcms1p4>
 <20180314013256epcms1p47a97f32cdcb5a7eaa9303dc4b2cb0ea9@epcms1p4>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 26 Mar 2018 11:35:37 +1030
X-Google-Sender-Auth: XYPfeUcbwGxnu86_jxSuxmALOVY
Message-ID: <CACPK8Xfqv1Noa3ychYTd5bAPCRzRvhCtQ5xEEN_rY5vHtwdk3A@mail.gmail.com>
Subject: Re: [PATCH v2] arm: ubsan: select ARCH_HAS_UBSAN_SANITIZE_ALL
To: jinb.park@samsung.com
Cc: "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Seung-Woo Kim <sw0312.kim@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 March 2018 at 12:02, Jinbum Park <jinb.park@samsung.com> wrote:
> To enable UBSAN on arm, ARCH_HAS_UBSAN_SANITIZE_ALL is needed to be selected.
>
> Basic test has passed on Raspberry Pi2, Raspbian jessi lite with
> CONFIG_UBSAN_SANITIZE_ALL, CONFIG_UBSAN_NULL.
>
> Used compiler is gcc 5.5.0 in [2] (2017.10).
>
> It would be a resend patch for [1] from Seung-Woo Kim.
> There was some problems when [1] submitted before.
>
>   P1) show -Warray-bounds that is not seen without UBSAN
>   P2) too large stack size in crypto/serpent_generic.c
>   P3) link error of ____ilog2_NaN, __aeabi_uldivmod
>
> I've tried to build locally with allmodconfig to ensure that above errors are fixed.
> The result is that P2), P3) have fixed, but P1) appears at diffent location.
> But, Since gcc closed P1) issue as won't fix [3],
> and It can be a helpful warning to user, we don't have to worry about P1).
>
> build-environment that I used is as belows.
>
>   - config: arm allmodconfig
>   - compiler: gcc 5.5.0 in [2] (2017.10)
>   - ubsan flag: UBSAN, UBSAN_SANITIZE_ALL, UBSAN_ALIGNMENT, UBSAN_NULL
>   - linux version: linux/arm 4.16.0-rc4
>   - CONFIG_FRAME_WARN: 1024 (default value)
>
> [1] https://patchwork.kernel.org/patch/9189575/
> [2] https://releases.linaro.org/components/toolchain/binaries/latest-5/arm-linux-gnueabi/
> [3] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=78678
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Jinbum Park <jinb.park@samsung.com>
> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>

Tested-by: Joel Stanley <joel@jms.id.au>

I built for an ARMv5 (aspeed_g5_defconfig) and booted on an ast2500.

FYI, it found a couple of issues in ASPEED specific code!

 https://github.com/openbmc/linux/issues/144
 https://github.com/openbmc/linux/issues/145

Cheers,

Joel
