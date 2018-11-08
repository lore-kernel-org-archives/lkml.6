Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC03BECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A009520825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A009520825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbeKIGhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 01:37:08 -0500
Received: from mout.gmx.net ([212.227.15.19]:46291 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725723AbeKIGhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 01:37:08 -0500
Received: from dhcp-41-57.bos.redhat.com ([66.187.233.206]) by mail.gmx.com
 (mrgmx001 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0LaXIV-1fecor2LtP-00mNHZ; Thu, 08 Nov 2018 21:59:34 +0100
Message-ID: <1541710771.12945.7.camel@gmx.us>
Subject: WARNING: CPU: 0 PID: 0 at drivers/irqchip/irq-gic-v3-its.c
From:   Qian Cai <cai@gmx.us>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Date:   Thu, 08 Nov 2018 15:59:31 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:g6uRufEbAdmFc0TKH2I74C2Fx9uv4TvnXr4cxhS2X3Zlg5tSpi2
 Dq2YRL9KPNquc13ofrooN5lWWT3eVGfZ7qlqNSTxTqkHC/KshXi9C4ufu57pTrQ6UhaHcoe
 h22R7ONFFZFKu8HSEj7YJEZ4HRIcck8lwx+ETQ40bNlOWcYJ7WAG/0q29bCVe35CAm9CWcM
 MSaQizGJD1YuVJktHVd9g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GtLinpKgxs8=:w4Qj9tk/7f4tbLD/Pbu7zp
 7V+/BC1GAa3ZS1fhYpt9+Zo7jcMb1iCh3T191kl0wxX/feMUerOChn9dQ3vNq0bu+s24zety0
 ACdUH/zqyGMUKItS60eNvXvbwVvrHjGZOkB6kyhdCXMwFfHNdhcPK3CJFtGhXkJsNBeBwX0rS
 wwJaukbfwtFmuZ7wxEcQbdYb4sVmEzSB+YmPcYpDUELh5MeBHiJ8+YgDZpV00I+zhTLB9/+Lq
 3H+mh95KnbJovw58Y1b0C3509mtaF2gNoEaV+EjgHCBTWXD/k7Ju3D2V3k3BEe4vTWuF/Mq3h
 vl90WMz5iWDTgRVXWxR40UGlm/4rYRFa3X3mZbIVix6lPadXR8O5eDv2WZNyyY2C0b7zVnCCq
 +Vl0h1g41CK7Lf9KYrQqsGndvBtZRxwOkf1nFKuGmHzGLjWo0K13JBR8fnwfW7EA6cg1DNM3J
 CgQPBEMKJ9fo1kG/mpRlAHZNQB7HKQY5TnC+ZRlclTQ5FCPjl32qebqD+JCDGN6wJb2UnCrcR
 g0Ma6olsd1DYzaXWXJDb4czhjeSzBllq40wnKo21mlFyZVTCdQOWC3LAm2q8tychQ7NK1TfXW
 m21jeY/ICk8UCsixzoJyvaq/ZAqd2A6bx71B1mI+Ye2xlCSShUHMgbyJEoxVt+bFKbff0Nd4F
 i8HZIqaJD7iTX1sLlVCqIRqKZEyh1XYBVWZNijAEQFFCUzKsUrtDKDgPxTv8BgY13RRL+lR6O
 8rgJYWJeUtKpqI1gJyfGSnN+JmQn70maIG2dVkV/tFsStmgJts8h2KufxbnBv9CWoTObdaZ/+
 WuBfeVbUW2QzWtlDIxM2JO41OBZUVQ9WhbR5IKt9ZyZViO7tXGuUydGG1wSXbvGtmw1nwGKto
 agFssVZGi8N97C1RueHW9ExIJ8L/zy0o5PgmyfcCCXaPqfojX3TKEgGNfNmaK2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just booting up the latest git master (b00d209) on an aarch64 server and saw
this. Not sure about the third warning (at kernel/cpu.c:315
lockdep_assert_cpus_held+0x50/0x60) relates to irqchip or not, but appended it
to here anyway just in case.

[    0.000000] WARNING: CPU: 0 PID: 0 at drivers/irqchip/irq-gic-v3-its.c:1696
its_init+0x588/0xb54
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G                T 4.20.0-
rc1+ #7
[    0.000000] pstate: 60000085 (nZCv daIf -PAN -UAO)
[    0.000000] pc : its_init+0x588/0xb54
[    0.000000] lr : its_init+0x558/0xb54
[    0.000000] sp : ffff200009ca79d0
[    0.000000] x29: ffff200009ca79d0 x28: 0000001dc0fb0000 
[    0.000000] x27: ffff7fe007703ec0 x26: 3fe2e7a5444e6979 
[    0.000000] x25: ffff2000093a8000 x24: 0000000000010000 
[    0.000000] x23: ffff200009ce61a0 x22: 1fffe40001394f4e 
[    0.000000] x21: ffff200009f84000 x20: ffff20000c0c3000 
[    0.000000] x19: ffff200008fb2000 x18: 000000000000003f 
[    0.000000] x17: 0000000000000000 x16: 0000000000000000 
[    0.000000] x15: 0000000000000007 x14: ffff200009ceea80 
[    0.000000] x13: ffff200009ceea80 x12: ffff801dc0d60f80 
[    0.000000] x11: ffff801dc0d6f080 x10: ffff200009ceea80 
[    0.000000] x9 : 0000000000000000 x8 : ffff801dc0fc0000 
[    0.000000] x7 : a2a2a2a2a2a2a2a2 x6 : ffff1003b81f7fff 
[    0.000000] x5 : ffff801dc0fbffff x4 : 0000000000000000 
[    0.000000] x3 : 000000000000003f x2 : dfff200000000000 
[    0.000000] x1 : 0000000000010000 x0 : 6667f74e4ba50b25 
[    0.000000] Call trace:
[    0.000000]  its_init+0x588/0xb54
[    0.000000]  gic_init_bases+0x53c/0x5d4
[    0.000000]  gic_acpi_init+0x2cc/0x564
[    0.000000]  acpi_match_madt+0x9c/0x15c
[    0.000000]  acpi_table_parse_entries_array+0x3e0/0x5d8
[    0.000000]  acpi_table_parse_entries+0xbc/0x114
[    0.000000]  acpi_table_parse_madt+0x4c/0x80
[    0.000000]  __acpi_probe_device_table+0x134/0x1ec
[    0.000000]  irqchip_init+0x48/0x74
[    0.000000]  init_IRQ+0xe4/0x12c
[    0.000000]  start_kernel+0x4d0/0x7d4
[    0.000000] irq event stamp: 0
[    0.000000] hardirqs last  enabled at (0):
[<0000000000000000>]           (null)
[    0.000000] hardirqs last disabled at (0):
[<0000000000000000>]           (null)
[    0.000000] softirqs last  enabled at (0):
[<0000000000000000>]           (null)
[    0.000000] softirqs last disabled at (0):
[<0000000000000000>]           (null)
[    0.000000] ---[ end trace f27c5aed63f8afd4 ]---
[    0.000000] GICv3: using LPI property table @0x0000001dc0fb0000
[    0.000000] ITS: Using DirectLPI for VPE invalidation
[    0.000000] ITS: Enabling GICv4 support
[    0.000000] WARNING: CPU: 0 PID: 0 at drivers/irqchip/irq-gic-v3-its.c:2096
its_cpu_init_lpis+0x3b4/0x3f0
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W       T 4.20.0-
rc1+ #7
[    0.000000] pstate: 60000085 (nZCv daIf -PAN -UAO)
[    0.000000] pc : its_cpu_init_lpis+0x3b4/0x3f0
[    0.000000] lr : its_cpu_init_lpis+0x3b0/0x3f0
[    0.000000] sp : ffff200009ca7a00
[    0.000000] x29: ffff200009ca7a00 x28: ffff200009ce6188 
[    0.000000] x27: 0000601df1e30000 x26: ffff200009ca7a00 
[    0.000000] x25: 0000001dc0fc0000 x24: ffff20000c0c3000 
[    0.000000] x23: ffff7fe007703f00 x22: ffff2000093a8000 
[    0.000000] x21: ffff20000c180000 x20: ffff200009cd9000 
[    0.000000] x19: 1fffe40001394f4c x18: 000000000000003f 
[    0.000000] x17: 0000000000000000 x16: 0000000000000000 
[    0.000000] x15: 0000000000000007 x14: ffff2000094f050c 
[    0.000000] x13: ffff2000094f3cac x12: ffff2000094e7248 
[    0.000000] x11: ffff2000094e69e0 x10: ffff2000094e9d18 
[    0.000000] x9 : 1fffe40001394e5c x8 : ffff040001394edf 
[    0.000000] x7 : 0000000041b58ab3 x6 : 00000000f1f1f1f1 
[    0.000000] x5 : 0000000041b58ab3 x4 : 00000000f1f1f1f1 
[    0.000000] x3 : ffff040001394f4c x2 : 000000000000ffff 
[    0.000000] x1 : 0000000000010000 x0 : 00000000ffffffed 
[    0.000000] Call trace:
[    0.000000]  its_cpu_init_lpis+0x3b4/0x3f0
[    0.000000]  its_cpu_init+0xa8/0x220
[    0.000000]  gic_init_bases+0x540/0x5d4
[    0.000000]  gic_acpi_init+0x2cc/0x564
[    0.000000]  acpi_match_madt+0x9c/0x15c
[    0.000000]  acpi_table_parse_entries_array+0x3e0/0x5d8
[    0.000000]  acpi_table_parse_entries+0xbc/0x114
[    0.000000]  acpi_table_parse_madt+0x4c/0x80
[    0.000000]  __acpi_probe_device_table+0x134/0x1ec
[    0.000000]  irqchip_init+0x48/0x74
[    0.000000]  init_IRQ+0xe4/0x12c
[    0.000000]  start_kernel+0x4d0/0x7d4
[    0.000000] irq event stamp: 0
[    0.000000] hardirqs last  enabled at (0):
[<0000000000000000>]           (null)
[    0.000000] hardirqs last disabled at (0):
[<0000000000000000>]           (null)
[    0.000000] softirqs last  enabled at (0):
[<0000000000000000>]           (null)
[    0.000000] softirqs last disabled at (0):
[<0000000000000000>]           (null)
[    0.000000] ---[ end trace f27c5aed63f8afd5 ]---
[    0.000000] GICv3: CPU0: using allocated LPI pending table
@0x0000001dc0fc0000
[    0.000000] rcu: 	Offload RCU callbacks from CPUs: (none).
[    0.000000] WARNING: CPU: 0 PID: 0 at kernel/cpu.c:315
lockdep_assert_cpus_held+0x50/0x60
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W       T 4.20.0-
rc1+ #7
[    0.000000] pstate: 20000085 (nzCv daIf -PAN -UAO)
[    0.000000] pc : lockdep_assert_cpus_held+0x50/0x60
[    0.000000] lr : lockdep_assert_cpus_held+0x4c/0x60
[    0.000000] sp : ffff200009ca7b10
[    0.000000] x29: ffff200009ca7b10 x28: ffff200009e49000 
[    0.000000] x27: ffff200009ce1000 x26: ffff200009ce2000 
[    0.000000] x25: ffff200009135000 x24: ffff200009cd9868 
[    0.000000] x23: ffff200009c8c040 x22: 0000000000001000 
[    0.000000] x21: 0000000000000012 x20: ffff200009cd9000 
[    0.000000] x19: ffff200009ce5000 x18: 000000000000003f 
[    0.000000] x17: 0000000000000000 x16: 0000000000000000 
[    0.000000] x15: 0000000000000007 x14: ffff200009471ccc 
[    0.000000] x13: ffff2000094795a0 x12: ffff2000095249ac 
[    0.000000] x11: ffff2000094f4470 x10: ffff2000094f0a44 
[    0.000000] x9 : ffff200009526aa8 x8 : ffff0ffbffcc4004 
[    0.000000] x7 : 1fffeffbffcc4003 x6 : ffff0ffbffcc4003 
[    0.000000] x5 : ffff7fdffe62001b x4 : ffff0ffbffcc4004 
[    0.000000] x3 : ffff0ffbffcc4004 x2 : dfff200000000000 
[    0.000000] x1 : 0000000000000000 x0 : 0000000000000000 
[    0.000000] Call trace:
[    0.000000]  lockdep_assert_cpus_held+0x50/0x60
[    0.000000]  static_key_enable_cpuslocked+0x30/0xe8
[    0.000000]  arch_timer_check_ool_workaround+0x128/0x2d0
[    0.000000]  arch_timer_acpi_init+0x274/0x6ac
[    0.000000]  acpi_table_parse+0x1ac/0x218
[    0.000000]  __acpi_probe_device_table+0x164/0x1ec
[    0.000000]  timer_probe+0x1bc/0x254
[    0.000000]  time_init+0x44/0x98
[    0.000000]  start_kernel+0x4ec/0x7d4
[    0.000000] irq event stamp: 0
[    0.000000] hardirqs last  enabled at (0):
[<0000000000000000>]           (null)
[    0.000000] hardirqs last disabled at (0):
[<0000000000000000>]           (null)
[    0.000000] softirqs last  enabled at (0):
[<0000000000000000>]           (null)
[    0.000000] softirqs last disabled at (0):
[<0000000000000000>]           (null)
[    0.000000] ---[ end trace f27c5aed63f8afd6 ]---
