Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F903ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE7D12145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mQP4EucD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE7D12145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732799AbeIYBWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:22:51 -0400
Received: from mail-eopbgr710081.outbound.protection.outlook.com ([40.107.71.81]:24357
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731044AbeIYBWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DR/a+/iZNRqljvcafmZzbgAoDsx79HUJL23krCJ1w14=;
 b=mQP4EucDP85p8HPJZtyXVy6EUPEt0/EZr7f7yPSC27AzC7JL+4lt/9mfDXJGITWiMiPye6DAhYo18xb6zdLTFcCtRvT7rHWogNlQ75XG5Xi22CoGCRjZm20I0LQ+/vf+9MqnT+N6iXJEH9on1vVDfOMaPlFZtT44rw5/zv1LFRI=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2455.namprd12.prod.outlook.com (52.132.141.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Mon, 24 Sep 2018 19:19:07 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::5c18:7df5:fd4b:9de]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::5c18:7df5:fd4b:9de%5]) with mapi id 15.20.1164.024; Mon, 24 Sep 2018
 19:19:07 +0000
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
Subject: [RFC PATCH 06/10] arch/x86: Initialize the resource functions that
 are different
Thread-Topic: [RFC PATCH 06/10] arch/x86: Initialize the resource functions
 that are different
Thread-Index: AQHUVDt2BjQ8Krcjz0mZSUcWMkilQw==
Date:   Mon, 24 Sep 2018 19:19:07 +0000
Message-ID: <20180924191841.29111-7-babu.moger@amd.com>
References: <20180924191841.29111-1-babu.moger@amd.com>
In-Reply-To: <20180924191841.29111-1-babu.moger@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2455;20:xT5yB35A6B7m9ZC3UP31Oiu3mOtrw2LhAYcTSKtl2uGq/0M5bemHA3j/IzLVb0o7QMihuWtwmatxY5gxGBhBd5IGlrQZo4nHWNHJZBx10Ad8lsXLqGqyVieoEeV9LUDMlzsCNiyKYjoqyWFmbxcDVHe4CQXQUdkmr/WQUam2uRPI4PZ24/p9bRv1VPwWffjiHs3H4LoGsrUk3FDgCEMCooqpvJ9RGGZf/EFc5VnLViXhTclHyjng+2hhRo22uV5q
x-ms-office365-filtering-correlation-id: 311925cf-9f80-4ae5-6f43-08d6225298e1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2455;
x-ms-traffictypediagnostic: DM5PR12MB2455:
x-microsoft-antispam-prvs: <DM5PR12MB2455627B6F31196C9EE7B49695170@DM5PR12MB2455.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149066)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051);SRVR:DM5PR12MB2455;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2455;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(366004)(396003)(376002)(189003)(199004)(97736004)(217873002)(256004)(14444005)(2501003)(5250100002)(316002)(2900100001)(52116002)(7736002)(68736007)(305945005)(5660300001)(1076002)(76176011)(386003)(66066001)(6506007)(478600001)(72206003)(25786009)(7416002)(14454004)(4326008)(6436002)(106356001)(8936002)(8676002)(81156014)(81166006)(6512007)(36756003)(53936002)(26005)(2906002)(3846002)(6116002)(6486002)(54906003)(86362001)(110136005)(102836004)(186003)(2201001)(486006)(71200400001)(446003)(476003)(11346002)(99286004)(2616005)(71190400001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2455;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: clmmhFud1+hljIZyXuD+okrHGgYNpvNPwSfHD3ihZ7XJOKkicuN1nKXKr25DUnAG0JuLTa7ZAg1rQUwSNAwFY5l1aef5PnexRItQhLgylui0PLB/XMU6nrjCmYgdVCsIig+46VpSiLyVLzq9fED5aL5p+mUT8kfUNE9yuZD8L7VO7Ttly9AST1jUde3ZTILJzNPkH9TK2Wm9sgvyJ6MQglbU9hgReRisTRK+K4GFFfQf/jEZC2dr27bw6AXZxpx461ZDDUc56RvAwD00tt9tzSz8jMAKif8HEiVNS9UWn3HAG0kOHCdXt7+RMyz0IjYRLUWe+ChBBpXqWl8p5IKcrUB7IEqKihalkpca21c0zVw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 311925cf-9f80-4ae5-6f43-08d6225298e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 19:19:07.7124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2455
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize the resource functions that are different between the
vendors. Some features are initialized differently between the vendors.

For example, MBA feature varies significantly between Intel and AMD.
Separate the initialization of these resource functions. That way we
can easily add AMD's functions later.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/rdt.c | 28 +++++++++++++++++++++++++---
 arch/x86/kernel/cpu/rdt.h |  4 ++++
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/rdt.c b/arch/x86/kernel/cpu/rdt.c
index 736715b81fd8..6dec45bf81d6 100644
--- a/arch/x86/kernel/cpu/rdt.c
+++ b/arch/x86/kernel/cpu/rdt.c
@@ -174,10 +174,7 @@ struct rdt_resource rdt_resources_all[] =3D {
 		.rid			=3D RDT_RESOURCE_MBA,
 		.name			=3D "MB",
 		.domains		=3D domain_init(RDT_RESOURCE_MBA),
-		.msr_base		=3D IA32_MBA_THRTL_BASE,
-		.msr_update		=3D mba_wrmsr,
 		.cache_level		=3D 3,
-		.parse_ctrlval		=3D parse_bw,
 		.format_str		=3D "%d=3D%*u",
 		.fflags			=3D RFTYPE_RES_MB,
 	},
@@ -865,6 +862,25 @@ static __init void rdt_check_mba(void)
 		rdt_get_mem_config(&rdt_resources_all[RDT_RESOURCE_MBA]);
 }
=20
+static __init void rdt_init_res_defs_intel(void)
+{
+	struct rdt_resource *r;
+
+	for_each_rdt_resource(r) {
+		if (r->rid =3D=3D RDT_RESOURCE_MBA) {
+			r->msr_base =3D IA32_MBA_THRTL_BASE;
+			r->msr_update =3D mba_wrmsr;
+			r->parse_ctrlval =3D parse_bw;
+		}
+	}
+}
+
+static __init void rdt_init_res_defs(void)
+{
+	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL)
+		rdt_init_res_defs_intel();
+}
+
 static enum cpuhp_state rdt_online;
=20
 static int __init rdt_late_init(void)
@@ -875,6 +891,12 @@ static int __init rdt_late_init(void)
 	/* Run quirks first */
 	rdt_quirks();
=20
+	/*
+	 * Initialize functions(or definitions) that are different
+	 * between vendors here.
+	 */
+	rdt_init_res_defs();
+
 	rdt_alloc_capable =3D get_rdt_alloc_resources();
 	rdt_mon_capable =3D get_rdt_mon_resources();
=20
diff --git a/arch/x86/kernel/cpu/rdt.h b/arch/x86/kernel/cpu/rdt.h
index c15417a6b1af..2569c10c37f4 100644
--- a/arch/x86/kernel/cpu/rdt.h
+++ b/arch/x86/kernel/cpu/rdt.h
@@ -455,6 +455,10 @@ enum {
 	RDT_NUM_RESOURCES,
 };
=20
+#define for_each_rdt_resource(r)					      \
+	for (r =3D rdt_resources_all; r < rdt_resources_all + RDT_NUM_RESOURCES;\
+	     r++)
+
 #define for_each_capable_rdt_resource(r)				      \
 	for (r =3D rdt_resources_all; r < rdt_resources_all + RDT_NUM_RESOURCES;\
 	     r++)							      \
--=20
2.17.1

