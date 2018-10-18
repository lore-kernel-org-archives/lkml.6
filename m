Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4913C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D12E21486
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ruCokVPt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D12E21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbeJSGzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 02:55:18 -0400
Received: from mail-by2nam01on0048.outbound.protection.outlook.com ([104.47.34.48]:52049
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726506AbeJSGzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 02:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSQ1axmy8lXOUD7l501sjNBVbDw+rZ+w7b9E2mmRG1g=;
 b=ruCokVPtJEduwNMyuN4Qabrv2+Q3wrfLXLcO8fpN3tM/MbelN6E8nQkuBKk1ccnVfhwi7ydlrclxqLU8OuDEHlqyXhIt61s6ew07oHyRGKDVRfxiOyknG0A1d3/oHB46M0zu+4vNbpoC5W15rMv2iaDbP5vE48I5AgEjnvNNHho=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1818.namprd12.prod.outlook.com (10.175.91.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.25; Thu, 18 Oct 2018 22:52:01 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%3]) with mapi id 15.20.1250.028; Thu, 18 Oct 2018
 22:52:01 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: [PATCH v5 00/13] arch/x86: AMD QoS support
Thread-Topic: [PATCH v5 00/13] arch/x86: AMD QoS support
Thread-Index: AQHUZzUuNvwvLZwExEq0GgZvZL3+EA==
Date:   Thu, 18 Oct 2018 22:52:00 +0000
Message-ID: <20181018225124.23043-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0044.namprd02.prod.outlook.com
 (2603:10b6:803:2e::30) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1818;20:Kt/osaEvUCdZE1T3UWvSdREnVtnjWEDPY4dzjDF2TVucq634zhpjAyM3wmO+dA3Dn/F1B6zsTMdmW4EaabMP9sMO40hughqpe3XLJ0UgFPpGlxm6JaA/Hdvmn99L8vwUENcN1+ClQB7Ie5oeUy+c8GW0kH3bmJfErGtExpZGxinneLs/npsr8RJefQnNl+Yz3VDR8X6dynRQCckmBkzl2ZAC6vIlHXknAksgP9/HFrx3ZIuiZ8rPnoWitjFxjZOo
x-ms-office365-filtering-correlation-id: 5c9b7722-7175-46a7-0398-08d6354c5041
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1818;
x-ms-traffictypediagnostic: DM5PR12MB1818:
x-microsoft-antispam-prvs: <DM5PR12MB18189D4AB70EEDEFD531958795F80@DM5PR12MB1818.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72170088055959)(269456686620040)(767451399110)(84791874153150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1818;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1818;
x-forefront-prvs: 08296C9B35
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(110136005)(478600001)(2201001)(8936002)(5660300001)(6306002)(7406005)(14454004)(7416002)(1076002)(6486002)(6512007)(5250100002)(6436002)(68736007)(966005)(72206003)(54906003)(66066001)(106356001)(3846002)(186003)(26005)(86362001)(2616005)(2906002)(476003)(99286004)(81166006)(102836004)(81156014)(6116002)(53936002)(486006)(52116002)(36756003)(386003)(316002)(2501003)(7736002)(6506007)(8676002)(2900100001)(25786009)(305945005)(71200400001)(71190400001)(105586002)(14444005)(256004)(97736004)(4326008)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1818;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zjfsBqpdEjgqwCZ0lJPS9PnlWsIplU2dSVp2C2sbSpATC3B5DZpP1TRFsQFZZnMoHnklRpTKjn9EW4f9ZPwbDgnXbt2NkiuEZPYoqg3SmnHFAP8Yd9j+UNPysw+nlkLZSjsS3hspw5JZve5J3o2IavD5EQlREcid7Cshk4z7rKc0Z7Eku3g3rrwZPbcI0jCKNWRbI/L3ue3xpCwZfeTBQJEHzJB+qtsfFaz63j8oL3qd1BDXdMfzKXiEeGBVscwB5VBiLrBS6qrfeqCc2SqTa+/UD3boDArnGgVITm7y5x5et120/KEbVmfxjJphNidqnVqbiZHq/7OFMWYWndMv4xdoDDbGxncEynb+uZxwX+c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9b7722-7175-46a7-0398-08d6354c5041
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2018 22:52:00.9205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1818
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

Changes from v4 -> v5:
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


Babu Moger (12):
  arch/x86: Start renaming the rdt files to more generic names
  arch/x86: Rename the RDT functions and definitions
  arch/x86: Re-arrange RDT init code
  arch/x86: Bring all the macros to resctrl.h
  arch/x86: Introduce a new config parameter RESCTRL
  arch/x86: Use new config parameter RESCTRL for compilation
  arch/x86: Initialize the resource functions that are different
  arch/x86: Bring cbm_validate function into the resource structure
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
 ...ntel_rdt_rdtgroup.c =3D> resctrl_rdtgroup.c} |  14 +-
 arch/x86/kernel/cpu/scattered.c               |   7 +-
 arch/x86/kernel/process_32.c                  |   4 +-
 arch/x86/kernel/process_64.c                  |   4 +-
 include/linux/sched.h                         |   2 +-
 16 files changed, 317 insertions(+), 95 deletions(-)
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

