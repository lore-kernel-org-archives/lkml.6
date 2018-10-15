Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60189C71144
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CFB120869
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="H5SMdNV6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CFB120869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbeJPEmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 00:42:47 -0400
Received: from mail-sn1nam01on0078.outbound.protection.outlook.com ([104.47.32.78]:26912
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726927AbeJPEmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 00:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xztFcYOhrHAzOJlvbfvFYwj5ESDnOA5FGHAhriei8bc=;
 b=H5SMdNV6tV8gM83hO2Ul2F+SH9bYrpVJdyvrtYA+QFQow4SKJfKRQNzErG4qyYA09Cr/7c5BFwSwt8LmdYwI8FyfBNinmxtDQHU7zU1KjcUfYmnZqD8Vqdpl7fmMwl63br7q40HXPn5Ah+PZit3FfuyX4m8rPILS7gAffURRQ6o=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2534.namprd12.prod.outlook.com (52.132.141.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.24; Mon, 15 Oct 2018 20:55:39 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%3]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 20:55:39 +0000
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
Subject: [PATCH v4 04/13] arch/x86: Bring all the macros to resctrl.h
Thread-Topic: [PATCH v4 04/13] arch/x86: Bring all the macros to resctrl.h
Thread-Index: AQHUZMlt+CLEkHQg40q1afGfimWQvA==
Date:   Mon, 15 Oct 2018 20:55:39 +0000
Message-ID: <20181015205514.25387-5-babu.moger@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2534;20:Jngxr/7qcaG3RtYH4J80LnDakYD4tWY1g1uP37c9/9cwLLPTzX3K3UCBiBMCeOrfSPQVaVbZCO4Ri2aQfyVvWI7SIMGvpNsjzlxT5D3n+Ik5x29izZVeNZ30gCl4TaUAQnqFDXEUuClkpHKQyRCfJntuQDublETPVzG4NDcB25NNd+3/s1nVq+55JDMBj2chr3ZluRRrrZvXw+DWO6nDgtaT5DfRxSvoPwkN8DVh27GVpbveBMNXP+7FBXAuXZ76
x-ms-office365-filtering-correlation-id: 8fdac7f3-1d7a-44c5-f938-08d632e08fe2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2534;
x-ms-traffictypediagnostic: DM5PR12MB2534:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-microsoft-antispam-prvs: <DM5PR12MB2534EC16FEEE521118B88F7995FD0@DM5PR12MB2534.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991067);SRVR:DM5PR12MB2534;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2534;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(396003)(366004)(189003)(199004)(2900100001)(66066001)(5250100002)(26005)(36756003)(186003)(110136005)(54906003)(6436002)(386003)(6506007)(52116002)(97736004)(7406005)(7416002)(76176011)(68736007)(6486002)(7736002)(106356001)(102836004)(99286004)(53936002)(2501003)(2906002)(446003)(305945005)(6512007)(5660300001)(105586002)(2616005)(11346002)(4326008)(1076002)(72206003)(25786009)(81156014)(316002)(476003)(81166006)(14444005)(6116002)(478600001)(486006)(256004)(2201001)(8936002)(71190400001)(86362001)(71200400001)(14454004)(575784001)(3846002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2534;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: yAZiJ2vqTS54TNMpx35MtDaPUFsunDPjNqh3TeImUZGRJKWjwibtMkvlzpBXoKVIW+Reg7Ywpf7d/Q5h/83inp/VHVI2s9uURPG+U+TU0IlJ3mVBd5baKftycW3UcJWAasXetSiwERZ+qKqEe5cFSqDW3v/y41LLivb+lMn24f3huguzRc8ZP9lP6gHndLhk8I4vS9F6Nm5amyCmbF/GakugJwckybhrjLfKhzunXkZSZAfYJKd9VPN0l8BcTRb3HbEzgDG7cEBuU5vA2ORBCVCXtNkooJ8OHm5OEKWkHfyvE2MfLmbzuPhzPqnQgNmEDD4jn9iNNxvQkKwCMPwFYAybx3KkE+xzW7EPlu44hzQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fdac7f3-1d7a-44c5-f938-08d632e08fe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 20:55:39.2687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2534
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bring all the macros to resctrl.h and rename for consistency.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/resctrl.c         | 3 ---
 arch/x86/kernel/cpu/resctrl.h         | 5 +++++
 arch/x86/kernel/cpu/resctrl_monitor.c | 7 ++-----
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl.c b/arch/x86/kernel/cpu/resctrl.c
index 6c1199f7f28e..befc4eee0f07 100644
--- a/arch/x86/kernel/cpu/resctrl.c
+++ b/arch/x86/kernel/cpu/resctrl.c
@@ -33,9 +33,6 @@
 #include <asm/resctrl_sched.h>
 #include "resctrl.h"
=20
-#define MBA_IS_LINEAR	0x4
-#define MBA_MAX_MBPS	U32_MAX
-
 /* Mutex to protect rdtgroup access. */
 DEFINE_MUTEX(rdtgroup_mutex);
=20
diff --git a/arch/x86/kernel/cpu/resctrl.h b/arch/x86/kernel/cpu/resctrl.h
index abf5c7e4c625..e5f7bf6a8d09 100644
--- a/arch/x86/kernel/cpu/resctrl.h
+++ b/arch/x86/kernel/cpu/resctrl.h
@@ -12,6 +12,9 @@
 #define IA32_L2_CBM_BASE	0xd10
 #define IA32_MBA_THRTL_BASE	0xd50
=20
+#define IA32_QM_CTR		0x0c8e
+#define IA32_QM_EVTSEL		0x0c8d
+
 #define L3_QOS_CDP_ENABLE	0x01ULL
=20
 #define L2_QOS_CDP_ENABLE	0x01ULL
@@ -29,6 +32,8 @@
 #define MBM_CNTR_WIDTH			24
 #define MBM_OVERFLOW_INTERVAL		1000
 #define MAX_MBA_BW			100u
+#define MBA_IS_LINEAR			0x4
+#define MBA_MAX_MBPS			U32_MAX
=20
 #define RMID_VAL_ERROR			BIT_ULL(63)
 #define RMID_VAL_UNAVAIL		BIT_ULL(62)
diff --git a/arch/x86/kernel/cpu/resctrl_monitor.c b/arch/x86/kernel/cpu/re=
sctrl_monitor.c
index 68dbdbbf47df..ad0107bc16a0 100644
--- a/arch/x86/kernel/cpu/resctrl_monitor.c
+++ b/arch/x86/kernel/cpu/resctrl_monitor.c
@@ -28,9 +28,6 @@
 #include <asm/cpu_device_id.h>
 #include "resctrl.h"
=20
-#define MSR_IA32_QM_CTR		0x0c8e
-#define MSR_IA32_QM_EVTSEL		0x0c8d
-
 struct rmid_entry {
 	u32				rmid;
 	int				busy;
@@ -97,8 +94,8 @@ static u64 __rmid_read(u32 rmid, u32 eventid)
 	 * IA32_QM_CTR.Error (bit 63) and IA32_QM_CTR.Unavailable (bit 62)
 	 * are error bits.
 	 */
-	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
-	rdmsrl(MSR_IA32_QM_CTR, val);
+	wrmsr(IA32_QM_EVTSEL, eventid, rmid);
+	rdmsrl(IA32_QM_CTR, val);
=20
 	return val;
 }
--=20
2.17.1

