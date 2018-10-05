Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6A2C65BBE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C86F9213A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1e+VsvzL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C86F9213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbeJFD4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 23:56:35 -0400
Received: from mail-eopbgr720053.outbound.protection.outlook.com ([40.107.72.53]:11230
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729252AbeJFD4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 23:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pp8tMSVHkWFS3ItloqMBLLKYnjsh7xjNoC49B8kI1es=;
 b=1e+VsvzLy2ZadM5hysivF799T9REuB0agX0D+4cmGY6QQXGIJSIj4hSOyC8QcCx9hfbTVHvCEekdc/icMHkoqcNOOGgR40JXH3Hjz1+UElO76XnPjL+wARVnK27BcASfQy9s1l4Ryauu8M/Sg/FPX7QtzzzE/Sf14RWFCeEad1s=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2504.namprd12.prod.outlook.com (52.132.141.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.23; Fri, 5 Oct 2018 20:55:59 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%2]) with mapi id 15.20.1207.024; Fri, 5 Oct 2018
 20:55:59 +0000
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
Subject: [PATCH v2 07/11] arch/x86: Initialize the resource functions that are
 different
Thread-Topic: [PATCH v2 07/11] arch/x86: Initialize the resource functions
 that are different
Thread-Index: AQHUXO3RKpKecNr1j0SojII0eXo5EA==
Date:   Fri, 5 Oct 2018 20:55:59 +0000
Message-ID: <20181005205512.29545-8-babu.moger@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2504;20:ooPEDVFHwlWJ3RFTZv5ajt/+ILjH43gqv88FCjA7NIDV8mhYdrLMDSEqJ+f3ZFA861Ho7Ssua7Vb7+FzsqnHoLNNFBMDnkjeGsilVZPEaXqNBovChpR3pCXaxdDYtOiPJ8haUb2ssB3RPg+YXCK2DBeeJmoKnTZJ6uKnYo9D2NlGoU09J05QVsxFcmwPS/YqNFhIHMhY2f1iVYcu5qWvF3r733uJW9JPL3mHJHS3mzixX0ph/kVw/vP7iZ7a/Zw5
x-ms-office365-filtering-correlation-id: 0707ba4e-552b-4f00-5a24-08d62b04f3c9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2504;
x-ms-traffictypediagnostic: DM5PR12MB2504:
x-microsoft-antispam-prvs: <DM5PR12MB2504F1A58F8A63C049D65FBF95EB0@DM5PR12MB2504.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302102)(93006095)(93001095)(3002001)(10201501046)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051);SRVR:DM5PR12MB2504;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2504;
x-forefront-prvs: 0816F1D86E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(366004)(396003)(189003)(199004)(110136005)(2201001)(256004)(36756003)(72206003)(102836004)(54906003)(14444005)(6512007)(305945005)(52116002)(25786009)(14454004)(53936002)(386003)(8936002)(478600001)(68736007)(105586002)(6506007)(66066001)(99286004)(86362001)(106356001)(2900100001)(7416002)(4326008)(476003)(486006)(8676002)(6116002)(76176011)(3846002)(7736002)(71190400001)(71200400001)(316002)(2906002)(186003)(11346002)(2501003)(81156014)(81166006)(446003)(5660300001)(5250100002)(6486002)(6436002)(2616005)(97736004)(26005)(1076002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2504;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ers6OgAJkJ2sH/G7HeiTUTYqY7RfeKuZ9L38mb6DDeZ7fam0mixjO9aCiMN+hyMdBBQTR8iXlRjGWJe29o5rdXwUgMWKz6g16hpp3tzxRN0D1UsA+7s00y6X2ghpR9ajUhbOOZ6r5zFliK2dd1jsQpvD8h1d2IG0+BOd90IZjWdA87oMEF5JaZDAlwdFVmV5XIEioi+eGYbctaCZGLkGvUlLlhzfJiznYLgo9DYUp4YtULzp4Mpj5rQSSYNZOu3+x34Xso8VouzHZc1wP9sadmz5VBoM4eUpek9Fg+nQmbuGX/76ToRIm3F7tHGiw2l/l4EYTnzHtVPG66yxqGkG5KnEMLauLhzpiO4Q2fboW6c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0707ba4e-552b-4f00-5a24-08d62b04f3c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2018 20:55:59.3958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2504
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize the resource functions that are different between the
vendors. Some features are initialized differently between the vendors.
Add _intel suffix to Intel specific functions.

For example, MBA feature varies significantly between Intel and AMD.
Separate the initialization of these resource functions. That way we
can easily add AMD's functions later.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/rdt.c             | 34 +++++++++++++++++++++++----
 arch/x86/kernel/cpu/rdt.h             |  8 +++++--
 arch/x86/kernel/cpu/rdt_ctrlmondata.c |  2 +-
 3 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/rdt.c b/arch/x86/kernel/cpu/rdt.c
index 87fe073a0571..9680a43d9485 100644
--- a/arch/x86/kernel/cpu/rdt.c
+++ b/arch/x86/kernel/cpu/rdt.c
@@ -57,7 +57,8 @@ int max_name_width, max_data_width;
 bool rdt_alloc_capable;
=20
 static void
-mba_wrmsr(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *=
r);
+mba_wrmsr_intel(struct rdt_domain *d, struct msr_param *m,
+		struct rdt_resource *r);
 static void
 cat_wrmsr(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *=
r);
=20
@@ -171,10 +172,7 @@ struct rdt_resource rdt_resources_all[] =3D {
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
@@ -356,7 +354,8 @@ u32 delay_bw_map(unsigned long bw, struct rdt_resource =
*r)
 }
=20
 static void
-mba_wrmsr(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *=
r)
+mba_wrmsr_intel(struct rdt_domain *d, struct msr_param *m,
+		struct rdt_resource *r)
 {
 	unsigned int i;
=20
@@ -870,6 +869,25 @@ static __init bool get_rdt_resources(void)
 	return (rdt_mon_capable || rdt_alloc_capable);
 }
=20
+static __init void rdt_init_res_defs_intel(void)
+{
+	struct rdt_resource *r;
+
+	for_each_rdt_resource(r) {
+		if (r->rid =3D=3D RDT_RESOURCE_MBA) {
+			r->msr_base =3D IA32_MBA_THRTL_BASE;
+			r->msr_update =3D mba_wrmsr_intel;
+			r->parse_ctrlval =3D parse_bw_intel;
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
@@ -877,6 +895,12 @@ static int __init rdt_late_init(void)
 	struct rdt_resource *r;
 	int state, ret;
=20
+	/*
+	 * Initialize functions(or definitions) that are different
+	 * between vendors here.
+	 */
+	rdt_init_res_defs();
+
 	/* Run quirks first */
 	rdt_quirks();
=20
diff --git a/arch/x86/kernel/cpu/rdt.h b/arch/x86/kernel/cpu/rdt.h
index 8431af5c6825..42bf239313a0 100644
--- a/arch/x86/kernel/cpu/rdt.h
+++ b/arch/x86/kernel/cpu/rdt.h
@@ -444,8 +444,8 @@ struct rdt_resource {
=20
 int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
 	      struct rdt_domain *d);
-int parse_bw(struct rdt_parse_data *data, struct rdt_resource *r,
-	     struct rdt_domain *d);
+int parse_bw_intel(struct rdt_parse_data *data, struct rdt_resource *r,
+		   struct rdt_domain *d);
=20
 extern struct mutex rdtgroup_mutex;
=20
@@ -468,6 +468,10 @@ enum {
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
diff --git a/arch/x86/kernel/cpu/rdt_ctrlmondata.c b/arch/x86/kernel/cpu/rd=
t_ctrlmondata.c
index 812cc5c5e39e..ee3e8389d8d2 100644
--- a/arch/x86/kernel/cpu/rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/rdt_ctrlmondata.c
@@ -64,7 +64,7 @@ static bool bw_validate(char *buf, unsigned long *data, s=
truct rdt_resource *r)
 	return true;
 }
=20
-int parse_bw(struct rdt_parse_data *data, struct rdt_resource *r,
+int parse_bw_intel(struct rdt_parse_data *data, struct rdt_resource *r,
 	     struct rdt_domain *d)
 {
 	unsigned long bw_val;
--=20
2.17.1

