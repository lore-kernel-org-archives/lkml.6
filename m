Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52640ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0851E204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="G6eroZyE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0851E204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbeJSGzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 02:55:35 -0400
Received: from mail-by2nam01on0071.outbound.protection.outlook.com ([104.47.34.71]:57077
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726733AbeJSGze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 02:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSkVNqzTsChJS3//fCVF8HJxPA7aGblrkMrU0BiCYc0=;
 b=G6eroZyEg22z+e5uSjuy1U5JhAA5wwZjdgDp653H/FiwdK9BDTQujop//SX42twT/F08ehFmmKq310T1QRV7SnHw0zxdPoot1e3hXjGFxwVb4ToePptYeoy4h2sMn21DWBBTLloeNvqH235Bju7XHZPDltUqB7ANzi2XfXu10tg=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1818.namprd12.prod.outlook.com (10.175.91.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.25; Thu, 18 Oct 2018 22:52:16 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%3]) with mapi id 15.20.1250.028; Thu, 18 Oct 2018
 22:52:16 +0000
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
Subject: [PATCH v5 06/13] arch/x86: Use new config parameter RESCTRL for
 compilation
Thread-Topic: [PATCH v5 06/13] arch/x86: Use new config parameter RESCTRL for
 compilation
Thread-Index: AQHUZzU3rYg0FtdLUUqq+VLh/BaKyQ==
Date:   Thu, 18 Oct 2018 22:52:16 +0000
Message-ID: <20181018225124.23043-7-babu.moger@amd.com>
References: <20181018225124.23043-1-babu.moger@amd.com>
In-Reply-To: <20181018225124.23043-1-babu.moger@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1818;20:McnNTfDz2LKN5uxe0nJvgGNvcEH40aJ4+G0vH00r5VcNSu8/kWGueG9m/JbheToekdc5FC3BKqKVixrdezWOmBzHSlR+lUICv4fa9maymtXlipu5KEqTtaEmn0iRcotTj31f/PxSQuM+/Ipt+/pGArxq6tZGD8MTY21fSpZxz+4zmWnevS+JqmoXbC0zJGiSj5rZ2RaEKmjYdtgRVQhHTZYDrqdQbVhYpBuxqw4KuLyMXpFx9XDsVKHddXxFacs6
x-ms-office365-filtering-correlation-id: 778a34f1-7d52-4e57-1b1a-08d6354c5963
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1818;
x-ms-traffictypediagnostic: DM5PR12MB1818:
x-microsoft-antispam-prvs: <DM5PR12MB18182FD5A23866BFC2A4104395F80@DM5PR12MB1818.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1818;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1818;
x-forefront-prvs: 08296C9B35
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(110136005)(478600001)(2201001)(8936002)(5660300001)(7406005)(14454004)(7416002)(1076002)(6486002)(6512007)(5250100002)(6436002)(68736007)(72206003)(54906003)(66066001)(106356001)(3846002)(186003)(26005)(86362001)(2616005)(2906002)(476003)(99286004)(81166006)(102836004)(81156014)(6116002)(53936002)(486006)(52116002)(446003)(36756003)(76176011)(386003)(316002)(2501003)(7736002)(11346002)(6506007)(8676002)(2900100001)(25786009)(305945005)(71200400001)(71190400001)(105586002)(14444005)(256004)(97736004)(4326008)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1818;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: tMH+SO8oNm/3VJhm7c8AjgRaR+W6Kuqubj1wfved/w+QZGiFttzkap19Jp8rUQSOTR1/jkNZo8gQ0yp+5eUrph7fuCLtSB3jAVNHfuFQ+OlOspUByDdHkxRqq+7BNAI+EODuyfg9iq4o0SO8UkIRXk3XTsAZiyD2en6ES5+Pns4ctGB61Di1ieMH18su0QvldBnbMC53qUEVofmJ/5veeQEuj8jKPCA4/GMpV0RhNPMQx02BR2l/llZY5e8C31S0jvalq8dtR0JcNaEphKqf0fbDcyl6pdX8YTk2TkolxeZYhE5EmSMmjqqanao14E9DhcNw4eXQ0T890+GwYUVEKcl5+jojWBVrVVpChYxvaTc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 778a34f1-7d52-4e57-1b1a-08d6354c5963
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2018 22:52:16.2394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1818
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

