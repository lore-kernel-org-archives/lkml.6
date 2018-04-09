Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523244511-2-2597423048585224674
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523244510; b=LZJHGZGqGSj2flw15pzV2jZ0reDjx4yC2A5osU+V+ZoJXeTkCm
    f3+WMB1ppfd3YCTSoLSmWaaLvV4r38lQ13iy7VFbmXh2IlAxsf/6ePQfbS6u4dGl
    pfBMFDOWprnGb0TrRxD/2Xas2uYvWiAfygjOklcAk65LgaXmXnpVjBMumszNTokU
    8smQF7QQXG19w3+UqONtOpDpBvSkLA++lC2Qq6eYE6z/IMa+E3TQ9AFpk0OHO82x
    tKAGvJ6xXuAKXOjkdvgNvfCBr2JCoMDwLVmI1I1/rPmDib4HrQdjua5Sn3WxNJuL
    xRniVDtyo+dczyL3CkKpMlqrIGQlvDaKDbog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244510; bh=3+slkllpJO
    o2ijoNjx7nbUrPJWpiXWEuNdY+HIybJcM=; b=uy6AlQSAAjLHYXnoBUWPQaa8cJ
    pdEA7DFNsJu2doz8sQpk3Wvlsg81bbpwkikAxXo2rT2jKnrW3QJQUOtRYr/iCoJC
    xRQgYJ1n7kF7tjH5cWiYM6vEH80oP2G66C4JISdwKtR5x5sRV7TkLoofkR+/zzj0
    QfxxsjXVJXLQE+X8g6KkTeRziR2FUqehkxuqEg+agqPP+8puva4A7C1rXfxSg3Du
    L+bM8vUqYZBXxBJBB++goOA/fJbaYEEA6tvQdIxCGbkKKBj3Ug7EfHBnkEj0oP5A
    reIuZ1kt8Cq397frXg7/05sfNnk/6XJGZVPv/NFIRgwCl2YxUcvH4cFz919A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BGmOBmMr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BGmOBmMr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFDHJEmo6Mv2lYnigINV0Q5ljqJMwGK+eAI1itPuWSyVm/l9v3agCS7UJjdkV5whUfMd7Gyuhyv+pCqlmd6CiawPxco9GtzWAg+XlbnrbQUiquUEScKE
    hXuKbrARt5vEyhLeXeKfUw+MGysP+3En2qqT5yYpKtsOsNcJlTzpJKrJZFVVWJrT/j3eZn438oqQdB1zZv0yddzrH/kM8ooylIf39s1JDiYT8TcyYH2VmF+7
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=voM4FWlXAAAA:8 a=yMhMjlubAAAA:8 a=d3OEcdXZJ61ZiO9ohwUA:9
    a=wPNLvfGTeEIA:10 a=IC2XNlieTeVoXbcui8wp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751815AbeDID2P (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:28:15 -0400
Received: from mail-sn1nam02on0111.outbound.protection.outlook.com ([104.47.36.111]:52845
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754609AbeDIAWG (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:22:06 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Paul Mackerras <paulus@ozlabs.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 009/161] KVM: PPC: Book3S HV: Enable
 migration of decrementer register
Thread-Topic: [PATCH AUTOSEL for 4.14 009/161] KVM: PPC: Book3S HV: Enable
 migration of decrementer register
Thread-Index: AQHTz5h48U+RubVx9kmQHLMUx5q5XQ==
Date: Mon, 9 Apr 2018 00:19:48 +0000
Message-ID: <20180409001936.162706-9-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0936;7:pBezmZQQKmt23cXmgrv0zcW5Pjf2y0YP8Ixhv9REXIJv/r3QXZpc3ZtlLp0+UMUz4AxKpkgmYze2/4KrziplefBrp2/C5jqUb4bL2lApswymBPE9AepOo+h2rygslifHTQ1IZguwFeqCTT2UZmR5Jp/NLHgf2nPCtLU/0h5XmE0ejxWXXp+tkNkpGUs2pXKMkI++iydLxve/J1hc+w1XwNkQgXN2RNVzQB1Xg/Ryn7XB5ba3ujjqwvBII07ROlta;20:OWjGTClGeS4bBN+Nt2d8R2XSpK8Y+X7AZlVNcBJT8F6VeJaPaiz+vt1kGjOrEjg9xOJIFBEwNoD4ND0SelpP6Q+2qocnVfATmh1lMj/8KsOBURrm13JyQSHG49Ap4ggELn+6Io0HVXDZ2XwIDM+AonGj498pmAEfTs9PWqKo5YE=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: e4c479c6-42c6-454d-6a5c-08d59dafe8a3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09360245805A63C7F084081BFBBF0@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0936;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0936;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(396003)(376002)(366004)(199004)(189003)(3660700001)(36756003)(2501003)(76176011)(10290500003)(2616005)(5250100002)(3280700002)(478600001)(1076002)(72206003)(6436002)(53936002)(486006)(476003)(4326008)(6486002)(107886003)(5660300001)(54906003)(110136005)(102836004)(2906002)(6116002)(3846002)(86612001)(81156014)(81166006)(6666003)(8936002)(305945005)(8676002)(2900100001)(6506007)(68736007)(14454004)(106356001)(105586002)(25786009)(6512007)(86362001)(99286004)(446003)(551984002)(59450400001)(10090500001)(11346002)(316002)(26005)(7736002)(66066001)(186003)(22452003)(97736004)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0936;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: gobLc3kM7j+GSuJWQTtJwe09EoMPVV3t3qUCIrdYdu236lTjV6n+dF+Pm4GKi9YOLJy0Dmm3P2BDYtRrxPh06SB8AZ7yYySFSF0+Rhd1TSdpnSalgvx/SnXXFmbyaYGv3Hb/UOEkiDMEZs3kXQqqVboCdCrXFQVxjxOJGX+cPHzTGWbqyNcoVKpWcJQX0LgxbpgIqxNyY3vbGbLFQrYwGupNNkI/536m+osmHx+HkwIDy228ZPYtc5konfOxlt9tvXxvq4PEVrOYMCJiK1daMgIicwpk0LXTa2FWPw1ZWMSk5lpWXdsflr3o1crxeLxCLySeeKYwviaPH/qNIqu2soaPCyJymCGg5hk0JOOIo90aW7tdCnikjkctqf8h9PL42hGtINfwVjuviEuJjSUdQTWjSe2esVOJZgEziG6nkSI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c479c6-42c6-454d-6a5c-08d59dafe8a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:48.2545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Paul Mackerras <paulus@ozlabs.org>

[ Upstream commit 5855564c8ab2d9cefca7b2933bd19818eb795e40 ]

This adds a register identifier for use with the one_reg interface
to allow the decrementer expiry time to be read and written by
userspace.  The decrementer expiry time is in guest timebase units
and is equal to the sum of the decrementer and the guest timebase.
(The expiry time is used rather than the decrementer value itself
because the expiry time is not constantly changing, though the
decrementer value is, while the guest vcpu is not running.)

Without this, a guest vcpu migrated to a new host will see its
decrementer set to some random value.  On POWER8 and earlier, the
decrementer is 32 bits wide and counts down at 512MHz, so the
guest vcpu will potentially see no decrementer interrupts for up
to about 4 seconds, which will lead to a stall.  With POWER9, the
decrementer is now 56 bits side, so the stall can be much longer
(up to 2.23 years) and more noticeable.

To help work around the problem in cases where userspace has not been
updated to migrate the decrementer expiry time, we now set the
default decrementer expiry at vcpu creation time to the current time
rather than the maximum possible value.  This should mean an
immediate decrementer interrupt when a migrated vcpu starts
running.  In cases where the decrementer is 32 bits wide and more
than 4 seconds elapse between the creation of the vcpu and when it
first runs, the decrementer would have wrapped around to positive
values and there may still be a stall - but this is no worse than
the current situation.  In the large-decrementer case, we are sure
to get an immediate decrementer interrupt (assuming the time from
vcpu creation to first run is less than 2.23 years) and we thus
avoid a very long stall.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 Documentation/virtual/kvm/api.txt   | 1 +
 arch/powerpc/include/uapi/asm/kvm.h | 2 ++
 arch/powerpc/kvm/book3s_hv.c        | 8 ++++++++
 arch/powerpc/kvm/powerpc.c          | 2 +-
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/=
api.txt
index e63a35fafef0..0f9089416b4c 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -1837,6 +1837,7 @@ registers, find a list below:
   PPC	| KVM_REG_PPC_DBSR              | 32
   PPC   | KVM_REG_PPC_TIDR              | 64
   PPC   | KVM_REG_PPC_PSSCR             | 64
+  PPC   | KVM_REG_PPC_DEC_EXPIRY        | 64
   PPC   | KVM_REG_PPC_TM_GPR0           | 64
           ...
   PPC   | KVM_REG_PPC_TM_GPR31          | 64
diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uap=
i/asm/kvm.h
index 61d6049f4c1e..8aaec831053a 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -607,6 +607,8 @@ struct kvm_ppc_rmmu_info {
 #define KVM_REG_PPC_TIDR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xbc)
 #define KVM_REG_PPC_PSSCR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xbd)
=20
+#define KVM_REG_PPC_DEC_EXPIRY	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xbe)
+
 /* Transactional Memory checkpointed state:
  * This is all GPRs, all VSX regs and a subset of SPRs
  */
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index f48e3379a18a..e094dc90ff1b 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1497,6 +1497,10 @@ static int kvmppc_get_one_reg_hv(struct kvm_vcpu *vc=
pu, u64 id,
 	case KVM_REG_PPC_ARCH_COMPAT:
 		*val =3D get_reg_val(id, vcpu->arch.vcore->arch_compat);
 		break;
+	case KVM_REG_PPC_DEC_EXPIRY:
+		*val =3D get_reg_val(id, vcpu->arch.dec_expires +
+				   vcpu->arch.vcore->tb_offset);
+		break;
 	default:
 		r =3D -EINVAL;
 		break;
@@ -1724,6 +1728,10 @@ static int kvmppc_set_one_reg_hv(struct kvm_vcpu *vc=
pu, u64 id,
 	case KVM_REG_PPC_ARCH_COMPAT:
 		r =3D kvmppc_set_arch_compat(vcpu, set_reg_val(id, *val));
 		break;
+	case KVM_REG_PPC_DEC_EXPIRY:
+		vcpu->arch.dec_expires =3D set_reg_val(id, *val) -
+			vcpu->arch.vcore->tb_offset;
+		break;
 	default:
 		r =3D -EINVAL;
 		break;
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 2b02d51d14d8..ecb45361095b 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -758,7 +758,7 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
=20
 	hrtimer_init(&vcpu->arch.dec_timer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
 	vcpu->arch.dec_timer.function =3D kvmppc_decrementer_wakeup;
-	vcpu->arch.dec_expires =3D ~(u64)0;
+	vcpu->arch.dec_expires =3D get_tb();
=20
 #ifdef CONFIG_KVM_EXIT_TIMING
 	mutex_init(&vcpu->arch.exit_timing_lock);
--=20
2.15.1
