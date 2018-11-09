Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D906C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD4062081C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD4062081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbeKIVsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 16:48:24 -0500
Received: from foss.arm.com ([217.140.101.70]:58272 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727742AbeKIVsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 16:48:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5369180D;
        Fri,  9 Nov 2018 04:08:03 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BFA53F718;
        Fri,  9 Nov 2018 04:08:02 -0800 (PST)
Subject: Re: WARNING: CPU: 0 PID: 0 at drivers/irqchip/irq-gic-v3-its.c
To:     Qian Cai <cai@gmx.us>, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <1541710771.12945.7.camel@gmx.us>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <c8ff3004-33ee-19d5-8eb8-38d41f78c8ee@arm.com>
Date:   Fri, 9 Nov 2018 12:08:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1541710771.12945.7.camel@gmx.us>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Ard]

On 08/11/18 20:59, Qian Cai wrote:
> Just booting up the latest git master (b00d209) on an aarch64 server and saw
> this. Not sure about the third warning (at kernel/cpu.c:315
> lockdep_assert_cpus_held+0x50/0x60) relates to irqchip or not, but appended it
> to here anyway just in case.
> 
> [    0.000000] WARNING: CPU: 0 PID: 0 at drivers/irqchip/irq-gic-v3-its.c:1696
> its_init+0x588/0xb54

It looks like EFI cannot manage to reserve the memory for your GIC
redistributors. Pretty annoying. At the same time, you have reported
other issues with the EFI reservation mechanism, such as:

https://lore.kernel.org/patchwork/patch/1008413/

for which you have given a "Tested-by:". Is that related?

> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G                T 4.20.0-
> rc1+ #7
> [    0.000000] pstate: 60000085 (nZCv daIf -PAN -UAO)
> [    0.000000] pc : its_init+0x588/0xb54
> [    0.000000] lr : its_init+0x558/0xb54
> [    0.000000] sp : ffff200009ca79d0
> [    0.000000] x29: ffff200009ca79d0 x28: 0000001dc0fb0000 
> [    0.000000] x27: ffff7fe007703ec0 x26: 3fe2e7a5444e6979 
> [    0.000000] x25: ffff2000093a8000 x24: 0000000000010000 
> [    0.000000] x23: ffff200009ce61a0 x22: 1fffe40001394f4e 
> [    0.000000] x21: ffff200009f84000 x20: ffff20000c0c3000 
> [    0.000000] x19: ffff200008fb2000 x18: 000000000000003f 
> [    0.000000] x17: 0000000000000000 x16: 0000000000000000 
> [    0.000000] x15: 0000000000000007 x14: ffff200009ceea80 
> [    0.000000] x13: ffff200009ceea80 x12: ffff801dc0d60f80 
> [    0.000000] x11: ffff801dc0d6f080 x10: ffff200009ceea80 
> [    0.000000] x9 : 0000000000000000 x8 : ffff801dc0fc0000 
> [    0.000000] x7 : a2a2a2a2a2a2a2a2 x6 : ffff1003b81f7fff 
> [    0.000000] x5 : ffff801dc0fbffff x4 : 0000000000000000 
> [    0.000000] x3 : 000000000000003f x2 : dfff200000000000 
> [    0.000000] x1 : 0000000000010000 x0 : 6667f74e4ba50b25 
> [    0.000000] Call trace:
> [    0.000000]  its_init+0x588/0xb54
> [    0.000000]  gic_init_bases+0x53c/0x5d4
> [    0.000000]  gic_acpi_init+0x2cc/0x564
> [    0.000000]  acpi_match_madt+0x9c/0x15c
> [    0.000000]  acpi_table_parse_entries_array+0x3e0/0x5d8
> [    0.000000]  acpi_table_parse_entries+0xbc/0x114
> [    0.000000]  acpi_table_parse_madt+0x4c/0x80
> [    0.000000]  __acpi_probe_device_table+0x134/0x1ec
> [    0.000000]  irqchip_init+0x48/0x74
> [    0.000000]  init_IRQ+0xe4/0x12c
> [    0.000000]  start_kernel+0x4d0/0x7d4
> [    0.000000] irq event stamp: 0
> [    0.000000] hardirqs last  enabled at (0):
> [<0000000000000000>]           (null)
> [    0.000000] hardirqs last disabled at (0):
> [<0000000000000000>]           (null)
> [    0.000000] softirqs last  enabled at (0):
> [<0000000000000000>]           (null)
> [    0.000000] softirqs last disabled at (0):
> [<0000000000000000>]           (null)
> [    0.000000] ---[ end trace f27c5aed63f8afd4 ]---
> [    0.000000] GICv3: using LPI property table @0x0000001dc0fb0000
> [    0.000000] ITS: Using DirectLPI for VPE invalidation
> [    0.000000] ITS: Enabling GICv4 support
> [    0.000000] WARNING: CPU: 0 PID: 0 at drivers/irqchip/irq-gic-v3-its.c:2096
> its_cpu_init_lpis+0x3b4/0x3f0

Same thing here.

> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W       T 4.20.0-
> rc1+ #7
> [    0.000000] pstate: 60000085 (nZCv daIf -PAN -UAO)
> [    0.000000] pc : its_cpu_init_lpis+0x3b4/0x3f0
> [    0.000000] lr : its_cpu_init_lpis+0x3b0/0x3f0
> [    0.000000] sp : ffff200009ca7a00
> [    0.000000] x29: ffff200009ca7a00 x28: ffff200009ce6188 
> [    0.000000] x27: 0000601df1e30000 x26: ffff200009ca7a00 
> [    0.000000] x25: 0000001dc0fc0000 x24: ffff20000c0c3000 
> [    0.000000] x23: ffff7fe007703f00 x22: ffff2000093a8000 
> [    0.000000] x21: ffff20000c180000 x20: ffff200009cd9000 
> [    0.000000] x19: 1fffe40001394f4c x18: 000000000000003f 
> [    0.000000] x17: 0000000000000000 x16: 0000000000000000 
> [    0.000000] x15: 0000000000000007 x14: ffff2000094f050c 
> [    0.000000] x13: ffff2000094f3cac x12: ffff2000094e7248 
> [    0.000000] x11: ffff2000094e69e0 x10: ffff2000094e9d18 
> [    0.000000] x9 : 1fffe40001394e5c x8 : ffff040001394edf 
> [    0.000000] x7 : 0000000041b58ab3 x6 : 00000000f1f1f1f1 
> [    0.000000] x5 : 0000000041b58ab3 x4 : 00000000f1f1f1f1 
> [    0.000000] x3 : ffff040001394f4c x2 : 000000000000ffff 
> [    0.000000] x1 : 0000000000010000 x0 : 00000000ffffffed 
> [    0.000000] Call trace:
> [    0.000000]  its_cpu_init_lpis+0x3b4/0x3f0
> [    0.000000]  its_cpu_init+0xa8/0x220
> [    0.000000]  gic_init_bases+0x540/0x5d4
> [    0.000000]  gic_acpi_init+0x2cc/0x564
> [    0.000000]  acpi_match_madt+0x9c/0x15c
> [    0.000000]  acpi_table_parse_entries_array+0x3e0/0x5d8
> [    0.000000]  acpi_table_parse_entries+0xbc/0x114
> [    0.000000]  acpi_table_parse_madt+0x4c/0x80
> [    0.000000]  __acpi_probe_device_table+0x134/0x1ec
> [    0.000000]  irqchip_init+0x48/0x74
> [    0.000000]  init_IRQ+0xe4/0x12c
> [    0.000000]  start_kernel+0x4d0/0x7d4
> [    0.000000] irq event stamp: 0
> [    0.000000] hardirqs last  enabled at (0):
> [<0000000000000000>]           (null)
> [    0.000000] hardirqs last disabled at (0):
> [<0000000000000000>]           (null)
> [    0.000000] softirqs last  enabled at (0):
> [<0000000000000000>]           (null)
> [    0.000000] softirqs last disabled at (0):
> [<0000000000000000>]           (null)
> [    0.000000] ---[ end trace f27c5aed63f8afd5 ]---
> [    0.000000] GICv3: CPU0: using allocated LPI pending table
> @0x0000001dc0fc0000
> [    0.000000] rcu: 	Offload RCU callbacks from CPUs: (none).
> [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/cpu.c:315
> lockdep_assert_cpus_held+0x50/0x60
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W       T 4.20.0-
> rc1+ #7
> [    0.000000] pstate: 20000085 (nzCv daIf -PAN -UAO)
> [    0.000000] pc : lockdep_assert_cpus_held+0x50/0x60
> [    0.000000] lr : lockdep_assert_cpus_held+0x4c/0x60
> [    0.000000] sp : ffff200009ca7b10
> [    0.000000] x29: ffff200009ca7b10 x28: ffff200009e49000 
> [    0.000000] x27: ffff200009ce1000 x26: ffff200009ce2000 
> [    0.000000] x25: ffff200009135000 x24: ffff200009cd9868 
> [    0.000000] x23: ffff200009c8c040 x22: 0000000000001000 
> [    0.000000] x21: 0000000000000012 x20: ffff200009cd9000 
> [    0.000000] x19: ffff200009ce5000 x18: 000000000000003f 
> [    0.000000] x17: 0000000000000000 x16: 0000000000000000 
> [    0.000000] x15: 0000000000000007 x14: ffff200009471ccc 
> [    0.000000] x13: ffff2000094795a0 x12: ffff2000095249ac 
> [    0.000000] x11: ffff2000094f4470 x10: ffff2000094f0a44 
> [    0.000000] x9 : ffff200009526aa8 x8 : ffff0ffbffcc4004 
> [    0.000000] x7 : 1fffeffbffcc4003 x6 : ffff0ffbffcc4003 
> [    0.000000] x5 : ffff7fdffe62001b x4 : ffff0ffbffcc4004 
> [    0.000000] x3 : ffff0ffbffcc4004 x2 : dfff200000000000 
> [    0.000000] x1 : 0000000000000000 x0 : 0000000000000000 
> [    0.000000] Call trace:
> [    0.000000]  lockdep_assert_cpus_held+0x50/0x60
> [    0.000000]  static_key_enable_cpuslocked+0x30/0xe8
> [    0.000000]  arch_timer_check_ool_workaround+0x128/0x2d0

Looks like we're calling static_key_enable_cpuslocked in the wrong
context. That's a separate issue (I'll investigate it).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
