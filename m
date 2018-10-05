Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEBAC65BBE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBBBD213A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4yEzgJKT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBBBD213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbeJFD4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 23:56:31 -0400
Received: from mail-eopbgr720052.outbound.protection.outlook.com ([40.107.72.52]:2970
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729252AbeJFD4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 23:56:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r83cwQyrBfpZQIvnQs3FljSQ6YNQMFNUY5RyTP1Ot/s=;
 b=4yEzgJKT35eDnLZYdAXg7IHc9aLcKHsC5Hz+adDAstIj/X8icmyFRHAdyCWayzY8ZH/yv/LZAKvP407HcZXHUY1h2domzyzFKbEbyYRMBSnUqpHzfNYds03hi+Hlq1YIr2KeAkI9Mm6GjlVtRSXeuZbb6g0bSvOEAAxDrwqcMgs=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2504.namprd12.prod.outlook.com (52.132.141.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.23; Fri, 5 Oct 2018 20:55:56 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%2]) with mapi id 15.20.1207.024; Fri, 5 Oct 2018
 20:55:56 +0000
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
Subject: [PATCH v2 06/11] arch/x86: Use new config parameter PLATFORM_QOS for
 compilation
Thread-Topic: [PATCH v2 06/11] arch/x86: Use new config parameter PLATFORM_QOS
 for compilation
Thread-Index: AQHUXO3PoNfEh3AUv0K5cuZUo8jI2A==
Date:   Fri, 5 Oct 2018 20:55:55 +0000
Message-ID: <20181005205512.29545-7-babu.moger@amd.com>
References: <20181005205512.29545-1-babu.moger@amd.com>
In-Reply-To: <20181005205512.29545-1-babu.moger@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2504;20:DvbKfFkdyoF3CPL8lmWLmdgiGao3f+g1aSpZNbTZaPMt49/O8y8F0o1FA1/VsDROkXgDKBSWAAvRTg1DTaXeIxEO0K35OLoVj3tt+YePtEGwzxJrJGAEgZ3/8dFDoiVADrDYJbv8LnJlsJHVOR9nPPYxE7hcyge3KrwLkvUR8H8zxh0tZWHAm2DRBUMMWZ2LhlSUOZU0/hacH8npVZrnx2Ew5qSOE3eWac6wteu/tuDtCc3ytfUVeoKRC7pM6Ueo
x-ms-office365-filtering-correlation-id: c200f11e-45ea-4e59-0f24-08d62b04f1b8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2504;
x-ms-traffictypediagnostic: DM5PR12MB2504:
x-microsoft-antispam-prvs: <DM5PR12MB2504C6F7E792C62EA18A03D795EB0@DM5PR12MB2504.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302102)(93006095)(93001095)(3002001)(10201501046)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051);SRVR:DM5PR12MB2504;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2504;
x-forefront-prvs: 0816F1D86E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(366004)(396003)(189003)(199004)(110136005)(2201001)(256004)(36756003)(72206003)(102836004)(54906003)(14444005)(6512007)(305945005)(52116002)(25786009)(14454004)(53936002)(386003)(8936002)(478600001)(68736007)(105586002)(6506007)(66066001)(99286004)(86362001)(106356001)(2900100001)(7416002)(4326008)(476003)(486006)(8676002)(6116002)(76176011)(3846002)(7736002)(71190400001)(71200400001)(316002)(2906002)(186003)(11346002)(2501003)(81156014)(81166006)(446003)(5660300001)(5250100002)(6486002)(6436002)(2616005)(97736004)(26005)(1076002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2504;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Z6L716pXHkGnDX6VBClQUnmDOMeJrvivutl/oY9O2axOQ7O1elMC5+l4VvJkb5vJ4sVzFZk6Wp/rLdvClo1W03w13SUoQKvQWfClsLDgh/J+Km5IF/awwVReG+pBUpB8OgEUol5E7Dp/hJwH/efm8sc+hgSFKzXIsPmPCHAScBA7P7sE9s+Piwp21VftSZlA8SsTfqioEiVilmp48s5DWUI7FXZgZWZx3+3tLzyE26BBO9ZOjLnTx19142XmraHqXi+doj3JnGDnQ/5pLnhENMtmMYK4tRlkvNuycTsPz+oUu9ZKlbyZNBPAqmZdMsMXLXrWlXsJOMSLFIx0DSehHmv1xRx4dZbDhKkugXnM5lI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c200f11e-45ea-4e59-0f24-08d62b04f1b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2018 20:55:56.0207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2504
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use newly added config parameter PLATFORM_QOS to compile sources.
This is common parameter across both Intel and AMD.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/include/asm/rdt_sched.h | 4 ++--
 arch/x86/kernel/cpu/Makefile     | 4 ++--
 include/linux/sched.h            | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/rdt_sched.h b/arch/x86/include/asm/rdt_sc=
hed.h
index 666bf9acb41d..6018a362d1cf 100644
--- a/arch/x86/include/asm/rdt_sched.h
+++ b/arch/x86/include/asm/rdt_sched.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_RDT_SCHED_H
 #define _ASM_X86_RDT_SCHED_H
=20
-#ifdef CONFIG_INTEL_RDT
+#ifdef CONFIG_PLATFORM_QOS
=20
 #include <linux/sched.h>
 #include <linux/jump_label.h>
@@ -88,6 +88,6 @@ static inline void rdt_sched_in(void)
=20
 static inline void rdt_sched_in(void) {}
=20
-#endif /* CONFIG_INTEL_RDT */
+#endif /* CONFIG_PLATFORM_QOS */
=20
 #endif /* _ASM_X86_RDT_SCHED_H */
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 6c35d89f174f..8655adc84f11 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -35,8 +35,8 @@ obj-$(CONFIG_CPU_SUP_CENTAUR)		+=3D centaur.o
 obj-$(CONFIG_CPU_SUP_TRANSMETA_32)	+=3D transmeta.o
 obj-$(CONFIG_CPU_SUP_UMC_32)		+=3D umc.o
=20
-obj-$(CONFIG_INTEL_RDT)	+=3D rdt.o rdt_rdtgroup.o rdt_monitor.o
-obj-$(CONFIG_INTEL_RDT)	+=3D rdt_ctrlmondata.o rdt_pseudo_lock.o
+obj-$(CONFIG_PLATFORM_QOS)	+=3D rdt.o rdt_rdtgroup.o rdt_monitor.o
+obj-$(CONFIG_PLATFORM_QOS)	+=3D rdt_ctrlmondata.o rdt_pseudo_lock.o
 CFLAGS_rdt_pseudo_lock.o =3D -I$(src)
=20
 obj-$(CONFIG_X86_MCE)			+=3D mcheck/
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 977cb57d7bc9..1a4d00b7a5b1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -985,7 +985,7 @@ struct task_struct {
 	/* cg_list protected by css_set_lock and tsk->alloc_lock: */
 	struct list_head		cg_list;
 #endif
-#ifdef CONFIG_INTEL_RDT
+#ifdef CONFIG_PLATFORM_QOS
 	u32				closid;
 	u32				rmid;
 #endif
--=20
2.17.1

