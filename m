Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09227C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F76820838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="TElD6OZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F76820838
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbeH3W1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:27:04 -0400
Received: from mail-sn1nam01on0117.outbound.protection.outlook.com ([104.47.32.117]:62560
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728135AbeH3W1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGxHgsiWTXFI6hg9z633Z2SF+YCW6Sl5CjS+bbJhbjk=;
 b=TElD6OZjcKIrLjOZAU1Qk1vEggtngSS0Jh4xIf73ZRdu4xpxnX6CXowCUVHDEQpwqtuoDPs36NzWjjsggbA6g/xdQu50ehY8wJY7ZpEJmX+5IBqLWJ6Uctsk6Zy1Fx1bB/3tq8mmBgu20IPHSX2t0hbY2MmPlWZgKy+765eWBtA=
Received: from MW2PR2101MB1113.namprd21.prod.outlook.com (52.132.149.30) by
 MW2PR2101MB0906.namprd21.prod.outlook.com (52.132.152.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Thu, 30 Aug 2018 18:23:26 +0000
Received: from MW2PR2101MB1113.namprd21.prod.outlook.com
 ([fe80::9005:3b61:42d7:1fe1]) by MW2PR2101MB1113.namprd21.prod.outlook.com
 ([fe80::9005:3b61:42d7:1fe1%4]) with mapi id 15.20.1122.009; Thu, 30 Aug 2018
 18:23:26 +0000
From:   KY Srinivasan <kys@microsoft.com>
To:     "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
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
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: RE: [PATCH v2 1/4] arm64: hyperv: Add core Hyper-V include files
Thread-Topic: [PATCH v2 1/4] arm64: hyperv: Add core Hyper-V include files
Thread-Index: AQHUP68Ozsma7NTY6kCqWE/cAPw7gqTYii3A
Date:   Thu, 30 Aug 2018 18:23:26 +0000
Message-ID: <MW2PR2101MB1113C65A74A961624C865B8CA0080@MW2PR2101MB1113.namprd21.prod.outlook.com>
References: <1535556148-10452-1-git-send-email-mikelley@microsoft.com>
 <1535556148-10452-2-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1535556148-10452-2-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [73.136.232.39]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0906;6:OAmf2+wYiQB5l2iRXAyyD49dRkkzbwpTp3qDCJ5eFrxd3jEQ+5cK/h1XNBPBJqM3OH3uHLCOXJ4JUs7S8VBXC1eGBkKkZVYGU5g2OWTPvQQRh9mF5fjkhczRZqN9nEItLE3m10iZivo8j84D4D7AcXoxKi1olEv6m8qg2DtMNFVQ3aFngFlGngFay8kWFnUcxzS6U3s+wFnvqe3e2iCWaL2ILahooabXnjxq6j4xhA2yII1kNhpA64gtXG3dKcK9BxL+sNyO16WFcJ/Gu6ozzFtRpcLI/jUfL3yUOu4zsRDL0K3Jfmra+/NnJKTbZ6+/dnbKeo0vLdNmRCrNcH7Q270ZXA8qyjhXp45s9/2qyi4xjf4Gxu/MGRK0WAUiZhmTdd/IM6H3E/9eB5tUaOAoBe3eMSlDjBbkFzzpKGCznKxzMBdPzzFXt9D22yeldwiB1djcm3nFb0eKQp7R0YQxow==;5:OdBdVx44qsOn1cKe/KMnCzYCWhwknRygS9P4LCcS/sssP9BrwZl10HqciQScrPYoukvmBL9n9KNZRNWy7UTtXIZqU5TKCOjLEW9O81QyVpTLAvtYCwfsTyqPOazFTGHZVeSUPuSYRtsIJpwDHlRuYBz/nFd9vIzCy8/8q4VmN7Q=;7:dQWRicjSQimX1UhWDY2KKTm/VhyixJgoPHi9w+r6wxxzH/rV+61lj6jyqLGnI7gWKqBrUdK+T/Dm+pfHy4vfszRtQn65sqy56cQhd2/t73llQKooZgUu+6YRrqKNS50JVVIg6dRC0TlvvjPVbdYx56K8cN05YpqNqtZBQUaN67VvZscjSR65iMMl9g97s61RC2X77T5UG6Vl7pkW6NuhSK9+j2rKih4cMGGyIeqe06Aojz8WKgtzPmWuXXePpsoH
x-ms-office365-filtering-correlation-id: 6ffb8f4b-9bcc-44d9-732e-08d60ea5add3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB0906;
x-ms-traffictypediagnostic: MW2PR2101MB0906:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB0906AD2676DE36EE8028F1BFA0080@MW2PR2101MB0906.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(9452136761055)(189930954265078)(85827821059158)(258649278758335)(176295241369792)(219752817060721)(198206253151910);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:MW2PR2101MB0906;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0906;
x-forefront-prvs: 07807C55DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(136003)(346002)(396003)(366004)(13464003)(189003)(199004)(3846002)(8676002)(476003)(5660300001)(6116002)(1511001)(55016002)(5250100002)(81156014)(81166006)(22452003)(8936002)(102836004)(53546011)(305945005)(74316002)(6246003)(11346002)(6506007)(10090500001)(446003)(14444005)(68736007)(97736004)(66066001)(33656002)(19627235002)(486006)(316002)(53946003)(110136005)(6636002)(6306002)(9686003)(2501003)(25786009)(53936002)(256004)(14454004)(106356001)(99286004)(229853002)(105586002)(2906002)(7416002)(10290500003)(575784001)(2201001)(86362001)(7736002)(6346003)(26005)(8990500004)(2900100001)(45954006)(966005)(86612001)(7696005)(76176011)(478600001)(6436002)(921003)(2004002)(1121003)(559001)(579004);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0906;H:MW2PR2101MB1113.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com; 
x-microsoft-antispam-message-info: eBzCfVuZTWugGZWHhc1RahK9QLDjq3jNXAINMuFVaKQmjvJ4MfR38ZlFW3lLPXoGnH1q7nWgcoacwUMjMEZw01ihQ0DMX+iACNiFqgdDfNAmoK4EgrI1eVDoH1diQZeHyWrP9+TnpPdndd9NCyO/A99tmAyI67/cZVrqhXQCMEzuuVJvmMS95ysddTNitVi5VUSTVeEy9FPm142rArOxXwsuOHR4UARfkvIk0S01VxG7HBifVOJFwHsezRgbHVB+g6bGHJv/GVao0aWqnibLitEayC9xt3ZKxi8zSA2/Nq8wnHOTgjuZ0ZtHdudgwpq0eB3Qs+g+1N0pfPHKgwe7yir7ucLM718Un83IqMKp46E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ffb8f4b-9bcc-44d9-732e-08d60ea5add3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2018 18:23:26.7121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0906
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: mhkelley58@gmail.com <mhkelley58@gmail.com>
> Sent: Wednesday, August 29, 2018 10:22 AM
> To: will.deacon@arm.com; catalin.marinas@arm.com;
> mark.rutland@arm.com; marc.zyngier@arm.com; linux-arm-
> kernel@lists.infradead.org; gregkh@linuxfoundation.org; linux-
> kernel@vger.kernel.org; devel@linuxdriverproject.org; olaf@aepfle.de;
> apw@canonical.com; vkuznets <vkuznets@redhat.com>;
> jasowang@redhat.com; marcelo.cerri@canonical.com; Stephen Hemminger
> <sthemmin@microsoft.com>; KY Srinivasan <kys@microsoft.com>
> Cc: Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>
> Subject: [PATCH v2 1/4] arm64: hyperv: Add core Hyper-V include files
>=20
> From: Michael Kelley <mikelley@microsoft.com>
>=20
> hyperv-tlfs.h defines Hyper-V interfaces from the Hyper-V Top Level
> Functional Spec (TLFS). The TLFS is distinctly oriented to x86/x64,
> and Hyper-V has not separated out the architecture-dependent parts into
> x86/x64 vs. ARM64. So hyperv-tlfs.h includes information for ARM64
> that is not yet formally published. The TLFS is available here:
>=20
>   docs.microsoft.com/en-us/virtualization/hyper-v-on-
> windows/reference/tlfs
>=20
> mshyperv.h defines Linux-specific structures and routines for
> interacting with Hyper-V on ARM64.
>=20
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> Reviewed-by: James Morris <jmorris@namei.org>
> ---
>  MAINTAINERS                          |   2 +
>  arch/arm64/include/asm/hyperv-tlfs.h | 338
> +++++++++++++++++++++++++++++++++++
>  arch/arm64/include/asm/mshyperv.h    | 295
> ++++++++++++++++++++++++++++++
>  3 files changed, 635 insertions(+)
>  create mode 100644 arch/arm64/include/asm/hyperv-tlfs.h
>  create mode 100644 arch/arm64/include/asm/mshyperv.h
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8bef28b..c8db9be 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6775,6 +6775,8 @@ F:	arch/x86/include/asm/trace/hyperv.h
>  F:	arch/x86/include/asm/hyperv-tlfs.h
>  F:	arch/x86/kernel/cpu/mshyperv.c
>  F:	arch/x86/hyperv
> +F:	arch/arm64/include/asm/hyperv-tlfs.h
> +F:	arch/arm64/include/asm/mshyperv.h
>  F:	drivers/hid/hid-hyperv.c
>  F:	drivers/hv/
>  F:	drivers/input/serio/hyperv-keyboard.c
> diff --git a/arch/arm64/include/asm/hyperv-tlfs.h
> b/arch/arm64/include/asm/hyperv-tlfs.h
> new file mode 100644
> index 0000000..6f46829
> --- /dev/null
> +++ b/arch/arm64/include/asm/hyperv-tlfs.h
> @@ -0,0 +1,338 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * This file contains definitions from the Hyper-V Hypervisor Top-Level
> + * Functional Specification (TLFS):
> + *
> https://na01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fdocs.
> microsoft.com%2Fen-us%2Fvirtualization%2Fhyper-v-on-
> windows%2Freference%2Ftlfs&amp;data=3D02%7C01%7Ckys%40microsoft.co
> m%7C97234dd1d1ca4ea5479f08d60dc62f1f%7C72f988bf86f141af91ab2d7cd01
> 1db47%7C1%7C0%7C636711542195781827&amp;sdata=3DJOwMHsJSmkwuflaJH
> qgFGHa6Wd1E7k608YK4P6KY5Xs%3D&amp;reserved=3D0
> + *
> + * Copyright (C) 2018, Microsoft, Inc.
> + *
> + * Author : Michael Kelley <mikelley@microsoft.com>
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms of the GNU General Public License version 2 as
> published
> + * by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD
> TITLE or
> + * NON INFRINGEMENT.  See the GNU General Public License for more
> + * details.
> + */
> +
A lot of TLFS definitions are ISA independent and we are duplicating these =
definitions both for X86_64 and ARM_64.
Perhaps we should look at splitting this file into a common and ISA specifi=
c header file.

> +#ifndef _ASM_ARM64_HYPERV_H
> +#define _ASM_ARM64_HYPERV_H
> +
> +#include <linux/types.h>
> +
> +/*
> + * These Hyper-V registers provide information equivalent to the CPUID
> + * instruction on x86/x64.
> + */
> +#define HvRegisterHypervisorVersion		0x00000100 /*CPUID
> 0x40000002 */
> +#define	HvRegisterPrivilegesAndFeaturesInfo	0x00000200 /*CPUID
> 0x40000003 */
> +#define	HvRegisterFeaturesInfo			0x00000201
> /*CPUID 0x40000004 */
> +#define	HvRegisterImplementationLimitsInfo	0x00000202 /*CPUID
> 0x40000005 */
> +#define HvARM64RegisterInterfaceVersion		0x00090006 /*CPUID
> 0x40000001 */

Can we avoid the mixed case names.
> +
> +/*
> + * Feature identification. HvRegisterPrivilegesAndFeaturesInfo returns a
> + * 128-bit value with flags indicating which features are available to t=
he
> + * partition based upon the current partition privileges. The 128-bit
> + * value is broken up with different portions stored in different 32-bit
> + * fields in the ms_hyperv structure.
> + */
> +
> +/* Partition Reference Counter available*/
> +#define HV_MSR_TIME_REF_COUNT_AVAILABLE		(1 << 1)
> +
> +/*
> + * Synthetic Timers available
> + */
> +#define HV_MSR_SYNTIMER_AVAILABLE		(1 << 3)
> +
> +/* Frequency MSRs available */
> +#define HV_FEATURE_FREQUENCY_MSRS_AVAILABLE	(1 << 8)
> +
> +/* Reference TSC available */
> +#define HV_MSR_REFERENCE_TSC_AVAILABLE		(1 << 9)
> +
> +/* Crash MSR available */
> +#define HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE	(1 << 10)
> +
> +
> +/*
> + * This group of flags is in the high order 64-bits of the returned
> + * 128-bit value.
> + */
> +
> +/* STIMER direct mode is available */
> +#define HV_STIMER_DIRECT_MODE_AVAILABLE		(1 << 19)
> +
> +/*
> + * Implementation recommendations in register
> + * HvRegisterFeaturesInfo. Indicates which behaviors the hypervisor
> + * recommends the OS implement for optimal performance.
> + */
> +
> +/*
> + * Recommend not using Auto EOI
> + */
> +#define HV_DEPRECATING_AEOI_RECOMMENDED		(1 << 9)
> +
> +/*
> + * Synthetic register definitions equivalent to MSRs on x86/x64
> + */
> +#define HvRegisterCrashP0       0x00000210
> +#define HvRegisterCrashP1       0x00000211
> +#define HvRegisterCrashP2       0x00000212
> +#define HvRegisterCrashP3       0x00000213
> +#define HvRegisterCrashP4       0x00000214
> +#define HvRegisterCrashCtl      0x00000215
> +
> +#define HvRegisterGuestOsId     0x00090002
> +#define HvRegisterVpIndex       0x00090003
> +#define HvRegisterTimeRefCount  0x00090004
> +#define HvRegisterReferenceTsc	0x00090017
> +
> +#define HvRegisterSint0         0x000A0000
> +#define HvRegisterSint1         0x000A0001
> +#define HvRegisterSint2         0x000A0002
> +#define HvRegisterSint3         0x000A0003
> +#define HvRegisterSint4         0x000A0004
> +#define HvRegisterSint5         0x000A0005
> +#define HvRegisterSint6         0x000A0006
> +#define HvRegisterSint7         0x000A0007
> +#define HvRegisterSint8         0x000A0008
> +#define HvRegisterSint9         0x000A0009
> +#define HvRegisterSint10        0x000A000A
> +#define HvRegisterSint11        0x000A000B
> +#define HvRegisterSint12        0x000A000C
> +#define HvRegisterSint13        0x000A000D
> +#define HvRegisterSint14        0x000A000E
> +#define HvRegisterSint15        0x000A000F
> +#define HvRegisterScontrol      0x000A0010
> +#define HvRegisterSversion      0x000A0011
> +#define HvRegisterSifp          0x000A0012
> +#define HvRegisterSipp          0x000A0013
> +#define HvRegisterEom           0x000A0014
> +#define HvRegisterSirbp         0x000A0015
> +
> +#define HvRegisterStimer0Config 0x000B0000
> +#define HvRegisterStimer0Count  0x000B0001
> +#define HvRegisterStimer1Config 0x000B0002
> +#define HvRegisterStimer1Count  0x000B0003
> +#define HvRegisterStimer2Config 0x000B0004
> +#define HvRegisterStimer2Count  0x000B0005
> +#define HvRegisterStimer3Config 0x000B0006
> +#define HvRegisterStimer3Count  0x000B0007
> +
> +/*
> + * Crash notification flags.
> + */
> +#define HV_CRASH_CTL_CRASH_NOTIFY_MSG	BIT_ULL(62)
> +#define HV_CRASH_CTL_CRASH_NOTIFY	BIT_ULL(63)
> +
> +/*
> + * The guest OS needs to register the guest ID with the hypervisor.
> + * The guest ID is a 64 bit entity and the structure of this ID is
> + * specified in the Hyper-V specification:
> + *
> + * msdn.microsoft.com/en-
> us/library/windows/hardware/ff542653%28v=3Dvs.85%29.aspx
> + *
> + * While the current guideline does not specify how Linux guest ID(s)
> + * need to be generated, our plan is to publish the guidelines for
> + * Linux and other guest operating systems that currently are hosted
> + * on Hyper-V. The implementation here conforms to this yet
> + * unpublished guidelines.
> + *
> + *
> + * Bit(s)
> + * 63 - Indicates if the OS is Open Source or not; 1 is Open Source
> + * 62:56 - Os Type; Linux is 0x100
> + * 55:48 - Distro specific identification
> + * 47:16 - Linux kernel version number
> + * 15:0  - Distro specific identification
> + *
> + *
> + */
> +#define HV_LINUX_VENDOR_ID              0x8100
> +
> +/* Declare the various hypercall operations. */
> +#define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE	0x0002
> +#define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST	0x0003
> +#define HVCALL_NOTIFY_LONG_SPIN_WAIT		0x0008
> +#define HVCALL_SEND_IPI				0x000b
> +#define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX	0x0013
> +#define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX	0x0014
> +#define HVCALL_SEND_IPI_EX			0x0015
> +#define HVCALL_GET_VP_REGISTERS			0x0050
> +#define HVCALL_SET_VP_REGISTERS			0x0051
> +#define HVCALL_POST_MESSAGE			0x005c
> +#define HVCALL_SIGNAL_EVENT			0x005d
> +#define HVCALL_RETARGET_INTERRUPT		0x007e
> +#define HVCALL_START_VIRTUAL_PROCESSOR		0x0099
> +#define HVCALL_GET_VP_INDEX_FROM_APICID		0x009a
> +
> +/* Declare standard hypercall field values. */
> +#define HV_PARTITION_ID_SELF                    ((u64)-1)
> +#define HV_VP_INDEX_SELF                        ((u32)-2)
> +
> +#define HV_HYPERCALL_FAST_BIT                   BIT(16)
> +#define HV_HYPERCALL_REP_COUNT_1                BIT_ULL(32)
> +#define HV_HYPERCALL_RESULT_MASK                GENMASK_ULL(15, 0)
> +
> +/* Define the hypercall status result */
> +
> +union hv_hypercall_status {
> +	u64 as_uint64;
> +	struct {
> +		u16 status;
> +		u16 reserved;
> +		u16 reps_completed;  /* Low 12 bits */
> +		u16 reserved2;
> +	};
> +};
> +
> +/* hypercall status code */
> +#define HV_STATUS_SUCCESS			0
> +#define HV_STATUS_INVALID_HYPERCALL_CODE	2
> +#define HV_STATUS_INVALID_HYPERCALL_INPUT	3
> +#define HV_STATUS_INVALID_ALIGNMENT		4
> +#define HV_STATUS_INSUFFICIENT_MEMORY		11
> +#define HV_STATUS_INVALID_CONNECTION_ID		18
> +#define HV_STATUS_INSUFFICIENT_BUFFERS		19
> +
> +/* Define output layout for Get VP Register hypercall */
> +struct hv_get_vp_register_output {
> +	u64 registervaluelow;
> +	u64 registervaluehigh;
> +};
> +
> +#define HV_FLUSH_ALL_PROCESSORS			BIT(0)
> +#define HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES	BIT(1)
> +#define HV_FLUSH_NON_GLOBAL_MAPPINGS_ONLY	BIT(2)
> +#define HV_FLUSH_USE_EXTENDED_RANGE_FORMAT	BIT(3)
> +
> +enum HV_GENERIC_SET_FORMAT {
> +	HV_GENERIC_SET_SPARSE_4K,
> +	HV_GENERIC_SET_ALL,
> +};
> +
> +/*
> + * The Hyper-V TimeRefCount register and the TSC
> + * page provide a guest VM clock with 100ns tick rate
> + */
> +#define HV_CLOCK_HZ (NSEC_PER_SEC/100)
> +
> +/*
> + * The fields in this structure are set by Hyper-V and read
> + * by the Linux guest.  They should be accessed with READ_ONCE()
> + * so the compiler doesn't optimize in a way that will cause
> + * problems.
> + */
> +struct ms_hyperv_tsc_page {
> +	u32 tsc_sequence;
> +	u32 reserved1;
> +	u64 tsc_scale;
> +	s64 tsc_offset;
> +	u64 reserved2[509];
> +};
> +
> +/* Define the number of synthetic interrupt sources. */
> +#define HV_SYNIC_SINT_COUNT		(16)
> +/* Define the expected SynIC version. */
> +#define HV_SYNIC_VERSION_1		(0x1)
> +
> +#define HV_SYNIC_CONTROL_ENABLE		(1ULL << 0)
> +#define HV_SYNIC_SIMP_ENABLE		(1ULL << 0)
> +#define HV_SYNIC_SIEFP_ENABLE		(1ULL << 0)
> +#define HV_SYNIC_SINT_MASKED		(1ULL << 16)
> +#define HV_SYNIC_SINT_AUTO_EOI		(1ULL << 17)
> +#define HV_SYNIC_SINT_VECTOR_MASK	(0xFF)
> +
> +#define HV_SYNIC_STIMER_COUNT		(4)
> +
> +/* Define synthetic interrupt controller message constants. */
> +#define HV_MESSAGE_SIZE			(256)
> +#define HV_MESSAGE_PAYLOAD_BYTE_COUNT	(240)
> +#define HV_MESSAGE_PAYLOAD_QWORD_COUNT	(30)
> +
> +/* Define hypervisor message types. */
> +enum hv_message_type {
> +	HVMSG_NONE			=3D 0x00000000,
> +
> +	/* Memory access messages. */
> +	HVMSG_UNMAPPED_GPA		=3D 0x80000000,
> +	HVMSG_GPA_INTERCEPT		=3D 0x80000001,
> +
> +	/* Timer notification messages. */
> +	HVMSG_TIMER_EXPIRED		=3D 0x80000010,
> +
> +	/* Error messages. */
> +	HVMSG_INVALID_VP_REGISTER_VALUE	=3D 0x80000020,
> +	HVMSG_UNRECOVERABLE_EXCEPTION	=3D 0x80000021,
> +	HVMSG_UNSUPPORTED_FEATURE	=3D 0x80000022,
> +
> +	/* Trace buffer complete messages. */
> +	HVMSG_EVENTLOG_BUFFERCOMPLETE	=3D 0x80000040,
> +};
> +
> +/* Define synthetic interrupt controller message flags. */
> +union hv_message_flags {
> +	__u8 asu8;
> +	struct {
> +		__u8 msg_pending:1;
> +		__u8 reserved:7;
> +	};
> +};
> +
> +/* Define port identifier type. */
> +union hv_port_id {
> +	__u32 asu32;
> +	struct {
> +		__u32 id:24;
> +		__u32 reserved:8;
> +	} u;
> +};
> +
> +/* Define synthetic interrupt controller message header. */
> +struct hv_message_header {
> +	__u32 message_type;
> +	__u8 payload_size;
> +	union hv_message_flags message_flags;
> +	__u8 reserved[2];
> +	union {
> +		__u64 sender;
> +		union hv_port_id port;
> +	};
> +};
> +
> +/* Define synthetic interrupt controller message format. */
> +struct hv_message {
> +	struct hv_message_header header;
> +	union {
> +		__u64 payload[HV_MESSAGE_PAYLOAD_QWORD_COUNT];
> +	} u;
> +};
> +
> +/* Define the synthetic interrupt message page layout. */
> +struct hv_message_page {
> +	struct hv_message sint_message[HV_SYNIC_SINT_COUNT];
> +};
> +
> +/* Define timer message payload structure. */
> +struct hv_timer_message_payload {
> +	__u32 timer_index;
> +	__u32 reserved;
> +	__u64 expiration_time;	/* When the timer expired */
> +	__u64 delivery_time;	/* When the message was delivered */
> +};
> +
> +#define HV_STIMER_ENABLE		(1ULL << 0)
> +#define HV_STIMER_PERIODIC		(1ULL << 1)
> +#define HV_STIMER_LAZY			(1ULL << 2)
> +#define HV_STIMER_AUTOENABLE		(1ULL << 3)
> +#define HV_STIMER_SINT(config)		(__u8)(((config) >> 16) &
> 0x0F)
> +
> +#endif
> diff --git a/arch/arm64/include/asm/mshyperv.h
> b/arch/arm64/include/asm/mshyperv.h
> new file mode 100644
> index 0000000..1ea49ae
> --- /dev/null
> +++ b/arch/arm64/include/asm/mshyperv.h
> @@ -0,0 +1,295 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Linux-specific definitions for managing interactions with Microsoft's
> + * Hyper-V hypervisor. Definitions that are specified in the Hyper-V
> + * Top Level Functional Spec (TLFS) should not go in this file, but
> + * should instead go in hyperv-tlfs.h.
> + *
> + * Copyright (C) 2018, Microsoft, Inc.
> + *
> + * Author : Michael Kelley <mikelley@microsoft.com>
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms of the GNU General Public License version 2 as
> published
> + * by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD
> TITLE or
> + * NON INFRINGEMENT.  See the GNU General Public License for more
> + * details.
> + */

Would it make sense to breakup this header file into ISA independent and de=
pendent files?

> +
> +#ifndef _ASM_ARM64_MSHYPERV_H
> +#define _ASM_ARM64_MSHYPERV_H
> +
> +#include <linux/types.h>
> +#include <linux/interrupt.h>
> +#include <linux/clocksource.h>
> +#include <linux/irq.h>
> +#include <linux/irqdesc.h>
> +#include <asm/hyperv-tlfs.h>
> +
> +/*
> + * Hyper-V always runs with a page size of 4096. These definitions
> + * are used when communicating with Hyper-V using guest physical
> + * pages and guest physical page addresses, since the guest page
> + * size may not be 4096 on ARM64.
> + */
> +#define HV_HYP_PAGE_SIZE	4096
> +#define HV_HYP_PAGE_SHIFT	12
> +#define HV_HYP_PAGE_MASK	(~(HV_HYP_PAGE_SIZE - 1))
> +
> +
> +struct ms_hyperv_info {
> +	u32 features;
> +	u32 misc_features;
> +	u32 hints;
> +	u32 max_vp_index;
> +	u32 max_lp_index;
> +};
> +extern struct ms_hyperv_info ms_hyperv;
> +
> +/*
> + * Define the IRQ numbers/vectors used by Hyper-V VMbus interrupts
> + * and by STIMER0 Direct Mode interrupts. Hyper-V should be supplying
> + * these values through ACPI, but there are no other interrupting
> + * devices in a Hyper-V VM on ARM64, so it's OK to hard code for now.
> + * The "CALLBACK_VECTOR" terminology is a left-over from the x86/x64
> + * world that is used in architecture independent Hyper-V code.
> + */
When we have direct device assignment for ARM-64 guests, can we still hardc=
ode.

> +#define HYPERVISOR_CALLBACK_VECTOR 16
> +#define	HV_STIMER0_IRQNR	   17
> +
> +extern u64 hv_do_hypercall(u64 control, void *inputaddr, void
> *outputaddr);
> +extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
> +
> +extern u64 hv_do_hvc(u64 control, ...);
> +extern u64 hv_do_hvc_fast_get(u64 control, u64 input1, u64 input2, u64
> input3,
> +		struct hv_get_vp_register_output *output);
> +
> +/*
> + * Declare calls to get and set Hyper-V VP register values on ARM64, whi=
ch
> + * requires a hypercall.
> + */
> +extern void hv_set_vpreg(u32 reg, u64 value);
> +extern u64 hv_get_vpreg(u32 reg);
> +extern void hv_get_vpreg_128(u32 reg, struct hv_get_vp_register_output
> *result);
> +
> +/*
> + * The guest OS needs to register the guest ID with the hypervisor.
> + * The guest ID is a 64 bit entity and the structure of this ID is
> + * specified in the Hyper-V specification:
> + *
> + * msdn.microsoft.com/en-
> us/library/windows/hardware/ff542653%28v=3Dvs.85%29.aspx
> + *
> + * While the current guideline does not specify how Linux guest ID(s)
> + * need to be generated, our plan is to publish the guidelines for
> + * Linux and other guest operating systems that currently are hosted
> + * on Hyper-V. The implementation here conforms to this yet
> + * unpublished guidelines.
> + *
> + *
> + * Bit(s)
> + * 63 - Indicates if the OS is Open Source or not; 1 is Open Source
> + * 62:56 - Os Type; Linux is 0x100
> + * 55:48 - Distro specific identification
> + * 47:16 - Linux kernel version number
> + * 15:0  - Distro specific identification
> + *
> + * Generate the guest ID based on the guideline described above.
> + */

No need to repeat the above block comment (already included in the TLFS hea=
der).

> +
> +static inline  __u64 generate_guest_id(__u64 d_info1, __u64
> kernel_version,
> +				       __u64 d_info2)
> +{
> +	__u64 guest_id =3D 0;
> +
> +	guest_id =3D (((__u64)HV_LINUX_VENDOR_ID) << 48);
> +	guest_id |=3D (d_info1 << 48);
> +	guest_id |=3D (kernel_version << 16);
> +	guest_id |=3D d_info2;
> +
> +	return guest_id;
> +}
> +
> +
> +/* Free the message slot and signal end-of-message if required */
> +static inline void vmbus_signal_eom(struct hv_message *msg, u32
> old_msg_type)
> +{
> +	/*
> +	 * On crash we're reading some other CPU's message page and we
> need
> +	 * to be careful: this other CPU may already had cleared the header
> +	 * and the host may already had delivered some other message
> there.
> +	 * In case we blindly write msg->header.message_type we're going
> +	 * to lose it. We can still lose a message of the same type but
> +	 * we count on the fact that there can only be one
> +	 * CHANNELMSG_UNLOAD_RESPONSE and we don't care about
> other messages
> +	 * on crash.
> +	 */
> +	if (cmpxchg(&msg->header.message_type, old_msg_type,
> +		    HVMSG_NONE) !=3D old_msg_type)
> +		return;
> +
> +	/*
> +	 * Make sure the write to MessageType (ie set to
> +	 * HVMSG_NONE) happens before we read the
> +	 * MessagePending and EOMing. Otherwise, the EOMing
> +	 * will not deliver any more messages since there is
> +	 * no empty slot
> +	 */
> +	mb();
> +
> +	if (msg->header.message_flags.msg_pending) {
> +		/*
> +		 * This will cause message queue rescan to
> +		 * possibly deliver another msg from the
> +		 * hypervisor
> +		 */
> +		hv_set_vpreg(HvRegisterEom, 0);
> +	}
> +}

The code above is identical to what we have on the x86 side except how we s=
ignal EOM state. If we
Abstract this, this entire function can be in a common file.
=20
> +
> +/*
> + * Use the Hyper-V provided stimer0 as the timer that is made
> + * available to the architecture independent Hyper-V drivers.
> + */
> +#define hv_init_timer(timer, tick) \
> +		hv_set_vpreg(HvRegisterStimer0Count + (2*timer), tick)
> +#define hv_init_timer_config(timer, val) \
> +		hv_set_vpreg(HvRegisterStimer0Config + (2*timer), val)
> +#define hv_get_current_tick(tick) \
> +		(tick =3D hv_get_vpreg(HvRegisterTimeRefCount))
> +
> +#define hv_get_simp(val) (val =3D hv_get_vpreg(HvRegisterSipp))
> +#define hv_set_simp(val) hv_set_vpreg(HvRegisterSipp, val)
> +
> +#define hv_get_siefp(val) (val =3D hv_get_vpreg(HvRegisterSifp))
> +#define hv_set_siefp(val) hv_set_vpreg(HvRegisterSifp, val)
> +
> +#define hv_get_synic_state(val) (val =3D hv_get_vpreg(HvRegisterScontrol=
))
> +#define hv_set_synic_state(val) hv_set_vpreg(HvRegisterScontrol, val)
> +
> +#define hv_get_vp_index(index) (index =3D
> hv_get_vpreg(HvRegisterVpIndex))
> +
> +/*
> + * Hyper-V SINT registers are numbered sequentially, so we can just
> + * add the SINT number to the register number of SINT0
> + */
> +#define hv_get_synint_state(sint_num, val) \
> +		(val =3D hv_get_vpreg(HvRegisterSint0 + sint_num))
> +#define hv_set_synint_state(sint_num, val) \
> +		hv_set_vpreg(HvRegisterSint0 + sint_num, val)
> +
> +#define hv_get_crash_ctl(val) \
> +		(val =3D hv_get_vpreg(HvRegisterCrashCtl))
> +
> +void hv_setup_vmbus_irq(void (*handler)(void));
> +void hv_remove_vmbus_irq(void);
> +void hv_enable_vmbus_irq(void);
> +void hv_disable_vmbus_irq(void);
> +
> +void hv_setup_kexec_handler(void (*handler)(void));
> +void hv_remove_kexec_handler(void);
> +void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs));
> +void hv_remove_crash_handler(void);
> +
> +#if IS_ENABLED(CONFIG_HYPERV)
> +extern struct clocksource *hyperv_cs;
> +
> +/*
> + * Hypervisor's notion of virtual processor ID is different from
> + * Linux' notion of CPU ID. This information can only be retrieved
> + * in the context of the calling CPU. Setup a map for easy access
> + * to this information.
> + */
> +extern u32 *hv_vp_index;
> +extern u32 hv_max_vp_index;
> +
> +/**
> + * hv_cpu_number_to_vp_number() - Map CPU to VP.
> + * @cpu_number: CPU number in Linux terms
> + *
> + * This function returns the mapping between the Linux processor
> + * number and the hypervisor's virtual processor number, useful
> + * in making hypercalls and such that talk about specific
> + * processors.
> + *
> + * Return: Virtual processor number in Hyper-V terms
> + */
> +static inline int hv_cpu_number_to_vp_number(int cpu_number)
> +{
> +	return hv_vp_index[cpu_number];
> +}
> +
> +void hyperv_report_panic(struct pt_regs *regs, long err);
> +void hyperv_report_panic_msg(phys_addr_t pa, size_t size);
> +bool hv_is_hyperv_initialized(void);
> +void hyperv_cleanup(void);
> +#else /* CONFIG_HYPERV */
> +static inline bool hv_is_hyperv_initialized(void) { return false; }
> +static inline void hyperv_cleanup(void) {}
> +#endif /* CONFIG_HYPERV */
> +
> +#if IS_ENABLED(CONFIG_HYPERV)
> +#define hv_enable_stimer0_percpu_irq(irq)	enable_percpu_irq(irq, 0)
> +#define hv_disable_stimer0_percpu_irq(irq)	disable_percpu_irq(irq)
> +extern int hv_setup_stimer0_irq(int *irq, int *vector, void
> (*handler)(void));
> +extern void hv_remove_stimer0_irq(int irq);
> +#endif
> +
> +extern struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
> +static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page
> *tsc_pg,
> +				       u64 *cur_tsc)
> +{
> +	u64	scale, offset;
> +	u32	sequence;
> +
> +	/*
> +	 * The protocol for reading Hyper-V TSC page is specified in
> Hypervisor
> +	 * Top-Level Functional Specification.  To get the reference time we
> +	 * must do the following:
> +	 * - READ ReferenceTscSequence
> +	 *   A special '0' value indicates the time source is unreliable and we
> +	 *   need to use something else.
> +	 * - ReferenceTime =3D
> +	 *        ((CNTVCT_EL0) * ReferenceTscScale) >> 64) +
> ReferenceTscOffset
> +	 * - READ ReferenceTscSequence again. In case its value has changed
> +	 *   since our first reading we need to discard ReferenceTime and
> repeat
> +	 *   the whole sequence as the hypervisor was updating the page in
> +	 *   between.
> +	 */
> +	do {
> +		sequence =3D READ_ONCE(tsc_pg->tsc_sequence);
> +		/*
> +		 * Make sure we read sequence before we read other values
> from
> +		 * TSC page.
> +		 */
> +		smp_rmb();
> +
> +		scale =3D READ_ONCE(tsc_pg->tsc_scale);
> +		offset =3D READ_ONCE(tsc_pg->tsc_offset);
> +		isb();
> +		*cur_tsc =3D read_sysreg(cntvct_el0);
> +		isb();
> +
> +		/*
> +		 * Make sure we read sequence after we read all other
> values
> +		 * from TSC page.
> +		 */
> +		smp_rmb();
> +
> +	} while (READ_ONCE(tsc_pg->tsc_sequence) !=3D sequence);
> +
> +	return mul_u64_u64_shr(*cur_tsc, scale, 64) + offset;
> +}
> +
> +static inline u64 hv_read_tsc_page(const struct ms_hyperv_tsc_page
> *tsc_pg)
> +{
> +	u64 cur_tsc;
> +
> +	return hv_read_tsc_page_tsc(tsc_pg, &cur_tsc);
> +}
> +
> +#endif
> --
> 1.8.3.1

