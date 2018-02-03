Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1486374-1517681026-2-16928236427983658825
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517681025; b=tYht6zFS93g/oTfd1YGpWvEE4LUEEiWrYMgx27wTSowtEZ1
    POrWp3Kv/qNJI0EgjFpbB/eRATwh8ztvvAFOA5skhJcSzLWz8XNsdSJM8M71tNfj
    pdQnM0w8egcnFTO5NmZ+08CLYwMzsXWOHPWbLZr9vJe22ec3H6cHMV7IV/DcA1d4
    A/mMR5TjrZzo/gdxJa3cqJU7oIrytzOXEmbo0dLNG25Tr8bUJBs9WBiQYJOwde1P
    uBWHdiFSKbnHTmY4YPciVHrKoJq16g3ajxtQLm/lkuKdVNZUBQ2kSRb1PUZVxB+A
    OQS+ZP2pPX0+4DlhvweB3/Lhs3a1RKtxEUlSmUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681025; bh=0n+zup
    j31DccZlFUzpJxpaAGoUranR3qWJbgKC4qStQ=; b=Uz+QE+50Kha6oUh3KP34Gc
    Xwmre61grm/lpsocePzVEHO8ycMC9niefLqwtJmZojnXMf6B2UGd50JK9WeG5YQf
    zfaXuGm8U/YMOXok4UOkgRruyFKg5NsHXSAhNexKGR0jnUo0ELUOO6xy/vMnYz8B
    y4/XHAsfmYcGEWzoT9MQorpvZ6bnsO6bG9ICcCkCkHSee9O28Lx2akRTEE/3Igz8
    zmpMbLzkNfsuO+uAyk66272lGe42BgxQdGAQk2p5VlZcsRkQOs478QcijCW4l5W0
    f1ks5Q4jnxbfqXfL612Iyi2RYSiVx9kGCbSpB7uA0Lm+p78GpS3L+sH09bDtZhyw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FliIBC98 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FliIBC98 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753245AbeBCSDd (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:03:33 -0500
Received: from mail-cys01nam02on0123.outbound.protection.outlook.com ([104.47.37.123]:2624
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753002AbeBCSB6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:01:58 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: John Stultz <john.stultz@linaro.org>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Archit Taneja <architt@codeaurora.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Shmidt <dimitrysh@google.com>,
        Todd Kjos <tkjos@google.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 031/110] staging: ion: Fix ion_cma_heap
 allocations
Thread-Topic: [PATCH AUTOSEL for 4.14 031/110] staging: ion: Fix ion_cma_heap
 allocations
Thread-Index: AQHTnRjovWuE6CKAiEOQ376bBqZwUg==
Date: Sat, 3 Feb 2018 18:00:43 +0000
Message-ID: <20180203180015.29073-31-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1090;7:PcBSh/ULxOmZMAuapPcRHsIJNbY/6sofUboST+VoHd0bTgnpmajUUaE5XoCABKyE9iidD7wyUN1ugP+FwVSV5Klp42xgZPMi+u1+dltCouM+E4Sa2ECEYIU7wab+S6cDVZQktrmWHRxCV0JOoQyrhv+GvkWwE8IE2hR9Mv3RGnNqC176TKKrwbFsIyF6g4ZC0z05bS7BiRMI0UQIF/10gP2fntZHAcjZWrQGhIjrBy9PssEeHYJd68uH4VovkXtY
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e7de90b7-d66a-4b5d-79bd-08d56b301e60
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1090;
x-ms-traffictypediagnostic: BL0PR2101MB1090:
x-microsoft-antispam-prvs: <BL0PR2101MB1090842296F255D5CAAF8553FBF80@BL0PR2101MB1090.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1090;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1090;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(39380400002)(39860400002)(346002)(199004)(189003)(2900100001)(5660300001)(316002)(25786009)(4326008)(14454004)(2950100002)(478600001)(107886003)(72206003)(6666003)(22452003)(10290500003)(186003)(3660700001)(86612001)(76176011)(86362001)(53936002)(3280700002)(106356001)(6436002)(6486002)(59450400001)(81166006)(81156014)(2501003)(6506007)(97736004)(26005)(7736002)(6512007)(6346003)(102836004)(105586002)(68736007)(8936002)(5250100002)(305945005)(36756003)(1076002)(6116002)(3846002)(8676002)(110136005)(7416002)(66066001)(54906003)(2906002)(10090500001)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1090;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: EcW3cnj2cFuu0Bq6riNaKuDZGYV2eiVOtnd0wivwjAgS5VbKyZD9j7VnA1/m9cdK4c3dq2CL//dRCmcOqzQinA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7de90b7-d66a-4b5d-79bd-08d56b301e60
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:43.6128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1090
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: John Stultz <john.stultz@linaro.org>

[ Upstream commit f292b9b28097d8fe870336108e91bd95a14294bf ]

In trying to add support for drm_hwcomposer to HiKey,
I've needed to utilize the ION CMA heap, and I've noticed
problems with allocations on newer kernels failing.

It seems back with 204f672255c2 ("ion: Use CMA APIs directly"),
the ion_cma_heap code was modified to use the CMA API, but
kept the arguments as buffer lengths rather then number of pages.

This results in errors as we don't have enough pages in CMA to
satisfy the exaggerated requests.

This patch converts the ion_cma_heap CMA API usage to properly
request pages.

It also fixes a minor issue in the allocation where in the error
path, the cma_release is called with the buffer->size value which
hasn't yet been set.

Cc: Laura Abbott <labbott@redhat.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Archit Taneja <architt@codeaurora.org>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Dmitry Shmidt <dimitrysh@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Amit Pundir <amit.pundir@linaro.org>
Fixes: 204f672255c2 ("staging: android: ion: Use CMA APIs directly")
Acked-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/staging/android/ion/Kconfig        |  2 +-
 drivers/staging/android/ion/ion_cma_heap.c | 15 +++++++++++----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/android/ion/Kconfig b/drivers/staging/android/=
ion/Kconfig
index a517b2d29f1b..8f6494158d3d 100644
--- a/drivers/staging/android/ion/Kconfig
+++ b/drivers/staging/android/ion/Kconfig
@@ -37,7 +37,7 @@ config ION_CHUNK_HEAP
=20
 config ION_CMA_HEAP
 	bool "Ion CMA heap support"
-	depends on ION && CMA
+	depends on ION && DMA_CMA
 	help
 	  Choose this option to enable CMA heaps with Ion. This heap is backed
 	  by the Contiguous Memory Allocator (CMA). If your system has these
diff --git a/drivers/staging/android/ion/ion_cma_heap.c b/drivers/staging/a=
ndroid/ion/ion_cma_heap.c
index dd5545d9990a..86196ffd2faf 100644
--- a/drivers/staging/android/ion/ion_cma_heap.c
+++ b/drivers/staging/android/ion/ion_cma_heap.c
@@ -39,9 +39,15 @@ static int ion_cma_allocate(struct ion_heap *heap, struc=
t ion_buffer *buffer,
 	struct ion_cma_heap *cma_heap =3D to_cma_heap(heap);
 	struct sg_table *table;
 	struct page *pages;
+	unsigned long size =3D PAGE_ALIGN(len);
+	unsigned long nr_pages =3D size >> PAGE_SHIFT;
+	unsigned long align =3D get_order(size);
 	int ret;
=20
-	pages =3D cma_alloc(cma_heap->cma, len, 0, GFP_KERNEL);
+	if (align > CONFIG_CMA_ALIGNMENT)
+		align =3D CONFIG_CMA_ALIGNMENT;
+
+	pages =3D cma_alloc(cma_heap->cma, nr_pages, align, GFP_KERNEL);
 	if (!pages)
 		return -ENOMEM;
=20
@@ -53,7 +59,7 @@ static int ion_cma_allocate(struct ion_heap *heap, struct=
 ion_buffer *buffer,
 	if (ret)
 		goto free_mem;
=20
-	sg_set_page(table->sgl, pages, len, 0);
+	sg_set_page(table->sgl, pages, size, 0);
=20
 	buffer->priv_virt =3D pages;
 	buffer->sg_table =3D table;
@@ -62,7 +68,7 @@ static int ion_cma_allocate(struct ion_heap *heap, struct=
 ion_buffer *buffer,
 free_mem:
 	kfree(table);
 err:
-	cma_release(cma_heap->cma, pages, buffer->size);
+	cma_release(cma_heap->cma, pages, nr_pages);
 	return -ENOMEM;
 }
=20
@@ -70,9 +76,10 @@ static void ion_cma_free(struct ion_buffer *buffer)
 {
 	struct ion_cma_heap *cma_heap =3D to_cma_heap(buffer->heap);
 	struct page *pages =3D buffer->priv_virt;
+	unsigned long nr_pages =3D PAGE_ALIGN(buffer->size) >> PAGE_SHIFT;
=20
 	/* release memory */
-	cma_release(cma_heap->cma, pages, buffer->size);
+	cma_release(cma_heap->cma, pages, nr_pages);
 	/* release sg table */
 	sg_free_table(buffer->sg_table);
 	kfree(buffer->sg_table);
--=20
2.11.0
