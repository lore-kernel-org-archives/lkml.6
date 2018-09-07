Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3578C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2F52083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PI1i2g/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E2F52083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730025AbeIGUDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:03:06 -0400
Received: from m12-15.163.com ([220.181.12.15]:55425 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729753AbeIGUDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=LHSm/AMczcyEPF9XyF
        b9OY++ZgEXxl5Wk28NZhH45jk=; b=PI1i2g/ZZPFGP4gd8W8QVBp6k2KyYeTuJJ
        Gz6Wb3g8CFLRxfKfcBJrNJCRjpJHCej10irbyBJYOi+J5p5mxsBZCWddf/XFIG/J
        TsP3YdsY4cRbHJigdvH7NzB8QQSMP0T691lfUq924ae/R4xquyyagfflT9gBNRbz
        aXldBQiTA=
Received: from localhost (unknown [183.156.140.9])
        by smtp11 (Coremail) with SMTP id D8CowADH599Ul5JblUi_GQ--.48014S5;
        Fri, 07 Sep 2018 23:20:54 +0800 (CST)
From:   jun qian <hangdianqj@163.com>
To:     Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>
Cc:     devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        Barry song <21cnbao@gmail.com>, jun qian <hangdianqj@163.com>
Subject: [PATCH] android:ion: the order and count are in the wrong position
Date:   Fri,  7 Sep 2018 08:20:32 -0700
Message-Id: <20180907152032.45956-1-hangdianqj@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: D8CowADH599Ul5JblUi_GQ--.48014S5
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFyDWr1xXF4Duw18WF1ftFb_yoWDKrbEkr
        9F9rn3Jr4FqFWkXF1q9F47Wa9Fva1xZwsav34aqFZrXay7AFyxJFyDZrW3Zw4UXr43KrZx
        AFn5twnYy34xGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbTGQPUUUUU==
X-Originating-IP: [183.156.140.9]
X-CM-SenderInfo: pkdqwvpldq1yi6rwjhhfrp/1tbiJxa6R1XloABFLAAAs1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value in the wrong position will cause misunderstanding,
when the debug infomations display in the window.

Signed-off-by: jun qian <hangdianqj@163.com>
---
 drivers/staging/android/ion/ion_system_heap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
index 701eb9f3b0f1..54b8a7710958 100644
--- a/drivers/staging/android/ion/ion_system_heap.c
+++ b/drivers/staging/android/ion/ion_system_heap.c
@@ -225,10 +225,10 @@ static int ion_system_heap_debug_show(struct ion_heap *heap, struct seq_file *s,
 		pool = sys_heap->pools[i];
 
 		seq_printf(s, "%d order %u highmem pages %lu total\n",
-			   pool->high_count, pool->order,
+			   pool->order, pool->high_count,
 			   (PAGE_SIZE << pool->order) * pool->high_count);
 		seq_printf(s, "%d order %u lowmem pages %lu total\n",
-			   pool->low_count, pool->order,
+			   pool->order, pool->low_count,
 			   (PAGE_SIZE << pool->order) * pool->low_count);
 	}
 
-- 
2.17.1



