Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5173C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 23:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D0F20647
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 23:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74D0F20647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbeH0DfL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 23:35:11 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:45196 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbeH0DfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 23:35:11 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id w7QNoYm1007133
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 27 Aug 2018 08:50:34 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id w7QNoYnx003127;
        Mon, 27 Aug 2018 08:50:34 +0900
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id w7QNnDe3017152;
        Mon, 27 Aug 2018 08:50:34 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.149] [10.38.151.149]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-3052741; Mon, 27 Aug 2018 08:49:49 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC21GP.gisp.nec.co.jp ([10.38.151.149]) with mapi id 14.03.0319.002; Mon,
 27 Aug 2018 08:49:48 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2] tools/vm/slabinfo.c: fix sign-compare warning
Thread-Topic: [PATCH v2] tools/vm/slabinfo.c: fix sign-compare warning
Thread-Index: AQHUPZd49tQkGd6j1UO2OK3DHhN73Q==
Date:   Sun, 26 Aug 2018 23:49:47 +0000
Message-ID: <20180826234947.GA9787@hori1.linux.bs1.fc.nec.co.jp>
References: <1535103134-20239-1-git-send-email-n-horiguchi@ah.jp.nec.com>
 <20180826022114.GA23206@bombadil.infradead.org>
In-Reply-To: <20180826022114.GA23206@bombadil.infradead.org>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.80]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <4AAD8CA9736C6A4BBEB17E32908E4524@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 25, 2018 at 07:21:14PM -0700, Matthew Wilcox wrote:
> On Fri, Aug 24, 2018 at 06:32:14PM +0900, Naoya Horiguchi wrote:
> > -	int hwcache_align, object_size, objs_per_slab;
> > -	int sanity_checks, slab_size, store_user, trace;
> > +	int hwcache_align, objs_per_slab;
> > +	int sanity_checks, store_user, trace;
> >  	int order, poison, reclaim_account, red_zone;
> > +	unsigned int object_size, slab_size;
> 
> Surely hwcache_align and objs_per_slab can't be negative either?
> Nor the other three.  So maybe convert all seven of these variables to
> unsigned int?
> 

Fair enough, I update the patch.
Thanks for the comment.

- Naoya

---
From 25e19ce711cdb4aa5c4f1a04784017af48616e5f Mon Sep 17 00:00:00 2001
From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Date: Fri, 24 Aug 2018 18:22:40 +0900
Subject: [PATCH v2] tools/vm/slabinfo.c: fix sign-compare warning

Currently we get the following compiler warning:

    slabinfo.c:854:22: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
       if (s->object_size < min_objsize)
                          ^

due to the mismatch of signed/unsigned comparison. ->object_size and
->slab_size are never expected to be negative, so let's define them
as unsigned int.

Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
---
 tools/vm/slabinfo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/vm/slabinfo.c b/tools/vm/slabinfo.c
index f82c2eaa859d..334b16db0ebb 100644
--- a/tools/vm/slabinfo.c
+++ b/tools/vm/slabinfo.c
@@ -30,8 +30,8 @@ struct slabinfo {
 	int alias;
 	int refs;
 	int aliases, align, cache_dma, cpu_slabs, destroy_by_rcu;
-	int hwcache_align, object_size, objs_per_slab;
-	int sanity_checks, slab_size, store_user, trace;
+	unsigned int hwcache_align, object_size, objs_per_slab;
+	unsigned int sanity_checks, slab_size, store_user, trace;
 	int order, poison, reclaim_account, red_zone;
 	unsigned long partial, objects, slabs, objects_partial, objects_total;
 	unsigned long alloc_fastpath, alloc_slowpath;
-- 
2.7.4



