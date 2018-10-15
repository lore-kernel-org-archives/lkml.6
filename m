Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D449DC71144
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E52F208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TzrJCyuH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E52F208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbeJPEnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 00:43:04 -0400
Received: from mail-sn1nam02on0078.outbound.protection.outlook.com ([104.47.36.78]:20160
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726911AbeJPEnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 00:43:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSkVNqzTsChJS3//fCVF8HJxPA7aGblrkMrU0BiCYc0=;
 b=TzrJCyuHbFrVm3gc18uzrclwrIBuRdSKABkfRjPD17of7hGBWGJZu5mKf8PObreu2z6P56AmyCpJM1E2RXBxEqIjNsOhNLAKmF+uKD1lttd0FsnY/7jUMie6u9QXb9JVQ4Gu5mzGzLvE7aYilCZvgUYUW8xzy7hywh7FQikUeHA=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1850.namprd12.prod.outlook.com (10.175.86.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Mon, 15 Oct 2018 20:55:44 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%3]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 20:55:44 +0000
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
Subject: [PATCH v4 06/13] arch/x86: Use new config parameter RESCTRL for
 compilation
Thread-Topic: [PATCH v4 06/13] arch/x86: Use new config parameter RESCTRL for
 compilation
Thread-Index: AQHUZMlwaj6B8LH3RkatJYeuFUY2ag==
Date:   Mon, 15 Oct 2018 20:55:44 +0000
Message-ID: <20181015205514.25387-7-babu.moger@amd.com>
References: <20181015205514.25387-1-babu.moger@amd.com>
In-Reply-To: <20181015205514.25387-1-babu.moger@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1850;20:fjuNMFp7K5Risn4sm9PPTdNBqffGQuWUyWKQcbyVUE/imyMHpbhec0kow8/hox9gn3G2xlhWshll/gthSNsVK8s/lyA0jSS3wG4e15PAqWmPJDwpz5eLInOnf05WxdO2+MswWX7VYXMizsHj5OCh7WtTM8NUxG+DaZzuin95Rp6EjJft+QPL3yv2w4khLHnipMD/vyppzMpOXzloPt7SbNRMjNfTGmgadXBc2joEtWuDT5z+/1R19PitUtEbaHLY
x-ms-office365-filtering-correlation-id: 7e80d74c-ad4d-4b61-abd8-08d632e092fe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1850;
x-ms-traffictypediagnostic: DM5PR12MB1850:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-microsoft-antispam-prvs: <DM5PR12MB18503E2C6D21ADA5215F642695FD0@DM5PR12MB1850.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991067);SRVR:DM5PR12MB1850;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1850;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(376002)(396003)(39860400002)(189003)(199004)(54906003)(106356001)(81156014)(8676002)(52116002)(305945005)(105586002)(5660300001)(110136005)(2900100001)(6436002)(6512007)(53936002)(6486002)(2201001)(8936002)(81166006)(446003)(256004)(476003)(86362001)(11346002)(99286004)(5250100002)(36756003)(486006)(2501003)(478600001)(72206003)(97736004)(71190400001)(25786009)(76176011)(71200400001)(1076002)(2616005)(26005)(386003)(14454004)(6506007)(186003)(66066001)(102836004)(7736002)(7416002)(316002)(4326008)(68736007)(3846002)(14444005)(2906002)(6116002)(7406005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1850;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HVPNtV/N0jEj8xPbiC+AilYQUwnS4K8M3ah5dVOaiKzjou+slIzpRNt6IGtG9l1rkLDOAHMKxSYsRTMXpDVPKV52O+dQ1bPa+sHqLhAqCBP5pMIzB96k1ldnhXeud95JROKqafzVLHhQMPIhoGAxHumhkhuymeQC8ul8DXLLpjDK6QXblBP8HvIpaJEqPT3IVQCd0TM0lMCrG9sYDZdTrmntf7vFK87ZmVYRhpuK5PtENeJSwkFSglz6XXKRXa+DzxAl2877qyz5pAg2TSducxUsIr+Z++0+bkZfY6dkHO1ZNzvy8eYP0f72Dfqs+kZj4Y0sQTGg/fZ55O/PYy5quK6ws5tPAbixfjvIhc7XZpc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e80d74c-ad4d-4b61-abd8-08d632e092fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 20:55:44.5064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1850
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use newly added config parameter RESCTRL to compile sources.
This is common parameter across both Intel and AMD.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/include/asm/resctrl_sched.h | 4 ++--
 arch/x86/kernel/cpu/Makefile         | 4 ++--
 include/linux/sched.h                | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/resctrl_sched.h b/arch/x86/include/asm/re=
sctrl_sched.h
index 6e082697a613..54990fe2a3ae 100644
--- a/arch/x86/include/asm/resctrl_sched.h
+++ b/arch/x86/include/asm/resctrl_sched.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_RESCTRL_SCHED_H
 #define _ASM_X86_RESCTRL_SCHED_H
=20
-#ifdef CONFIG_INTEL_RDT
+#ifdef CONFIG_RESCTRL
=20
 #include <linux/sched.h>
 #include <linux/jump_label.h>
@@ -88,6 +88,6 @@ static inline void resctrl_sched_in(void)
=20
 static inline void resctrl_sched_in(void) {}
=20
-#endif /* CONFIG_INTEL_RDT */
+#endif /* CONFIG_RESCTRL */
=20
 #endif /* _ASM_X86_RESCTRL_SCHED_H */
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 222cf8cc078d..79279953c5f9 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -35,8 +35,8 @@ obj-$(CONFIG_CPU_SUP_CENTAUR)		+=3D centaur.o
 obj-$(CONFIG_CPU_SUP_TRANSMETA_32)	+=3D transmeta.o
 obj-$(CONFIG_CPU_SUP_UMC_32)		+=3D umc.o
=20
-obj-$(CONFIG_INTEL_RDT)	+=3D resctrl.o resctrl_rdtgroup.o resctrl_monitor.=
o
-obj-$(CONFIG_INTEL_RDT)	+=3D resctrl_ctrlmondata.o resctrl_pseudo_lock.o
+obj-$(CONFIG_RESCTRL)	+=3D resctrl.o resctrl_rdtgroup.o resctrl_monitor.o
+obj-$(CONFIG_RESCTRL)	+=3D resctrl_ctrlmondata.o resctrl_pseudo_lock.o
 CFLAGS_resctrl_pseudo_lock.o =3D -I$(src)
=20
 obj-$(CONFIG_X86_MCE)			+=3D mcheck/
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 977cb57d7bc9..c4cf94c447b2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -985,7 +985,7 @@ struct task_struct {
 	/* cg_list protected by css_set_lock and tsk->alloc_lock: */
 	struct list_head		cg_list;
 #endif
-#ifdef CONFIG_INTEL_RDT
+#ifdef CONFIG_RESCTRL
 	u32				closid;
 	u32				rmid;
 #endif
--=20
2.17.1

