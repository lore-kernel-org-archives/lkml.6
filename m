Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932528AbeBTDRw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 22:17:52 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51738 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932352AbeBTDRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 22:17:51 -0500
X-Google-Smtp-Source: AH8x227BPuOD90DlNa/IQAF4GhIcUfU5cCfPNfYYjkcILgc4dYS4AP4jN/Co8dI/nR0BaD45q+dTNw==
MIME-Version: 1.0
In-Reply-To: <20180219080511.wfzeokrwbyyr5l3r@flea.lan>
References: <20180217050112.14619-1-wens@csie.org> <20180219080511.wfzeokrwbyyr5l3r@flea.lan>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 20 Feb 2018 11:17:28 +0800
X-Gmail-Original-Message-ID: <CAGb2v642RKd7UAsqTkCRfeL6hEPWMEWTL1H_hes0CFFPfGtVRA@mail.gmail.com>
Message-ID: <CAGb2v642RKd7UAsqTkCRfeL6hEPWMEWTL1H_hes0CFFPfGtVRA@mail.gmail.com>
Subject: Re: [PATCH] ARM: sunxi: Fix multi-cluster SMP support compilation in
 multi v6/v7 configs
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 4:05 PM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> On Sat, Feb 17, 2018 at 01:01:12PM +0800, Chen-Yu Tsai wrote:
>> Various parts of the assembly code used in the multi-cluster SMP support
>> requires ARMv7-A. If the kernel config also has multi v6 support enabled,
>> Kbuild defaults to building for armv6k, which does not support some of
>> the instructions we use.
>>
>> Configure the Makefile such that the multi-cluster SMP code is always
>> built for ARMv7-A. This is also what mach-exynos does for their MC-SMP
>> code.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>
>> This addresses "[sunxi:sunxi/core-for-4.17 1/4] /tmp/ccSQM2rD.s:438:
>> Error: selected processor does not support `isb' in ARM mode"
>> reported by the kbuild test robot for arm-allmodconfig.
>>
>> Should we apply it, or squash it in the original patch?
>
> I guess we can squash it. And while you're at it..
>
>> ---
>>  arch/arm/mach-sunxi/Makefile | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/mach-sunxi/Makefile b/arch/arm/mach-sunxi/Makefile
>> index 3e741e959c7c..3c2c4384357a 100644
>> --- a/arch/arm/mach-sunxi/Makefile
>> +++ b/arch/arm/mach-sunxi/Makefile
>> @@ -1,3 +1,4 @@
>>  obj-$(CONFIG_ARCH_SUNXI) += sunxi.o
>>  obj-$(CONFIG_ARCH_SUNXI_MC_SMP) += mc_smp.o
>> +CFLAGS_mc_smp.o      += -march=armv7-a
>
> Can you move it to the first line of the file (before the other obj-*)
> with a newline after it?

Done and done.

ChenYu
