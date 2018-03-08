Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520486257-2-14002043297582638244
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
    t=1520486256; b=hoYUkOk9F3NBwndghUkXu739pVjAArBnr+T/A6AdWIhUub4
    mDYPgYzDQ/GwbJgGsBdn2jHj1auMfElp2z0sWj1Ek2V2UHEa7xJZ0G1ZsrBQGOQ2
    5ItEHAni8Wha6L/lewczYv8emduxDiFfv3akiF8KLbD8201NhpxlotQTKAje8gC+
    sPxHXkKF7YkCJM9z0xlQExHtDhVm8M+15+YTL8Ix8NLY+iUceZi5fWd2IPndAhxe
    BuNS65zwZi9Bc9knT+bVLIEX7mFmR7/bklc1dURDqNEf1bE+BK7nGu/tGRJnph/l
    YqTB7xGdJ3xvs5uArv+4jo//PdIHd3FKCzF+HsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486256; bh=9vsWDu
    4vh7rxE6TKbHAUXrOREx3b2EPA9Uk5jle6g8I=; b=oyh6VVPlEcrqmiMRgqtafR
    B8Ubrb2W7pkxiD4tsdX2iVETpbHOq4FxYiWCph4EIAe7SA9jIR8xVVmO1kwHM0nL
    gVrLrzAyyCic8zjkBbmgji+qIJJiVEHdy1Cy6ItjpJg+kpFmqWUdKu0noW0Nf97F
    /Xc/dYLxz/iUiawrGnotRo+k2SlvyIkoJnk4ZIOwywHQiL+nbqvSWYDnLZKIwUQW
    G2IqsMfjariLt+0sC56tNGhZwTxcDY7YO1fwNyZ8OgVzZKqp0yeLSvdvBnOeM7Lu
    fcoSDVOaGTGkF6D+pgjM4pCKXHqhEHeDez4KpL8bv7dos6semBU8eBdXP78SP7HA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HORWeL+s x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HORWeL+s x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966563AbeCHFIr (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:08:47 -0500
Received: from mail-bn3nam01on0104.outbound.protection.outlook.com ([104.47.33.104]:62624
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966479AbeCHFIo (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:08:44 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Alexey Kardashevskiy <aik@ozlabs.ru>,
        Paul Mackerras <paulus@ozlabs.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 20/53] KVM: PPC: Book3S PR: Exit KVM on
 failed mapping
Thread-Topic: [PATCH AUTOSEL for 3.18 20/53] KVM: PPC: Book3S PR: Exit KVM on
 failed mapping
Thread-Index: AQHTtprEHX97RQmlL0O/dURhCT0c7A==
Date: Thu, 8 Mar 2018 05:03:15 +0000
Message-ID: <20180308050230.8876-20-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0871;20:fJwvMPK+6YMRqOiN5PsezV7bSCdq1HoK/mfeQ3GXtYJGrmsGFa9EhwPSvhwZB87uhweHCAVb+GK6VFPL7ehikv/nIcSs5lVuRSQVJZkgw3JE517WLpx6sSXS9VAq6EqPNRvWQTkYlfrTrD8T+1yUKMB2QN6+bkQh/SSLpzBnhiM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0b2e5f3e-0a6c-4682-b440-08d584b2a872
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0871;
x-ms-traffictypediagnostic: DM5PR2101MB0871:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB087119D149368855B7BD1F75FBDF0@DM5PR2101MB0871.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0871;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0871;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(346002)(376002)(366004)(396003)(189003)(199004)(7736002)(14454004)(3660700001)(68736007)(4477795004)(305945005)(2900100001)(10090500001)(66066001)(97736004)(81166006)(105586002)(10290500003)(8676002)(72206003)(8936002)(102836004)(59450400001)(86612001)(53936002)(6512007)(6506007)(110136005)(107886003)(478600001)(54906003)(106356001)(81156014)(25786009)(4326008)(26005)(316002)(186003)(5250100002)(2501003)(575784001)(2906002)(86362001)(6666003)(3280700002)(22452003)(36756003)(2950100002)(1076002)(6486002)(76176011)(5660300001)(99286004)(6436002)(3846002)(6116002)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0871;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: mSQAB0LIFKHgqPMJTSWK2O4KzowX15nEduoewJsbDtVFdROg2sF/WoHHNAFsgT7i0ARos1Qf8ICaSLNFxRha8vt/+AujZH+1BSlC5tJQvkO7+JXNbbCrKkqR3WaPD5RWS/7+/Cr8o+Z499XD0rtHALrNE38P443Jf5SfLzPvwLxD9LtFCgFVUinfrApURWjs4vPwT6DfaebTwlzycYEdhwMCNKVV5mWh48GK6HVi2C9n59oRSrrhX658oJoIxOY1zPDzDqX2cLfPJnHQDVnljKdMJ12Jd53rYtGg+JUlxkGDVRuMnqoTI7zkiy4Hgdc1n8s1HlG7l6VsZXOGAt5TAg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2e5f3e-0a6c-4682-b440-08d584b2a872
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:15.5881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0871
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
index b982d925c710..c74c9c4134b5 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
@@ -176,12 +176,15 @@ int kvmppc_mmu_map_page(struct kvm_vcpu *vcpu, struct=
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
index cf2eb16846d1..db549f2ae98f 100644
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
