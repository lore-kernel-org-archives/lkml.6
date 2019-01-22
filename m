Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BB5C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E2A2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="at/iQ5g+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfAVIqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 03:46:15 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:2107 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbfAVIqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 03:46:15 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c46d83d0000>; Tue, 22 Jan 2019 00:45:49 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 22 Jan 2019 00:46:13 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 22 Jan 2019 00:46:13 -0800
Received: from [10.24.242.22] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 22 Jan
 2019 08:46:08 +0000
Subject: Re: [PATCH] of: reserved_mem: disable kmemleak scan on removed memory
 blocks
To:     Rob Herring <robh+dt@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        <will.deacon@arm.com>, <matt@codeblueprint.co.uk>,
        Catalin Marinas <catalin.marinas@arm.com>
CC:     Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <talho@nvidia.com>,
        Stephen Warren <swarren@nvidia.com>, <vdumpa@nvidia.com>,
        <snikam@nvidia.com>
References: <1541747389-28544-1-git-send-email-prpatel@nvidia.com>
 <CAL_JsqKOH0SQRXuRW5Y5dmWeUTSxhf2Nmn_0uNLeKXFPRc549Q@mail.gmail.com>
From:   Prateek Patel <prpatel@nvidia.com>
Message-ID: <39d4161b-bcc0-0f1c-e7a3-5ad552fae724@nvidia.com>
Date:   Tue, 22 Jan 2019 14:16:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKOH0SQRXuRW5Y5dmWeUTSxhf2Nmn_0uNLeKXFPRc549Q@mail.gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548146749; bh=iAhIztpwoPIQ/teUXWYpDpSB6NWGBeBA0eeVd0z/Jjk=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=at/iQ5g+rNpHlZBDjumXYwgTd4S7VrhhTQCCvoAtnQ1GqoJrQ64UowKtyRHvmjD9N
         IXfr4FRpghrKo+rpxtdW0axwpKLax0e6+Bjud0Nt8DUtzPdn4JbW4ApHGIRZ22YogB
         PO/PeSN1DGCk+IQHPz5sp126FILIBM2EJGH+F5FCn4aBuOq6yPh1TLGg+u7cHejajk
         79MILUk0ZSEGBpykSHj7rzrnLE3FTJTE+R2jxepZaSSYCHnAgFMyYuPl7SoWmXXyah
         5Cp4gcV3lIdBy+rx3Ups4bLR8+ig2e+8x3VEP1gR8Vn/lAsTmtixCj4ahrcBxRw71P
         pab5NJgyYhVQg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/10/2018 2:58 AM, Rob Herring wrote:
> On Fri, Nov 9, 2018 at 1:09 AM Prateek Patel <prpatel@nvidia.com> wrote:
>> From: Sri Krishna chowdary <schowdary@nvidia.com>
>>
>> Memory reserved with "nomap" DT property in of_reserved_mem.c
>> removes the memory block. The removed memory blocks don't have
>> VA to PA mapping created in kernel page table. Kmemleak scan on
>> removed memory blocks is causing page faults and leading to
>> kernel panic. So, Disable kmemleak scan on the removed memory
>> blocks.
>>
>> Following is the observed crash log:
>> [  154.846370] Unable to handle kernel paging request at virtual address=
 ffffffc070a00000
>> <1>[  154.846576] Mem abort info:
>> <1>[  154.846635]   Exception class =3D DABT (current EL), IL =3D 32 bit=
s
>> <1>[  154.846737]   SET =3D 0, FnV =3D 0
>> <1>[  154.846796]   EA =3D 0, S1PTW =3D 0
>> <1>[  154.846859] Data abort info:
>> <1>[  154.846913]   ISV =3D 0, ISS =3D 0x00000006
>> <1>[  154.846983]   CM =3D 0, WnR =3D 0
>> <1>[  154.847053] swapper pgtable: 4k pages, 39-bit VAs, pgd =3D ffffff8=
009df7000
>> <1>[  154.847228] [ffffffc070a00000] *pgd=3D000000087fff5803, *pud=3D000=
000087fff5803, *pmd=3D0000000000000000
>> <0>[  154.847408] Internal error: Oops: 96000006 [#1] PREEMPT SMP
>> <4>[  154.847511] Modules linked in: nvs_led_test nvs_bmi160 nvs_cm3218 =
nvs_bh1730fvc nvi_bmpX80 nvi_ak89xx nvi_mpu cdc_acm uas lr388k7_ts imx268 i=
mx318 imx204 imx274 imx185 lc898212 ov23850 ov10823 ov9281 ov5693 tc358840 =
pca9570 nvs snd_soc_tegra_machine_driver_mobile lp855x_bl spidev input_cfbo=
ost pwm_tegra tegra_cryptodev tegra_se_nvhost tegra_se_elp tegra_se ghash_c=
e sha2_ce sha1_ce aes_ce_ccm cryptd nvgpu cpufreq_userspace snd_soc_tegra18=
6_alt_dspk snd_soc_tegra186_alt_asrc snd_soc_tegra186_alt_arad snd_soc_tegr=
a210_alt_ope snd_soc_tegra210_alt_mvc snd_soc_tegra210_alt_dmic snd_soc_teg=
ra210_alt_amx snd_soc_tegra210_alt_adx snd_soc_tegra210_alt_afc snd_soc_teg=
ra210_alt_mixer snd_soc_tegra210_alt_i2s snd_soc_tegra210_alt_sfc snd_soc_t=
egra210_alt_adsp snd_soc_tegra210_alt_admaif snd_soc_tegra210_alt_xbar
>> <4>[  154.882606]  snd_soc_tegra_alt_utils snd_hda_tegra
>> <4>[  154.888133] CPU: 2 PID: 8079 Comm: sh Not tainted 4.14.53-tegra-05=
132-g9c33465 #2
>> <4>[  154.895983] Hardware name: e3360_1099 (DT)
>> <4>[  154.900447] task: ffffffc7d62dda00 task.stack: ffffff800e2b0000
>> <4>[  154.906502] PC is at scan_block+0x7c/0x148
>> <4>[  154.911234] LR is at scan_block+0x78/0x148
>> <4>[  154.915689] pc : [<ffffff8008271724>] lr : [<ffffff8008271720>] ps=
tate: 804000c9
>> <4>[  154.923290] sp : ffffff800e2b3b80
>> <4>[  154.927228] x29: ffffff800e2b3b80 x28: ffffffc7d62dda00
>> <4>[  154.932999] x27: ffffff8009aaa000 x26: ffffffc070c00000
>> <4>[  154.938769] x25: 00000000000000c0 x24: ffffff8009d90608
>> <4>[  154.944287] x23: ffffffc7dc6c6000 x22: ffffff8009d90000
>> <4>[  154.950320] x21: ffffff8009aeb320 x20: ffffffc070a00ff9
>> <4>[  154.955919] x19: ffffffc070a00000 x18: 00000000bec4c3f2
>> <4>[  154.961438] x17: 0000002224777924 x16: ffffff80080bb0e0
>> <4>[  154.967124] x15: 0000000000000000 x14: 0000000000000f75
>> <4>[  154.973069] x13: 000fffffffffffff x12: ffffffbf1e9f4240
>> <4>[  154.978670] x11: 0000000000000040 x10: 0000000000000ad0
>> <4>[  154.984107] x9 : ffffff800e2b3ab0 x8 : ffffffc7d62de530
>> <4>[  154.989958] x7 : 0000000780000000 x6 : 0000000000000018
>> <4>[  154.995645] x5 : 0000000000000000 x4 : 0000000000000000
>> <4>[  155.001245] x3 : ffffff8009aaa000 x2 : 00000047f6712000
>> <4>[  155.006846] x1 : ffffffc7d1ae6900 x0 : 0000000000000000
>>
>> Signed-off-by: Sri Krishna chowdary <schowdary@nvidia.com>
>> Signed-off-by: Prateek <prpatel@nvidia.com>
>> ---
>>   drivers/of/of_reserved_mem.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
>> index 1977ee0..ac8f377 100644
>> --- a/drivers/of/of_reserved_mem.c
>> +++ b/drivers/of/of_reserved_mem.c
>> @@ -21,6 +21,7 @@
>>   #include <linux/sort.h>
>>   #include <linux/slab.h>
>>   #include <linux/memblock.h>
>> +#include <linux/kmemleak.h>
>>
>>   #define MAX_RESERVED_REGIONS   32
>>   static struct reserved_mem reserved_mem[MAX_RESERVED_REGIONS];
>> @@ -50,8 +51,10 @@ int __init __weak early_init_dt_alloc_reserved_memory=
_arch(phys_addr_t size,
>>          }
>>
>>          *res_base =3D base;
>> -       if (nomap)
>> +       if (nomap) {
>> +               kmemleak_no_scan(__va(base));
>>                  return memblock_remove(base, size);
> I'm curious how I can't find any other similar example in the kernel.
> Please Cc some kmemleak folks.
>
> Perhaps we should be using memblock_mark_nomap() for nomap areas?
>
> Rob

Sorry for this late reply.

Yes, memblock_mark_nomap() can be used here but if I understand=20
correctly, memblock_mark_nomap() is used to indicate marked parts of=20
memory should not be covered by the kernel direct mapping and=20
memblock_remove() here is doing that by removing a given memory from the=20
"memblock.memory" list to prevent the memory from CPU accessing by the=20
linear address. I am not 100% sure what will be the side effects of=20
using memblock_mark_nomap(). Adding folks to help me here on=20
MEMBLOCK_NOMAP and kmemleak.

I checked and verified with following and I didn't find any errors on my=20
local setup:

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 1977ee0..f77cde0 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -50,8 +50,10 @@ int __init __weak=20
early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *res_base =3D base;
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (nomap)
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return memblock_remove(base, size);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (nomap) {
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 kmemleak_no_scan(__va(base));
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return memblock_mark_nomap(base, size);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
 =C2=A0}

