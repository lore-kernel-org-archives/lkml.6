Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4007C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3038208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Nwl33lrK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3038208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbeJPEpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 00:45:22 -0400
Received: from mail-sn1nam02on0063.outbound.protection.outlook.com ([104.47.36.63]:36736
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726091AbeJPEpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 00:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICqrv446Q03IRncwX9Js1BUherhILT9Pev6VYvjSO/s=;
 b=Nwl33lrKPvmbcDajTBUzTEHV60GLaB7Nyrd2FcRFV0JOdt5yKR04IjTwxXY0Bb1+jwqtui/pdxrcKDCrmrIv0Otn6EXAXfsKeDxWzuWa4lGxH3Miu94Q+m0biLf35DpG/BjZe4uUNrSRV+vHXLzRKEo4JQvoqHi2LNWfqdj5tVA=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1850.namprd12.prod.outlook.com (10.175.86.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Mon, 15 Oct 2018 20:55:29 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%3]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 20:55:29 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>
Subject: [PATCH v4 00/13] arch/x86: AMD QoS support
Thread-Topic: [PATCH v4 00/13] arch/x86: AMD QoS support
Thread-Index: AQHUZMln/uDMNH+1C0Wx9abUT3nl5Q==
Date:   Mon, 15 Oct 2018 20:55:29 +0000
Message-ID: <20181015205514.25387-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:805:a2::30) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1850;20:t3kKn90tPZvFXPYupWy56p0ran1FPMqtCaVrkC9YedSxyZlFbF1Uv4l4LnDtQkZaViCpwZAboUqUr0JU/nFX0dDDwe66JbYg6egLwRvxKLNeywWa978/U4FJ3/tHvmYheb/G0Z0XAqsCcfm61HfaU8cPm0rlOX0lEp2bhb33m82aYZz7vAFyM8bQ0TbE/ou5QkzFP9CjrbSjeesDjGAHDdJ8DKSYcJUgUWORSW1yb3hiAsCNIouJbpMsBCPIS7j6
x-ms-office365-filtering-correlation-id: b3031ed9-f77d-43ca-17ad-08d632e08a15
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1850;
x-ms-traffictypediagnostic: DM5PR12MB1850:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-microsoft-antispam-prvs: <DM5PR12MB1850FB286526ED3EDB362E7195FD0@DM5PR12MB1850.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72170088055959)(269456686620040)(767451399110)(84791874153150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991067);SRVR:DM5PR12MB1850;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1850;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(376002)(396003)(39860400002)(189003)(199004)(54906003)(6306002)(106356001)(81156014)(8676002)(52116002)(305945005)(105586002)(5660300001)(110136005)(2900100001)(6436002)(6512007)(53936002)(6486002)(2201001)(8936002)(81166006)(256004)(476003)(86362001)(99286004)(5250100002)(36756003)(486006)(2501003)(478600001)(966005)(72206003)(97736004)(71190400001)(25786009)(71200400001)(1076002)(2616005)(26005)(386003)(14454004)(6506007)(186003)(66066001)(102836004)(7736002)(7416002)(316002)(4326008)(68736007)(3846002)(14444005)(2906002)(6116002)(7406005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1850;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: M5j/bf2gvOWqO8MBIgpnFupgSteUw5AoHsjKZSNVNECrcPNp8+hm1tRksYmQ7ZsLEgKuMKtHb/Jj4vSoM/pTqJRh8LP4NzF7CRL6/v17wwQ73aQ2P/4U48euBfZEdMWqVzJZFlqxgT1gjG84wPt8UHCaVUS0gYzB8gIEbAFvYtr+3tJgY1VxAa8mUKSZX//Xujp+0HYKryqkHCoT1IP+tXMRRZbY0Df+0vE5echfWBeSP/328em5erDcB4JzYYeCuuz8DXl8P4SSkel+VRZJ3NUiJ1IuP93jPzbwkse8QAsWVIuBLeFWOFoXT2fTqgZOBl/WiaBt3/GnWx1D4ZMbxYJfUi5DuBe2g06uAuHu7z0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3031ed9-f77d-43ca-17ad-08d632e08a15
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 20:55:29.5989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1850
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

The public specification for this feature is available at
https://developer.amd.com/wp-content/resources/56375.pdf

Obviously, there are multiple ways we can go about these changes. We felt
it is appropriate to rename and re-organize the code little bit before
making the functional changes. The first few patches(1-10) renames and
re-organizes the sources in preparation. Rest of the patches(7-11) adds
support for AMD QoS features.

Please review and provide me feedback.

Changes from v3 -> v4:
 a. Addressed comments from Reinette Chatre and Borislav Petkov.
 b. Removed X86 dependancy for CONFIG_AMD_QOS. Implicitly is it already
    dependent on X86.
 c. Updated the MAINTAINER file for name changes.
 d. Addressed most of "checkpatch.pl --strict" issues.
 d. Updated Documentation/x86/resctrl_ui.txt(previously
    intel_rdt_ui.txt) file with AMD specific details. Changed few names
    to resctrl from intel_rdt.

Changes from v2 -> v3:
 https://lore.kernel.org/lkml/20181011203223.18157-1-babu.moger@amd.com/
 a. Rebased the patches on top of below branch as suggested by Thomas Gleix=
ner.
    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cache
 b. Addressed comments from Reinette Chatre, Fenghua Yu and Borislav Petkov=
.
 c. Main changes are related to renaming the files and functions.
    Renamed from intel_rdt to more generic resctrl(patches 1 to 3).
 d. Config parameter changed from PLATFORM_QOS to more generic RESCTRL.
 e. Fixed minor indentation issues.

Changes from v1 -> v2:
 https://lore.kernel.org/lkml/20181005205512.29545-1-babu.moger@amd.com/
 a. Removed RFC from subject header. Based on the discussion so far,=20
    plan is to go ahead with these patches and eventually re-structure
    the code to make arch and non-arch separate.
 b. Addressed comments from Reinette Chatre and Fenghua Yu.
 c. Separated quirks and MBA from rdt init code. Kept the rest of the
    code as is.
 d. Added _intel suffixes all the Intel only code just like AMD code.
 e. Added one more patch to bring the macros into header file.
 f. Few minor text changes.

v1:
 https://lore.kernel.org/lkml/20180924191841.29111-1-babu.moger@amd.com/

Babu Moger (12):
  arch/x86: Start renaming the rdt files to more generic names
  arch/x86: Rename the RDT functions and definitions
  arch/x86: Re-arrange RDT init code
  arch/x86: Bring all the macros to resctrl.h
  arch/x86: Introduce a new config parameter RESCTRL
  arch/x86: Use new config parameter RESCTRL for compilation
  arch/x86: Initialize the resource functions that are different
  arch/x86: Bring few more functions into the resource structure
  arch/x86: Introduce new config parameter AMD_QOS
  arch/x86: Introduce QOS feature for AMD
  Documentation/x86: Rename and update intel_rdt_ui.txt
  MAINTAINERS: Update the file and documentation names in arch/x86

Sherry Hurwitz (1):
  arch/x86: Add AMD feature bit X86_FEATURE_MBA in cpuid bits array

 .../x86/{intel_rdt_ui.txt =3D> resctrl_ui.txt}  |   9 +-
 MAINTAINERS                                   |   6 +-
 arch/x86/Kconfig                              |  19 ++
 .../{intel_rdt_sched.h =3D> resctrl_sched.h}    |  28 +--
 arch/x86/kernel/cpu/Makefile                  |   6 +-
 .../x86/kernel/cpu/{intel_rdt.c =3D> resctrl.c} | 169 +++++++++++++++---
 .../x86/kernel/cpu/{intel_rdt.h =3D> resctrl.h} |  41 +++--
 ...dt_ctrlmondata.c =3D> resctrl_ctrlmondata.c} |  80 ++++++++-
 ...{intel_rdt_monitor.c =3D> resctrl_monitor.c} |  30 ++--
 ...dt_pseudo_lock.c =3D> resctrl_pseudo_lock.c} |   6 +-
 ...ck_event.h =3D> resctrl_pseudo_lock_event.h} |   2 +-
 ...ntel_rdt_rdtgroup.c =3D> resctrl_rdtgroup.c} |  14 +-
 arch/x86/kernel/cpu/scattered.c               |   7 +-
 arch/x86/kernel/process_32.c                  |   4 +-
 arch/x86/kernel/process_64.c                  |   4 +-
 include/linux/sched.h                         |   2 +-
 16 files changed, 329 insertions(+), 98 deletions(-)
 rename Documentation/x86/{intel_rdt_ui.txt =3D> resctrl_ui.txt} (99%)
 rename arch/x86/include/asm/{intel_rdt_sched.h =3D> resctrl_sched.h} (77%)
 rename arch/x86/kernel/cpu/{intel_rdt.c =3D> resctrl.c} (85%)
 rename arch/x86/kernel/cpu/{intel_rdt.h =3D> resctrl.h} (92%)
 rename arch/x86/kernel/cpu/{intel_rdt_ctrlmondata.c =3D> resctrl_ctrlmonda=
ta.c} (86%)
 rename arch/x86/kernel/cpu/{intel_rdt_monitor.c =3D> resctrl_monitor.c} (9=
6%)
 rename arch/x86/kernel/cpu/{intel_rdt_pseudo_lock.c =3D> resctrl_pseudo_lo=
ck.c} (99%)
 rename arch/x86/kernel/cpu/{intel_rdt_pseudo_lock_event.h =3D> resctrl_pse=
udo_lock_event.h} (95%)
 rename arch/x86/kernel/cpu/{intel_rdt_rdtgroup.c =3D> resctrl_rdtgroup.c} =
(99%)

--=20
2.17.1

