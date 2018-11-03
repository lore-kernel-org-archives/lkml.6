Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC65C32789
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 00:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691DD2081B
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 00:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="mpw6Z1b6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691DD2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbeKCJYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 05:24:22 -0400
Received: from mail-eopbgr730092.outbound.protection.outlook.com ([40.107.73.92]:50275
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726083AbeKCJYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 05:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ktaS7IORjoJby985sF0lD2Hi9bO/bycGYpTo24IpLc=;
 b=mpw6Z1b6aV73IVcSQpoVdwAFW4pEdPiC7wVp3usZmfpkI3BCdK7OIkc3rJ8weivfKkUrT1yYvuzLJDKoZjYKGAqh/Uf14SAnRhGd5FO9jDkGthpUWFqOTlBdGxSxVykaCFGiS7Mvd/WrU6Jdpbn05VwFPMJm+LbkkiKJ6lsq6FY=
Received: from MWHPR21MB0766.namprd21.prod.outlook.com (10.173.51.20) by
 MWHPR21MB0286.namprd21.prod.outlook.com (10.173.53.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1294.2; Sat, 3 Nov 2018 00:14:59 +0000
Received: from MWHPR21MB0766.namprd21.prod.outlook.com
 ([fe80::1982:5e59:2489:88e6]) by MWHPR21MB0766.namprd21.prod.outlook.com
 ([fe80::1982:5e59:2489:88e6%14]) with mapi id 15.20.1339.000; Sat, 3 Nov 2018
 00:14:59 +0000
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
Subject: [PATCH v3 0/4] Subject: Enable Linux guests on Hyper-V on ARM64
Thread-Topic: [PATCH v3 0/4] Subject: Enable Linux guests on Hyper-V on ARM64
Thread-Index: AQHUcwpCUQj7EpoJEUyYUEdcukF0Fw==
Date:   Sat, 3 Nov 2018 00:14:59 +0000
Message-ID: <1541204037-18043-1-git-send-email-mikelley@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR21MB0286;6:fEjvlXWtyDp1yN6JLvhfngh4YyAAzKritIV4LJd8SPu4WW0T9CAIuYTrrnAOUU40Low11AmcmgSxp3plBNYJW9Ab/azLR/Higz3PQNlDVgaGJLIfoWVRxxZuPoNSZOPorD/YlZ1x8WM0OldQ8dUz2ZxW9ZXt4XXKafTvtdtouAnhvefFpEAwsyN3XOP4Z5AnApcsKWyYF1IGAIeC3RoEMWLxgT9YTaRijBdfNy8FtCg9CPHFvcYP8g5OTt8iFBpCO98GpXZs3ML/U5WAQmScANOJCSQ7x+ZXj0GVz4VHEyFqNQ9FdvzUES2I5UFHc6VYcYW1f/XWp6r5hA7h1+jpB3SfbxX5vyp4f1RZAFOgzuOximP/GKitKiiw/Ijp4yBquJaPs/pRM3oAXfe2ocMLGMA+4mE8EGjeXLrGFad3Hy9119uA8p6YoXqtXLlaspFaFWjIPfgi3uov3QaLk1Ueqg==;5:F09KVNU7kKuqxSiyVOB1y4/0q6HCRKYtnEBgsjiaWFwxx/CvSR2DsFgLgDSbhziILKCHPxUH1kfMoXwqN8yZFwvCvdhDjHMOlDUQW2DrlMPy37KL6ghLyJk49/Mstcn3ogk9gpz1zVqP3qIc+kCFkalFdQiN4rHTHp+uUw7Iw60=;7:wBY862DNrt5KyqyABrvh2sk9l0FX55ThWySYXSbZyn28wQ4qd2fi0/OUYp8b/soNcoZOt6ph04CKrXCW3KOov/OEp7shw5fr21OPPJcyDmqfQ9N8s2K718ih8vlnTqJh8U9BnVKC4Rad523S5FsxQg==
x-ms-office365-filtering-correlation-id: ac1fa257-7575-47bb-c051-08d641216490
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR21MB0286;
x-ms-traffictypediagnostic: MWHPR21MB0286:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-o365eop-header: O365_EOP: Allow for Unauthenticated Relay
x-o365ent-eop-header: Message processed by -  O365_ENT: Allow from ranges
 (Engineering ONLY)
x-microsoft-antispam-prvs: <MWHPR21MB028616FE213CB51F86FA56B8D7C80@MWHPR21MB0286.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(8121501046)(5005006)(10201501046)(3231382)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:MWHPR21MB0286;BCL:0;PCL:0;RULEID:;SRVR:MWHPR21MB0286;
x-forefront-prvs: 08457955C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(136003)(366004)(39860400002)(189003)(199004)(6506007)(316002)(386003)(2501003)(7736002)(81156014)(81166006)(2201001)(22452003)(2900100001)(99286004)(66066001)(8936002)(53936002)(476003)(3846002)(14454004)(110136005)(10090500001)(36756003)(5660300001)(6636002)(1511001)(86362001)(305945005)(8676002)(52116002)(86612001)(6116002)(4326008)(14444005)(7416002)(256004)(97736004)(102836004)(486006)(10290500003)(71200400001)(71190400001)(6512007)(6486002)(25786009)(186003)(105586002)(26005)(2616005)(107886003)(68736007)(478600001)(106356001)(2906002)(6436002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0286;H:MWHPR21MB0766.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: D5iRqfiSRL11Wa2TWc7rJ9+G5mok8aMJaUw/jZkSkDyVLyPkpRbVe9fttCBFPlvmkRPrWHlYLD0EP9nFbxoM196soHZmma/dQ32eiyVz/AMeQbR1dimD2yaXFz8XBnsCJFR8vpm/mQIpCcuzXVQcei3vTo7qYYrSgm3UfmsI5OsBVUMK/TEW5w/2nEgTGLy3sjtCjAgLp31ad88+K3wa4pNnQSPHDvEZD2XbtHzZsQFFuZoyqz5BZF/CfqvAArmsxRHVV9I01QbgTpNYFVoMUap2fWY+fEuKNblyg/L5PnfUCXnYnaS4Tqce0y38LoxryZ2nnPz4dJhX7g1eg4vC/PiFmLjgaKaugIPumHBLjVY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac1fa257-7575-47bb-c051-08d641216490
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2018 00:14:59.8313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0286
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables Linux guests running on Hyper-V on ARM64
hardware. New ARM64-specific code in arch/arm64/hyperv initializes
Hyper-V, including its synthetic clocks and hypercall mechanism.
Existing architecture independent drivers for Hyper-V's VMbus and
synthetic devices just work when built for ARM64. Hyper-V code is
built and included in the image and modules only if CONFIG_HYPERV
is enabled.

The four patches are organized as follows:
1) Add include files that define the Hyper-V interface as
   described in the Hyper-V Top Level Functional Spec (TLFS), plus
   additional definitions specific to Linux running on Hyper-V.

2) Add core Hyper-V support on ARM64, including hypercalls,
   synthetic clock initialization, and interrupt handlers.

3) Update the existing VMbus driver to generalize interrupt
   management across x86/x64 and ARM64.

4) Make CONFIG_HYPERV selectable on ARM64 in addition to x86/x64.

Some areas of Linux guests on Hyper-V on ARM64 are a work-
in-progress, primarily due to work still being done in Hyper-V:

* Hyper-V on ARM64 currently runs with a 4 Kbyte page size, and only
  supports guests with a 4 Kbyte page size. Because Hyper-V uses
  shared pages to communicate between the guest and the hypervisor,
  there are open design decisions on the page size to use when
  the guest is using 16K/64K pages.  Once those issues are
  resolved and Hyper-V fully supports 16K/64K guest pages, changes
  may be needed in the Linux drivers for Hyper-V synthetic devices.

* Hyper-V on ARM64 does not currently support mapping PCI devices
  into the guest address space. The Hyper-V PCI driver at
  drivers/pci/host/pci-hyperv.c has x86/x64-specific code and is
  not being built for ARM64.

In a few cases, terminology from the x86/x64 world has been carried
over into the ARM64 code ("MSR", "TSC").  Hyper-V still uses the
x86/x64 terminology and has not replaced it with something more
generic, so the code uses the Hyper-V terminology.  This will be
fixed when Hyper-V updates the usage in the TLFS.

Changes in v3:
* Added initialization of hv_vp_index array like was recently
  added on x86 branch [KY Srinivasan]
* Changed Hyper-V ARM64 register symbols to be all uppercase=20
  instead of mixed case [KY Srinivasan]
* Separated mshyperv.h into two files, one architecture
  independent and one architecture dependent. After this code
  is upstream, will make changes to the x86 code to use the
  architecture independent file and remove duplication. And
  once we have a multi-architecture Hyper-V TLFS, will do a
  separate patch to split hyperv-tlfs.h in the same way.
  [KY Srinivasan]
* Minor tweaks to rebase to latest linux-next code

Changes in v2:
* Removed patch to implement slow_virt_to_phys() on ARM64.
  Use of slow_virt_to_phys() in arch independent Hyper-V
  drivers has been eliminated by commit 6ba34171bcbd
  ("Drivers: hv: vmbus: Remove use of slow_virt_to_phys()")
* Minor tweaks to rebase to latest linux-next code

Michael Kelley (4):
  arm64: hyperv: Add core Hyper-V include files
  arm64: hyperv: Add support for Hyper-V as a hypervisor
  Drivers: hv: vmbus: Add hooks for per-CPU IRQ
  Drivers: hv: Enable CONFIG_HYPERV on ARM64

 MAINTAINERS                          |   4 +
 arch/arm64/Makefile                  |   1 +
 arch/arm64/hyperv/Makefile           |   2 +
 arch/arm64/hyperv/hv_hvc.S           |  54 +++++
 arch/arm64/hyperv/hv_init.c          | 441 +++++++++++++++++++++++++++++++=
++++
 arch/arm64/hyperv/mshyperv.c         | 178 ++++++++++++++
 arch/arm64/include/asm/hyperv-tlfs.h | 338 +++++++++++++++++++++++++++
 arch/arm64/include/asm/mshyperv.h    | 116 +++++++++
 arch/x86/include/asm/mshyperv.h      |   4 +
 drivers/hv/Kconfig                   |   3 +-
 drivers/hv/hv.c                      |   2 +
 include/asm-generic/mshyperv.h       | 240 +++++++++++++++++++
 12 files changed, 1382 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/hyperv/Makefile
 create mode 100644 arch/arm64/hyperv/hv_hvc.S
 create mode 100644 arch/arm64/hyperv/hv_init.c
 create mode 100644 arch/arm64/hyperv/mshyperv.c
 create mode 100644 arch/arm64/include/asm/hyperv-tlfs.h
 create mode 100644 arch/arm64/include/asm/mshyperv.h
 create mode 100644 include/asm-generic/mshyperv.h

--=20
1.8.3.1

