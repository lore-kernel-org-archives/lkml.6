Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74EDC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D45121477
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dpEUVPLG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D45121477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbeJOXZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 19:25:25 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53178 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbeJOXZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 19:25:24 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181015153937euoutp02f623a3cf6da045d26542fda31b9c82b7~d0mSyYUWS1165411654euoutp02r
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 15:39:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181015153937euoutp02f623a3cf6da045d26542fda31b9c82b7~d0mSyYUWS1165411654euoutp02r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539617977;
        bh=nPnYrQzAEptyv1avR9eK7vetpkCldz/Cfvy27G43UZo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=dpEUVPLGOX6RjL0SsXIEURRBFz2hpeXTqPjXSv/Ljk2d4hwUz840xDidd8NxRjTjs
         sE1VvbxGvivxZOokbJkVViG9pO0jTuOBCukHaEtvTB7HhU3qET2PPZHh1Y0DFHbUub
         AA9Y8cdmcXz4C/7Spafty0mEwLxmLjJEqurRLddc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181015153937eucas1p1029fb39791b7e4fd0dd75bcf27182b62~d0mSWqSc92718027180eucas1p1a;
        Mon, 15 Oct 2018 15:39:37 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A9.FD.04441.8B4B4CB5; Mon, 15
        Oct 2018 16:39:36 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181015153936eucas1p10fc822d6161c3d95d5d0bdd98408e55f~d0mRowyUD3030630306eucas1p1K;
        Mon, 15 Oct 2018 15:39:36 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181015153936eusmtrp2178c6a372a707b2581e15cdc2740a951~d0mRaa6ff3150331503eusmtrp2Q;
        Mon, 15 Oct 2018 15:39:36 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-4a-5bc4b4b88c25
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 19.FA.04284.7B4B4CB5; Mon, 15
        Oct 2018 16:39:36 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181015153935eusmtip1824b7f78eb2adaa76a15350cf0c90a89~d0mRHSxLO2965029650eusmtip1N;
        Mon, 15 Oct 2018 15:39:35 +0000 (GMT)
Subject: Re: [PATCH v2] ARM: SAMSUNG: limit SAMSUNG_PM_DEBUG config option
 to non-Exynos platforms
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kgene@kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date:   Mon, 15 Oct 2018 17:39:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPdR0q_2DGbMrroqNcVfCPSkh0=ry=yyb9qmSDFf+TWbFg@mail.gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm2znbjuLkcyp7sTIaZBdIM/qxMsJAcESF/eoiMWeevM7Ljpoa
        klHmhWCZDEuWS7y2TO0oOkVFl9eShg7MijBR/DFvecnQcrbjUfLf8z7P+3zv88BHEVK90IeK
        TUyltYnqBLnIlWzpX7eeMDf3hp9s+3pKoZuaJRRWa6NYwU6NCRW2doNI8dzaJVBY9J0oWKS0
        jY0QStZUIFI2Vd5XrrC+YeRN13NRdEJsOq0NOB/hGlNlXxIls74ZxpEhIgctyAqRCwX4NPSN
        dosLkSslxbUImurWRPywiqBqY1XADysI/pTPCHYt7d/fErxQg0D3ybBjWURQ3mpH3JYnjoKt
        7lwxh73wMfi8+VvILRG4A8H4XDfBCSJ8ForyTNsGEh+GYnbVaaAob3wddMNHOFqCPWDoxTTJ
        YRd8Fdg1+/abBD4IrfOG7RSAi8XwwDYh4A3pMFlfSvBRQ+Blz08hjz3BPtAs5vF+2GozCnhz
        CYK5jSqSHxoQ1A337xQNgvcDI0IuEeGs0NAewNMXwDxThDgasDuMz3vwgdzhWUsJwdMSyH8s
        5bf9oLG6UbR7trDt9U40JTyqKSGeokOle2qW7qlW+v/uK0SYkIxOYzTRNBOYSN/1Z9QaJi0x
        2v92koZFzs/y0TGwbEa/RiMtCFNI7ibBbr3hUqE6ncnUWBBQhNxL8oR1UpIodWYWrU1SadMS
        aMaC9lGkXCapLnsXLsXR6lQ6nqaTae2uKqBcfHJQF+oMHQ3wjys2DibcuuM7FCKUlomz647q
        878sWbrzq1Uk7ljsu9ZmcDRNBhdU1OedibwcsxDq6J3PTf6go22aaUftpRQjjstYPWDqrBxc
        6wjazEL6FYfZr2ThYXy57WJEtvc62WMI+6HaWp6V3SAqe1RXJlre3Ov6tvg3pUJOMjHqwOOE
        llH/A7l3AkwoAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xu7o7thyJNlj7j9Gi//FrZovz5zew
        W2x6fI3V4vKuOWwWM87vY7I4NHUvowObx+VrF5k9Nq3qZPPYvKTe4/MmuQCWKD2bovzSklSF
        jPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2Mpa8+shVskquYf/Ek
        cwPjO/EuRk4OCQETiV131zJ3MXJxCAksZZSY+fUeYxcjB1BCRuL4+jKIGmGJP9e62CBq3jJK
        vLrVww6SEBZIkWh7upQFxBYR0JS4/vc7K0TRRCaJwx1fwDqYBfYxSpx4swqsik3ASmJi+ypG
        EJtXwE6ivWUtmM0ioCoxedMXsKmiAhEStx52sEDUCEqcnPkEzOYUCJTY9O0VWA2zgLrEn3mX
        mCFseYntb+cwT2AUnIWkZRaSsllIyhYwMq9iFEktLc5Nzy021CtOzC0uzUvXS87P3cQIjJht
        x35u3sF4aWPwIUYBDkYlHl4BniPRQqyJZcWVuYcYJTiYlUR4ezYBhXhTEiurUovy44tKc1KL
        DzGaAj0xkVlKNDkfGM15JfGGpobmFpaG5sbmxmYWSuK85w0qo4QE0hNLUrNTUwtSi2D6mDg4
        pRoYyybva01w5EyTOHL+V6MQW6K07OL203YWslPfPl/aeGrdijUHZzWa58yK2fLoC1usQfSt
        yfnFcSbGsk8fLNn150tjrnF8RGeQy6Ltylx/g288fFvG+PzAkS25r2Mjp5VHyak3zGk+UFUc
        ucwwJFdp5xlJpcIW6TtN4d/qjCzMLvKeiHefze2uxFKckWioxVxUnAgACWK2oq4CAAA=
Message-Id: <20181015153936eucas1p10fc822d6161c3d95d5d0bdd98408e55f~d0mRowyUD3030630306eucas1p1K@eucas1p1.samsung.com>
X-CMS-MailID: 20181015153936eucas1p10fc822d6161c3d95d5d0bdd98408e55f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181015135055eucas1p2fdb917790b3690dd52ee7b9aa19ea677
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181015135055eucas1p2fdb917790b3690dd52ee7b9aa19ea677
References: <CGME20181015135055eucas1p2fdb917790b3690dd52ee7b9aa19ea677@eucas1p2.samsung.com>
        <20181015135055eucas1p2fdb917790b3690dd52ee7b9aa19ea677~dzHYfFW2j0676906769eucas1p2c@eucas1p2.samsung.com>
        <CAJKOXPdR0q_2DGbMrroqNcVfCPSkh0=ry=yyb9qmSDFf+TWbFg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/15/2018 05:22 PM, Krzysztof Kozlowski wrote:
> On Mon, 15 Oct 2018 at 15:50, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
>>
>> "Samsung PM Suspend debug" feature (controlled by SAMSUNG_PM_DEBUG
>> config option) is not working properly (debug messages are not
>> displayed after resume) on Exynos platforms because GPIOs restore
>> code is not implemented.
>>
>> Add PLAT_S3C24XX, ARCH_S3C64XX and ARCH_S5PV210 dependencies to
>> SAMSUNG_PM_DEBUG config option to hide it on Exynos platforms.
>> Then convert Exynos code to not require <plat/pm-common.h>
>> header (use pr_debug() directly instead of S3C_PMDBG() macro and
>> remove redundant s3c_pm_*() calls).
>>
>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> ---
>> v2:
>> - convert Exynos code to not require <plat/pm-common.h> header
>>
>> Should by applied on top of "[PATCH] ARM: EXYNOS: remove no longer
>> needed s3c_pm_check_*() calls".
>>
>>  arch/arm/mach-exynos/suspend.c |   14 ++++----------
>>  arch/arm/plat-samsung/Kconfig  |    3 ++-
>>  2 files changed, 6 insertions(+), 11 deletions(-)
>>
>> Index: b/arch/arm/mach-exynos/suspend.c
>> ===================================================================
>> --- a/arch/arm/mach-exynos/suspend.c    2018-10-15 15:11:15.296187842 +0200
>> +++ b/arch/arm/mach-exynos/suspend.c    2018-10-15 15:22:54.656205454 +0200
>> @@ -30,8 +30,6 @@
>>  #include <asm/smp_scu.h>
>>  #include <asm/suspend.h>
>>
>> -#include <plat/pm-common.h>
>> -
>>  #include "common.h"
>>
>>  #define REG_TABLE_END (-1U)
>> @@ -490,11 +488,9 @@ static int exynos_suspend_enter(suspend_
>>  {
>>         int ret;
>>
>> -       s3c_pm_debug_init();
>> -
>> -       S3C_PMDBG("%s: suspending the system...\n", __func__);
>> +       pr_debug("%s: suspending the system...\n", __func__);
>>
>> -       S3C_PMDBG("%s: wakeup masks: %08x,%08x\n", __func__,
>> +       pr_debug("%s: wakeup masks: %08x,%08x\n", __func__,
>>                         exynos_irqwake_intmask, exynos_get_eint_wake_mask());
>>
>>         if (exynos_irqwake_intmask == -1U
>> @@ -504,7 +500,6 @@ static int exynos_suspend_enter(suspend_
>>                 return -EINVAL;
>>         }
>>
>> -       s3c_pm_save_uarts();
>>         if (pm_data->pm_prepare)
>>                 pm_data->pm_prepare();
>>         flush_cache_all();
>> @@ -517,12 +512,11 @@ static int exynos_suspend_enter(suspend_
>>
>>         if (pm_data->pm_resume_prepare)
>>                 pm_data->pm_resume_prepare();
>> -       s3c_pm_restore_uarts();
>>
>> -       S3C_PMDBG("%s: wakeup stat: %08x\n", __func__,
>> +       pr_debug("%s: wakeup stat: %08x\n", __func__,
>>                         pmu_raw_readl(S5P_WAKEUP_STAT));
>>
>> -       S3C_PMDBG("%s: resuming the system...\n", __func__);
>> +       pr_debug("%s: resuming the system...\n", __func__);
>>
>>         return 0;
>>  }
>> Index: b/arch/arm/plat-samsung/Kconfig
>> ===================================================================
>> --- a/arch/arm/plat-samsung/Kconfig     2018-10-15 15:16:22.804195586 +0200
>> +++ b/arch/arm/plat-samsung/Kconfig     2018-10-15 15:16:22.800195586 +0200
>> @@ -238,7 +238,8 @@ comment "Power management"
>>
>>  config SAMSUNG_PM_DEBUG
>>         bool "Samsung PM Suspend debug"
>> -       depends on PM && DEBUG_KERNEL
>> +       depends on DEBUG_KERNEL
> 
> I don't get this change - why moving PM to line below?

My mistake, I will correct it in v3.

[ The idea was to make SAMSUNG_PM_DEBUG consistent with other options
  depending on DEBUG_KERNEL. However after I've checked them it turned
  out that there is no such consistency. I intended to revert this
  change but ultimately I forgot about it.. ]

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
