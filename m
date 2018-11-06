Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A94CC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CDDB20896
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fHEDb2eO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CDDB20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388989AbeKGBHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:07:00 -0500
Received: from mail-by2nam03on0078.outbound.protection.outlook.com ([104.47.42.78]:34136
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388819AbeKGBG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 20:06:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8BUXU3lXTY68VXc0lkAgEksHzlS5BOe+fItw5zIJVw=;
 b=fHEDb2eONLCnoZFasiYfRmwmj1uoCKoL/+2WoFUtrihP++XG5zm3gejnREK4wB/OGnZ59RZGV5Sij2SyCXz7tHOm80GXsa4VHwThso7jI+zp9aeNwJOCgsUmFWGMWDZfIgakJ4GwdiSds7W8tRbore4/RwCq2+xYnNYj+Vdwx8E=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1354.namprd12.prod.outlook.com (10.168.238.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Tue, 6 Nov 2018 15:40:57 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e%4]) with mapi id 15.20.1294.032; Tue, 6 Nov 2018
 15:40:57 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "qianyue.zj@alibaba-inc.com" <qianyue.zj@alibaba-inc.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Hurwitz, Sherry" <sherry.hurwitz@amd.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jannh@google.com" <jannh@google.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "rian@alum.mit.edu" <rian@alum.mit.edu>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "Moger, Babu" <Babu.Moger@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: [PATCH v6 00/14] arch/x86: AMD QoS support
Thread-Topic: [PATCH v6 00/14] arch/x86: AMD QoS support
Thread-Index: AQHUdeccE48O9gayT0KPrbKuvNEvBw==
Date:   Tue, 6 Nov 2018 15:40:56 +0000
Message-ID: <20181106154034.15386-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0401CA0010.namprd04.prod.outlook.com
 (2603:10b6:803:21::20) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1354;20:31r88LytuVGVilb/D0Xlts05YmJKxFPi6zx15eqDtfvl1ZHBaB7oMfVzUDiP0PVYS2XAgTXxgzHCRugL7ghs2GDbo6WpdFF6AlrrXeb/koHNuBSUfAH7ScBIBLs4lgs89NP/0dO1T4jfyIuWmY3YTqhG7dhLt4i56BHwl/xk04spFDZ0czj7YOJ85wqqcpx83fyQBajf1s1V8uhpyt7nyQNZR1musDYlN2Ib2vkTmYLpPnSJ5kUarYYE2Kg9ckbp
x-ms-office365-filtering-correlation-id: 6068e886-340c-41b1-317f-08d643fe3e48
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1354;
x-ms-traffictypediagnostic: DM5PR12MB1354:
x-microsoft-antispam-prvs: <DM5PR12MB13549CE827410BC69D5FC14A95CB0@DM5PR12MB1354.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72170088055959)(269456686620040)(767451399110)(84791874153150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1354;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1354;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(346002)(366004)(136003)(189003)(199004)(6306002)(2906002)(54906003)(5660300001)(3846002)(6116002)(1076002)(53936002)(478600001)(25786009)(36756003)(110136005)(7406005)(7416002)(966005)(14454004)(66066001)(4326008)(6486002)(2900100001)(68736007)(305945005)(7736002)(6512007)(2201001)(6506007)(86362001)(26005)(102836004)(14444005)(99286004)(97736004)(486006)(2501003)(386003)(256004)(81166006)(81156014)(6436002)(316002)(72206003)(8936002)(8676002)(52116002)(71190400001)(186003)(2616005)(476003)(106356001)(71200400001)(105586002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1354;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QUZXqLvijM8bU0Q0FKJ/0vOYGFIWKeRZMjjh0Bl0F3tT/PwVesmcKyWT3ZsjlnL8UyOYpf2Ll5oVHmOEw2iPi8BN3RgKv3YFxVj4bcrd6GMcYX0HI4tEBs3gEVhVn91JahxgBWozN1GznBUYhEG/rNzqa/gt6NTt/i7ckT3WAoXvA/3A1xU7JGX4aPJS0RtKam6SWpv3uM/yKJshDTxZJf47cGxKrCNm7soHqA3d3VMZp1tChn4HnSsSCx/8XiPWx1mvCpNRK2S8vx4WiRvhx5lZHwFjqRZnnY6iysxF2xQOaC0Bk5Qg4x/9Ip9F+vSL35DT/HWQYic963PM8UinvVabqvwMI2q4PPMkQ2NjwGU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6068e886-340c-41b1-317f-08d643fe3e48
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 15:40:56.8579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1354
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

Please review.

Changes from v5 -> v6:
 a. Addressed comments from Fenghua Yu. Added vendor check while
    detecting MBA software controller support.
 a. Rebased again on top of
    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cache

Changes from v4 -> v5:
https://lore.kernel.org/lkml/20181018225124.23043-1-babu.moger@amd.com/
 a. Addressed comments from Fenghua Yu.
 b. The functions update_mba_bw and set_mba_sc is not required for AMD.
    Removed all the changes related to these functions.

Changes from v3 -> v4:
https://lore.kernel.org/lkml/20181015205514.25387-1-babu.moger@amd.com/
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

Babu Moger (13):
  arch/x86: Start renaming the rdt files to more generic names
  arch/x86: Rename the RDT functions and definitions
  arch/x86: Re-arrange RDT init code
  arch/x86: Bring all the macros to resctrl.h
  arch/x86: Introduce a new config parameter RESCTRL
  arch/x86: Use new config parameter RESCTRL for compilation
  arch/x86: Initialize the resource functions that are different
  arch/x86: Bring cbm_validate function into the resource structure
  arch/x86: Add vendor check for MBA software controller
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
 .../x86/kernel/cpu/{intel_rdt.c =3D> resctrl.c} | 168 +++++++++++++++---
 .../x86/kernel/cpu/{intel_rdt.h =3D> resctrl.h} |  37 ++--
 ...dt_ctrlmondata.c =3D> resctrl_ctrlmondata.c} |  80 ++++++++-
 ...{intel_rdt_monitor.c =3D> resctrl_monitor.c} |  20 +--
 ...dt_pseudo_lock.c =3D> resctrl_pseudo_lock.c} |   6 +-
 ...ck_event.h =3D> resctrl_pseudo_lock_event.h} |   2 +-
 ...ntel_rdt_rdtgroup.c =3D> resctrl_rdtgroup.c} |  19 +-
 arch/x86/kernel/cpu/scattered.c               |   7 +-
 arch/x86/kernel/process_32.c                  |   4 +-
 arch/x86/kernel/process_64.c                  |   4 +-
 include/linux/sched.h                         |   2 +-
 16 files changed, 321 insertions(+), 96 deletions(-)
 rename Documentation/x86/{intel_rdt_ui.txt =3D> resctrl_ui.txt} (99%)
 rename arch/x86/include/asm/{intel_rdt_sched.h =3D> resctrl_sched.h} (77%)
 rename arch/x86/kernel/cpu/{intel_rdt.c =3D> resctrl.c} (85%)
 rename arch/x86/kernel/cpu/{intel_rdt.h =3D> resctrl.h} (94%)
 rename arch/x86/kernel/cpu/{intel_rdt_ctrlmondata.c =3D> resctrl_ctrlmonda=
ta.c} (86%)
 rename arch/x86/kernel/cpu/{intel_rdt_monitor.c =3D> resctrl_monitor.c} (9=
7%)
 rename arch/x86/kernel/cpu/{intel_rdt_pseudo_lock.c =3D> resctrl_pseudo_lo=
ck.c} (99%)
 rename arch/x86/kernel/cpu/{intel_rdt_pseudo_lock_event.h =3D> resctrl_pse=
udo_lock_event.h} (95%)
 rename arch/x86/kernel/cpu/{intel_rdt_rdtgroup.c =3D> resctrl_rdtgroup.c} =
(99%)

--=20
2.17.1

