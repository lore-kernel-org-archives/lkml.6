Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4147991-1523247055-2-6302455465163480574
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
    1523247054; b=dRipV1+uCuMQPkhVuxE0KVP1tG0oDa5FCBK4yKOsjhcgdEEPun
    U80t6BGqRz7g/3PnL7c9PF815JA/2CjV9mid4/pJ7g7sKvl2guHxSVIzrAc7jVyq
    lJuFmLdqc+vB8u+KrFNlV/W4aIBXanRtZbq9OJN5kB7CgVHnVmGCyr+XUGFEHzG8
    VBNaMAGZha9r9ojnzmC9sKPMGfGuTC8w/ANpJ7xB05WzJtGZABy9/qz8n6wtSrUu
    JXA6Tii965BzkXl9sj687FAXHlh92vd8YqTm+emiPsBpINe+TRYqejau+6w8h4Wa
    V2P460Odb7iTcaHVH9EORMd33/+L77XKpYOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523247054; bh=YDAn6pEDvm
    QsPnCIFsOc0jGqU6D983NmbF8nPcDjh2U=; b=Ast7k+IqXBwOVO+4sW+FLmVNhB
    DbaCx8yyakafiVhhnluXGqRaVzeJSQhy4/bXT1ngCwjbHcsoYXPSW5hVrdm6wltE
    ElkTNYmNUkeemgxOk7SHoZ+liPIkVwksmJaYcf3USQ3IGARvLxs0eJjm7i0M/46D
    Wq0mrtnIPo+kFZCoh6YEKQ52Ekw2WeBZoKOCjVmVvQ7zO/4LIdFKAj4QwfMoYn5Y
    YSpY1vq/1eEaR3KijvDPWbkTi71ug2w4xcZGokXWza/jBj6Qt+ir6wiO28fxhR7+
    hG/vzHZa8EEQmXfjPFQV/QIpri4X6WOS1wqsE4HLT8xFgWbypvWaVAeD5+vQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KARW+wb+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KARW+wb+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ/iokx85+SkeKRQq9/MA/UfbxEVNNd/L0kCyyOxJLDQFt8reHS66thnfWMxJk5KbyRBY79/sTXeKsx08Gi2EBjq2Ck7LDARcLvHZilPEEYZJ3j3GMO/
    Jd7HZPBpvlAAA6cin5OWIaju235xqRpq3D7Xbrd1IfG4AbbqPvTPB8G+yZFAdGi6345/QNYRqowDhqJCWnBhtVjqYjF2quIJTvBBShhgqSmb5paTM97mzWPP
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=voM4FWlXAAAA:8 a=yMhMjlubAAAA:8 a=d3OEcdXZJ61ZiO9ohwUA:9
    a=wPNLvfGTeEIA:10 a=IC2XNlieTeVoXbcui8wp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752994AbeDIARC (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:17:02 -0400
Received: from mail-co1nam03on0128.outbound.protection.outlook.com ([104.47.40.128]:49080
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752946AbeDIAQ6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:16:58 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Paul Mackerras <paulus@ozlabs.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 012/189] KVM: PPC: Book3S HV: Enable
 migration of decrementer register
Thread-Topic: [PATCH AUTOSEL for 4.15 012/189] KVM: PPC: Book3S HV: Enable
 migration of decrementer register
Thread-Index: AQHTz5gP+lCLDsvEzU6g1wIxqVmzlA==
Date: Mon, 9 Apr 2018 00:16:53 +0000
Message-ID: <20180409001637.162453-12-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1127;7:9UmGr0loWxBq/jS7D1YddlAgQ9yHFC03OICk3Czvw1yPxCfaLxRi3ZaNExjcK3DSEnMC4/EExL4KkfDQGFm2z6XpCZkrATuoVVF0xb+M5Kk4cturh2NETjn2C23DlWyuaJMFkuR1SFTGx3VAg9aEwnXGq8AMGLuiKaFVHolnqS60dVrQuP9UMf/Ktv04FvDdFpDVzllpYTKCr83l++jXq7I22hVKTSmtg8O7RbfBzkJN9h+yYODiiyl9BXGDs4D4;20:c5EwJUSatCulLZzgGzW9JAEYqxpitbSmAusSHXy+UWBR3rUkVPbqzL9fBuMcr2T82U2VwXUmnsCSnhO7A4aLStCqFRWD1aMzpqcE7Hyy5RXEOgUlWshZjCoi03tvns25tFw7YbZK8CNTE2uUtfvX8PNvk+kkXsfb5xm0I98rkRk=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 05ee223b-30d3-42e3-096d-08d59daf32b1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1127;
x-ms-traffictypediagnostic: DM5PR2101MB1127:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1127DE63BB7D1A614619341BFBBF0@DM5PR2101MB1127.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1127;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1127;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(376002)(346002)(366004)(189003)(199004)(105586002)(186003)(66066001)(6486002)(54906003)(7736002)(26005)(86362001)(316002)(305945005)(110136005)(478600001)(3280700002)(86612001)(10290500003)(25786009)(5250100002)(2616005)(99286004)(22452003)(5660300001)(3660700001)(2900100001)(81166006)(3846002)(2906002)(106356001)(6506007)(59450400001)(107886003)(486006)(8676002)(81156014)(14454004)(10090500001)(68736007)(551984002)(4326008)(6116002)(1076002)(72206003)(102836004)(97736004)(11346002)(8936002)(476003)(2501003)(6436002)(6512007)(446003)(76176011)(36756003)(53936002)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1127;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: XYR7YTOPBnc82gZkqGWUtK/eV5eESnbgVwZg24sQQffvEVlYi06TB1Mx5w9+2sjpNTZUxUa7ibsSJpOPR0cm9/rPECGceusL7mjw5AH40Sg6W5UPhVqKUgCfEilzfz9P+SmrMq6ixvPaJwhDzrhF6Fct5/+S/GJ6S0bRzVXQE9JCsb0pdvVMmY4t6grrKz0iQCsuczB6JP80CYkVW/rKKA7Yp6Bn4kw8TNCxn3liy++HItNGvX1mqWjxqIhgwDQNNFCG00q8J5kPVYjf8gj6mPo87fi4eQYzFlfz8mOPnLyaauWOxDtaH1qO/RWBliUB4k8oQwMjX+XJwZF1mXQ1MXMloyswE9bhW1rIpbIJvh5HHqAEngzZWh7Yerwt1ekfi1ptUZu7GvZ+6kUSwPQ//GcIDSWcQ0aYuW+rnRF03vk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ee223b-30d3-42e3-096d-08d59daf32b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:16:53.6218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1127
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
index fc3ae951bc07..d225ec217ebb 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -1841,6 +1841,7 @@ registers, find a list below:
   PPC	| KVM_REG_PPC_DBSR              | 32
   PPC   | KVM_REG_PPC_TIDR              | 64
   PPC   | KVM_REG_PPC_PSSCR             | 64
+  PPC   | KVM_REG_PPC_DEC_EXPIRY        | 64
   PPC   | KVM_REG_PPC_TM_GPR0           | 64
           ...
   PPC   | KVM_REG_PPC_TM_GPR31          | 64
diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uap=
i/asm/kvm.h
index 637b7263cb86..833ed9a16adf 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -632,6 +632,8 @@ struct kvm_ppc_cpu_char {
 #define KVM_REG_PPC_TIDR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xbc)
 #define KVM_REG_PPC_PSSCR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xbd)
=20
+#define KVM_REG_PPC_DEC_EXPIRY	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xbe)
+
 /* Transactional Memory checkpointed state:
  * This is all GPRs, all VSX regs and a subset of SPRs
  */
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 6c402f6c4940..deffe36d8a2b 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1504,6 +1504,10 @@ static int kvmppc_get_one_reg_hv(struct kvm_vcpu *vc=
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
@@ -1731,6 +1735,10 @@ static int kvmppc_set_one_reg_hv(struct kvm_vcpu *vc=
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
index 0a7c88786ec0..f3a7a2fc3d70 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -763,7 +763,7 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
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
