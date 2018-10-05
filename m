Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662B5C65BBE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15701213A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AqLCTYOC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15701213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbeJFD4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 23:56:22 -0400
Received: from mail-eopbgr720049.outbound.protection.outlook.com ([40.107.72.49]:19386
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728139AbeJFD4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 23:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2cOibP5T/iouZKFt+bJEwvieuMwbNLu6PUp/c+QUro=;
 b=AqLCTYOCB4+xSCTfOjhWq/6NDbl8lN6FavrE/+wvMsX9KHxBKJzuq8nq9KH0R70IgBlWQkOor2hpv3hcqGLxE4hXTLeA9UVLA1LYsKO6dQl8l+pRMMdxJGuRh32cy2LeE9f+Ym1sV2yjQmtScz7aviHi3oKYTJ6kaGBvBCv0Llc=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1386.namprd12.prod.outlook.com (10.168.238.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.23; Fri, 5 Oct 2018 20:55:34 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%2]) with mapi id 15.20.1207.024; Fri, 5 Oct 2018
 20:55:34 +0000
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
Subject: [PATCH v2 00/11] arch/x86: AMD QoS support
Thread-Topic: [PATCH v2 00/11] arch/x86: AMD QoS support
Thread-Index: AQHUXO3CTn+1tr8+o06JtjDxs0CMcA==
Date:   Fri, 5 Oct 2018 20:55:34 +0000
Message-ID: <20181005205512.29545-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR2001CA0018.namprd20.prod.outlook.com
 (2603:10b6:404:b4::28) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1386;20:pGUD1r0o3UDUXWs/+U4jNqiJKvUCuLfITGrT52IegschX5MaOYYH8ktpbVc4Ml8LwkOy6z6fI0fKJ8W2RKqn9KueCtHZH155y+d1M7SRD8CJhauAkvR3UfRE7p5pudCPRMYrHoqzS1Ij7gpNtVWPA75/tL7q9ASOUfAuDRKvqLKbJ+Ve1NkUub8uvm7vmOq7aXUugPLIILf4fHeiJkbfdXAIcCJIbjzcHR5D26+QJkE7BSxERbefwQl6hoX7SMSu
x-ms-office365-filtering-correlation-id: 8f610134-cc81-45a9-8bfa-08d62b04e4ee
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1386;
x-ms-traffictypediagnostic: DM5PR12MB1386:
x-microsoft-antispam-prvs: <DM5PR12MB13868DB15202A56B4008805295EB0@DM5PR12MB1386.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72170088055959)(269456686620040)(95223839027130)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302102)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:DM5PR12MB1386;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1386;
x-forefront-prvs: 0816F1D86E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(186003)(99286004)(86362001)(5660300001)(66066001)(476003)(305945005)(106356001)(316002)(5250100002)(6506007)(52116002)(97736004)(486006)(7736002)(105586002)(386003)(102836004)(2501003)(26005)(81166006)(6486002)(4326008)(110136005)(81156014)(2906002)(6436002)(54906003)(71200400001)(6512007)(478600001)(72206003)(53936002)(6306002)(8936002)(68736007)(71190400001)(14444005)(2616005)(6116002)(2900100001)(36756003)(256004)(966005)(1076002)(2201001)(25786009)(3846002)(7416002)(8676002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1386;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zpPx6c1NmKuBQJGG97ULwovDf9ZGmkDPDRUupwyqZwtlgH0B8eqgMhmZV7rRKrLGZShna/CpcLTLmiwyVuyjPvPNZ9/snIG+k8uOIsLEyP4+72n6pHGG94DyycOnZW9TJJnj1o2B3xQBGNDbYcYj/A/lrzE5uNCW5bzx6tYTYF/uTy+ilnSMso4l6qpOAk0QSPM9VzXuFAWSGeEQ90Ro/m1AH7+Lc/lcoeou2/9rxaazu1bSEvUazvsYJeXFm5CP312l5HIcJ1M2Kj4fpch9SThP/TLip5q3Sg5vC0gDu9PPHNwQerRqkCHZqnhqtBl+OQG7ZNEDhHylb5KG/uQxOCpUDV2pEBIKWmLtBUOkCbU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f610134-cc81-45a9-8bfa-08d62b04e4ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2018 20:55:34.6612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1386
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
https://www.amd.com/system/files/TechDocs/56375_Quality_of_Service_Extensio=
ns.pdf

Obviously, there are multiple ways we can go about these changes. We felt
it is appropriate to rename and re-organize the code little bit before
making the functional changes. The first few patches(1-6) renames and
re-organizes the sources in preparation. Rest of the patches(7-11) adds
support for AMD QoS features.

Please review and provide me feedback. If you think of any better way to
approach this, please let us know.=20

Changes from v1 -> v2:
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
  arch/x86: Bring all the macros to rdt.h
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
 arch/x86/kernel/cpu/{intel_rdt.c =3D> rdt.c}    | 167 +++++++++++++++---
 arch/x86/kernel/cpu/{intel_rdt.h =3D> rdt.h}    |  41 +++--
 ...el_rdt_ctrlmondata.c =3D> rdt_ctrlmondata.c} |  78 +++++++-
 .../{intel_rdt_monitor.c =3D> rdt_monitor.c}    |  29 +--
 ...el_rdt_pseudo_lock.c =3D> rdt_pseudo_lock.c} |   6 +-
 ...o_lock_event.h =3D> rdt_pseudo_lock_event.h} |   2 +-
 .../{intel_rdt_rdtgroup.c =3D> rdt_rdtgroup.c}  |  14 +-
 arch/x86/kernel/cpu/scattered.c               |   7 +-
 arch/x86/kernel/process_32.c                  |   4 +-
 arch/x86/kernel/process_64.c                  |   4 +-
 include/linux/sched.h                         |   2 +-
 14 files changed, 316 insertions(+), 89 deletions(-)
 rename arch/x86/include/asm/{intel_rdt_sched.h =3D> rdt_sched.h} (80%)
 rename arch/x86/kernel/cpu/{intel_rdt.c =3D> rdt.c} (85%)
 rename arch/x86/kernel/cpu/{intel_rdt.h =3D> rdt.h} (92%)
 rename arch/x86/kernel/cpu/{intel_rdt_ctrlmondata.c =3D> rdt_ctrlmondata.c=
} (86%)
 rename arch/x86/kernel/cpu/{intel_rdt_monitor.c =3D> rdt_monitor.c} (96%)
 rename arch/x86/kernel/cpu/{intel_rdt_pseudo_lock.c =3D> rdt_pseudo_lock.c=
} (99%)
 rename arch/x86/kernel/cpu/{intel_rdt_pseudo_lock_event.h =3D> rdt_pseudo_=
lock_event.h} (95%)
 rename arch/x86/kernel/cpu/{intel_rdt_rdtgroup.c =3D> rdt_rdtgroup.c} (99%=
)

--=20
2.17.1

