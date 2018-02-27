Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeB0G6J (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 01:58:09 -0500
Received: from mail-sg2apc01on0125.outbound.protection.outlook.com ([104.47.125.125]:7360
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751993AbeB0G6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 01:58:07 -0500
From: Tianyu Lan <Tianyu.Lan@microsoft.com>
CC: Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] KVM/X86: Check input sreg values before loading vcpu
Thread-Topic: [PATCH] KVM/X86: Check input sreg values before loading vcpu
Thread-Index: AQHTr5hN8NOqe9GuWkWmcSxT1Wc7aQ==
Date: Tue, 27 Feb 2018 06:57:59 +0000
Message-ID: <1519714664-2649-1-git-send-email-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com;
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2P15301MB0018;6:lUKQ5POxskfo8m/QrXNDaYsigD9s2Vze3+QG+4vJmlckVzirkEGOhX0hFJlsN2cdRsuKJjjffUR1XFBEzGWCBrgpMowVJydtqCZXPLAfRsZYFoiGvzj/5e65QM98GEMb1voug2b/ajPaUYqV6lF4/YYNhbCqxWm9DyT5gnAyoEkJFIWiy7WPOT9tS2Bp5x3nPs6yHolS+2ezWl1bMFwzu5HpprLE28cXtq6hGhZYv1N/OStAzcFGr2P6s0M6TaM75rjAm6ibHv9drIQC4foVj0Af6ZJuBAcxxvp3GYVgKOWOWb4hUogzUHz0R8gm1HFjGEBFG6qbhUXNSMk+2hK4+YbRMxWypPH5Upy3nFrzoiEQOYVNjRj+uPzodUskpm5k;5:tP1xww1jVfiURT6LdmImpNEZZcunHLBBlcyHEUl78ckiuJ0HjhiOyjBMORaFk8wLcobstcy5ypIu5pDrZd/8o0/qaMQH6nkIJi+gs5fRyavy/jxp5aIQrzC0ffzcDMLb34hVe1PjyPiVUjVg95C1rRlnWRxxCBs+m6G4Na3D4Dk=;24:J1tRw9/WMahhawJu33286BMypYTJhs0Z9LrMY07MG58UnAGlv4ofl2SgEy8Hp81nQN3K+t6s+ieHYDySO1ggOfEmgxT3/ljSO2P3uv7P7M8=;7:CjrlR9EvunUC6wi2V9ynPgZBBc8G24krXBDJG0xRuNPtByr7Oa7Q0134ZgPwryjf+5LpJW03/WoPl9h33xNyJWUUXJReB6MvFWuJejyVioJ7WfTm/vaRcVAfLA9r1wK/SWYAucjnyEQnx0jwPBPDVDALigjAfpkYCnsWgfWLln+6XAubu5vBJNDp9ov+ols0xJtWbe2l+MXEPdvHyX2OLZP6ATzWMhI/G7YkXHq+29DMuKykikSEegVLRRqgLWNZ
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cc697274-5c08-4102-c2a9-08d57daf708f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:HK2P15301MB0018;
x-ms-traffictypediagnostic: HK2P15301MB0018:
x-microsoft-antispam-prvs: <HK2P15301MB00188DA7FEC2BF4A90FCB4E792C00@HK2P15301MB0018.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501198)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:HK2P15301MB0018;BCL:0;PCL:0;RULEID:;SRVR:HK2P15301MB0018;
x-forefront-prvs: 05961EBAFC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(39860400002)(346002)(376002)(189003)(199004)(86612001)(106356001)(105586002)(6486002)(2900100001)(86362001)(478600001)(10290500003)(72206003)(99286004)(14454004)(10090500001)(59246006)(575784001)(68736007)(66066001)(6116002)(3846002)(3660700001)(5250100002)(8936002)(5660300001)(81156014)(81166006)(8676002)(2906002)(3280700002)(6436002)(4326008)(25786009)(316002)(54906003)(97736004)(1857600001)(6506007)(59450400001)(6512007)(305945005)(26005)(36756003)(7736002)(102836004)(22452003)(1671002)(53936002)(109986005)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2P15301MB0018;H:HK2P15301MB0065.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: Xzm82le11yxqNLct5eI8HTIbmyjrirlNryK91q5FSt4skX2H4H9JLvqb+ZMOxdktMu02HYJLzRey/oSmSEJc+qwbt0Gd0FbBIWNTGiy8ASI8paMZ1uXBE14EnxXzZmn+J8/LSf/r1+vRfeKv7uq85Qu1VhH3eioFK2wmChxliKw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc697274-5c08-4102-c2a9-08d57daf708f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2018 06:58:00.0618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2P15301MB0018
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1R6wEnT018149

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patch is to check sreg value first and then load vcpu in order
to avoid redundant loading/putting vcpu.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/x86.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c8a0b54..46da9ec 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7671,6 +7671,10 @@ EXPORT_SYMBOL_GPL(kvm_task_switch);
 
 int kvm_valid_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 {
+	if (!guest_cpuid_has(vcpu, X86_FEATURE_XSAVE) &&
+			(sregs->cr4 & X86_CR4_OSXSAVE))
+		return -EINVAL;
+
 	if ((sregs->efer & EFER_LME) && (sregs->cr0 & X86_CR0_PG)) {
 		/*
 		 * When EFER.LME and CR0.PG are set, the processor is in
@@ -7701,14 +7705,10 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 	struct desc_ptr dt;
 	int ret = -EINVAL;
 
-	vcpu_load(vcpu);
-
-	if (!guest_cpuid_has(vcpu, X86_FEATURE_XSAVE) &&
-			(sregs->cr4 & X86_CR4_OSXSAVE))
-		goto out;
-
 	if (kvm_valid_sregs(vcpu, sregs))
-		goto out;
+		return ret;
+
+	vcpu_load(vcpu);
 
 	apic_base_msr.data = sregs->apic_base;
 	apic_base_msr.host_initiated = true;
-- 
2.7.4
