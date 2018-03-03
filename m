Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520121650-2-17945870676289450051
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520121650; b=P/2hUd6glH2vRD80Itbw2tHeotHzjdp3DZD6bQMKZz2YqpY
    App4W+Kfo6PpqsgVEc4zX1NyZ8t/aksdN43Djaj5xSGXH9MIBPHNbiKwWwIkgS/I
    rRRbCq7pMRzXjocV8LB7+YR+N5+d3NEE6t2VtAN52q/4V7wNpe92Uo6+A88fN7k8
    JBXd+T4V7uDdumRrIq2fKIoaGBxc2NPOx0ajmBbNPYO2uQ0mIHGLGJMb7xs3kaeY
    aAQQPQWi/xkAByKX1YggQEeWLsPh7d8NS4MHhp2FM6hluDe5S9mrIme4aPuZWeEr
    FyVL6s7RNhKw+yONyH7JE38kJbtTLTZgtv1LIRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121650; bh=waKcfP
    ncJnv3FCnZow+CNO7hOlS0LINng4IyFMkvGpc=; b=B1zakOWmTWGczPMUm+PCmz
    RPgEP/vyVS3oJPD17hwpxCiwWBj9dCcg4rOAbcsKfqTh5AcXLLvFPp6QRlMwKL/l
    Hxm9dR9ynFyhd18uRjGC5rxL45thSqhOmkUlPrAsILpfyFvzN052pEhO4X1ctEDG
    OgjuVUuPgkybYUPiy4ZTpoIlwJ+Yw2BeKHK9pEKrvGP2JNOfEwo6SyZlEJL0XQOe
    DLpJTIZ6Rydo3pRGw8H8pPFfOdTnnGhePhYMUcM8vbhRU7B0iAavNR4/u46zbQtg
    2DA8pYN+0TiXrpSV5Dofb28ucb08ErNT3mFgc/eljlbxq0/DayhwcnfHHv53dXOQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nEwHjwY3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nEwHjwY3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933786AbeCDAAp (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:00:45 -0500
Received: from mail-co1nam03on0109.outbound.protection.outlook.com ([104.47.40.109]:6764
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933773AbeCCWcG (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:32:06 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Tony Luck <tony.luck@intel.com>,
        linux-edac <linux-edac@vger.kernel.org>, x86-ml <x86@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 041/219] x86/mce: Init some CPU features early
Thread-Topic: [PATCH AUTOSEL for 4.9 041/219] x86/mce: Init some CPU features
 early
Thread-Index: AQHTsz7u9WLtG+6wjUSePl5zHWtMqQ==
Date: Sat, 3 Mar 2018 22:28:19 +0000
Message-ID: <20180303222716.26640-41-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1083;7:xeqXUFfvBZ+G7aB3tkQFlvu6FqUf/REZUBG0r//N/wum4C8zjGwYJhY2mj0ms4ixDpgXhjqGUIXcXqHQm/NuniMmLwcOGp0MOC/7kzXlUuoGa9ffF7VcfYtQq0f7LTGgvGXdYYB7pD0Ja3Wg03psUhhCTovWwOh/0FL0OlT72kfSjVbjLEGztwvih05PxA3f1a1gQvrdC+9a8CijGcVITYRttDCo1+ZEbNsS+rhugqY+vl89jRHQRKTcXTHd8ef4
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 47092bb4-dee3-4984-4ee4-08d5815695f1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1083;
x-ms-traffictypediagnostic: MW2PR2101MB1083:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1083F7819AB49CC38EE6EBD2FBC40@MW2PR2101MB1083.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(767451399110)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1083;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1083;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(39380400002)(396003)(346002)(366004)(189003)(199004)(106356001)(53936002)(316002)(305945005)(7736002)(3280700002)(107886003)(2906002)(8666007)(6512007)(6436002)(97736004)(3660700001)(6306002)(6486002)(99286004)(81166006)(8936002)(81156014)(76176011)(8676002)(25786009)(2950100002)(6506007)(4326008)(110136005)(5250100002)(54906003)(36756003)(575784001)(105586002)(6116002)(6666003)(22452003)(86612001)(10090500001)(186003)(68736007)(26005)(2900100001)(86362001)(66066001)(102836004)(3846002)(14454004)(478600001)(72206003)(10290500003)(5660300001)(1076002)(966005)(2501003)(22906009)(217873001)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1083;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: wCr4m5GeVKwYPm/MUogIqcioPZtUIcGsSzxxG+FfmL6PB9mZExNGQ79Ry+L5HR0+z49PZe99JH5wKZhtoOXzd2cBvVaqWCiIM/dJv+p/rv3963D0Dlzxb8xeSx56fPyzsDTdUG7wWxyegzNWbZ3kBB1NlA6PP46tJzs6bZ/SZpo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47092bb4-dee3-4984-4ee4-08d5815695f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:19.6037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1083
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Yazen Ghannam <Yazen.Ghannam@amd.com>

[ Upstream commit 5204bf17031b69fa5faa4dc80a9dc1e2446d74f9 ]

When the MCA banks in __mcheck_cpu_init_generic() are polled for leftover
errors logged during boot or from the previous boot, its required to have
CPU features detected sufficiently so that the reading out and handling of
those early errors is done correctly.

If those features are not available, the decoding may miss some information
and get incomplete errors logged. For example, on SMCA systems the MCA_IPID
and MCA_SYND registers are not logged and MCA_ADDR is not masked
appropriately.

To cure that, do a subset of the basic feature detection early while the
rest happens in its usual place in __mcheck_cpu_init_vendor().

Signed-off-by: Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: x86-ml <x86@kernel.org>
Link: http://lkml.kernel.org/r/1489599055-20756-1-git-send-email-Yazen.Ghan=
nam@amd.com
[ Massage commit message and simplify. ]
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/kernel/cpu/mcheck/mce.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/=
mce.c
index b0cc7bd26ab5..dc39f5ace024 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1692,30 +1692,35 @@ static int __mcheck_cpu_ancient_init(struct cpuinfo=
_x86 *c)
 	return 0;
 }
=20
-static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
+/*
+ * Init basic CPU features needed for early decoding of MCEs.
+ */
+static void __mcheck_cpu_init_early(struct cpuinfo_x86 *c)
 {
-	switch (c->x86_vendor) {
-	case X86_VENDOR_INTEL:
-		mce_intel_feature_init(c);
-		mce_adjust_timer =3D cmci_intel_adjust_timer;
-		break;
-
-	case X86_VENDOR_AMD: {
+	if (c->x86_vendor =3D=3D X86_VENDOR_AMD) {
 		mce_flags.overflow_recov =3D !!cpu_has(c, X86_FEATURE_OVERFLOW_RECOV);
 		mce_flags.succor	 =3D !!cpu_has(c, X86_FEATURE_SUCCOR);
 		mce_flags.smca		 =3D !!cpu_has(c, X86_FEATURE_SMCA);
=20
-		/*
-		 * Install proper ops for Scalable MCA enabled processors
-		 */
 		if (mce_flags.smca) {
 			msr_ops.ctl	=3D smca_ctl_reg;
 			msr_ops.status	=3D smca_status_reg;
 			msr_ops.addr	=3D smca_addr_reg;
 			msr_ops.misc	=3D smca_misc_reg;
 		}
-		mce_amd_feature_init(c);
+	}
+}
=20
+static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
+{
+	switch (c->x86_vendor) {
+	case X86_VENDOR_INTEL:
+		mce_intel_feature_init(c);
+		mce_adjust_timer =3D cmci_intel_adjust_timer;
+		break;
+
+	case X86_VENDOR_AMD: {
+		mce_amd_feature_init(c);
 		break;
 		}
=20
@@ -1801,6 +1806,7 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
=20
 	machine_check_vector =3D do_machine_check;
=20
+	__mcheck_cpu_init_early(c);
 	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_vendor(c);
 	__mcheck_cpu_init_clear_banks();
--=20
2.14.1
