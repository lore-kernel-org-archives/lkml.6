Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520489911-2-4234240083163446516
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
    t=1520489910; b=tuX495rtJou3jFy3seAxzGJQ6AVkNhjkDGC+clFNM1FPYtm
    I39RDs6NnyhwVbLr4k9n2EeTx4wr+6WOOh98G0mSzsj37k9F4FFr1JCnSiI1oxGm
    tls0dAC/uNRCDOsq2Hv/rsE4BtN4Nq2KU5XojDeQCYUzeaCwoTHX6hbkN9oLAAHb
    xy+iAsmMSzigweN4pA2J7OO4C9VO6RGnXfnD01wd7GhsNpLtp65q+UkCad3ms5wl
    054sJHKGsas9hWr6nZn8pDhwkfc2B8xNWQ76m3SXZ/FKPX0y5vfngGCsvsEqbzEr
    NIMHzr2+qw4eTkHDil5WcWzmUgvrubS75aY6D8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489910; bh=nB8Q6K
    cl7AYWwwlks+tLVbi3xtZezPO/E83f/lHsLcw=; b=FXLSibxv9okXY82ZMe5yQ0
    fX1h8F+8/3aAjgbKNwGiu643GHm6jaZn4latuxrcgDpXxRVHJz2eield3gplOoMd
    dizYQ6LaQ9yepczYB+A7KBAZVFGYKRCQk34Nhn9TbwW7rFxO9yAuB0lcqJ8oxvwi
    uC8SnqDHzR1lDU29rIVR91m2t9qLbqxfjBL+TJ30mxtfSy93HqkKoN0rSdbsdond
    upqjhxG4wkdcbxOrwor9BKOafYV0uX83RCv68Gt6vCSnGCZYz8wd+OqOcAHCtTXj
    H2PV82jj5cs8kmS57NdfbWYj0kb+jz3N2MURGWjtnY1IBxvw6j9H187LW200mrEw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gLerC8mv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gLerC8mv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965628AbeCHFBD (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:01:03 -0500
Received: from mail-co1nam03on0105.outbound.protection.outlook.com ([104.47.40.105]:45079
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965197AbeCHFAz (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:55 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Alexey Kardashevskiy <aik@ozlabs.ru>,
        Paul Mackerras <paulus@ozlabs.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 050/190] KVM: PPC: Book3S PR: Exit KVM on
 failed mapping
Thread-Topic: [PATCH AUTOSEL for 4.9 050/190] KVM: PPC: Book3S PR: Exit KVM on
 failed mapping
Thread-Index: AQHTtpozjR2c9weYrkGLabzNU8moCA==
Date: Thu, 8 Mar 2018 04:59:13 +0000
Message-ID: <20180308045810.8041-50-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;20:kbCbq9DTfnhb9yJGUina+4JhI9AC3G8XrqtHAQZXlnhmJmmDkpwL3Yt/0g6kwccj14tj2otYGvxryiLpYhf34aI4Rhz3HChzQ5yF+xTlHoLiUMsbbRapwS8E0/D7CTha8E1vi7rR2A+uP3Uvp5rcbflZyrssFDDGwmFgZIjJ7Kk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f1b37c5e-be28-4d50-b0d4-08d584b18ca5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB110941CE050DE3C0B83383E6FBDF0@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39380400002)(39860400002)(366004)(199004)(189003)(3660700001)(5250100002)(102836004)(6436002)(2501003)(81166006)(8936002)(6486002)(81156014)(53936002)(6512007)(8676002)(6506007)(5660300001)(86612001)(76176011)(10290500003)(4477795004)(86362001)(575784001)(4326008)(59450400001)(105586002)(25786009)(10090500001)(26005)(2900100001)(316002)(106356001)(97736004)(54906003)(305945005)(7736002)(186003)(36756003)(22452003)(110136005)(14454004)(72206003)(6116002)(3846002)(68736007)(3280700002)(66066001)(2906002)(2950100002)(478600001)(6666003)(99286004)(1076002)(107886003)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: R51fhXKKntcv6njQckbYJW8Z4pXG0tOG/hyj5+6GVOCp8VpuiUY0jO6PukMY9n53uDdhNuRp2hgWt5BVbj1Xl1TFog7+FjuL7sui0Fe3wlEgJzPrgrf/uyu9FlKziTfrZ0SIu1A99++ewk18oOxc4IYliZNlPHGe1UoKDTCGoHSaiTZZDEnfhvDaS+vxJ2qspHoeHVJfCuTJ2vApMSfl4AfRSorqfIGdYC3eoYTzYAkIsV/GsNQ7rt5M4IsbJHcIpWiGmd1igUnmscFL/3DmU0LPBiogZPfIYeaIvTdTsyNdY41ChDhO+lfT6WU0qZ5+GPM2Eq1FPEo4nWoBlZ7dQQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b37c5e-be28-4d50-b0d4-08d584b18ca5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:13.7807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
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
index a587e8f4fd26..4b4e927c4822 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
@@ -177,12 +177,15 @@ int kvmppc_mmu_map_page(struct kvm_vcpu *vcpu, struct=
 kvmppc_pte *orig_pte,
 	ret =3D mmu_hash_ops.hpte_insert(hpteg, vpn, hpaddr, rflags, vflags,
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
index 826c541a12af..e0d88d0890aa 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -627,7 +627,11 @@ int kvmppc_handle_pagefault(struct kvm_run *run, struc=
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
