Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B0DC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ACF1214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ScyRQKEw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ACF1214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbeJIW5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:57:09 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56450 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbeJIW5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:57:09 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181009153937euoutp02cd7dba4efbcb4957ee76863244428a55~b_ulJLl1f0533705337euoutp02m
        for <linux-kernel@vger.kernel.org>; Tue,  9 Oct 2018 15:39:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181009153937euoutp02cd7dba4efbcb4957ee76863244428a55~b_ulJLl1f0533705337euoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539099577;
        bh=nvGZS2W9IbxKF7D6gw/14I5psQW8+eBORz1kb648k7A=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ScyRQKEwPJQRK6fiUcHzIn/Nyp/d7XDSqpLwu6MQ3FjGXZvaPfsFrTBoMlaMYgPuv
         yDQCztzG3FLC6NiiQ3e3SH2VVIzCWi7y+DIxi2QPpLkW8zV7axx6Sdp+lsd4xu9yrz
         ArWr/t9s/2E19HCdA92k4gPT0Ga57z1aKpu9/nf0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181009153936eucas1p10b0508c4141bde1848e2d8e7f3237ed9~b_ukTtGZF2905929059eucas1p1-;
        Tue,  9 Oct 2018 15:39:36 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id F3.61.04806.8BBCCBB5; Tue,  9
        Oct 2018 16:39:36 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181009153935eucas1p2dec146575ed5fefd4a0b2b6cb9bac056~b_ujkjRd31303013030eucas1p2C;
        Tue,  9 Oct 2018 15:39:35 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181009153935eusmtrp2f913a607ecdf7cc96b22c16e26d2847a~b_ujTjC0p0203702037eusmtrp2h;
        Tue,  9 Oct 2018 15:39:35 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-9d-5bbccbb88351
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 95.A4.04284.7BBCCBB5; Tue,  9
        Oct 2018 16:39:35 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181009153935eusmtip151d08354d1d89f3a0eda74d47b9e9189~b_ui6LRbs1755517555eusmtip1P;
        Tue,  9 Oct 2018 15:39:35 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     l.luba@partner.samsung.com, b.zolnierkie@samsung.com,
        peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        corbet@lwn.net
Subject: [PATCH] Doc: lockdep: add information about performance impact
Date:   Tue,  9 Oct 2018 17:39:27 +0200
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsWy7djPc7o7Tu+JNpjzTNRi44z1rBZPDrQz
        WtxqkLHY9Pgaq8XlXXPYLC4dWMBkcbz3AJPFy48nWBw4PNbMW8PosXmFlsfmJfUei/sms3oc
        fLeHyeP9vqtsHn1bVjF6fN4kF8ARxWWTkpqTWZZapG+XwJVxa+NWpoKjfBW9X24wNTDO5uli
        5OSQEDCR+LH2CCOILSSwglFiaVN9FyMXkP2FUeLXldmMEM5nRon/e98DORxgHauaaiHiyxkl
        nm07ygLX8fHRMnaQIjYBPYkdqwpBpooIuEncaOxgAqlhFmhnlHgzbyYzSEJYwF1icWcnG4jN
        IqAq8fnBElaIk+Qkbp7rZAZpkBD4zCZxeEsTC0iCV6BM4u7Gn8wQRS4SJ4+dYISwhSVeHd/C
        DmHLSPzfOZ8Jwi6WONuxig3CrpFoP7kDqsZa4vDxi6wghzILaEqs36UPEXaUWPb6LRPEk3wS
        N94KgoSZgcxJ26YzQ4R5JTrahCCqNSS29FyAWiQmsXzNNKjhHhJLrz9gggRorMT1pWfYJjDK
        zULYtYCRcRWjeGppcW56arFxXmq5XnFibnFpXrpecn7uJkZgojj97/jXHYz7/iQdYhTgYFTi
        4Z2RtztaiDWxrLgy9xCjBAezkgiv6PZd0UK8KYmVValF+fFFpTmpxYcYpTlYlMR5l83bGC0k
        kJ5YkpqdmlqQWgSTZeLglGpgXKKWE/RLqPPujwWm9/+ar/FPW3Hw9NIXn665/uKUXbn7fmfO
        5GcBH8XeHA748o4tuCzEOyZ4//91Or2lCe9WPbpfbvL8p2D0rfllphPSvxXtnGzVtv8Pi7Vq
        UkbJzcMPP6xlP5TWkNa66g3zeYU5akvcuPvOWLe3PW2+IZpcuda/8PPx9HKWPUosxRmJhlrM
        RcWJALhtFfQQAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsVy+t/xu7rbT++JNji/U85i44z1rBZPDrQz
        WtxqkLHY9Pgaq8XlXXPYLC4dWMBkcbz3AJPFy48nWBw4PNbMW8PosXmFlsfmJfUei/sms3oc
        fLeHyeP9vqtsHn1bVjF6fN4kF8ARpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtl
        ZKqkb2eTkpqTWZZapG+XoJdxa+NWpoKjfBW9X24wNTDO5uli5OCQEDCRWNVU28XIxSEksJRR
        YsvDo6xdjJxAcTGJSfu2s0PYwhJ/rnWxQRR9YpQ49WMfK0gzm4CexI5VhSA1IgIeEm3/7jGD
        1DAL9DNKXG45xgSSEBZwl1jc2ckGYrMIqEp8frAEbAGvgKfEuxOnoRbISdw818k8gZFnASPD
        KkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMAg3Xbs5+YdjJc2Bh9iFOBgVOLhnZG3O1qINbGs
        uDL3EKMEB7OSCK/o9l3RQrwpiZVVqUX58UWlOanFhxhNgZZPZJYSTc4HRlBeSbyhqaG5haWh
        ubG5sZmFkjjveYPKKCGB9MSS1OzU1ILUIpg+Jg5OqQbGtqNF1q69Lm9+vOWT/VR6JvVSl0Hx
        hEWSFnfqD51691ZQosK43OJriPzuxDknBNatt3viKnHz/fedG6TrVjE0nGbYbqUQvC2Ye+7e
        VOHbTnM9ni/L4d3AZaxmduNf9/64i8sCExdfEvhuofPizMFIw83HPshF/Lz+nDc3O8jt2ymN
        1WrfHc9IKbEUZyQaajEXFScCAECNfoNoAgAA
Message-Id: <20181009153935eucas1p2dec146575ed5fefd4a0b2b6cb9bac056~b_ujkjRd31303013030eucas1p2C@eucas1p2.samsung.com>
X-CMS-MailID: 20181009153935eucas1p2dec146575ed5fefd4a0b2b6cb9bac056
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181009153935eucas1p2dec146575ed5fefd4a0b2b6cb9bac056
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181009153935eucas1p2dec146575ed5fefd4a0b2b6cb9bac056
References: <CGME20181009153935eucas1p2dec146575ed5fefd4a0b2b6cb9bac056@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add some warning related to performance drop.
It should be mentioned that this is not for free
and the platfrom resources (cache, bus interconnect, etc.)
will be used more frequently.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 Documentation/locking/lockdep-design.txt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/locking/lockdep-design.txt b/Documentation/locking/lockdep-design.txt
index 49f58a0..1af3686 100644
--- a/Documentation/locking/lockdep-design.txt
+++ b/Documentation/locking/lockdep-design.txt
@@ -331,3 +331,22 @@ Run the command and save the output, then compare against the output from
 a later run of this command to identify the leakers.  This same output
 can also help you find situations where runtime lock initialization has
 been omitted.
+
+This feature can have performance impact, which affects context
+switching time, cache invalidations, delays on bus transactions.
+System performance in some use cases can drop x3-x4 times.
+Tested on ARM Exynos5422 and ARM64 Exynos5433 big.LITTLE architectures
+(overhead is really big).
+The overhead can be measures using hackbench which will show different
+finish time (11sec -> 3.4sec(no lockdep)).
+Use 'perf' with enabled events showing cache usage, and bus usage
+(it is architecture specyfic and if needed on ARM enable CCI to check
+bus transactions).
+When you check transaction on cache or buses, the results are way higher
+than normal for the same hackbench test:
+L1d cache invalidations: 26mln vs 4mln
+L2u cache invalidations: 42mln vs 12mln
+bus cyc/access: 30cyc/access vs. 20cyc/access
+context switch is x3 times cheaper.
+Apart from hackbench issue, there is dhrystone performance drop,
+1.05 DMIPS/MHz vs. 1.45 DMIPS/MHz (no lockdep) on 'big' core.
-- 
2.7.4

