Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412D5C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14DE2087D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JSyn52lM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14DE2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbeJLEB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 00:01:58 -0400
Received: from mail-dm3nam03on0053.outbound.protection.outlook.com ([104.47.41.53]:19008
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725742AbeJLEB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 00:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9f5xAAjA86uk8sX+sSgmrWK5OGVDBqx/1SEXBDSfKN8=;
 b=JSyn52lMt+sa/xTsG2yUG0U0r+lyBhek6DSTkAS7R8GviJHQWG2nTk1pHXDz+4YTqvPq5mUJs9/P5v2J01YXb+enWK3fGsHGjrjX/OD/QWdQbBi7Mrzyo6x9+XQTzH94yIt+oKW71wao4YjyzWvJ1tVNEcK1iXIIYk+fxnSAn4c=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1674.namprd12.prod.outlook.com (10.172.40.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.24; Thu, 11 Oct 2018 20:33:00 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%3]) with mapi id 15.20.1228.020; Thu, 11 Oct 2018
 20:33:00 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
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
Subject: [PATCH v3 00/11] arch/x86: AMD QoS support
Thread-Topic: [PATCH v3 00/11] arch/x86: AMD QoS support
Thread-Index: AQHUYaGZU9GWgDk9202EWeKIbu0ONQ==
Date:   Thu, 11 Oct 2018 20:32:59 +0000
Message-ID: <20181011203223.18157-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR22CA0062.namprd22.prod.outlook.com
 (2603:10b6:300:12a::24) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1674;20:gx9vkT2WqbQCiRVfRUSfth0+tIpey+zaBoAx3r0aAkf2s2fzrN1JOQbmI+lMb5ByVidpN79SaWen3qgmTkViOEGl1ANwRwW/SX/VcwabRA2UI6xMZJIZsbgipgMXg6rIPSfy15zlwMtnz59KrQuX/rY9Hrw0hCD0LffnlmFhWKHjVpGHKfvIXhtTr1CcHRehzQHdpuOB9+dYCZVVn5O9WqTcGWti21fqdye2X/6ULZdw18TnLJS40jaK+lWvwadn
x-ms-office365-filtering-correlation-id: 940c9030-e085-4575-bdf9-08d62fb8bbe2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1674;
x-ms-traffictypediagnostic: DM5PR12MB1674:
x-microsoft-antispam-prvs: <DM5PR12MB1674617A2A68265AF93B13D195E10@DM5PR12MB1674.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72170088055959)(269456686620040)(767451399110)(84791874153150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051);SRVR:DM5PR12MB1674;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1674;
x-forefront-prvs: 08220FA8D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(136003)(396003)(39860400002)(189003)(199004)(53936002)(6306002)(6486002)(99286004)(478600001)(966005)(6512007)(52116002)(4326008)(81166006)(6436002)(81156014)(8676002)(14454004)(2501003)(26005)(5250100002)(102836004)(1076002)(3846002)(6116002)(186003)(2906002)(7736002)(2201001)(110136005)(7416002)(54906003)(486006)(476003)(2616005)(2900100001)(97736004)(8936002)(106356001)(305945005)(316002)(86362001)(256004)(72206003)(66066001)(25786009)(386003)(105586002)(71200400001)(71190400001)(36756003)(6506007)(5660300001)(68736007)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1674;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TzirYMXIBEks/104BKnSM9lUFAhkWK7edI7LilVGYDUAIWbn2HxlxHJ9aGfAkshKbaUlAWygeWW6GCmrhgCfePc/Iifocd8HIoneDqgrxzNu7oK5JiZJZuU9WBOFvkdgUH9A3OO7M2KwtZLM1q4AX3z+g15iWGBetXXrLZTPgv+DLAm0NCIVV0iSwt5QpJ9G6koeeeh6DHmNW5rTlPT1XIuZZPE1XKtJS+p3lThIMNZYnH1UWh8xLdnxdg+FKJFSAYm+d/9Nl3SVEB89nIIbXXgmD+Ds7KhriGpZnB8cgZ9UygmgEDyPUk7efFB5r5TUH/iJ2QcJ3aHrBXEZ8jOLQ3bhBOvwS5YQp3uoy2nfN1M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 940c9030-e085-4575-bdf9-08d62fb8bbe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2018 20:33:00.0436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1674
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
making the functional changes. The first few patches(1-6) renames and
re-organizes the sources in preparation. Rest of the patches(7-11) adds
support for AMD QoS features.

Please review and provide me feedback.

Changes from v2 -> v3:
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


Babu Moger (10):
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

Sherry Hurwitz (1):
  arch/x86: Add AMD feature bit X86_FEATURE_MBA in cpuid bits array

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
 14 files changed, 320 insertions(+), 92 deletions(-)
 rename arch/x86/include/asm/{intel_rdt_sched.h =3D> resctrl_sched.h} (77%)
 rename arch/x86/kernel/cpu/{intel_rdt.c =3D> resctrl.c} (84%)
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

