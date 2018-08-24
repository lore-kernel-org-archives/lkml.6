Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FAFC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7FD921712
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoAtPDKB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7FD921712
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbeHXNGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 09:06:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36890 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbeHXNGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 09:06:16 -0400
Received: by mail-pf1-f196.google.com with SMTP id h69-v6so4283258pfd.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 02:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=F2idZfVkJ1qXOK3JbG2V/nxdIrzhu73uB/2TBusRpLc=;
        b=BoAtPDKBpo7Z38mhsdKONIvEzrIxMr7TTojyzO/rU8MGzQRbWunuy/8wXTvq8nzm78
         iSyj0Vy2fLKJsdpGJgOPDKZiTN3fyFnUPsPdWNGy+T91qzBM/pbk2tUf1RSogYQ/r8Sy
         KnjPc9ITl/12SqG2AaJBtCDlDPh+HdFKMH/uYFJPjt/KFWVOKZPhLS0aK3lbhbwA056H
         VcCAMGW9GckbT1mXnLBrleX9C9kxM6/1IHyyteE7MLJUSmWVyo1yuEgR6udOpC/ELQQz
         Cjwn5tddWGZGh+QjUE/t5nzK63CAb7AlWCXM/ausIvGGgkgHIcK97mFgOKlIVGmPthEr
         x0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=F2idZfVkJ1qXOK3JbG2V/nxdIrzhu73uB/2TBusRpLc=;
        b=JC51iYa9hg6Jqo6tVFClzaYJ6wCCOs7XWdf2zdSAWcsU+W2eDXaFUlcyn42q4G08wJ
         pttgM/EGE0lzUCrtkcypFMQuhGODkuYfw68NgzOLtTgSKVtZxTxlso9L10xFiLFFpiWs
         PA5YDMP2RLA/LwSTl7YxVAhUFP3Y4lsbTkNI7OOuGkVSfl1xc5Cfel3qZ5pFJ/yIgcbI
         O3DgMFHLztFv915t3FIPvc8ax1GHQ6io9dTMytmDIjrK7lN/s5ekBPKy4Sp+eHJeS0jX
         6nk+IU3u0ePE9zX20TMAheSeRPhCJDqxATuG2YFfGw6yaEyIbsXYXBaBwFxwv1q83MDN
         vcWQ==
X-Gm-Message-State: APzg51DMIn/+YG2C/09EpuBUMlLvkD2Y6Qd4f6queZiyjKFUJdEZnCmG
        fPJiQbOiq32/8eZ04z/5wA==
X-Google-Smtp-Source: ANB0VdZdVXVrhk3WdLpX7p8fHDAieSTt5tfMi/IfpDbXFeRFrTw5ZfgStFrbSLIu/tWov6vQvHOuMQ==
X-Received: by 2002:a63:b544:: with SMTP id u4-v6mr925687pgo.247.1535103147147;
        Fri, 24 Aug 2018 02:32:27 -0700 (PDT)
Received: from www9186uo.sakura.ne.jp (www9186uo.sakura.ne.jp. [153.121.56.200])
        by smtp.gmail.com with ESMTPSA id h7-v6sm16746557pfd.155.2018.08.24.02.32.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 02:32:26 -0700 (PDT)
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1] tools/vm/slabinfo.c: fix sign-compare warning
Date:   Fri, 24 Aug 2018 18:32:14 +0900
Message-Id: <1535103134-20239-1-git-send-email-n-horiguchi@ah.jp.nec.com>
X-Mailer: git-send-email 2.7.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we get the following compiler warning:

    slabinfo.c:854:22: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
       if (s->object_size < min_objsize)
                          ^

due to the mismatch of signed/unsigned comparison. ->object_size and
->slab_size are never expected to be negative, so let's define them
as unsigned int.

Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
---
 tools/vm/slabinfo.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git v4.18-mmotm-2018-08-17-15-48/tools/vm/slabinfo.c v4.18-mmotm-2018-08-17-15-48_patched/tools/vm/slabinfo.c
index f82c2ea..eebeeb1 100644
--- v4.18-mmotm-2018-08-17-15-48/tools/vm/slabinfo.c
+++ v4.18-mmotm-2018-08-17-15-48_patched/tools/vm/slabinfo.c
@@ -30,9 +30,10 @@ struct slabinfo {
 	int alias;
 	int refs;
 	int aliases, align, cache_dma, cpu_slabs, destroy_by_rcu;
-	int hwcache_align, object_size, objs_per_slab;
-	int sanity_checks, slab_size, store_user, trace;
+	int hwcache_align, objs_per_slab;
+	int sanity_checks, store_user, trace;
 	int order, poison, reclaim_account, red_zone;
+	unsigned int object_size, slab_size;
 	unsigned long partial, objects, slabs, objects_partial, objects_total;
 	unsigned long alloc_fastpath, alloc_slowpath;
 	unsigned long free_fastpath, free_slowpath;
-- 
2.7.0

