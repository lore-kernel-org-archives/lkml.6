Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1171329-1520491637-2-12361730474829316295
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES roen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520491636; b=EJSlT+IdHPn8S8yf4bvpQsEuwNka6mEGAZnp0tQxfWwQkDr
    p0MC1SL5jVXbF9FTwaXpEFBFnAcTDVZvV/o/Ts6kVa0QiUOKYB0BTL3uF0QreZuT
    RHISmnKNz5gb8saToHM26ohQTcV150ZmtlQ7pb9no0cgMYMZq0K1kzVWKNtMGpVR
    D/HIxR4AKWAXl2il0FEl5IOq62XUxfyY2cVOhQL/a27u2ZC3TA+ICp0qB0U8sxCx
    mQktCDMKyk4Kk2PlYFEsAlij/w4jKE/8WWDNaC/cBXYlNRNdUq0RTrW3siKuU1qr
    Q6YZigQqJAImubHwSzP9axCaeDk4pLoxqCUHNxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491636; bh=Yj0wd7
    xGU3SqLZdj6mO593+FqjS/lae4Y+WYkIW/86s=; b=D/nznUBIHSHz13G9qjwo0D
    jpG+zUIL6XCJ/FIGAPVROKTLa//wq/04Od+xJgWR+yQABfetNSYoPEieilc5MfuB
    jh5cHEr6dq7aU2uUfaGxnZYHpUQ5nkHALW45T37ouFS56fS6Ov/2Di+G67Wmq3Rg
    ORma57tTMAz3a2QkhL7e5bJ/8M7RvRsOlA0+5sOFzj2zZUJs9gZ0xWAzDlANH8JW
    UBf5a3cnvLJSqDTreeJRfjIcW3BZqVDbKkGVsh8JXzoEDCRZBh75sygm4GZ8RblG
    96ca3ta5o8/J1lSEoy2HSlMWY01HcRj6VQkGwxRr0OXlN8cKaM34Hkhv/bBK83fg
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QC0kHF1O x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QC0kHF1O x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965113AbeCHE6X (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:58:23 -0500
Received: from mail-by2nam03on0117.outbound.protection.outlook.com ([104.47.42.117]:8510
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935227AbeCHE6N (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:13 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 12/67] KVM: x86: add support for emulating
 UMIP
Thread-Topic: [PATCH AUTOSEL for 4.14 12/67] KVM: x86: add support for
 emulating UMIP
Thread-Index: AQHTtpn6RxGhJxHWy02eLbnawN2M7A==
Date: Thu, 8 Mar 2018 04:57:36 +0000
Message-ID: <20180308045641.7814-12-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0936;20:hjCCN/w8h9VjM6yGo9geiKT35nOwdbbW2IlDoTv1hnl/8bivzVhARABZNMouYxu9n6nxVXgFSfBuyNuZ1yJq4qFMphH8L0CMVhyF946W8Y16vQPFpmTHZLeHZPGwAabM8CxfSDh66pmDDfGcvI2LBH39rv7I62seXwQ/8WncbBM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 55cea832-5c16-4dc5-7be7-08d584b1302e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09368D1433073BACEE49A514FBDF0@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(130873036417446)(194151415913766);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0936;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0936;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(39380400002)(346002)(376002)(199004)(189003)(478600001)(99286004)(575784001)(6506007)(3660700001)(36756003)(86362001)(54906003)(6116002)(110136005)(2950100002)(102836004)(1076002)(3846002)(6486002)(3280700002)(10090500001)(10290500003)(305945005)(72206003)(6436002)(6666003)(26005)(5250100002)(2906002)(186003)(2501003)(105586002)(76176011)(66066001)(7736002)(68736007)(25786009)(6512007)(106356001)(86612001)(8936002)(107886003)(81166006)(2900100001)(5660300001)(4326008)(81156014)(53936002)(14454004)(97736004)(316002)(22452003)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0936;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: fjbdmIPw3w/YNcVfGMcvY8GxG4gU/liyLTb1KCXlvVisCKTAceAGhQve8gdzMK2QgK+hlKEPlhD0Zu6iY4cWvZQ+SN7goOnVvLpXheYxX4JTFvPg/8txpFXgsuqBtsdOlowmuMcbDz+OsK37MUVkjjMhb7jPU8GhBSLC26TGcO3hbwXvvq1KeMYeSyz7jqiQ2kEOial5CTvMZtkiKCectah0UermfKjFYq4ULIWcAcEOeBrD0x5+1R9ozG3x9kvu3HK2PPdU4UwoV50/vAYA35m0YP8IG3Xx55UoXl4ZQ8q5TB4Hvh0/IYAmmceRoCjOCLaszUQxq9e9eVUMUfG7Eg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55cea832-5c16-4dc5-7be7-08d584b1302e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:36.6093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Paolo Bonzini <pbonzini@redhat.com>

[ Upstream commit 66336cab3531d3325ebde36a04725dddd0c42cb5 ]

The User-Mode Instruction Prevention feature present in recent Intel
processor prevents a group of instructions (sgdt, sidt, sldt, smsw, and
str) from being executed with CPL > 0. Otherwise, a general protection
fault is issued.

UMIP instructions in general are also able to trigger vmexits, so we can
actually emulate UMIP on older processors.  This commit sets up the
infrastructure so that kvm-intel.ko and kvm-amd.ko can set the UMIP
feature bit for CPUID even if the feature is not actually available
in hardware.

Reviewed-by: Wanpeng Li <wanpeng.li@hotmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/cpuid.c            | 2 ++
 arch/x86/kvm/svm.c              | 6 ++++++
 arch/x86/kvm/vmx.c              | 6 ++++++
 4 files changed, 15 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_hos=
t.h
index 4f8b80199672..52ecf9b2f61e 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1004,6 +1004,7 @@ struct kvm_x86_ops {
 	void (*handle_external_intr)(struct kvm_vcpu *vcpu);
 	bool (*mpx_supported)(void);
 	bool (*xsaves_supported)(void);
+	bool (*umip_emulated)(void);
=20
 	int (*check_nested_events)(struct kvm_vcpu *vcpu, bool external_intr);
=20
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 13f5d4217e4f..f3fc225f5ebb 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -325,6 +325,7 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry=
2 *entry, u32 function,
 	unsigned f_invpcid =3D kvm_x86_ops->invpcid_supported() ? F(INVPCID) : 0;
 	unsigned f_mpx =3D kvm_mpx_supported() ? F(MPX) : 0;
 	unsigned f_xsaves =3D kvm_x86_ops->xsaves_supported() ? F(XSAVES) : 0;
+	unsigned f_umip =3D kvm_x86_ops->umip_emulated() ? F(UMIP) : 0;
=20
 	/* cpuid 1.edx */
 	const u32 kvm_cpuid_1_edx_x86_features =3D
@@ -476,6 +477,7 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry=
2 *entry, u32 function,
 			entry->ebx |=3D F(TSC_ADJUST);
 			entry->ecx &=3D kvm_cpuid_7_0_ecx_x86_features;
 			cpuid_mask(&entry->ecx, CPUID_7_ECX);
+			entry->ecx |=3D f_umip;
 			/* PKU is not yet implemented for shadow paging. */
 			if (!tdp_enabled || !boot_cpu_has(X86_FEATURE_OSPKE))
 				entry->ecx &=3D ~F(PKU);
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index e0bc3ad0f6cd..8ea19bf09202 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -5322,6 +5322,11 @@ static bool svm_xsaves_supported(void)
 	return false;
 }
=20
+static bool svm_umip_emulated(void)
+{
+	return false;
+}
+
 static bool svm_has_wbinvd_exit(void)
 {
 	return true;
@@ -5633,6 +5638,7 @@ static struct kvm_x86_ops svm_x86_ops __ro_after_init=
 =3D {
 	.invpcid_supported =3D svm_invpcid_supported,
 	.mpx_supported =3D svm_mpx_supported,
 	.xsaves_supported =3D svm_xsaves_supported,
+	.umip_emulated =3D svm_umip_emulated,
=20
 	.set_supported_cpuid =3D svm_set_supported_cpuid,
=20
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 5ffde16253cb..924d88d5ca35 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -9212,6 +9212,11 @@ static bool vmx_xsaves_supported(void)
 		SECONDARY_EXEC_XSAVES;
 }
=20
+static bool vmx_umip_emulated(void)
+{
+	return false;
+}
+
 static void vmx_recover_nmi_blocking(struct vcpu_vmx *vmx)
 {
 	u32 exit_intr_info;
@@ -12252,6 +12257,7 @@ static struct kvm_x86_ops vmx_x86_ops __ro_after_in=
it =3D {
 	.handle_external_intr =3D vmx_handle_external_intr,
 	.mpx_supported =3D vmx_mpx_supported,
 	.xsaves_supported =3D vmx_xsaves_supported,
+	.umip_emulated =3D vmx_umip_emulated,
=20
 	.check_nested_events =3D vmx_check_nested_events,
=20
--=20
2.14.1
