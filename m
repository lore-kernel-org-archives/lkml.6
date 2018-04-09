Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523246155-2-16738959225610158139
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
    1523246154; b=ILklllWn+0WWkzMEGBjlM3tZtSpQKQ/2h566Axw9R+p8LJRVU1
    yHSYfx/PcffniGA4uqiaQGRCsjdLBMjgxNKNLS0KW2dqEHWz524rZN7hKhW05I+z
    2XrY72ao4G9QnuGoU5ZsYhF05FEVkfB2pvM9gEsBUsO5K40+3M/120FC8Vm5SyRr
    5qFnCOWb3oYhADWDMIooHr8q4S77w7PMH3PTGfoiRFzHwlRChJq28+b/MWGh3F1D
    2PgTv7oAK9hgHCzrOkTRggbOkcEXEXQd8Xk5uM1/KklRT/5mL4CoLhdRRrk30DfY
    3B/w3qRhQELliHInAP6tXZ1Vxz7Ta/MCpung==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246154; bh=6iXe2NSWdI
    RHBVKcEjKzPozFV6WWca+vEkyqJ5bwO5k=; b=u2d/0CqpdvnTm+osHVgOgW6LGX
    aLKVLVVZu9Do97U50rI8hjGVEtcg5yR/jWvPAfm7Sbv69FwT2ybewsNDBMUrQs0O
    T0PTXSid1sKNadmuYJxoj3QWHu5daGVEsKOURorZpwLrxqxuzTn3ced3nKTIXVHc
    ShlzjaLAiFf3Xnp/0ZMkLwb+z1b4YPXiiGcQ63tXjkvzXU4vkRXYE7vXfqTVr2Bc
    BSIFcdtzy+YK1oBB62kgh2PDeU++Fk+BG+15pEbaHptEw9N4nPAxJsHoxiDDrTVw
    hMHrZTnJ6dCRTv8VTozM8XjAE4ntM+bMZz1u1hrrEvKt3+N75h69S5Jz42+A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=URFFxC6l x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=URFFxC6l x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGh/fhUbnICp84O+TIxeRoUy5KrQOb6pTnEpkkIb8b/3+Ys4m5a5F6PKQG6BTNosE0mt9iQz4cDAP2JWF1gzW6kFujQ23b1M1AUbrQSISSfzKReKg6ud
    D7oinM38K1BcEoVqyNf8AWlU3VyIKNYrvFjIZRAtMPqDkuz5JYx/xbGFVyKPc37JzCFFWA6eo3OKZyamt4RiguDpER3iAD1p+DRaYO5mIt2YauVMe5I76Jo2
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=yMhMjlubAAAA:8
    a=7lQfPUhootlNXDL6mXMA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753784AbeDIASt (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:18:49 -0400
Received: from mail-by2nam01on0126.outbound.protection.outlook.com ([104.47.34.126]:59343
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753773AbeDIASq (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:18:46 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: David Hildenbrand <david@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 083/189] KVM: s390: vsie: store guest
 addresses of satellite blocks in vsie_page
Thread-Topic: [PATCH AUTOSEL for 4.15 083/189] KVM: s390: vsie: store guest
 addresses of satellite blocks in vsie_page
Thread-Index: AQHTz5gysyAvs1JGC0GQkIbPrxFDRw==
Date: Mon, 9 Apr 2018 00:17:50 +0000
Message-ID: <20180409001637.162453-83-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1128;7:Nma5OJULRTU1kmNwuU0TlFHGWaL6M6SD1OryfBlVbkQxWWkOZrjU+35DJQmaYROUp5f7bmVZL3fhWxens05bdiPApleQg7zEMHygO1U6Eq71O5pKdhAr2p7MuS4kfZuH1tBnq+4ndsmBjDuNzoR9n74IP4hmAHnAdqRIZ+ktfLRCxc+7YSJKtrCpesmbTO0vLpK4MTYzGfUFMP65DQ3ONcV2G+sLlqXUGRJPVszWUNdkcJ18g8eKdaqVC81Zl5RF;20:/KshpmWLEBW7Vt7nLwlNqAQK4oGnUK5RrgzVEzbTjp/XbKpFHx026pPuYXmV/j2Njv/2BGe8Q+8bvQxObM9lSxIHiRCd6sbdesLRyJ60XuY4kjbcrG1ijIN5XBAvKiQnEfLVt5428RGzTS35GZxPRkk4X+KhawpQsX98V/H2aRs=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3f5b983f-e78a-4074-ca4f-08d59daf7214
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1128;
x-ms-traffictypediagnostic: DM5PR2101MB1128:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1128D1C53116642D65E17222FBBF0@DM5PR2101MB1128.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(190383065149520)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1128;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1128;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(376002)(366004)(39380400002)(199004)(189003)(66066001)(86362001)(3660700001)(3280700002)(2900100001)(25786009)(36756003)(6506007)(76176011)(2906002)(6486002)(86612001)(99286004)(102836004)(1076002)(7736002)(575784001)(97736004)(2616005)(446003)(486006)(11346002)(476003)(26005)(305945005)(6666003)(6512007)(4326008)(107886003)(478600001)(6436002)(5660300001)(10290500003)(5250100002)(22452003)(316002)(105586002)(186003)(8676002)(110136005)(54906003)(72206003)(53936002)(2501003)(68736007)(14454004)(6116002)(8936002)(3846002)(81156014)(10090500001)(106356001)(81166006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1128;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: OM4pVXmnRVsNbOjGcMLLKguIMoZTkwUJTYiOOVk5chCeF/3lUHsOXVz6d0nnB3nuM0By8NhfKea8P1KLgVdklugdnf6yTpfWrYndK3HHDziNDXs0tS9oahUNnwKXZ9Q6qdA1nrIqkRieL3IS/vMUIXlkBcVjKqehSCIofvk4MOHYdpwBzzaNcLcWPX2dgcY43+K7aQlAssxKbymJEKCIZUYNcAkrTuoBQZ8WArqLL84KJYjK2q2n2LFECE3wwi1nSkPPMEuWpuNBx1WjuZ08IlGNCklIt/usLI5bi7VoUj5ix3sZiiljPycwOHpjReaiVfyVvFhl01EWc+dOefH5BJ5GedRtq+diLh49S5es6qqyQaIx7HcVNfbWj6uEXtSjEwnFACk+ROnjJ23uM3inYzkmFmleCTidCGkpnhSUJqc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f5b983f-e78a-4074-ca4f-08d59daf7214
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:50.7420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1128
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: David Hildenbrand <david@redhat.com>

[ Upstream commit 15e5020e575d0c1a4eddd99bf7ffdc1f34a3b17d ]

This way, the values cannot change, even if another VCPU might try to
mess with the nested SCB currently getting executed by another VCPU.

We now always use the same gpa for pinning and unpinning a page (for
unpinning, it is only relevant to mark the guest page dirty for
migration).

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180116171526.12343-3-david@redhat.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/s390/kvm/vsie.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 11fc525e6e7f..861832c2e842 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -38,7 +38,13 @@ struct vsie_page {
 	struct gmap *gmap;			/* 0x0220 */
 	/* address of the last reported fault to guest2 */
 	unsigned long fault_addr;		/* 0x0228 */
-	__u8 reserved[0x0700 - 0x0230];		/* 0x0230 */
+	/* calculated guest addresses of satellite control blocks */
+	gpa_t sca_gpa;				/* 0x0230 */
+	gpa_t itdba_gpa;			/* 0x0238 */
+	gpa_t gvrd_gpa;				/* 0x0240 */
+	gpa_t riccbd_gpa;			/* 0x0248 */
+	gpa_t sdnx_gpa;				/* 0x0250 */
+	__u8 reserved[0x0700 - 0x0258];		/* 0x0258 */
 	struct kvm_s390_crypto_cb crycb;	/* 0x0700 */
 	__u8 fac[S390_ARCH_FAC_LIST_SIZE_BYTE];	/* 0x0800 */
 };
@@ -485,46 +491,42 @@ static void unpin_guest_page(struct kvm *kvm, gpa_t g=
pa, hpa_t hpa)
 /* unpin all blocks previously pinned by pin_blocks(), marking them dirty =
*/
 static void unpin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_pag=
e)
 {
-	struct kvm_s390_sie_block *scb_o =3D vsie_page->scb_o;
 	struct kvm_s390_sie_block *scb_s =3D &vsie_page->scb_s;
 	hpa_t hpa;
-	gpa_t gpa;
=20
 	hpa =3D (u64) scb_s->scaoh << 32 | scb_s->scaol;
 	if (hpa) {
-		gpa =3D scb_o->scaol & ~0xfUL;
-		if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_64BSCAO))
-			gpa |=3D (u64) scb_o->scaoh << 32;
-		unpin_guest_page(vcpu->kvm, gpa, hpa);
+		unpin_guest_page(vcpu->kvm, vsie_page->sca_gpa, hpa);
+		vsie_page->sca_gpa =3D 0;
 		scb_s->scaol =3D 0;
 		scb_s->scaoh =3D 0;
 	}
=20
 	hpa =3D scb_s->itdba;
 	if (hpa) {
-		gpa =3D scb_o->itdba & ~0xffUL;
-		unpin_guest_page(vcpu->kvm, gpa, hpa);
+		unpin_guest_page(vcpu->kvm, vsie_page->itdba_gpa, hpa);
+		vsie_page->itdba_gpa =3D 0;
 		scb_s->itdba =3D 0;
 	}
=20
 	hpa =3D scb_s->gvrd;
 	if (hpa) {
-		gpa =3D scb_o->gvrd & ~0x1ffUL;
-		unpin_guest_page(vcpu->kvm, gpa, hpa);
+		unpin_guest_page(vcpu->kvm, vsie_page->gvrd_gpa, hpa);
+		vsie_page->gvrd_gpa =3D 0;
 		scb_s->gvrd =3D 0;
 	}
=20
 	hpa =3D scb_s->riccbd;
 	if (hpa) {
-		gpa =3D scb_o->riccbd & ~0x3fUL;
-		unpin_guest_page(vcpu->kvm, gpa, hpa);
+		unpin_guest_page(vcpu->kvm, vsie_page->riccbd_gpa, hpa);
+		vsie_page->riccbd_gpa =3D 0;
 		scb_s->riccbd =3D 0;
 	}
=20
 	hpa =3D scb_s->sdnxo;
 	if (hpa) {
-		gpa =3D scb_o->sdnxo;
-		unpin_guest_page(vcpu->kvm, gpa, hpa);
+		unpin_guest_page(vcpu->kvm, vsie_page->sdnx_gpa, hpa);
+		vsie_page->sdnx_gpa =3D 0;
 		scb_s->sdnxo =3D 0;
 	}
 }
@@ -569,6 +571,7 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsi=
e_page *vsie_page)
 		}
 		if (rc)
 			goto unpin;
+		vsie_page->sca_gpa =3D gpa;
 		scb_s->scaoh =3D (u32)((u64)hpa >> 32);
 		scb_s->scaol =3D (u32)(u64)hpa;
 	}
@@ -585,6 +588,7 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsi=
e_page *vsie_page)
 			rc =3D set_validity_icpt(scb_s, 0x0080U);
 			goto unpin;
 		}
+		vsie_page->itdba_gpa =3D gpa;
 		scb_s->itdba =3D hpa;
 	}
=20
@@ -603,6 +607,7 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsi=
e_page *vsie_page)
 			rc =3D set_validity_icpt(scb_s, 0x1310U);
 			goto unpin;
 		}
+		vsie_page->gvrd_gpa =3D gpa;
 		scb_s->gvrd =3D hpa;
 	}
=20
@@ -619,6 +624,7 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsi=
e_page *vsie_page)
 			goto unpin;
 		}
 		/* Validity 0x0044 will be checked by SIE */
+		vsie_page->riccbd_gpa =3D gpa;
 		scb_s->riccbd =3D hpa;
 	}
 	if ((scb_s->ecb & ECB_GS) && !(scb_s->ecd & ECD_HOSTREGMGMT)) {
@@ -646,6 +652,7 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsi=
e_page *vsie_page)
 			rc =3D set_validity_icpt(scb_s, 0x10b0U);
 			goto unpin;
 		}
+		vsie_page->sdnx_gpa =3D gpa;
 		scb_s->sdnxo =3D hpa | sdnxc;
 	}
 	return 0;
--=20
2.15.1
