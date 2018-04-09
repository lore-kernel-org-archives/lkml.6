Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523243694-2-5779418292189457963
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523243693; b=Dcw4vcHMGc3QgYKxfBTqOzHyQM6mpyPCyw2bQmwku7d3vg3eIu
    E6eNiXflZkyZ5kbUrPy4dgXqz2TzHs8rbeZUL1nBv6RrT/ro5X4yBuuYWkVKDmlv
    Uu4tIBX1QJCCPUh1bHSvTHa3gktIS1MtROswNmnp69m0xiGv+SvrnFa9DdxFFeea
    H0w9ZogikGEGIIE2Q0pKIBhRnsN8q+GeT1vRU8esI7qXydNx3P7hclH+2GAJIWUx
    qxY/feTfHBRMtEcE11GlsvoU2WLHKQVKNXEUfQgGcpiivLiJ3vBHIY6M5naGyWbE
    hOYjeFvYRjjmI4Ck1jXRyY4exZ4BZsoaHsRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523243693; bh=7btfNZaNUb
    q2XGwGFHbMusORsuyaydi4jZhpYL/t9K8=; b=Nzb6943SYVQSS2xZr3VzFnG/FJ
    2Ep9E5mH20ggcEr2owZ75Q9cQ3hHhiTOrlcjsgI1DwgP/Qf1PmveqpM1+zKkM9Ib
    v6XKFLDNsNhIdWuvWOTtfdpbDn/eDRgclF0386M3tBuk/v/fowAWNCskPkOsvz0z
    1TvTB9Qj9Al9YI76HtS9osf38W/Lv0jNw0ott6cB43WOH1JwgTboc9Pqv91exOoY
    a15IJcWWagG8UCIcPPxhnYR7gLott/KqDR8xhAEe55bbkFuXsmijK6NM8yqMGwHZ
    va035JdLlp45l8TdhjJ1CgMswo92YalfTf/AiuJsqC3dJHJ6kNcHXIRn0i8Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CL00f1lm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CL00f1lm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG+1L/wNs3X3axb+CvAIfDmYEzrLpI/LJOUSRUZGo7DjTYzu/5MU1qpp+FFlzgkSxhlC2M+ouq4Uoga26GnzJTUCBpkIDoxhP93cD7z/VqF7DW3UvWO/
    vl4ngkPxvWCaRjWhVgYlyYextl7pxUM0/0S6sLNtsvl8Of9KL+1sDADwHaaHl97wx7cIQmfqjv4l4WlwcX0D/8zTCOUaeVPeo1VNqVPOYFSJHEy0cZTtorPF
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=yMhMjlubAAAA:8
    a=nR6cGN4Ah6g1CHLdDo4A:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752383AbeDIDOd (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:14:33 -0400
Received: from mail-by2nam03on0115.outbound.protection.outlook.com ([104.47.42.115]:29467
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753655AbeDIAXt (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:23:49 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: David Hildenbrand <david@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 069/161] KVM: s390: vsie: use READ_ONCE to
 access some SCB fields
Thread-Topic: [PATCH AUTOSEL for 4.14 069/161] KVM: s390: vsie: use READ_ONCE
 to access some SCB fields
Thread-Index: AQHTz5iYElVPrhnqi0OQxZqYJt5WjQ==
Date: Mon, 9 Apr 2018 00:20:42 +0000
Message-ID: <20180409001936.162706-69-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1080;7:l9Lx/rvRsOiuyF+MZE4dWCnqAXJMrkF4fQKUPT3TPS9ku5ILIS/21XaVqJo4EiDYXVJmxSeB5qdr2+DoPOh8hwvNeUZOmcL9gpC7zwbcq7ajqbccadAeAJG4uD5B/cfaw4JmsyQyKVW3M+RdDLkiYLLxufJbNe4IYnhgFhf63k0ZGjBCThyY92qVlkp3oSgUQLKYBhREZr63C7r9pzxNKwgCfWaARW9VVDsaq9eqeI+3riifEeUK9qx7leeg/2JF;20:/LVDkNmo33OL/MN8QIUgutqx/oHIw6Axt1UUXYpxIAWDIehXE+QlMMUXfhJJhcijp4DyXRk90nU6iomJ8HHaPGvaG1ucNBGDyXpX4uzuo7W+00+BRK7D/JkGz16SpjoZrlMSfJWJb/8aGrF2AGtmV4J79wT7Mdsl1jyP6e0zXE8=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6b113038-4229-4e6e-ab91-08d59db027dd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1080;
x-ms-traffictypediagnostic: DM5PR2101MB1080:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1080E01DC086A64781BB9279FBBF0@DM5PR2101MB1080.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(190383065149520)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1080;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1080;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39380400002)(366004)(39860400002)(199004)(189003)(2501003)(5250100002)(8936002)(10090500001)(5660300001)(3660700001)(446003)(107886003)(14454004)(36756003)(6436002)(476003)(3280700002)(2616005)(11346002)(4326008)(6666003)(53936002)(6512007)(22452003)(305945005)(10290500003)(316002)(102836004)(2906002)(6116002)(66066001)(6506007)(3846002)(7736002)(486006)(54906003)(110136005)(186003)(72206003)(26005)(1076002)(105586002)(2900100001)(6486002)(97736004)(478600001)(81156014)(81166006)(86612001)(8676002)(106356001)(99286004)(86362001)(575784001)(76176011)(59450400001)(68736007)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1080;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: X9HdUXLKSHp6u+Vge77EcSX+g9u5/dtOyaMGQGaOP/wxrcHhE+S6/PZBog2e+F0In7jlqgcy4/N1Zpuqwv9M4Eta33aAQ7GGUQ4rbB4fZrzs6hSR+3HUSs5ElAjagIxXSEvejxYVpHV/L0bj9+a29ErZ1Ij4nde6DOh1r1qjAxGls8CoNLUZuPb8CHV6OmBXySpduAd626ShTelCvDfMPO+mhfdEFVTed5FcgYIeTJmPEpgmNmGQReiwEz6mJF+w0LINx2ElQKrM4rBIiP8xBoip7ThgebWvLlEMv8bXXfFSJloM3rFEbUvA4IR0N+yTALCzl17Xv9TTbyJ0K1ii4BnuRSxBokMrIPeg6zpQ3BKKTfoSycOwg+NuVQbO6AtLyC6lQKB2XMAVjpaaMP52KzJZqXMXMCI+hivA+x9tOeQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b113038-4229-4e6e-ab91-08d59db027dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:42.4566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1080
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: David Hildenbrand <david@redhat.com>

[ Upstream commit b3ecd4aa8632a86428605ab73393d14779019d82 ]

Another VCPU might try to modify the SCB while we are creating the
shadow SCB. In general this is no problem - unless the compiler decides
to not load values once, but e.g. twice.

For us, this is only relevant when checking/working with such values.
E.g. the prefix value, the mso, state of transactional execution and
addresses of satellite blocks.

E.g. if we blindly forward values (e.g. general purpose registers or
execution controls after masking), we don't care.

Leaving unpin_blocks() untouched for now, will handle it separately.

The worst thing right now that I can see would be a missed prefix
un/remap (mso, prefix, tx) or using wrong guest addresses. Nothing
critical, but let's try to avoid unpredictable behavior.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180116171526.12343-2-david@redhat.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/s390/kvm/vsie.c | 50 +++++++++++++++++++++++++++++++-----------------=
--
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index b18b5652e5c5..a74204db759b 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -31,7 +31,11 @@ struct vsie_page {
 	 * the same offset as that in struct sie_page!
 	 */
 	struct mcck_volatile_info mcck_info;    /* 0x0200 */
-	/* the pinned originial scb */
+	/*
+	 * The pinned original scb. Be aware that other VCPUs can modify
+	 * it while we read from it. Values that are used for conditions or
+	 * are reused conditionally, should be accessed via READ_ONCE.
+	 */
 	struct kvm_s390_sie_block *scb_o;	/* 0x0218 */
 	/* the shadow gmap in use by the vsie_page */
 	struct gmap *gmap;			/* 0x0220 */
@@ -143,12 +147,13 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct=
 vsie_page *vsie_page)
 {
 	struct kvm_s390_sie_block *scb_s =3D &vsie_page->scb_s;
 	struct kvm_s390_sie_block *scb_o =3D vsie_page->scb_o;
-	u32 crycb_addr =3D scb_o->crycbd & 0x7ffffff8U;
+	const uint32_t crycbd_o =3D READ_ONCE(scb_o->crycbd);
+	const u32 crycb_addr =3D crycbd_o & 0x7ffffff8U;
 	unsigned long *b1, *b2;
 	u8 ecb3_flags;
=20
 	scb_s->crycbd =3D 0;
-	if (!(scb_o->crycbd & vcpu->arch.sie_block->crycbd & CRYCB_FORMAT1))
+	if (!(crycbd_o & vcpu->arch.sie_block->crycbd & CRYCB_FORMAT1))
 		return 0;
 	/* format-1 is supported with message-security-assist extension 3 */
 	if (!test_kvm_facility(vcpu->kvm, 76))
@@ -186,12 +191,15 @@ static void prepare_ibc(struct kvm_vcpu *vcpu, struct=
 vsie_page *vsie_page)
 {
 	struct kvm_s390_sie_block *scb_s =3D &vsie_page->scb_s;
 	struct kvm_s390_sie_block *scb_o =3D vsie_page->scb_o;
+	/* READ_ONCE does not work on bitfields - use a temporary variable */
+	const uint32_t __new_ibc =3D scb_o->ibc;
+	const uint32_t new_ibc =3D READ_ONCE(__new_ibc) & 0x0fffU;
 	__u64 min_ibc =3D (sclp.ibc >> 16) & 0x0fffU;
=20
 	scb_s->ibc =3D 0;
 	/* ibc installed in g2 and requested for g3 */
-	if (vcpu->kvm->arch.model.ibc && (scb_o->ibc & 0x0fffU)) {
-		scb_s->ibc =3D scb_o->ibc & 0x0fffU;
+	if (vcpu->kvm->arch.model.ibc && new_ibc) {
+		scb_s->ibc =3D new_ibc;
 		/* takte care of the minimum ibc level of the machine */
 		if (scb_s->ibc < min_ibc)
 			scb_s->ibc =3D min_ibc;
@@ -256,6 +264,10 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vs=
ie_page *vsie_page)
 {
 	struct kvm_s390_sie_block *scb_o =3D vsie_page->scb_o;
 	struct kvm_s390_sie_block *scb_s =3D &vsie_page->scb_s;
+	/* READ_ONCE does not work on bitfields - use a temporary variable */
+	const uint32_t __new_prefix =3D scb_o->prefix;
+	const uint32_t new_prefix =3D READ_ONCE(__new_prefix);
+	const bool wants_tx =3D READ_ONCE(scb_o->ecb) & ECB_TE;
 	bool had_tx =3D scb_s->ecb & ECB_TE;
 	unsigned long new_mso =3D 0;
 	int rc;
@@ -302,14 +314,14 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct v=
sie_page *vsie_page)
 	scb_s->icpua =3D scb_o->icpua;
=20
 	if (!(atomic_read(&scb_s->cpuflags) & CPUSTAT_SM))
-		new_mso =3D scb_o->mso & 0xfffffffffff00000UL;
+		new_mso =3D READ_ONCE(scb_o->mso) & 0xfffffffffff00000UL;
 	/* if the hva of the prefix changes, we have to remap the prefix */
-	if (scb_s->mso !=3D new_mso || scb_s->prefix !=3D scb_o->prefix)
+	if (scb_s->mso !=3D new_mso || scb_s->prefix !=3D new_prefix)
 		prefix_unmapped(vsie_page);
 	 /* SIE will do mso/msl validity and exception checks for us */
 	scb_s->msl =3D scb_o->msl & 0xfffffffffff00000UL;
 	scb_s->mso =3D new_mso;
-	scb_s->prefix =3D scb_o->prefix;
+	scb_s->prefix =3D new_prefix;
=20
 	/* We have to definetly flush the tlb if this scb never ran */
 	if (scb_s->ihcpu !=3D 0xffffU)
@@ -321,11 +333,11 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct v=
sie_page *vsie_page)
 	if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_ESOP))
 		scb_s->ecb |=3D scb_o->ecb & ECB_HOSTPROTINT;
 	/* transactional execution */
-	if (test_kvm_facility(vcpu->kvm, 73)) {
+	if (test_kvm_facility(vcpu->kvm, 73) && wants_tx) {
 		/* remap the prefix is tx is toggled on */
-		if ((scb_o->ecb & ECB_TE) && !had_tx)
+		if (!had_tx)
 			prefix_unmapped(vsie_page);
-		scb_s->ecb |=3D scb_o->ecb & ECB_TE;
+		scb_s->ecb |=3D ECB_TE;
 	}
 	/* SIMD */
 	if (test_kvm_facility(vcpu->kvm, 129)) {
@@ -544,9 +556,9 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsi=
e_page *vsie_page)
 	gpa_t gpa;
 	int rc =3D 0;
=20
-	gpa =3D scb_o->scaol & ~0xfUL;
+	gpa =3D READ_ONCE(scb_o->scaol) & ~0xfUL;
 	if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_64BSCAO))
-		gpa |=3D (u64) scb_o->scaoh << 32;
+		gpa |=3D (u64) READ_ONCE(scb_o->scaoh) << 32;
 	if (gpa) {
 		if (!(gpa & ~0x1fffUL))
 			rc =3D set_validity_icpt(scb_s, 0x0038U);
@@ -566,7 +578,7 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsi=
e_page *vsie_page)
 		scb_s->scaol =3D (u32)(u64)hpa;
 	}
=20
-	gpa =3D scb_o->itdba & ~0xffUL;
+	gpa =3D READ_ONCE(scb_o->itdba) & ~0xffUL;
 	if (gpa && (scb_s->ecb & ECB_TE)) {
 		if (!(gpa & ~0x1fffU)) {
 			rc =3D set_validity_icpt(scb_s, 0x0080U);
@@ -581,7 +593,7 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsi=
e_page *vsie_page)
 		scb_s->itdba =3D hpa;
 	}
=20
-	gpa =3D scb_o->gvrd & ~0x1ffUL;
+	gpa =3D READ_ONCE(scb_o->gvrd) & ~0x1ffUL;
 	if (gpa && (scb_s->eca & ECA_VX) && !(scb_s->ecd & ECD_HOSTREGMGMT)) {
 		if (!(gpa & ~0x1fffUL)) {
 			rc =3D set_validity_icpt(scb_s, 0x1310U);
@@ -599,7 +611,7 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsi=
e_page *vsie_page)
 		scb_s->gvrd =3D hpa;
 	}
=20
-	gpa =3D scb_o->riccbd & ~0x3fUL;
+	gpa =3D READ_ONCE(scb_o->riccbd) & ~0x3fUL;
 	if (gpa && (scb_s->ecb3 & ECB3_RI)) {
 		if (!(gpa & ~0x1fffUL)) {
 			rc =3D set_validity_icpt(scb_s, 0x0043U);
@@ -617,8 +629,8 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsi=
e_page *vsie_page)
 	if ((scb_s->ecb & ECB_GS) && !(scb_s->ecd & ECD_HOSTREGMGMT)) {
 		unsigned long sdnxc;
=20
-		gpa =3D scb_o->sdnxo & ~0xfUL;
-		sdnxc =3D scb_o->sdnxo & 0xfUL;
+		gpa =3D READ_ONCE(scb_o->sdnxo) & ~0xfUL;
+		sdnxc =3D READ_ONCE(scb_o->sdnxo) & 0xfUL;
 		if (!gpa || !(gpa & ~0x1fffUL)) {
 			rc =3D set_validity_icpt(scb_s, 0x10b0U);
 			goto unpin;
@@ -785,7 +797,7 @@ static void retry_vsie_icpt(struct vsie_page *vsie_page=
)
 static int handle_stfle(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page=
)
 {
 	struct kvm_s390_sie_block *scb_s =3D &vsie_page->scb_s;
-	__u32 fac =3D vsie_page->scb_o->fac & 0x7ffffff8U;
+	__u32 fac =3D READ_ONCE(vsie_page->scb_o->fac) & 0x7ffffff8U;
=20
 	if (fac && test_kvm_facility(vcpu->kvm, 7)) {
 		retry_vsie_icpt(vsie_page);
--=20
2.15.1
