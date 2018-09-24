Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2157ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7627C2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="i3UdE/pg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7627C2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732276AbeIYBWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:22:37 -0400
Received: from mail-eopbgr710084.outbound.protection.outlook.com ([40.107.71.84]:21751
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730681AbeIYBWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ls+aqRy3X6F15r9G4ILvqAa8Dna6/tiQo684vs1YieM=;
 b=i3UdE/pgP9jkRMQHIdfx6zmJbTBL4MKWW9gToQNoYkgWrI4rtZ/6W6TI34rb7mZo3EovdFbyzUPumUwCdVPzP8RyEcVmJXj+K0nOLoxK20cXBWrT3KJz4HWoe7hr8DeIgQ90N/LF5iCKOwMtqo1t5aZz+jo5D8xpwERiFDgCLtk=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2455.namprd12.prod.outlook.com (52.132.141.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Mon, 24 Sep 2018 19:18:54 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::5c18:7df5:fd4b:9de]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::5c18:7df5:fd4b:9de%5]) with mapi id 15.20.1164.024; Mon, 24 Sep 2018
 19:18:54 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "vikas.shivappa@linux.intel.com" <vikas.shivappa@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Moger, Babu" <Babu.Moger@amd.com>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "bp@suse.de" <bp@suse.de>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "Hurwitz, Sherry" <sherry.hurwitz@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "luto@kernel.org" <luto@kernel.org>,
        "jroedel@suse.de" <jroedel@suse.de>,
        "jannh@google.com" <jannh@google.com>,
        "dima@arista.com" <dima@arista.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 00/10] arch/x86: AMD QoS support
Thread-Topic: [RFC PATCH 00/10] arch/x86: AMD QoS support
Thread-Index: AQHUVDtunpE+5D/HD063flof44uaLQ==
Date:   Mon, 24 Sep 2018 19:18:54 +0000
Message-ID: <20180924191841.29111-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR15CA0009.namprd15.prod.outlook.com
 (2603:10b6:805:16::22) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2455;20:CmnjZILmjb3+Oxuw0YDtLn7ociCFTykyO6jvTsbS4vC0mZJuQdG2YGQzRImKeYIJufH+aZu1TBsZ4Frp5n4Hdfc6mqxFr9WVjG8hkGDLFFSbuMhJ+U9K4F2xrg6wHZy0b0VdJkkVqTrg25/ezdIhNEz1ScOkF96ew3p4CNFPKGRQIX2OquvnpZUEAQDodIyPCX1hL1hFTwMFt3jv8R2GjrFd37Dv28ikMwNkozsFg4alfkCeNsMC5JIsDiWiMJEp
x-ms-office365-filtering-correlation-id: 475418c7-3439-48a9-d263-08d622529110
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2455;
x-ms-traffictypediagnostic: DM5PR12MB2455:
x-microsoft-antispam-prvs: <DM5PR12MB2455D1C3FC0E74A8F269ECB895170@DM5PR12MB2455.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72170088055959)(269456686620040);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149066)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051);SRVR:DM5PR12MB2455;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2455;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(366004)(396003)(376002)(189003)(199004)(97736004)(217873002)(256004)(14444005)(2501003)(5250100002)(316002)(2900100001)(52116002)(7736002)(68736007)(305945005)(5660300001)(1076002)(386003)(66066001)(6506007)(478600001)(72206003)(25786009)(7416002)(14454004)(4326008)(6436002)(106356001)(8936002)(8676002)(81156014)(81166006)(6512007)(36756003)(53936002)(26005)(2906002)(3846002)(6116002)(6486002)(54906003)(86362001)(110136005)(102836004)(186003)(2201001)(486006)(71200400001)(476003)(99286004)(2616005)(71190400001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2455;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: A06EmVEKG8T8Qk1C7ERyEdZQ0x04tHUAC/fj/WjvnTPVl3eybgi8RmHvI0b2beFkRKvv4WY/pyzjv1P3XLaVUmDhbP9p6ZkYuBBzjm4IP6g638GTXBg7vIdU668LKFdy73jExq2mQfVGnydE6HFhBX95vhCv0mjSFP1vvV20zBzdovB5m5Mhyk7cQExvoNxVxDEl7ya7yaHAe1oann87tceakrl5G+B+adLb76s5a0fvXsIrIXZHVI2mtUHLZ9A7ru2aD9+PaqSU2cwVnkSjQZ7PKG29diY0Vnum6lpSigMhUrwb5X9emU1wyEHislOpyRPV2NnT5s18UtsUCrys2xKxMCwxlpLFi2e7ln1z+Cg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 475418c7-3439-48a9-d263-08d622529110
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 19:18:54.2559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2455
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for AMD64 architectural extensions for Platform
Quality of Service. These extensions are intended to provide for the
monitoring of the usage of certain system resources by one or more
processors and for the separate allocation and enforcement of limits on
the use of certain system resources by one or more processors.

The monitoring and enforcement are not necessarily applied across the
entire system, but in general apply to a QOS domain which corresponds to
some shared system resource.  The set of resources which are monitored and
the set for which the enforcement of limits is provided are implementation
dependent. Platform QOS features are implemented on a logical processor bas=
is.
Therefore, multiple hardware threads of a single physical CPU core may have
independent resource monitoring and enforcement configurations.

AMD's next generation of processors support following QoS sub-features.
- L3 Cache allocation enforcement
- L3 Cache occupancy monitoring
- L3 Code-Data Prioritization support
- Memory Bandwidth Enforcement(Allocation)

The public specification is still in works. Will add the link when it is
available.

Obviously, there are multiple ways we can go about these changes. We felt
it is appropriate to rename and re-organize the code little bit before
making the functional changes. The first few patches(1-6) renames and
re-organizes the sources in preparation. Rest of the patches(7-10) adds
support for AMD QoS features.

Please review and provide me feedback. If you think of better way to
approach this, please let us know.=20

Babu Moger (9):
  arch/x86: Start renaming the rdt files to more generic names
  arch/x86: Rename the RDT functions and definitions
  arch/x86: Re-arrange RDT init code
  arch/x86: Introduce a new config parameter PLATFORM_QOS
  arch/x86: Use new config parameter PLATFORM_QOS for compilation
  arch/x86: Initialize the resource functions that are different
  arch/x86: Bring few more functions into the resource structure
  arch/x86: Introduce new config parameter AMD_QOS
  arch/x86: Introduce QOS feature for AMD

Sherry Hurwitz (1):
  arch/x86: Add AMD feature bit X86_FEATURE_MBA in cpuid bits array

 arch/x86/Kconfig                              |  19 ++
 .../asm/{intel_rdt_sched.h =3D> rdt_sched.h}    |  26 +--
 arch/x86/kernel/cpu/Makefile                  |   6 +-
 arch/x86/kernel/cpu/{intel_rdt.c =3D> rdt.c}    | 175 +++++++++++++++---
 arch/x86/kernel/cpu/{intel_rdt.h =3D> rdt.h}    |  34 +++-
 ...el_rdt_ctrlmondata.c =3D> rdt_ctrlmondata.c} |  87 ++++++++-
 .../{intel_rdt_monitor.c =3D> rdt_monitor.c}    |  22 ++-
 ...el_rdt_pseudo_lock.c =3D> rdt_pseudo_lock.c} |   6 +-
 ...o_lock_event.h =3D> rdt_pseudo_lock_event.h} |   2 +-
 .../{intel_rdt_rdtgroup.c =3D> rdt_rdtgroup.c}  |  14 +-
 arch/x86/kernel/cpu/scattered.c               |   1 +
 arch/x86/kernel/process_32.c                  |   4 +-
 arch/x86/kernel/process_64.c                  |   4 +-
 include/linux/sched.h                         |   2 +-
 14 files changed, 319 insertions(+), 83 deletions(-)
 rename arch/x86/include/asm/{intel_rdt_sched.h =3D> rdt_sched.h} (80%)
 rename arch/x86/kernel/cpu/{intel_rdt.c =3D> rdt.c} (84%)
 rename arch/x86/kernel/cpu/{intel_rdt.h =3D> rdt.h} (93%)
 rename arch/x86/kernel/cpu/{intel_rdt_ctrlmondata.c =3D> rdt_ctrlmondata.c=
} (84%)
 rename arch/x86/kernel/cpu/{intel_rdt_monitor.c =3D> rdt_monitor.c} (97%)
 rename arch/x86/kernel/cpu/{intel_rdt_pseudo_lock.c =3D> rdt_pseudo_lock.c=
} (99%)
 rename arch/x86/kernel/cpu/{intel_rdt_pseudo_lock_event.h =3D> rdt_pseudo_=
lock_event.h} (95%)
 rename arch/x86/kernel/cpu/{intel_rdt_rdtgroup.c =3D> rdt_rdtgroup.c} (99%=
)

--=20
2.17.1

