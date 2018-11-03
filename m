Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BADC6786F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 00:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B691520840
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 00:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Qir5tYTw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B691520840
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbeKCJYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 05:24:41 -0400
Received: from mail-eopbgr730132.outbound.protection.outlook.com ([40.107.73.132]:13314
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726083AbeKCJYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 05:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYlEViU4ZmuSQJX83yUdlhsoBAxIgRoqhbAipkDZ+7E=;
 b=Qir5tYTwinXuiy7jLECgHWwIyBQVr66wgVM0dm7ZdVuACeSCkH/NApycsn+ljYAaYKRYzxE54v+AfSZBxX8C3WWRSrAcVLSa+P0cedf0nTrPNM6hw/QmkvvgeHvlMHga3PyDtybowf+LpdPXrCeEVvArlE0oIY2iWK5+Inffm7k=
Received: from MWHPR21MB0766.namprd21.prod.outlook.com (10.173.51.20) by
 MWHPR21MB0286.namprd21.prod.outlook.com (10.173.53.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1294.2; Sat, 3 Nov 2018 00:15:10 +0000
Received: from MWHPR21MB0766.namprd21.prod.outlook.com
 ([fe80::1982:5e59:2489:88e6]) by MWHPR21MB0766.namprd21.prod.outlook.com
 ([fe80::1982:5e59:2489:88e6%14]) with mapi id 15.20.1339.000; Sat, 3 Nov 2018
 00:15:10 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "will.deacon@arm.com" <will.deacon@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
CC:     Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v3 1/4] arm64: hyperv: Add core Hyper-V include files
Thread-Topic: [PATCH v3 1/4] arm64: hyperv: Add core Hyper-V include files
Thread-Index: AQHUcwpIguMAB/xr0kKwJZiEE7aaNw==
Date:   Sat, 3 Nov 2018 00:15:10 +0000
Message-ID: <1541204037-18043-2-git-send-email-mikelley@microsoft.com>
References: <1541204037-18043-1-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1541204037-18043-1-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR2201CA0011.namprd22.prod.outlook.com
 (2603:10b6:301:28::24) To MWHPR21MB0766.namprd21.prod.outlook.com
 (2603:10b6:300:76::20)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [131.107.174.136]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR21MB0286;6:yjfmk7QXStz9XYeFCEfv9iLdhVaNoO/64PW8IBUTu/7TA7izBrs2ddug67KD4egPhuQFpx0/NHXdNOyN6QP/Wl2wBgbWI5YBLZGqnRpLGmJChItzgJIaihmj+AXSFb1bCOEBNlyFVVAARElBtv4nXHejqkFW7nq3y4UbWmegYkc5NsHRVt8hr4DVqhtwIPkY5C0NN5jlaWWgZImsG45zXsFFvsiFCitNYwdYKWXjyk6LoJrJ4XLA/YOTtbRTE8Z2ZdKWYEYPOdAx3jt79/213XdktRVWc3ywmZX86vBLamHXrp/MkvEy2mz+lDmWFPMs7EaO6h7zpnLAqvOjZnvgs7GPODxIt5/lewXmm/wSg5YRtvUvbqZvtTrDtZwPthHHwyFLtGmiDWakg2t+mcfZN1hs0V+zVDhnyNyRwqtfbKzVE04gUR4zX7eEri8kj++ysQfgxa708K9GVsHAPtSI/w==;5:GjGD4+x/JkW2+2fcdhixuEZky+fXIDp8pHxf4aEKFFNCzWm6f1q9El6vGoKQwnPFXaU2sdpWBT5XFYOC1GhkPoEH6AnchbbzujYpy7C8ap16ZchHGa7kq5YpULG3dXNoX5dLtrm9rjqbLCDDQCvtekM7zkE8bNlZkT7Tgfn/az8=;7:xLUN3dZ137JEBwrUdpSfRrZduARnh7UQ5wLNI+KaIh9PC5HqrUf0KCExTLRQc6J+TJtwlh6LQf5vwGYAn2nHcaYpGYXimed2g5AGGSDq52CFONl2NVhAAQe2xy/WJLLqtIbjiQvOloTcyIlsg+eRGw==
x-ms-office365-filtering-correlation-id: c831a45f-d63e-4a4b-0839-08d641216aa8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR21MB0286;
x-ms-traffictypediagnostic: MWHPR21MB0286:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-o365eop-header: O365_EOP: Allow for Unauthenticated Relay
x-o365ent-eop-header: Message processed by -  O365_ENT: Allow from ranges
 (Engineering ONLY)
x-microsoft-antispam-prvs: <MWHPR21MB02862581319583E19EE28FDDD7C80@MWHPR21MB0286.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(176295241369792)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(8121501046)(5005006)(10201501046)(3231382)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:MWHPR21MB0286;BCL:0;PCL:0;RULEID:;SRVR:MWHPR21MB0286;
x-forefront-prvs: 08457955C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(136003)(366004)(39860400002)(189003)(199004)(6506007)(316002)(386003)(2501003)(7736002)(81156014)(81166006)(2201001)(22452003)(2900100001)(99286004)(66066001)(8936002)(53936002)(53946003)(476003)(3846002)(14454004)(110136005)(10090500001)(36756003)(76176011)(5660300001)(6636002)(575784001)(1511001)(86362001)(305945005)(8676002)(52116002)(86612001)(11346002)(6116002)(4326008)(14444005)(7416002)(256004)(97736004)(102836004)(486006)(10290500003)(71200400001)(71190400001)(4744004)(6306002)(6512007)(6486002)(25786009)(186003)(105586002)(26005)(2616005)(107886003)(68736007)(446003)(478600001)(106356001)(966005)(2906002)(6436002)(2004002)(921003)(1121003)(579004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0286;H:MWHPR21MB0766.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lZkh+HypaxS70wmY8qMQhLBCKtMnkx9jTYwZGf2EHO1ppxMUz1tq3o/47G2htiTgHiejysZsjmK07uM/zsuYBti+wNA9fvONyulmYneKeeSP7Vcq7NtZv4TOS8PQFXBfRN9//BpJP4MVczcaYBNyJoT5zeafEaPqnO/ftEDm11sZ3KIAaZut7d+RtCyzmfNzPFwlP6yaVVzfTcL/6ABn2baU9VfUaKV8Kmwqjy7JyU6p03i26okCZXu8UIKTjy3o4QJ62245xGdfUydq9QXvAj0Z6CPI8KJGTkneC+Z1/XtUIBxq/Z0WZ1Qt6i//BvoLiKbcJqHD1/DtbaQH/glyH/DLE9NyRicoJH1npBNZlKg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c831a45f-d63e-4a4b-0839-08d641216aa8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2018 00:15:10.0658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0286
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
interacting with Hyper-V. It is split into an ARM64 specific file
and an architecture independent file in include/asm-generic.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 MAINTAINERS                          |   3 +
 arch/arm64/include/asm/hyperv-tlfs.h | 338 +++++++++++++++++++++++++++++++=
++++
 arch/arm64/include/asm/mshyperv.h    | 116 ++++++++++++
 include/asm-generic/mshyperv.h       | 240 +++++++++++++++++++++++++
 4 files changed, 697 insertions(+)
 create mode 100644 arch/arm64/include/asm/hyperv-tlfs.h
 create mode 100644 arch/arm64/include/asm/mshyperv.h
 create mode 100644 include/asm-generic/mshyperv.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 25c090e..00c7bad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6798,6 +6798,8 @@ F:	arch/x86/include/asm/trace/hyperv.h
 F:	arch/x86/include/asm/hyperv-tlfs.h
 F:	arch/x86/kernel/cpu/mshyperv.c
 F:	arch/x86/hyperv
+F:	arch/arm64/include/asm/hyperv-tlfs.h
+F:	arch/arm64/include/asm/mshyperv.h
 F:	drivers/hid/hid-hyperv.c
 F:	drivers/hv/
 F:	drivers/input/serio/hyperv-keyboard.c
@@ -6809,6 +6811,7 @@ F:	drivers/video/fbdev/hyperv_fb.c
 F:	net/vmw_vsock/hyperv_transport.c
 F:	include/linux/hyperv.h
 F:	include/uapi/linux/hyperv.h
+F:	include/asm-generic/mshyperv.h
 F:	tools/hv/
 F:	Documentation/ABI/stable/sysfs-bus-vmbus
=20
diff --git a/arch/arm64/include/asm/hyperv-tlfs.h b/arch/arm64/include/asm/=
hyperv-tlfs.h
new file mode 100644
index 0000000..1430798
--- /dev/null
+++ b/arch/arm64/include/asm/hyperv-tlfs.h
@@ -0,0 +1,338 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * This file contains definitions from the Hyper-V Hypervisor Top-Level
+ * Functional Specification (TLFS):
+ * https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/refe=
rence/tlfs
+ *
+ * Copyright (C) 2018, Microsoft, Inc.
+ *
+ * Author : Michael Kelley <mikelley@microsoft.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as publishe=
d
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
+#define HV_REGISTER_HYPERVISOR_VERSION		0x00000100 /*CPUID 0x40000002 */
+#define	HV_REGISTER_PRIVILEGES_AND_FEATURES	0x00000200 /*CPUID 0x40000003 =
*/
+#define	HV_REGISTER_FEATURES			0x00000201 /*CPUID 0x40000004 */
+#define	HV_REGISTER_IMPLEMENTATION_LIMITS	0x00000202 /*CPUID 0x40000005 */
+#define HV_ARM64_REGISTER_INTERFACE_VERSION	0x00090006 /*CPUID 0x40000001 =
*/
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
+ * Synthetic register definitions equivalent to MSRs on x86/x64
+ */
+#define HV_REGISTER_CRASH_P0		0x00000210
+#define HV_REGISTER_CRASH_P1		0x00000211
+#define HV_REGISTER_CRASH_P2		0x00000212
+#define HV_REGISTER_CRASH_P3		0x00000213
+#define HV_REGISTER_CRASH_P4		0x00000214
+#define HV_REGISTER_CRASH_CTL		0x00000215
+
+#define HV_REGISTER_GUEST_OSID		0x00090002
+#define HV_REGISTER_VPINDEX		0x00090003
+#define HV_REGISTER_TIME_REFCOUNT	0x00090004
+#define HV_REGISTER_REFERENCE_TSC	0x00090017
+
+#define HV_REGISTER_SINT0		0x000A0000
+#define HV_REGISTER_SINT1		0x000A0001
+#define HV_REGISTER_SINT2		0x000A0002
+#define HV_REGISTER_SINT3		0x000A0003
+#define HV_REGISTER_SINT4		0x000A0004
+#define HV_REGISTER_SINT5		0x000A0005
+#define HV_REGISTER_SINT6		0x000A0006
+#define HV_REGISTER_SINT7		0x000A0007
+#define HV_REGISTER_SINT8		0x000A0008
+#define HV_REGISTER_SINT9		0x000A0009
+#define HV_REGISTER_SINT10		0x000A000A
+#define HV_REGISTER_SINT11		0x000A000B
+#define HV_REGISTER_SINT12		0x000A000C
+#define HV_REGISTER_SINT13		0x000A000D
+#define HV_REGISTER_SINT14		0x000A000E
+#define HV_REGISTER_SINT15		0x000A000F
+#define HV_REGISTER_SCONTROL		0x000A0010
+#define HV_REGISTER_SVERSION		0x000A0011
+#define HV_REGISTER_SIFP		0x000A0012
+#define HV_REGISTER_SIPP		0x000A0013
+#define HV_REGISTER_EOM			0x000A0014
+#define HV_REGISTER_SIRBP		0x000A0015
+
+#define HV_REGISTER_STIMER0_CONFIG	0x000B0000
+#define HV_REGISTER_STIMER0_COUNT	0x000B0001
+#define HV_REGISTER_STIMER1_CONFIG	0x000B0002
+#define HV_REGISTER_STIMER1_COUNT	0x000B0003
+#define HV_REGISTER_STIMER2_CONFIG	0x000B0004
+#define HV_REGISTER_STIMER2_COUNT	0x000B0005
+#define HV_REGISTER_STIMER3_CONFIG	0x000B0006
+#define HV_REGISTER_STIMER3_COUNT	0x000B0007
+
+/*
+ * Crash notification flags.
+ */
+#define HV_CRASH_CTL_CRASH_NOTIFY_MSG	BIT_ULL(62)
+#define HV_CRASH_CTL_CRASH_NOTIFY	BIT_ULL(63)
+
+/*
+ * The guest OS needs to register the guest ID with the hypervisor.
+ * The guest ID is a 64 bit entity and the structure of this ID is
+ * specified in the Hyper-V specification:
+ *
+ * msdn.microsoft.com/en-us/library/windows/hardware/ff542653%28v=3Dvs.85%=
29.aspx
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
+	HVMSG_NONE			=3D 0x00000000,
+
+	/* Memory access messages. */
+	HVMSG_UNMAPPED_GPA		=3D 0x80000000,
+	HVMSG_GPA_INTERCEPT		=3D 0x80000001,
+
+	/* Timer notification messages. */
+	HVMSG_TIMER_EXPIRED		=3D 0x80000010,
+
+	/* Error messages. */
+	HVMSG_INVALID_VP_REGISTER_VALUE	=3D 0x80000020,
+	HVMSG_UNRECOVERABLE_EXCEPTION	=3D 0x80000021,
+	HVMSG_UNSUPPORTED_FEATURE	=3D 0x80000022,
+
+	/* Trace buffer complete messages. */
+	HVMSG_EVENTLOG_BUFFERCOMPLETE	=3D 0x80000040,
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
diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/msh=
yperv.h
new file mode 100644
index 0000000..a87c431
--- /dev/null
+++ b/arch/arm64/include/asm/mshyperv.h
@@ -0,0 +1,116 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Linux-specific definitions for managing interactions with Microsoft's
+ * Hyper-V hypervisor. The definitions in this file are specific to
+ * the ARM64 architecture.  See include/asm-generic/mshyperv.h for
+ * definitions are that architecture independent.
+ *
+ * Definitions that are specified in the Hyper-V Top Level Functional
+ * Spec (TLFS) should not go in this file, but should instead go in
+ * hyperv-tlfs.h.
+ *
+ * Copyright (C) 2018, Microsoft, Inc.
+ *
+ * Author : Michael Kelley <mikelley@microsoft.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as publishe=
d
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
+extern u64 hv_do_hvc(u64 control, ...);
+extern u64 hv_do_hvc_fast_get(u64 control, u64 input1, u64 input2, u64 inp=
ut3,
+		struct hv_get_vp_register_output *output);
+
+/*
+ * Declare calls to get and set Hyper-V VP register values on ARM64, which
+ * requires a hypercall.
+ */
+extern void hv_set_vpreg(u32 reg, u64 value);
+extern u64 hv_get_vpreg(u32 reg);
+extern void hv_get_vpreg_128(u32 reg, struct hv_get_vp_register_output *re=
sult);
+
+/*
+ * Use the Hyper-V provided stimer0 as the timer that is made
+ * available to the architecture independent Hyper-V drivers.
+ */
+#define hv_init_timer(timer, tick) \
+		hv_set_vpreg(HV_REGISTER_STIMER0_COUNT + (2*timer), tick)
+#define hv_init_timer_config(timer, val) \
+		hv_set_vpreg(HV_REGISTER_STIMER0_CONFIG + (2*timer), val)
+#define hv_get_current_tick(tick) \
+		(tick =3D hv_get_vpreg(HV_REGISTER_TIME_REFCOUNT))
+
+#define hv_get_simp(val) (val =3D hv_get_vpreg(HV_REGISTER_SIPP))
+#define hv_set_simp(val) hv_set_vpreg(HV_REGISTER_SIPP, val)
+
+#define hv_get_siefp(val) (val =3D hv_get_vpreg(HV_REGISTER_SIFP))
+#define hv_set_siefp(val) hv_set_vpreg(HV_REGISTER_SIFP, val)
+
+#define hv_get_synic_state(val) (val =3D hv_get_vpreg(HV_REGISTER_SCONTROL=
))
+#define hv_set_synic_state(val) hv_set_vpreg(HV_REGISTER_SCONTROL, val)
+
+#define hv_get_vp_index(index) (index =3D hv_get_vpreg(HV_REGISTER_VPINDEX=
))
+
+#define hv_signal_eom()	hv_set_vpreg(HV_REGISTER_EOM, 0)
+
+/*
+ * Hyper-V SINT registers are numbered sequentially, so we can just
+ * add the SINT number to the register number of SINT0
+ */
+#define hv_get_synint_state(sint_num, val) \
+		(val =3D hv_get_vpreg(HV_REGISTER_SINT0 + sint_num))
+#define hv_set_synint_state(sint_num, val) \
+		hv_set_vpreg(HV_REGISTER_SINT0 + sint_num, val)
+
+#define hv_get_crash_ctl(val) \
+		(val =3D hv_get_vpreg(HV_REGISTER_CRASH_CTL))
+
+#if IS_ENABLED(CONFIG_HYPERV)
+#define hv_enable_stimer0_percpu_irq(irq)	enable_percpu_irq(irq, 0)
+#define hv_disable_stimer0_percpu_irq(irq)	disable_percpu_irq(irq)
+#endif
+
+/* ARM64 specific code to read the hardware clock */
+static inline u64 hv_read_hwclock(void)
+{
+	u64 result;
+
+	isb();
+	result =3D read_sysreg(cntvct_el0);
+	isb();
+
+	return result;
+}
+
+#include <asm-generic/mshyperv.h>
+
+#endif
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.=
h
new file mode 100644
index 0000000..fbe1ec8
--- /dev/null
+++ b/include/asm-generic/mshyperv.h
@@ -0,0 +1,240 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Linux-specific definitions for managing interactions with Microsoft's
+ * Hyper-V hypervisor. The definitions in this file are architecture
+ * independent. See arch/<arch>/include/asm/mshyperv.h for definitions
+ * that are specific to architecture <arch>.
+ *
+ * Definitions that are specified in the Hyper-V Top Level Functional
+ * Spec (TLFS) should not go in this file, but should instead go in
+ * hyperv-tlfs.h.
+ *
+ * Copyright (C) 2018, Microsoft, Inc.
+ *
+ * Author : Michael Kelley <mikelley@microsoft.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as publishe=
d
+ * by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ */
+
+#ifndef _ASM_GENERIC_MSHYPERV_H
+#define _ASM_GENERIC_MSHYPERV_H
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
+extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr)=
;
+extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
+
+/*
+ * The guest OS needs to register the guest ID with the hypervisor.
+ * The guest ID is a 64 bit entity and the structure of this ID is
+ * specified in the Hyper-V specification:
+ *
+ * msdn.microsoft.com/en-us/library/windows/hardware/ff542653%28v=3Dvs.85%=
29.aspx
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
+static inline  __u64 generate_guest_id(__u64 d_info1, __u64 kernel_version=
,
+				       __u64 d_info2)
+{
+	__u64 guest_id =3D 0;
+
+	guest_id =3D (((__u64)HV_LINUX_VENDOR_ID) << 48);
+	guest_id |=3D (d_info1 << 48);
+	guest_id |=3D (kernel_version << 16);
+	guest_id |=3D d_info2;
+
+	return guest_id;
+}
+
+
+/* Free the message slot and signal end-of-message if required */
+static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_ty=
pe)
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
+		    HVMSG_NONE) !=3D old_msg_type)
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
+		hv_signal_eom();
+	}
+}
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
+/* Sentinel value for an uninitialized entry in hv_vp_index array */
+#define VP_INVAL	U32_MAX
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
+void hyperv_report_panic_msg(phys_addr_t pa, size_t size);
+bool hv_is_hyperv_initialized(void);
+void hyperv_cleanup(void);
+#else /* CONFIG_HYPERV */
+static inline bool hv_is_hyperv_initialized(void) { return false; }
+static inline void hyperv_cleanup(void) {}
+#endif /* CONFIG_HYPERV */
+
+#if IS_ENABLED(CONFIG_HYPERV)
+extern int hv_setup_stimer0_irq(int *irq, int *vector, void (*handler)(voi=
d));
+extern void hv_remove_stimer0_irq(int irq);
+#endif
+
+static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *ts=
c_pg,
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
+	 * - ReferenceTime =3D
+	 *     ((HWclock val) * ReferenceTscScale) >> 64) + ReferenceTscOffset
+	 * - READ ReferenceTscSequence again. In case its value has changed
+	 *   since our first reading we need to discard ReferenceTime and repeat
+	 *   the whole sequence as the hypervisor was updating the page in
+	 *   between.
+	 */
+	do {
+		sequence =3D READ_ONCE(tsc_pg->tsc_sequence);
+		/*
+		 * Make sure we read sequence before we read other values from
+		 * TSC page.
+		 */
+		smp_rmb();
+
+		scale =3D READ_ONCE(tsc_pg->tsc_scale);
+		offset =3D READ_ONCE(tsc_pg->tsc_offset);
+		*cur_tsc =3D hv_read_hwclock();
+
+		/*
+		 * Make sure we read sequence after we read all other values
+		 * from TSC page.
+		 */
+		smp_rmb();
+
+	} while (READ_ONCE(tsc_pg->tsc_sequence) !=3D sequence);
+
+	return mul_u64_u64_shr(*cur_tsc, scale, 64) + offset;
+}
+
+static inline u64 hv_read_tsc_page(const struct ms_hyperv_tsc_page *tsc_pg=
)
+{
+	u64 cur_tsc;
+
+	return hv_read_tsc_page_tsc(tsc_pg, &cur_tsc);
+}
+
+#endif
--=20
1.8.3.1

