Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02D5C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B8D20693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4d51VJs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48B8D20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757401AbeFSVZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:25:11 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37012 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755457AbeFSVZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:25:06 -0400
Received: by mail-pl0-f67.google.com with SMTP id 31-v6so522681plc.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 14:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
        bh=oXCjx4+702zY5ZQ0f5vwvArLuhCI43Re7IvO8GtKb/0=;
        b=c4d51VJs4bs+eDHw97Jd2u3psvFJq6eypzVusI3vt4lmPxfOdSjNUjcl574WUplOBk
         R+VN0r1ISUtwteC9xs38jqngzJOM1qZ01QxX7CH2MexXhvqUBh6JoHXhXRWcqt1dYyqs
         8+vbNgkNFE3VVFii8JQEOjsBwkaxXYbF00kCojpT4rmGV0DNbRaiGQmiM1zRxp2oQTti
         5ZQONzO376in/I0cQZCK1Z2z0A1xQM135qOabm32jTHVqje92LzR8yWx8Xb17RxZbUsB
         wtOe9vSvUX6i481jtMGC3Y+BKjM2XdUOoWCTXsFGEyCOcMROmFufDqVj2Qfsd6EoHABL
         cFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to;
        bh=oXCjx4+702zY5ZQ0f5vwvArLuhCI43Re7IvO8GtKb/0=;
        b=RhUKPNx6jwtd8WoybHKMk9Ul++okVpYjrVXK66CjcPkYh4asofkR8gtWmQtJSGt9Z4
         mBgrQq3XssyyG7ck35wWM97ffExHCcfmCcyXPIzg4xSxWRWN0yWJc1csG87ta4zR2g1S
         NtLRVE4G/pXN9o6S3KTMOiB4ap1RDQzhzj7o4xKipJ8yB5ju0JDqDg+qt0OZiCgVauwa
         1WpnI2tYzvhDRGcwHTjX4AlsCeKcsrvFsroyAW4UE6SWQYUo63y1OzvmP8bnEDZbHZ7c
         7tvM9Z9LdizjuSuA4xaMxYXxeOOJrExdd4lM0hhtRcxpKroAXXXvetVxQa4cgd0COKgh
         N9Sg==
X-Gm-Message-State: APt69E2qQ1ltJdOT5Cl0YyIUsCpsO0ahxO8ymF688IlSqpCrSiO7Eq46
        yW6TIL3bCzKOaZaAwephDT/n+Q==
X-Google-Smtp-Source: ADUXVKLo+U1/igy84s1AkgNWrQe6/FxJwqlJT5G96U+Rt4pUpmhlWIBNkWzvW7ySUle4cLDRBv9K2w==
X-Received: by 2002:a17:902:7b95:: with SMTP id w21-v6mr20793517pll.150.1529443505831;
        Tue, 19 Jun 2018 14:25:05 -0700 (PDT)
Received: from mhkkerneltest.corp.microsoft.com ([131.107.160.79])
        by smtp.gmail.com with ESMTPSA id t23-v6sm846203pfa.86.2018.06.19.14.25.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 14:25:05 -0700 (PDT)
From:   Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mikelley@microsoft.com>
To:     will.deacon@arm.com, catalin.marinas@arm.com, mark.rutland@arm.com,
        marc.zyngier@arm.com, linux-arm-kernel@lists.infradead.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        vkuznets@redhat.com, jasowang@redhat.com,
        leann.ogasawara@canonical.com, marcelo.cerri@canonical.com,
        sthemmin@microsoft.com, kys@microsoft.com
Cc:     mikelley@microsoft.com
Subject: [PATCH 2/5] arm64: hyperv: Add core Hyper-V include files
Date:   Tue, 19 Jun 2018 14:23:12 -0700
Message-Id: <1529443395-20874-3-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1529443395-20874-1-git-send-email-mikelley@microsoft.com>
References: <1529443395-20874-1-git-send-email-mikelley@microsoft.com>
Reply-To: mikelley@microsoft.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hyperv-tlfs.h defines Hyper-V interfaces from the Hyper-V Top Level
Functional Spec (TLFS). The TLFS is distinctly oriented to x86/x64,
and Hyper-V has not separated out the architecture-dependent parts into
x86/x64 vs. ARM64. So hyperv-tlfs.h includes information for ARM64
that is not yet formally published. The TLFS is available here:

  docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/reference/tlfs

mshyperv.h defines Linux-specific structures and routines for
interacting with Hyper-V on ARM64.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: James Morris <james.morris@microsoft.com>
---
 MAINTAINERS                          |   2 +
 arch/arm64/include/asm/hyperv-tlfs.h | 353 +++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/mshyperv.h    | 291 +++++++++++++++++++++++++++++
 3 files changed, 646 insertions(+)
 create mode 100644 arch/arm64/include/asm/hyperv-tlfs.h
 create mode 100644 arch/arm64/include/asm/mshyperv.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d5eeff..9c06145 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6617,6 +6617,8 @@ F:	arch/x86/include/asm/trace/hyperv.h
 F:	arch/x86/include/asm/hyperv-tlfs.h
 F:	arch/x86/kernel/cpu/mshyperv.c
 F:	arch/x86/hyperv
+F:	arch/arm64/include/asm/hyperv-tlfs.h
+F:	arch/arm64/include/asm/mshyperv.h
 F:	drivers/hid/hid-hyperv.c
 F:	drivers/hv/
 F:	drivers/input/serio/hyperv-keyboard.c
diff --git a/arch/arm64/include/asm/hyperv-tlfs.h b/arch/arm64/include/asm/hyperv-tlfs.h
new file mode 100644
index 0000000..3f88306
--- /dev/null
+++ b/arch/arm64/include/asm/hyperv-tlfs.h
@@ -0,0 +1,353 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * This file contains definitions from the Hyper-V Hypervisor Top-Level
+ * Functional Specification (TLFS):
+ * https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/reference/tlfs
+ *
+ * Copyright (C) 2018, Microsoft, Inc.
+ *
+ * Author : Michael Kelley <mikelley@microsoft.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ */
+
+#ifndef _ASM_ARM64_HYPERV_H
+#define _ASM_ARM64_HYPERV_H
+
+#include <linux/types.h>
+
+/*
+ * These Hyper-V registers provide information equivalent to the CPUID
+ * instruction on x86/x64.
+ */
+#define HvRegisterHypervisorVersion		0x00000100 /*CPUID 0x40000002 */
+#define	HvRegisterPrivilegesAndFeaturesInfo	0x00000200 /*CPUID 0x40000003 */
+#define	HvRegisterFeaturesInfo			0x00000201 /*CPUID 0x40000004 */
+#define	HvRegisterImplementationLimitsInfo	0x00000202 /*CPUID 0x40000005 */
+#define HvARM64RegisterInterfaceVersion		0x00090006 /*CPUID 0x40000001 */
+
+/*
+ * Feature identification. HvRegisterPrivilegesAndFeaturesInfo returns a
+ * 128-bit value with flags indicating which features are available to the
+ * partition based upon the current partition privileges. The 128-bit
+ * value is broken up with different portions stored in different 32-bit
+ * fields in the ms_hyperv structure.
+ */
+
+/* Partition Reference Counter available*/
+#define HV_MSR_TIME_REF_COUNT_AVAILABLE		(1 << 1)
+
+/*
+ * Synthetic Timers available
+ */
+#define HV_MSR_SYNTIMER_AVAILABLE		(1 << 3)
+
+/* Frequency MSRs available */
+#define HV_FEATURE_FREQUENCY_MSRS_AVAILABLE	(1 << 8)
+
+/* Reference TSC available */
+#define HV_MSR_REFERENCE_TSC_AVAILABLE		(1 << 9)
+
+/* Crash MSR available */
+#define HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE	(1 << 10)
+
+
+/*
+ * This group of flags is in the high order 64-bits of the returned
+ * 128-bit value.
+ */
+
+/* STIMER direct mode is available */
+#define HV_STIMER_DIRECT_MODE_AVAILABLE		(1 << 19)
+
+/*
+ * Implementation recommendations in register
+ * HvRegisterFeaturesInfo. Indicates which behaviors the hypervisor
+ * recommends the OS implement for optimal performance.
+ */
+
+/*
+ * Recommend not using Auto EOI
+ */
+#define HV_DEPRECATING_AEOI_RECOMMENDED		(1 << 9)
+
+/*
+ * Temporary #defines for compatibility with architecture
+ * independent Hyper-V drivers. Remove these once x86-isms
+ * have been removed from arch independent drivers.
+ */
+#define HV_X64_MSR_SYNTIMER_AVAILABLE \
+		HV_MSR_SYNTIMER_AVAILABLE
+#define HV_X64_STIMER_DIRECT_MODE_AVAILABLE \
+		HV_STIMER_DIRECT_MODE_AVAILABLE
+#define HV_X64_DEPRECATING_AEOI_RECOMMENDED \
+		HV_DEPRECATING_AEOI_RECOMMENDED
+#define HV_X64_MSR_STIMER0_COUNT 0
+#define HV_X64_MSR_STIMER0_CONFIG 0
+#define HV_X64_MSR_SINT0 0
+
+/*
+ * Synthetic register definitions equivalent to MSRs on x86/x64
+ */
+#define HvRegisterCrashP0       0x00000210
+#define HvRegisterCrashP1       0x00000211
+#define HvRegisterCrashP2       0x00000212
+#define HvRegisterCrashP3       0x00000213
+#define HvRegisterCrashP4       0x00000214
+#define HvRegisterCrashCtl      0x00000215
+
+#define HvRegisterGuestOsId     0x00090002
+#define HvRegisterVpIndex       0x00090003
+#define HvRegisterTimeRefCount  0x00090004
+#define HvRegisterReferenceTsc	0x00090017
+
+#define HvRegisterSint0         0x000A0000
+#define HvRegisterSint1         0x000A0001
+#define HvRegisterSint2         0x000A0002
+#define HvRegisterSint3         0x000A0003
+#define HvRegisterSint4         0x000A0004
+#define HvRegisterSint5         0x000A0005
+#define HvRegisterSint6         0x000A0006
+#define HvRegisterSint7         0x000A0007
+#define HvRegisterSint8         0x000A0008
+#define HvRegisterSint9         0x000A0009
+#define HvRegisterSint10        0x000A000A
+#define HvRegisterSint11        0x000A000B
+#define HvRegisterSint12        0x000A000C
+#define HvRegisterSint13        0x000A000D
+#define HvRegisterSint14        0x000A000E
+#define HvRegisterSint15        0x000A000F
+#define HvRegisterScontrol      0x000A0010
+#define HvRegisterSversion      0x000A0011
+#define HvRegisterSifp          0x000A0012
+#define HvRegisterSipp          0x000A0013
+#define HvRegisterEom           0x000A0014
+#define HvRegisterSirbp         0x000A0015
+
+#define HvRegisterStimer0Config 0x000B0000
+#define HvRegisterStimer0Count  0x000B0001
+#define HvRegisterStimer1Config 0x000B0002
+#define HvRegisterStimer1Count  0x000B0003
+#define HvRegisterStimer2Config 0x000B0004
+#define HvRegisterStimer2Count  0x000B0005
+#define HvRegisterStimer3Config 0x000B0006
+#define HvRegisterStimer3Count  0x000B0007
+
+/*
+ * Crash notification flag used in the
+ * CrashCtl register.
+ */
+#define HV_CRASH_CTL_CRASH_NOTIFY (1ULL << 63)
+
+/*
+ * The guest OS needs to register the guest ID with the hypervisor.
+ * The guest ID is a 64 bit entity and the structure of this ID is
+ * specified in the Hyper-V specification:
+ *
+ * msdn.microsoft.com/en-us/library/windows/hardware/ff542653%28v=vs.85%29.aspx
+ *
+ * While the current guideline does not specify how Linux guest ID(s)
+ * need to be generated, our plan is to publish the guidelines for
+ * Linux and other guest operating systems that currently are hosted
+ * on Hyper-V. The implementation here conforms to this yet
+ * unpublished guidelines.
+ *
+ *
+ * Bit(s)
+ * 63 - Indicates if the OS is Open Source or not; 1 is Open Source
+ * 62:56 - Os Type; Linux is 0x100
+ * 55:48 - Distro specific identification
+ * 47:16 - Linux kernel version number
+ * 15:0  - Distro specific identification
+ *
+ *
+ */
+#define HV_LINUX_VENDOR_ID              0x8100
+
+/* Declare the various hypercall operations. */
+#define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE	0x0002
+#define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST	0x0003
+#define HVCALL_NOTIFY_LONG_SPIN_WAIT		0x0008
+#define HVCALL_SEND_IPI				0x000b
+#define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX	0x0013
+#define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX	0x0014
+#define HVCALL_SEND_IPI_EX			0x0015
+#define HVCALL_GET_VP_REGISTERS			0x0050
+#define HVCALL_SET_VP_REGISTERS			0x0051
+#define HVCALL_POST_MESSAGE			0x005c
+#define HVCALL_SIGNAL_EVENT			0x005d
+#define HVCALL_RETARGET_INTERRUPT		0x007e
+#define HVCALL_START_VIRTUAL_PROCESSOR		0x0099
+#define HVCALL_GET_VP_INDEX_FROM_APICID		0x009a
+
+/* Declare standard hypercall field values. */
+#define HV_PARTITION_ID_SELF                    ((u64)-1)
+#define HV_VP_INDEX_SELF                        ((u32)-2)
+
+#define HV_HYPERCALL_FAST_BIT                   BIT(16)
+#define HV_HYPERCALL_REP_COUNT_1                BIT_ULL(32)
+#define HV_HYPERCALL_RESULT_MASK                GENMASK_ULL(15, 0)
+
+/* Define the hypercall status result */
+
+union hv_hypercall_status {
+	u64 as_uint64;
+	struct {
+		u16 status;
+		u16 reserved;
+		u16 reps_completed;  /* Low 12 bits */
+		u16 reserved2;
+	};
+};
+
+/* hypercall status code */
+#define HV_STATUS_SUCCESS			0
+#define HV_STATUS_INVALID_HYPERCALL_CODE	2
+#define HV_STATUS_INVALID_HYPERCALL_INPUT	3
+#define HV_STATUS_INVALID_ALIGNMENT		4
+#define HV_STATUS_INSUFFICIENT_MEMORY		11
+#define HV_STATUS_INVALID_CONNECTION_ID		18
+#define HV_STATUS_INSUFFICIENT_BUFFERS		19
+
+/* Define output layout for Get VP Register hypercall */
+struct hv_get_vp_register_output {
+	u64 registervaluelow;
+	u64 registervaluehigh;
+};
+
+#define HV_FLUSH_ALL_PROCESSORS			BIT(0)
+#define HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES	BIT(1)
+#define HV_FLUSH_NON_GLOBAL_MAPPINGS_ONLY	BIT(2)
+#define HV_FLUSH_USE_EXTENDED_RANGE_FORMAT	BIT(3)
+
+enum HV_GENERIC_SET_FORMAT {
+	HV_GENERIC_SET_SPARSE_4K,
+	HV_GENERIC_SET_ALL,
+};
+
+/*
+ * The Hyper-V TimeRefCount register and the TSC
+ * page provide a guest VM clock with 100ns tick rate
+ */
+#define HV_CLOCK_HZ (NSEC_PER_SEC/100)
+
+/*
+ * The fields in this structure are set by Hyper-V and read
+ * by the Linux guest.  They should be accessed with READ_ONCE()
+ * so the compiler doesn't optimize in a way that will cause
+ * problems.
+ */
+struct ms_hyperv_tsc_page {
+	u32 tsc_sequence;
+	u32 reserved1;
+	u64 tsc_scale;
+	s64 tsc_offset;
+	u64 reserved2[509];
+};
+
+/* Define the number of synthetic interrupt sources. */
+#define HV_SYNIC_SINT_COUNT		(16)
+/* Define the expected SynIC version. */
+#define HV_SYNIC_VERSION_1		(0x1)
+
+#define HV_SYNIC_CONTROL_ENABLE		(1ULL << 0)
+#define HV_SYNIC_SIMP_ENABLE		(1ULL << 0)
+#define HV_SYNIC_SIEFP_ENABLE		(1ULL << 0)
+#define HV_SYNIC_SINT_MASKED		(1ULL << 16)
+#define HV_SYNIC_SINT_AUTO_EOI		(1ULL << 17)
+#define HV_SYNIC_SINT_VECTOR_MASK	(0xFF)
+
+#define HV_SYNIC_STIMER_COUNT		(4)
+
+/* Define synthetic interrupt controller message constants. */
+#define HV_MESSAGE_SIZE			(256)
+#define HV_MESSAGE_PAYLOAD_BYTE_COUNT	(240)
+#define HV_MESSAGE_PAYLOAD_QWORD_COUNT	(30)
+
+/* Define hypervisor message types. */
+enum hv_message_type {
+	HVMSG_NONE			= 0x00000000,
+
+	/* Memory access messages. */
+	HVMSG_UNMAPPED_GPA		= 0x80000000,
+	HVMSG_GPA_INTERCEPT		= 0x80000001,
+
+	/* Timer notification messages. */
+	HVMSG_TIMER_EXPIRED		= 0x80000010,
+
+	/* Error messages. */
+	HVMSG_INVALID_VP_REGISTER_VALUE	= 0x80000020,
+	HVMSG_UNRECOVERABLE_EXCEPTION	= 0x80000021,
+	HVMSG_UNSUPPORTED_FEATURE	= 0x80000022,
+
+	/* Trace buffer complete messages. */
+	HVMSG_EVENTLOG_BUFFERCOMPLETE	= 0x80000040,
+};
+
+/* Define synthetic interrupt controller message flags. */
+union hv_message_flags {
+	__u8 asu8;
+	struct {
+		__u8 msg_pending:1;
+		__u8 reserved:7;
+	};
+};
+
+/* Define port identifier type. */
+union hv_port_id {
+	__u32 asu32;
+	struct {
+		__u32 id:24;
+		__u32 reserved:8;
+	} u;
+};
+
+/* Define synthetic interrupt controller message header. */
+struct hv_message_header {
+	__u32 message_type;
+	__u8 payload_size;
+	union hv_message_flags message_flags;
+	__u8 reserved[2];
+	union {
+		__u64 sender;
+		union hv_port_id port;
+	};
+};
+
+/* Define synthetic interrupt controller message format. */
+struct hv_message {
+	struct hv_message_header header;
+	union {
+		__u64 payload[HV_MESSAGE_PAYLOAD_QWORD_COUNT];
+	} u;
+};
+
+/* Define the synthetic interrupt message page layout. */
+struct hv_message_page {
+	struct hv_message sint_message[HV_SYNIC_SINT_COUNT];
+};
+
+/* Define timer message payload structure. */
+struct hv_timer_message_payload {
+	__u32 timer_index;
+	__u32 reserved;
+	__u64 expiration_time;	/* When the timer expired */
+	__u64 delivery_time;	/* When the message was delivered */
+};
+
+#define HV_STIMER_ENABLE		(1ULL << 0)
+#define HV_STIMER_PERIODIC		(1ULL << 1)
+#define HV_STIMER_LAZY			(1ULL << 2)
+#define HV_STIMER_AUTOENABLE		(1ULL << 3)
+#define HV_STIMER_SINT(config)		(__u8)(((config) >> 16) & 0x0F)
+
+#endif
diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
new file mode 100644
index 0000000..1428d13
--- /dev/null
+++ b/arch/arm64/include/asm/mshyperv.h
@@ -0,0 +1,291 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Linux-specific definitions for managing interactions with Microsoft's
+ * Hyper-V hypervisor. Definitions that are specified in the Hyper-V
+ * Top Level Functional Spec (TLFS) should not go in this file, but
+ * should instead go in hyperv-tlfs.h.
+ *
+ * Copyright (C) 2018, Microsoft, Inc.
+ *
+ * Author : Michael Kelley <mikelley@microsoft.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ */
+
+#ifndef _ASM_ARM64_MSHYPERV_H
+#define _ASM_ARM64_MSHYPERV_H
+
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/clocksource.h>
+#include <linux/irq.h>
+#include <linux/irqdesc.h>
+#include <asm/hyperv-tlfs.h>
+
+/*
+ * Hyper-V always runs with a page size of 4096. These definitions
+ * are used when communicating with Hyper-V using guest physical
+ * pages and guest physical page addresses, since the guest page
+ * size may not be 4096 on ARM64.
+ */
+#define HV_HYP_PAGE_SIZE	4096
+#define HV_HYP_PAGE_SHIFT	12
+#define HV_HYP_PAGE_MASK	(~(HV_HYP_PAGE_SIZE - 1))
+
+
+struct ms_hyperv_info {
+	u32 features;
+	u32 misc_features;
+	u32 hints;
+	u32 max_vp_index;
+	u32 max_lp_index;
+};
+extern struct ms_hyperv_info ms_hyperv;
+
+/*
+ * Define the IRQ numbers/vectors used by Hyper-V VMbus interrupts
+ * and by STIMER0 Direct Mode interrupts. Hyper-V should be supplying
+ * these values through ACPI, but there are no other interrupting
+ * devices in a Hyper-V VM on ARM64, so it's OK to hard code for now.
+ * The "CALLBACK_VECTOR" terminology is a left-over from the x86/x64
+ * world that is used in architecture independent Hyper-V code.
+ */
+#define HYPERVISOR_CALLBACK_VECTOR 16
+#define	HV_STIMER0_IRQNR	   17
+
+extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
+extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
+
+extern u64 hv_do_hvc(u64 control, ...);
+extern u64 hv_do_hvc_fast_get(u64 control, u64 input1, u64 input2, u64 input3,
+		struct hv_get_vp_register_output *output);
+
+/*
+ * Declare calls to get and set Hyper-V VP register values on ARM64, which
+ * requires a hypercall.
+ */
+extern void hv_set_vpreg(u32 reg, u64 value);
+extern u64 hv_get_vpreg(u32 reg);
+extern void hv_get_vpreg_128(u32 reg, struct hv_get_vp_register_output *result);
+
+/*
+ * The guest OS needs to register the guest ID with the hypervisor.
+ * The guest ID is a 64 bit entity and the structure of this ID is
+ * specified in the Hyper-V specification:
+ *
+ * msdn.microsoft.com/en-us/library/windows/hardware/ff542653%28v=vs.85%29.aspx
+ *
+ * While the current guideline does not specify how Linux guest ID(s)
+ * need to be generated, our plan is to publish the guidelines for
+ * Linux and other guest operating systems that currently are hosted
+ * on Hyper-V. The implementation here conforms to this yet
+ * unpublished guidelines.
+ *
+ *
+ * Bit(s)
+ * 63 - Indicates if the OS is Open Source or not; 1 is Open Source
+ * 62:56 - Os Type; Linux is 0x100
+ * 55:48 - Distro specific identification
+ * 47:16 - Linux kernel version number
+ * 15:0  - Distro specific identification
+ *
+ * Generate the guest ID based on the guideline described above.
+ */
+
+static inline  __u64 generate_guest_id(__u64 d_info1, __u64 kernel_version,
+				       __u64 d_info2)
+{
+	__u64 guest_id = 0;
+
+	guest_id = (((__u64)HV_LINUX_VENDOR_ID) << 48);
+	guest_id |= (d_info1 << 48);
+	guest_id |= (kernel_version << 16);
+	guest_id |= d_info2;
+
+	return guest_id;
+}
+
+
+/* Free the message slot and signal end-of-message if required */
+static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
+{
+	/*
+	 * On crash we're reading some other CPU's message page and we need
+	 * to be careful: this other CPU may already had cleared the header
+	 * and the host may already had delivered some other message there.
+	 * In case we blindly write msg->header.message_type we're going
+	 * to lose it. We can still lose a message of the same type but
+	 * we count on the fact that there can only be one
+	 * CHANNELMSG_UNLOAD_RESPONSE and we don't care about other messages
+	 * on crash.
+	 */
+	if (cmpxchg(&msg->header.message_type, old_msg_type,
+		    HVMSG_NONE) != old_msg_type)
+		return;
+
+	/*
+	 * Make sure the write to MessageType (ie set to
+	 * HVMSG_NONE) happens before we read the
+	 * MessagePending and EOMing. Otherwise, the EOMing
+	 * will not deliver any more messages since there is
+	 * no empty slot
+	 */
+	mb();
+
+	if (msg->header.message_flags.msg_pending) {
+		/*
+		 * This will cause message queue rescan to
+		 * possibly deliver another msg from the
+		 * hypervisor
+		 */
+		hv_set_vpreg(HvRegisterEom, 0);
+	}
+}
+
+/*
+ * Use the Hyper-V provided stimer0 as the timer that is made
+ * available to the architecture independent Hyper-V drivers.
+ */
+#define hv_init_timer(timer, tick) \
+		hv_set_vpreg(HvRegisterStimer0Count + (2*timer), tick)
+#define hv_init_timer_config(timer, val) \
+		hv_set_vpreg(HvRegisterStimer0Config + (2*timer), val)
+#define hv_get_current_tick(tick) \
+		(tick = hv_get_vpreg(HvRegisterTimeRefCount))
+
+#define hv_get_simp(val) (val = hv_get_vpreg(HvRegisterSipp))
+#define hv_set_simp(val) hv_set_vpreg(HvRegisterSipp, val)
+
+#define hv_get_siefp(val) (val = hv_get_vpreg(HvRegisterSifp))
+#define hv_set_siefp(val) hv_set_vpreg(HvRegisterSifp, val)
+
+#define hv_get_synic_state(val) (val = hv_get_vpreg(HvRegisterScontrol))
+#define hv_set_synic_state(val) hv_set_vpreg(HvRegisterScontrol, val)
+
+#define hv_get_vp_index(index) (index = hv_get_vpreg(HvRegisterVpIndex))
+
+/*
+ * Hyper-V SINT registers are numbered sequentially, so we can just
+ * add the SINT number to the register number of SINT0
+ */
+#define hv_get_synint_state(sint_num, val) \
+		(val = hv_get_vpreg(HvRegisterSint0 + sint_num))
+#define hv_set_synint_state(sint_num, val) \
+		hv_set_vpreg(HvRegisterSint0 + sint_num, val)
+
+void hv_setup_vmbus_irq(void (*handler)(void));
+void hv_remove_vmbus_irq(void);
+void hv_enable_vmbus_irq(void);
+void hv_disable_vmbus_irq(void);
+
+void hv_setup_kexec_handler(void (*handler)(void));
+void hv_remove_kexec_handler(void);
+void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs));
+void hv_remove_crash_handler(void);
+
+#if IS_ENABLED(CONFIG_HYPERV)
+extern struct clocksource *hyperv_cs;
+
+/*
+ * Hypervisor's notion of virtual processor ID is different from
+ * Linux' notion of CPU ID. This information can only be retrieved
+ * in the context of the calling CPU. Setup a map for easy access
+ * to this information.
+ */
+extern u32 *hv_vp_index;
+extern u32 hv_max_vp_index;
+
+/**
+ * hv_cpu_number_to_vp_number() - Map CPU to VP.
+ * @cpu_number: CPU number in Linux terms
+ *
+ * This function returns the mapping between the Linux processor
+ * number and the hypervisor's virtual processor number, useful
+ * in making hypercalls and such that talk about specific
+ * processors.
+ *
+ * Return: Virtual processor number in Hyper-V terms
+ */
+static inline int hv_cpu_number_to_vp_number(int cpu_number)
+{
+	return hv_vp_index[cpu_number];
+}
+
+void hyperv_report_panic(struct pt_regs *regs, long err);
+bool hv_is_hyperv_initialized(void);
+void hyperv_cleanup(void);
+#else /* CONFIG_HYPERV */
+static inline bool hv_is_hyperv_initialized(void) { return false; }
+static inline void hyperv_cleanup(void) {}
+#endif /* CONFIG_HYPERV */
+
+#if IS_ENABLED(CONFIG_HYPERV)
+#define hv_enable_stimer0_percpu_irq(irq)	enable_percpu_irq(irq, 0)
+#define hv_disable_stimer0_percpu_irq(irq)	disable_percpu_irq(irq)
+extern int hv_setup_stimer0_irq(int *irq, int *vector, void (*handler)(void));
+extern void hv_remove_stimer0_irq(int irq);
+#endif
+
+extern struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
+static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
+				       u64 *cur_tsc)
+{
+	u64	scale, offset;
+	u32	sequence;
+
+	/*
+	 * The protocol for reading Hyper-V TSC page is specified in Hypervisor
+	 * Top-Level Functional Specification.  To get the reference time we
+	 * must do the following:
+	 * - READ ReferenceTscSequence
+	 *   A special '0' value indicates the time source is unreliable and we
+	 *   need to use something else.
+	 * - ReferenceTime =
+	 *        ((CNTVCT_EL0) * ReferenceTscScale) >> 64) + ReferenceTscOffset
+	 * - READ ReferenceTscSequence again. In case its value has changed
+	 *   since our first reading we need to discard ReferenceTime and repeat
+	 *   the whole sequence as the hypervisor was updating the page in
+	 *   between.
+	 */
+	do {
+		sequence = READ_ONCE(tsc_pg->tsc_sequence);
+		/*
+		 * Make sure we read sequence before we read other values from
+		 * TSC page.
+		 */
+		smp_rmb();
+
+		scale = READ_ONCE(tsc_pg->tsc_scale);
+		offset = READ_ONCE(tsc_pg->tsc_offset);
+		isb();
+		*cur_tsc = read_sysreg(cntvct_el0);
+		isb();
+
+		/*
+		 * Make sure we read sequence after we read all other values
+		 * from TSC page.
+		 */
+		smp_rmb();
+
+	} while (READ_ONCE(tsc_pg->tsc_sequence) != sequence);
+
+	return mul_u64_u64_shr(*cur_tsc, scale, 64) + offset;
+}
+
+static inline u64 hv_read_tsc_page(const struct ms_hyperv_tsc_page *tsc_pg)
+{
+	u64 cur_tsc;
+
+	return hv_read_tsc_page_tsc(tsc_pg, &cur_tsc);
+}
+
+#endif
-- 
1.8.3.1

