Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523238563-2-9647050287129399795
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523238563; b=tQSa3jpc1ldZdGfBCK62uTGKWfh5ZVDnhMfaONFTTnMRPvJO3M
    2bD7hOd4n0+cA3jjZ7gXokPedAMO06A1UaXU5sJ9kc0IgrhDiuUxS6/DKo/w7Ski
    Q7kQynzPj7RAtlzBiH9kg+YuyY4fSRLpHa4GzkC57aJakFP49WIIWMbKZcPeRHs5
    JsqNZYww+X6pS8wQYwJot3OC/qTYOoi41LUPciWZU2/WvzeZ/lf0l+W/ppC4ZGn+
    0hrOakT/+CS/tp5miZXi9ZAt7H5HAJplaPV6LNJCHR7rP+09Zlrm/IIdS0sQUhuc
    kU4FlKmWzIXZSjp5HDVLOohgmD6C9KFJQ/bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238563; bh=j+OYy6cz8Z
    PCfIV27YFyi9teIQz9U1SCCcmWWigUUqk=; b=jLtwkCzon+tJ9OL+VqTX2b7Qds
    HaovozfccXc3kQ7namlczh/cyOiO41UMTVC576eXOwUy2Ql/ztgwtI/aloQd9p2L
    N4FVcIpkHxQembnxSmiBxrtI4j86wiTf0ikgFInCgJIqIQRF/qlEFHAP8CkpDy8Y
    dOwQSzXucIbedvLhgKeuSImLu5JR7+secCsZgTgJwjx6/A+RqHojHtIN5Q3EpFUM
    gqALGC2bD3jxfW8t45PBfktb8icNu4mrQz0d7GqlyLKdavtXO0LwN5vNOfWAmQzw
    d8Qb0Wh7/MgxCOdbebE9Td5jf7pW40lgMRRWREYeAROFgEnW0JVWB8YMYSDg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YQmwUOFr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YQmwUOFr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOzTVSSR/fM2UaXZIHGxRjKEIgBiKSHbUhbT0m4hKRuirye5InClTouIil46BDIzbtytqAEEJor25lkvJaTouu07birbSqjT/K9Tifku6EUg3+gNhev1
    jywk7lgSr+h5WGQ7ChmZsPFmCNWhzNscjhK7s/BXcCsJGllsjOae9Tk7/1Lr9MIrwePZmGrVJUYwfhbr6ZgJq7qp+UDSvzjrF/9WIE/NXKOd70opoUZzpaWV
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8
    a=QyXUC8HyAAAA:8 a=J1Y8HTJGAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8
    a=BIHwprYNq4FW_9NUsLoA:9 a=KPh4hgkfMoj2ZbMR:21 a=5_B14RxEFbtU-cMx:21
    a=wPNLvfGTeEIA:10 a=HkZW87K1Qel5hWWM3VKY:22 a=AjGcO6oz07-iQ99wixmX:22
    a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757282AbeDIBtH (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:49:07 -0400
Received: from mail-by2nam01on0130.outbound.protection.outlook.com ([104.47.34.130]:18358
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932389AbeDIAd6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:33:58 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Nitin Gupta <nitin.m.gupta@oracle.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        David Miller <davem@davemloft.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 260/293] sparc64: update pmdp_invalidate() to
 return old pmd value
Thread-Topic: [PATCH AUTOSEL for 4.9 260/293] sparc64: update
 pmdp_invalidate() to return old pmd value
Thread-Index: AQHTz5lgvKIGG/kwxECdjbEdJOL0WQ==
Date: Mon, 9 Apr 2018 00:26:17 +0000
Message-ID: <20180409002239.163177-260-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:8gitSj5KkjNTWuByUdYRPbPPsUkW1D/eE7eKgBwAZkAFwCsTO85wAMzfJzDJCwaKP/xBGcs70hrEUVNtU51pbiD9xddXnW5rotAVDrO/E9Wilnp1UtXKRGZuzdnDjToNonQThNqsBmTyyUhC3HWCkAq1kqpbl958t+5PipZSBX7iJs890pTjSFSOCqWsHpZUIlhjnArHvc7jqT1zS0Kqty7AaS8lQxSf5qu8oXazfYNsIfGSipd0rRvg3zrt8Zou;20:W0dZ64QBiLUyZFjqXc7XAhIx8TJjz1wk9n5SgE2RkeObSE6b1lfFtpnq6FTEjsxO2nvYqSsCkLTQ4LQ6G1rlWOYwU25iv4f0QycsY+yjtnn7cXgySXwf98/O0lUpLyHWxdonz9aCm/qyeYFHQV2MpIIFRNSzV7guY2bAwOcInn8=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 111bc324-ae70-4af0-b2d2-08d59db19373
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB080643273BDDEE3E52BF963AFBBF0@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301)(146099531331640)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(366004)(39380400002)(199004)(189003)(2906002)(25786009)(2501003)(10290500003)(476003)(10710500007)(11346002)(446003)(97736004)(5250100002)(68736007)(2616005)(102836004)(7110500001)(6506007)(59450400001)(3846002)(3660700001)(486006)(3280700002)(305945005)(6666003)(99286004)(5660300001)(76176011)(7416002)(1076002)(186003)(26005)(7736002)(6116002)(81156014)(81166006)(86612001)(4326008)(105586002)(2420400007)(15650500001)(10090500001)(2900100001)(54906003)(22452003)(316002)(36756003)(110136005)(107886003)(8676002)(6436002)(478600001)(53936002)(66066001)(6486002)(6512007)(6306002)(575784001)(86362001)(966005)(14454004)(72206003)(8936002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 7lfEv0peTkHho9VQIabXOesl3sUAAcffjrVvxbKbSrlQQMfDEUWRPL0ZWoZmq9bs3FQmqCUF9TykOjy88QcA3cLWBttRRmyw3s5mTA6aTMRW44czA6oXs1fAMUcdc3C4IOtFDuBXBww1hYSEgccRBK6K1PU210+eK/Njso+ViYWDoIKTJcedoIdIZcb1m8RsZaEq5vust9r9C8qFUlumS4gp0rwIHuwXbnqwJW0XLoqGIB4xqJA/L5t/tgqcyMDUvOfsAQBOOzo5KAWCjWh2O01jQncD6v8oQeTpIsko7vkTSOY1CTuk/OTIcAhGD/DrmY857QLFDvrbttsEoH2Vhw6teN+sSc6tsg+6i9s/UNBOSjvwaxuF9YKVxjzDePJceagPfHk0X3j4bvsN915FMlX9tQyBGSxMFLiPRcxRRos=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 111bc324-ae70-4af0-b2d2-08d59db19373
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:26:17.5507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Nitin Gupta <nitin.m.gupta@oracle.com>

[ Upstream commit a8e654f01cb725d0bfd741ebca1bf4c9337969cc ]

It's required to avoid losing dirty and accessed bits.

[akpm@linux-foundation.org: add a `do' to the do-while loop]
Link: http://lkml.kernel.org/r/20171213105756.69879-9-kirill.shutemov@linux=
.intel.com
Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: David Miller <davem@davemloft.net>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/sparc/include/asm/pgtable_64.h |  2 +-
 arch/sparc/mm/tlb.c                 | 23 ++++++++++++++++++-----
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/p=
gtable_64.h
index b6802b978140..81ad06a1672f 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -952,7 +952,7 @@ void update_mmu_cache_pmd(struct vm_area_struct *vma, u=
nsigned long addr,
 			  pmd_t *pmd);
=20
 #define __HAVE_ARCH_PMDP_INVALIDATE
-extern void pmdp_invalidate(struct vm_area_struct *vma, unsigned long addr=
ess,
+extern pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long add=
ress,
 			    pmd_t *pmdp);
=20
 #define __HAVE_ARCH_PGTABLE_DEPOSIT
diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index c56a195c9071..b2722ed31053 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -219,17 +219,28 @@ void set_pmd_at(struct mm_struct *mm, unsigned long a=
ddr,
 	}
 }
=20
+static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
+		unsigned long address, pmd_t *pmdp, pmd_t pmd)
+{
+	pmd_t old;
+
+	do {
+		old =3D *pmdp;
+	} while (cmpxchg64(&pmdp->pmd, old.pmd, pmd.pmd) !=3D old.pmd);
+
+	return old;
+}
+
 /*
  * This routine is only called when splitting a THP
  */
-void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
+pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 		     pmd_t *pmdp)
 {
-	pmd_t entry =3D *pmdp;
-
-	pmd_val(entry) &=3D ~_PAGE_VALID;
+	pmd_t old, entry;
=20
-	set_pmd_at(vma->vm_mm, address, pmdp, entry);
+	entry =3D __pmd(pmd_val(*pmdp) & ~_PAGE_VALID);
+	old =3D pmdp_establish(vma, address, pmdp, entry);
 	flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
=20
 	/*
@@ -240,6 +251,8 @@ void pmdp_invalidate(struct vm_area_struct *vma, unsign=
ed long address,
 	if ((pmd_val(entry) & _PAGE_PMD_HUGE) &&
 	    !is_huge_zero_page(pmd_page(entry)))
 		(vma->vm_mm)->context.thp_pte_count--;
+
+	return old;
 }
=20
 void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
--=20
2.15.1
