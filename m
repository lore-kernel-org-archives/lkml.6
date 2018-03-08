Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-912290-1520485534-2-16759518756244127078
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520485533; b=hI7FduTx8EeooNX18U2WGjdvnj+stp0nPa9r87O5Zm1dsFU
    xAVEKSgwaobjmcM0dFWEVNcZKMEcmvEgcaEPK4d8zW0/OwvntuUBYhAqbOfYZae/
    nNY+IlO1eY828vvSrDITw6veh/pwi3U+4FzPR9f0T5Rm+xBhLEAvtLNBpGC7MvgN
    PCJC4SDBc6q4AX6PIVI+UhNNeAdpCJiEPHMdbjayEvflwxoPxhKzxe96JlY3Ge0h
    IVRtGByE8Rx9SUhynW0d+ebwXVMroo8tx5kex5024ka+GhylkJOoRgebh6pLS5/c
    sdM32m4NFwq+aiCd2DcuS7YDcM2WEI/PKmA1Kkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485533; bh=E8zHBu
    ReNXeV9FPGnA1QIajw8+eKc+E0xXDpoMv78+0=; b=sY7JB1PHYlnD+tzQchcQsj
    yyWvaXUHRXQSkgwx1WQxZHpu65+otSwjOvd6rYAyB3o1Y79Cy/4GITF+rs6ZefsE
    TmFFm5lOkYDPbLNJMycgyfpl0D/gm8QiingVjC+qE2QyYf+aIbax7dO3dqhoZObN
    Uy2aadXXdP+DewWVQOpw5EniWYKcByUxWPhkvPUxGA3gYTX2Hhk3YgcK+lvJGVjs
    2SYGaiBuNRNZjWzcyn7Dnwx7yr55XjfAqSO6xAdwuFwt277/EWxSh6D4frrSXVg/
    3LUUnBA871z9Noizh8LL20UwnnLeLBq9gxQmmN82I92Qem4+EajXYUjRjG3B/neQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CqWXpVqj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CqWXpVqj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966260AbeCHFF3 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:05:29 -0500
Received: from mail-sn1nam02on0093.outbound.protection.outlook.com ([104.47.36.93]:58876
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966244AbeCHFF0 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:26 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Alexey Kardashevskiy <aik@ozlabs.ru>,
        Paul Mackerras <paulus@ozlabs.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 028/101] KVM: PPC: Book3S PR: Exit KVM on
 failed mapping
Thread-Topic: [PATCH AUTOSEL for 4.4 028/101] KVM: PPC: Book3S PR: Exit KVM on
 failed mapping
Thread-Index: AQHTtpqIi/pD8g/V9kWiXpJ8Knwanw==
Date: Thu, 8 Mar 2018 05:01:36 +0000
Message-ID: <20180308050023.8548-28-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;20:DZCeog3FeSISBM/I0m24zGGIrP+FPSAuLaQqvfl53jf+yBnK9368kdhwO8V6N2B4yl2N8IKWs30ZQfeQ90VTUlGKmYXtSbmCAyFy712LWOTqZXGAHi4zeEl8hQbWMj1VKEXSkgngTzjxVDT2EGl/DvB/TrWVm2vBaGf5LVhMGe8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7ab4f05c-edd4-4765-1ac0-08d584b22eb7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07274F19E9420AF887C3DF10FBDF0@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(199004)(189003)(81156014)(4326008)(97736004)(105586002)(2906002)(6666003)(8676002)(26005)(10290500003)(76176011)(186003)(110136005)(22452003)(7736002)(54906003)(25786009)(2950100002)(4477795004)(3280700002)(305945005)(81166006)(2900100001)(8936002)(59450400001)(102836004)(6506007)(68736007)(106356001)(10090500001)(1076002)(6512007)(86362001)(3846002)(2501003)(14454004)(478600001)(99286004)(575784001)(72206003)(6116002)(3660700001)(5250100002)(53936002)(107886003)(6436002)(5660300001)(316002)(6486002)(36756003)(86612001)(66066001)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: u1POLYpLIHFhtInKdfx0iB0sFNq5Pwt6VPEAw/pYekpAoRzQqPdsjzfTAjCDyGRzD6t+RV6p96aLdko9zh0aF2e1ukZvpHQcSXnKKBWSnknWAO/bwvxvBpvkJOOA94slwdd00Ss4PAmXierkEk8nHIa3LS7Zt7R7R1exBULyyF7sEJQaqcCo22GJhWp29qWsnzjxHlvBQwUeqxzDT+VL4BqvORi+nWLy+4CNltUJWvGwYDsU9I8f+sOKnO6hXYflw+J6VJXzT27BZVgYNlr2k68+sm1BssRVQSi/V+V7lBJADO3cYJKiT+QwFHzusG4/dlteHs3PDpUpXbVx/R48kg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab4f05c-edd4-4765-1ac0-08d584b22eb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:36.0863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

[ Upstream commit bd9166ffe624000140fc6b606b256df01fc0d060 ]

At the moment kvmppc_mmu_map_page() returns -1 if
mmu_hash_ops.hpte_insert() fails for any reason so the page fault handler
resumes the guest and it faults on the same address again.

This adds distinction to kvmppc_mmu_map_page() to return -EIO if
mmu_hash_ops.hpte_insert() failed for a reason other than full pteg.
At the moment only pSeries_lpar_hpte_insert() returns -2 if
plpar_pte_enter() failed with a code other than H_PTEG_FULL.
Other mmu_hash_ops.hpte_insert() instances can only fail with
-1 "full pteg".

With this change, if PR KVM fails to update HPT, it can signal
the userspace about this instead of returning to guest and having
the very same page fault over and over again.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/kvm/book3s_64_mmu_host.c | 5 ++++-
 arch/powerpc/kvm/book3s_pr.c          | 6 +++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_host.c b/arch/powerpc/kvm/book3=
s_64_mmu_host.c
index 79ad35abd196..ddec22828673 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
@@ -177,12 +177,15 @@ int kvmppc_mmu_map_page(struct kvm_vcpu *vcpu, struct=
 kvmppc_pte *orig_pte,
 	ret =3D ppc_md.hpte_insert(hpteg, vpn, hpaddr, rflags, vflags,
 				 hpsize, hpsize, MMU_SEGSIZE_256M);
=20
-	if (ret < 0) {
+	if (ret =3D=3D -1) {
 		/* If we couldn't map a primary PTE, try a secondary */
 		hash =3D ~hash;
 		vflags ^=3D HPTE_V_SECONDARY;
 		attempt++;
 		goto map_again;
+	} else if (ret < 0) {
+		r =3D -EIO;
+		goto out_unlock;
 	} else {
 		trace_kvm_book3s_64_mmu_map(rflags, hpteg,
 					    vpn, hpaddr, orig_pte);
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 64891b081ad5..81313844d81c 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -625,7 +625,11 @@ int kvmppc_handle_pagefault(struct kvm_run *run, struc=
t kvm_vcpu *vcpu,
 			kvmppc_mmu_unmap_page(vcpu, &pte);
 		}
 		/* The guest's PTE is not mapped yet. Map on the host */
-		kvmppc_mmu_map_page(vcpu, &pte, iswrite);
+		if (kvmppc_mmu_map_page(vcpu, &pte, iswrite) =3D=3D -EIO) {
+			/* Exit KVM if mapping failed */
+			run->exit_reason =3D KVM_EXIT_INTERNAL_ERROR;
+			return RESUME_HOST;
+		}
 		if (data)
 			vcpu->stat.sp_storage++;
 		else if (vcpu->arch.mmu.is_dcbz32(vcpu) &&
--=20
2.14.1
