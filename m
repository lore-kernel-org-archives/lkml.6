Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id EbNILjNVGFuwcQAAmS7hNA
	; Wed, 06 Jun 2018 21:48:19 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4A244608BA; Wed,  6 Jun 2018 21:48:19 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ee/UvkUN"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 87501601C3;
	Wed,  6 Jun 2018 21:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 87501601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752672AbeFFVsQ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 17:48:16 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:42117 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752559AbeFFVsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 17:48:11 -0400
Received: by mail-pg0-f67.google.com with SMTP id p9-v6so3638341pgc.9;
        Wed, 06 Jun 2018 14:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8Ttl3fHD6LG6SRpD2x3nbm9C7HVBovH2BgM+fkgnBK8=;
        b=Ee/UvkUNfx4b3apZF8c9wMIdMpPU/PLbsvPXuUFqJYFmp0BwTWa0H28En8ZkBuELFr
         SL/TPlKPu9uq1/7mtJZxdhabtlxF17EyNp7F3Q2Q/a4CigIxtaUFcxuGIEK2mdb8sf05
         yem0feFmIkRZ/q6vtW7uWtlRQHWlx31YGt+CQeGbTHW7RAk9INWltbEa0azJyjUkBVca
         Vmq5RuE1hJ6DfMxcrSmLcgt87ENDsG0BuGAkdqJM19Pnm9yl53zsIsBkGAVHXggqaVCb
         QPetqHNqicRu3dWsfBub8AYIS4Gk3xAt6LrBkxi3tCD/ZvMf3i+qSU6/hpiYdSKlBMDt
         pShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8Ttl3fHD6LG6SRpD2x3nbm9C7HVBovH2BgM+fkgnBK8=;
        b=ArdOFGabh0xrafUMM7H010txKcgUVEP8Y/3Dad3tfRr0/qdtzYPIAuKZJ+s49Zhaoy
         1E+NHLO9We/aJufYl0mWEnbnyEEkY5t8xZDO7F/rqFXclbJjE3wZE2WC2U54EjPMYfLA
         9haAJACeV1QX+GXHcEgpdNyg7Z0gSj2HMpcE14wMBSTlS4J99GLWusOlPJ7hk1IuRnFV
         BsgyrnlqNQLFpJvjKhOI0/0QB4FXHHfdfGNktux8+fbAlXzG+op0b6DtYh7nfA1NwBHJ
         vTzim4o7yRXeePKCViCYKhukOEc6qccAPIaseZ2KXF6NAHHD0g2UQwz26LA0PtRwYqsD
         6Gww==
X-Gm-Message-State: APt69E1XkfcIgd5kZ5mCFtCL3Au/2bBaR7iMZn84+ryQXgtPlHFCKkTR
        ROifbVh+XsKdzjzV+1cqhig=
X-Google-Smtp-Source: ADUXVKIDDvU6lwiWAnE5RQT2W6fYLjMZOgQDb6ac1eJti5pSFdu8sX64BN2A/7qH9VgPAuZLTxC8eg==
X-Received: by 2002:a62:bca:: with SMTP id 71-v6mr3959771pfl.234.1528321690335;
        Wed, 06 Jun 2018 14:48:10 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id p16-v6sm51047665pfd.47.2018.06.06.14.48.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 14:48:09 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] arm: shmobile: Add the R9A06G032 SMP enabler
 driver
To: Michel Pollet <michel.pollet@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>
Cc: Michel Pollet <buserror+upstream@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Douglas Anderson <dianders@chromium.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Carlo Caione <carlo@endlessm.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Frank Rowand <frank.rowand@sony.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
References: <1528198148-23308-1-git-send-email-michel.pollet@bp.renesas.com>
 <1528198148-23308-3-git-send-email-michel.pollet@bp.renesas.com>
 <0481173f-6384-98d6-707c-89dc5ef103f0@gmail.com>
 <OSBPR01MB2054E3A1E383495F3534B551D2650@OSBPR01MB2054.jpnprd01.prod.outlook.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <9cef7124-3020-5741-f3a2-6925a6c8f0f3@gmail.com>
Date: Wed, 6 Jun 2018 14:48:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB2054E3A1E383495F3534B551D2650@OSBPR01MB2054.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/18 23:36, Michel Pollet wrote:
> Hi Frank,
> 
> On 05 June 2018 18:34, Frank wrote:
>> On 06/05/18 04:28, Michel Pollet wrote:
>>> The Renesas R9A06G032 second CA7 is parked in a ROM pen at boot time,
>>> it requires a special enable method to get it started.
>>>
>>> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
>>> ---
>>>  arch/arm/mach-shmobile/Makefile        |  1 +
>>>  arch/arm/mach-shmobile/smp-r9a06g032.c | 79
>>> ++++++++++++++++++++++++++++++++++
>>>  2 files changed, 80 insertions(+)
>>>  create mode 100644 arch/arm/mach-shmobile/smp-r9a06g032.c
>>>
>>> diff --git a/arch/arm/mach-shmobile/Makefile
>>> b/arch/arm/mach-shmobile/Makefile index 1939f52..d7fc98f 100644
>>> --- a/arch/arm/mach-shmobile/Makefile
>>> +++ b/arch/arm/mach-shmobile/Makefile
>>> @@ -34,6 +34,7 @@ smp-$(CONFIG_ARCH_SH73A0)+= smp-sh73a0.o
>> headsmp-scu.o platsmp-scu.o
>>>  smp-$(CONFIG_ARCH_R8A7779)+= smp-r8a7779.o headsmp-scu.o
>> platsmp-scu.o
>>>  smp-$(CONFIG_ARCH_R8A7790)+= smp-r8a7790.o
>>>  smp-$(CONFIG_ARCH_R8A7791)+= smp-r8a7791.o
>>> +smp-$(CONFIG_ARCH_R9A06G032)+= smp-r9a06g032.o
>>>  smp-$(CONFIG_ARCH_EMEV2)+= smp-emev2.o headsmp-scu.o
>> platsmp-scu.o
>>>
>>>  # PM objects
>>> diff --git a/arch/arm/mach-shmobile/smp-r9a06g032.c
>>> b/arch/arm/mach-shmobile/smp-r9a06g032.c
>>> new file mode 100644
>>> index 0000000..cd40e6e
>>> --- /dev/null
>>> +++ b/arch/arm/mach-shmobile/smp-r9a06g032.c
>>> @@ -0,0 +1,79 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * R9A06G032 Second CA7 enabler.
>>> + *
>>> + * Copyright (C) 2018 Renesas Electronics Europe Limited
>>> + *
>>> + * Michel Pollet <michel.pollet@bp.renesas.com>,
>> <buserror@gmail.com>
>>> + * Derived from action,s500-smp
>>> + */
>>> +
>>> +#include <linux/io.h>
>>> +#include <linux/of.h>
>>> +#include <linux/of_address.h>
>>> +#include <linux/smp.h>
>>> +
>>> +/*
>>> + * The second CPU is parked in ROM at boot time. It requires waking
>>> +it after
>>> + * writing an address into the BOOTADDR register of sysctrl.
>>> + *
>>> + * So the default value of the "cpu-release-addr" corresponds to
>> BOOTADDR...
>>> + *
>>> + * *However* the BOOTADDR register is not available when the kernel
>>> + * starts in NONSEC mode.
>>> + *
>>> + * So for NONSEC mode, the bootloader re-parks the second CPU into a
>>> +pen
>>> + * in SRAM, and changes the "cpu-release-addr" of linux's DT to a
>>> +SRAM address,
>>> + * which is not restricted.
>>
>> The binding document for cpu-release-addr does not have a definition for 32
>> bit arm.  The existing definition is only 64 bit arm.  Please add the definition
>> for 32 bit arm to patch 1.
> 
> Hmmm I do find a definition in
> Documentation/devicetree/bindings/arm/cpus.txt -- just under where I
> added my 'enable-method' -- And it is already used as 32 bits in at least
> arch/arm/boot/dts/stih407-family.dtsi.

If the correct answer is for cpu-release-addr to be 64 bits in certain
cases (that discussion is ongoing further downthread) then one approach
to maintain compatibility _and_ to fix the devicetree source files is
to change the source code that currently gets cpu-release-addr as a
32 bit object to check the size of the property and get it as either
a 32 bit or 64 bit object, based on the actual size of the property
in the device tree and then change the value in the devicetree source
files to be two cells.  BUT this does not consider the bootloader
complication.  arch/arm/boot/dts/axm5516-cpus.dtsi has a note
"// Fixed by the boot loader", so the boot loader also has to be
modified to be able to handle the possibility that the property
could be either 32 bits or 64 bits.  I don't know how to maintain
compatibility with the boot loader since we can't force it to
change synchronously with changes in the kernel.

You can consider this comment to be a drive-by observation.  I think
Rob and Geert and people like that are likely to be more helpful with
what to actually do, and you can treat my comment more as pointing out
the issue than as providing the perfect solution.

-Frnak


> 
> What do you want me to add to this exactly? Do you want me to just
> change "required for systems that have an "enable-method" property
> value of "spin-table" to also specify renesas,r9a06g032 ?
> 
> Thanks!
> Michel
> 
>>
>> -Frank
>>
>>
>>> + */
>>> +
>>> +static void __iomem *cpu_bootaddr;
>>> +
>>> +static DEFINE_SPINLOCK(cpu_lock);
>>> +
>>> +static int r9a06g032_smp_boot_secondary(unsigned int cpu, struct
>>> +task_struct *idle) {
>>> +if (!cpu_bootaddr)
>>> +return -ENODEV;
>>> +
>>> +spin_lock(&cpu_lock);
>>> +
>>> +writel(__pa_symbol(secondary_startup), cpu_bootaddr);
>>> +arch_send_wakeup_ipi_mask(cpumask_of(cpu));
>>> +
>>> +spin_unlock(&cpu_lock);
>>> +
>>> +return 0;
>>> +}
>>> +
>>> +static void __init r9a06g032_smp_prepare_cpus(unsigned int max_cpus)
>>> +{
>>> +struct device_node *dn;
>>> +int ret;
>>> +u32 bootaddr;
>>> +
>>> +dn = of_get_cpu_node(1, NULL);
>>> +if (!dn) {
>>> +pr_err("CPU#1: missing device tree node\n");
>>> +return;
>>> +}
>>> +/*
>>> + * Determine the address from which the CPU is polling.
>>> + * The bootloader *does* change this property
>>> + */
>>> +ret = of_property_read_u32(dn, "cpu-release-addr", &bootaddr);
>>> +of_node_put(dn);
>>> +if (ret) {
>>> +pr_err("CPU#1: invalid cpu-release-addr property\n");
>>> +return;
>>> +}
>>> +pr_info("CPU#1: cpu-release-addr %08x\n", bootaddr);
>>> +
>>> +cpu_bootaddr = ioremap(bootaddr, sizeof(bootaddr)); }
>>> +
>>> +static const struct smp_operations r9a06g032_smp_ops __initconst = {
>>> +.smp_prepare_cpus = r9a06g032_smp_prepare_cpus,
>>> +.smp_boot_secondary = r9a06g032_smp_boot_secondary, };
>>> +CPU_METHOD_OF_DECLARE(r9a06g032_smp, "renesas,r9a06g032-smp",
>>> +&r9a06g032_smp_ops);
>>>
> 
> 
> 
> 
> Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
> 
