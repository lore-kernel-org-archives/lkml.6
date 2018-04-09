Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523243070-2-8355101778917647034
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enrosv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523243069; b=h7RjsCXnXl86JHcW+7g6xqsmXCcLmfgOrK8cf8XIZvj933mmPf
    Z395YTcehjLqyzDaR/6kaxvkEMaGI8Xe84ErPA58X+hyaItFplSFsXRYq+CfXsFN
    p1pK/pokkk3P0WXABtikcsFpRUGsiYL08log6PziRoriuB2uWLOWFC6nkQBHqCIe
    wOjbwj05KnBmjbfZ7OcKtK0Hd4eMZuNtG8kpA7aK2QqiDYz/QexvJ2hkKj6d5VKE
    toVAwppgz6p2Bjc25VG4bLNVbnvvxcfhB9Xba1oqc6cDJftrYcOAXX1nGEIHIbeB
    YoIPlMtHeWrpyapFdxFEbxLGfG9V2G+aW0mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523243069; bh=KEoXlPuciA
    KIYgJbBn6KxPefOkh6vDudHfTsDkyFph0=; b=TyDHIn8K8RBMYzMqg50G7Uj1a9
    IV+vQZRs7Jfn8pUrcPjdmsu9txpKzXX5vVNzt06wPe1lFXL7Q+X51zx/toAcANaV
    DtPh9jKnynRq3ygr1KyTDjn/3WNRI/t1p8lsTb6dX5b8U3hC8IEqvVA4rjK6U5rO
    3BYfOVz3KbKb4puW779aPPCoAGr7P2eRoe9GlOaPEtC1hQ6r6KOD67JOl4ebNlxk
    2G504biFCf8pJ+CzuSbbvzyIG9Y4I0mJEjOS4SihIZ1iynH3vvnHIfgU+0H7Nsa9
    4pyTryPyp33NL1Ieb0ZZZdIMLCA08yocjduY+R7pHAqytV9hRCrWw3M4h5QA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jyO57HnM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jyO57HnM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBV9V/HzYbuuSueQ6adzlct+EeX+vNVmIXwIZW7j60R0F/jLM1cciVk7llwPagwvGYOA+AAYFcryoRpkgF6uNd2x+zGaDQcag2kXzfP/VdGC5Ns+6zbz
    nl8Vay+WuqsA0C21w4Jk/FLUodQintIoK2reD95Thk/joZuL5nHMBeVTegwlwHrbe0HB2o5n8+wTGPn24o6iz8xMFjPuOz+kob1trZPC9qRsk0ArocpDJL4x
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8
    a=QyXUC8HyAAAA:8 a=J1Y8HTJGAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8
    a=BIHwprYNq4FW_9NUsLoA:9 a=KPh4hgkfMoj2ZbMR:21 a=USB9SORa4Z-Ay8cQ:21
    a=wPNLvfGTeEIA:10 a=HkZW87K1Qel5hWWM3VKY:22 a=AjGcO6oz07-iQ99wixmX:22
    a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755089AbeDIAYw (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:24:52 -0400
Received: from mail-sn1nam02on0128.outbound.protection.outlook.com ([104.47.36.128]:23328
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932094AbeDIAYr (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:24:47 -0400
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
Subject: [PATCH AUTOSEL for 4.14 102/161] sparc64: update pmdp_invalidate() to
 return old pmd value
Thread-Topic: [PATCH AUTOSEL for 4.14 102/161] sparc64: update
 pmdp_invalidate() to return old pmd value
Thread-Index: AQHTz5irXVKrMj7J002I4h8KOD1WBQ==
Date: Mon, 9 Apr 2018 00:21:15 +0000
Message-ID: <20180409001936.162706-102-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0983;7:qvVLQEM3KUc/5VFSWpSLh1nntZ5wgAApd3eTzlHpH0nw9tYKZxB9pc1CdMPAsDErj8fdsF4c6/gD50ZtPYrl9ZAXaIH/ZJuJt+czMHQ97c1UKepKPWzD+aoFDbBzS/EAbHWSajBTUgyGHV6J1e3arjRFgOp5N20+dp/xfOXNOG/6aWhXMQil5+CiZZboZLD5b19fDoQ7h+r/c0W+20nC+0PUkWdA5aa/oGgWvUc0KoEtXh3ADHnV4LSAX1RhrE8v;20:CUSNeGgWADKIKfMhEHV7J8wvD0fX6ScmgALOOhHvtVUSgAML3fgLfwFDAFPZ8PY7zbyVcxV9E+zTZ731Ab9kKEazTZkezvbwH/7asam1okhXkNFO5YoCUEGmtc/nevkKoGGrB+xcerY5gkHg4gxnOFvTsRyZhiiLeZubrT+w0jE=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9a04d318-e96b-49ca-7b15-08d59db04a80
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0983;
x-ms-traffictypediagnostic: DM5PR2101MB0983:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0983C23A66C21A6CCF195A42FBBF0@DM5PR2101MB0983.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301)(146099531331640)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0983;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0983;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(376002)(39380400002)(366004)(199004)(189003)(478600001)(59450400001)(72206003)(10290500003)(3846002)(102836004)(6506007)(6116002)(25786009)(6436002)(66066001)(99286004)(54906003)(86612001)(6666003)(105586002)(53936002)(76176011)(316002)(486006)(7736002)(22452003)(3660700001)(86362001)(97736004)(106356001)(575784001)(8936002)(110136005)(5660300001)(11346002)(446003)(81166006)(81156014)(2906002)(8676002)(2900100001)(10710500007)(1076002)(476003)(2616005)(7416002)(10090500001)(6486002)(15650500001)(107886003)(2420400007)(36756003)(4326008)(966005)(2501003)(68736007)(186003)(305945005)(3280700002)(5250100002)(6306002)(6512007)(26005)(7110500001)(14454004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0983;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 3KellAvaCuhCf8RnpQdBLTC5gL3uhg5a78EZ2/O41jow/D+WFHXEkpydH0eMWM4fE7pPs8P9az+IdO7KxM/82uur6+fvIEROeHc6A9P+YKtgde7Rtxg83SA4DSZxzDbEGyzBIaKOgWpvzYjiXpjLmMVu7cY4WIUvvlAcwo+DZ5NejE3Chqx+tGNFf0nKrAsvytjAkii2zpr5eacaO5VnUSmmAfL7pvvi3BVt/QbF/CZ4Sii9UtCJWAC/sVgWzKiA8rpagso6YNM6GKrTVA/yVkif0gVV+xfXpuDMfT8nItT4vPKC0b4ef3vXoiXH9pDQzZ+ZpB8AXQzZxz5utm7zYoXTNHT3/gI7bvktqHvjiCO1kjEVYZrURLvx60vP/vJNj4UHeZrJFd63tX3YiE0iGbkgHB3aSCibP0o6wFwawYk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a04d318-e96b-49ca-7b15-08d59db04a80
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:15.2688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
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
index fd9d9bac7cfa..79c3bdaaa0b4 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -980,7 +980,7 @@ void update_mmu_cache_pmd(struct vm_area_struct *vma, u=
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
index 4ae86bc0d35c..847ddffbf38a 100644
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
