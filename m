Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1282308-1520492997-2-12562156462941832333
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
    t=1520492996; b=rvkWmqekuxiUwR1QeVOFdZjN3rag8fk/jzE4jGnP5J7Y6yH
    xuUwOd+O0KMy+YnsRDRPgD4kGtZWvZDZGYEbfbY2nSj0MDwbd7EJnbGYdvo4ehvz
    fBY/0dyp2vSEtLtopDRjIBJffDt8Vz1WkYA2AUWlBHj/s/VdMqOEl34/MTUx8hRS
    q2UuYZjGzhGtu9dVUrpbbt1c2+wxXqKNPkwV58MAe79+IUg6QOpb1Ra4sn3eXyqg
    +1AFoSP6F2Yn0vKwiomfO6a6KNst7aPDvBQloUzCKbaPYvfSD/5r3YfMle4Ey10N
    8jU8xXzzvxzaU7R1HqnT8WeDntwtpdGJRfE3qzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492996; bh=lnO5DF
    Kx0Q5SGHjDnuSS6oqiCQUVUIAq/MaBvMkyxaw=; b=au6xnpmxEDBWelruJ+bRUY
    xfkQ6Lg1wAguYUC3m9OKOMcx5DUtI76zXVQ30ukS9418yAEmdFXvZk2OOsZHUgQy
    7L0og+hL448CDacfIhtJarcyplmDy9I1vw3tdbrdbwC0/cNG9qpqG0CFISx0G60Z
    hMW5WlQgUHcDTZknzRCcFBR5EopYP3TnqVGyFktVp8c16ScaQsJ7oIF+X7YWWPNC
    dzHY7H0FjLyxFD7UpI0p0J2CTlQf6qzdl8xk5YtZTyX0bfngK/N7mKdBWzJBl7Q1
    wUvkNYpwHxxYnead5VfB4Zga2YewX5ztzcoamEbk2I7pp43qau4zwAIN7zqYpntA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JW4GgQ4G x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JW4GgQ4G x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755485AbeCHHJf (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 02:09:35 -0500
Received: from mail-bn3nam01on0130.outbound.protection.outlook.com ([104.47.33.130]:45246
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755176AbeCHE4O (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:56:14 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 16/78] KVM: x86: add support for emulating
 UMIP
Thread-Topic: [PATCH AUTOSEL for 4.15 16/78] KVM: x86: add support for
 emulating UMIP
Thread-Index: AQHTtpnF4F28e0dffU2MBH7mpPSmTQ==
Date: Thu, 8 Mar 2018 04:56:08 +0000
Message-ID: <20180308045525.7662-16-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1111;20:nCw2JzyEkStiWcvwMRo2CTVqsDDdxL5vmLOyXa59yrFw6wvGP9hf7V9caIEczBMk1cpBHHiU6QwpPuelvQf1eYGJT161707sa/kymzFe/TYPEWZHZ/Ap84sImaEFlg31leYmtbMlzTmEtyxndmd/6Y5/A8EsXNlzMxjC2g/OqxY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e6d2b0a6-f4b2-4dbc-c5da-08d584b0ea59
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1111;
x-ms-traffictypediagnostic: DM5PR2101MB1111:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB111172186F6E5F0DF43B7460FBDF0@DM5PR2101MB1111.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(130873036417446)(194151415913766);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1111;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1111;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(396003)(376002)(39860400002)(366004)(199004)(189003)(86612001)(22452003)(99286004)(7736002)(54906003)(305945005)(86362001)(5660300001)(66066001)(6512007)(81156014)(14454004)(53936002)(2900100001)(10090500001)(1076002)(110136005)(107886003)(575784001)(6116002)(6436002)(3846002)(72206003)(36756003)(102836004)(316002)(3280700002)(3660700001)(478600001)(106356001)(6486002)(76176011)(6666003)(81166006)(10290500003)(4326008)(2950100002)(97736004)(25786009)(105586002)(8676002)(26005)(2501003)(2906002)(5250100002)(8936002)(186003)(68736007)(6506007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1111;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 2mn1aNoqQUHBc0y/UTH9Yv/GZJvL4PzpUZkggA87wwC9rl5AB3T+CVwav5t4LB59TSdP1eO/EhPMX+Th7VyafiuZpt3urIMc02Sjc9VegSNwReYdUxSa/r6k8uYDQfi0rUeJoZcR55/sG75W3ZjFHQLrOApnm2zkOoqonA1KjhzveY9ueoy83Vzp72WI0+1neHKwY9xv8EfG75L27Fhtvg0ffhA9Uz6Is7JVKFayNSL/LC+sckeZgSmIdhnyE9WmkQML2h8SgY/TswzatxK6Jw+b0PedQk0SGN5DgAZoIshTZvtpN7d+FacLwLUL9C81JMtewwasLmjom1NGlyH8hg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d2b0a6-f4b2-4dbc-c5da-08d584b0ea59
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:08.0425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1111
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
index 516798431328..c02c7a47eae9 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1017,6 +1017,7 @@ struct kvm_x86_ops {
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
index 4e3c79530526..fb606ee6f93d 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -5336,6 +5336,11 @@ static bool svm_xsaves_supported(void)
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
@@ -5729,6 +5734,7 @@ static struct kvm_x86_ops svm_x86_ops __ro_after_init=
 =3D {
 	.invpcid_supported =3D svm_invpcid_supported,
 	.mpx_supported =3D svm_mpx_supported,
 	.xsaves_supported =3D svm_xsaves_supported,
+	.umip_emulated =3D svm_umip_emulated,
=20
 	.set_supported_cpuid =3D svm_set_supported_cpuid,
=20
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 561d8937fac5..24746d0b2b8e 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -9224,6 +9224,11 @@ static bool vmx_xsaves_supported(void)
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
@@ -12314,6 +12319,7 @@ static struct kvm_x86_ops vmx_x86_ops __ro_after_in=
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
