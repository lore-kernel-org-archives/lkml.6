Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADA7C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 02:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A84205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 02:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWmlvKuN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3A84205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754106AbeFTCjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 22:39:00 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:32926 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752836AbeFTCi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 22:38:59 -0400
Received: by mail-pl0-f66.google.com with SMTP id 6-v6so899040plb.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 19:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fpyZRkFgwW/DeenzdLodx6v+cyc93wA7zJWJmIpYx0E=;
        b=iWmlvKuNPiHrcFb/bU+tFfVGU5Gz8gHPhokEwGi8em0kw1WJUrl7HNkIPKfpHOYtsB
         cqin8ZaqyeDUFbunF5NYi4+HvC6NLYaajkmhI5LHzOjRORli9KfQl1WKB+iWo0jqkwFY
         z1TVN/NHzEdQ2bZc5d3S7GQ7muI1o/0zm2PM7Ld941x+Skj9HTThgyNtaW528cdzxoDC
         2FcAq51FWDjerkEjgKTEXGeDnFCapLHYIKqJK1EFtX0CwrxLowArIUtcMXW4/gGXtBh1
         q5eMikzcmNQfi4uEbWEHdP3GOcvsVHzb5d7O0m5Xdz/PBGGJ2wJwdKYpmFhvxk0FPWse
         EGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fpyZRkFgwW/DeenzdLodx6v+cyc93wA7zJWJmIpYx0E=;
        b=Q+wFD5PlSOGPdzN8DmxrE028jXYpT+vuyUNPo0mz5yXJLsQEeHvXSzfRi92/uHgzc4
         31k+do8k4yCkUpuSCL7xPI2SKcHlz2XS9NtgaFze7jHJ0mMbDDv/589RzEjxunFEE8Tg
         l40V6nkOZXjOOZgv3PodKAkzQHf0ca8+8GIIFdyZhduZiZ5D48XIBa2ANWhTXfJDjy87
         LaX+0v5Uj+j7ViIjqUN4xC6QhiRRFVY/DVTL3AOd8dGpyDtrwvJT3dYQUtdrz52pOJgP
         VbVsIC2vwfS4+hkakgNK4eSlkwwrQLbMQyDQ/I4KoPEjv5W2Ctx4FVuGOzI1onUmJpNx
         cBeA==
X-Gm-Message-State: APt69E3SgKTigpTH/ECxpOaawEdsBJQ2fJ2J29ZSDsmoE3c3samiLQJo
        1fL+wDHJA1SNVDOaFiZxwOvNzg==
X-Google-Smtp-Source: ADUXVKJcgHGT2GAvhZ3JMqqvZt3wDHIAcxHEozgSKGr3bL/lTJ5fe670yEQuDD5Hn1EX957vMMtmsA==
X-Received: by 2002:a17:902:758e:: with SMTP id j14-v6mr21046505pll.160.1529462338693;
        Tue, 19 Jun 2018 19:38:58 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:1:4413:d85e:ce7f:5f7a:fdfe])
        by smtp.gmail.com with ESMTPSA id o13-v6sm741477pgp.50.2018.06.19.19.38.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 19:38:58 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     boris.ostrovsky@oracle.com, jgross@suse.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] xen: Fix two possible sleep-in-atomic-context bugs in create_active()
Date:   Wed, 20 Jun 2018 10:38:46 +0800
Message-Id: <20180620023846.30618-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver may sleep with holding a spinlock.
The function call paths (from bottom to top) in Linux-4.16.7 are:

[FUNC] __get_free_pages(GFP_KERNEL)
drivers/xen/pvcalls-front.c, 351: __get_free_pages in create_active
drivers/xen/pvcalls-front.c, 800: create_active in pvcalls_front_accept
drivers/xen/pvcalls-front.c, 783: spin_lock in pvcalls_front_accept

[FUNC] __get_free_pages(GFP_KERNEL)
drivers/xen/pvcalls-front.c, 347: __get_free_pages in create_active
drivers/xen/pvcalls-front.c, 800: create_active in pvcalls_front_accept
drivers/xen/pvcalls-front.c, 783: spin_lock in pvcalls_front_accept

To fix these bugs, GFP_KERNEL is replaced with GFP_ATOMIC.

These bugs are found by my static analysis tool (DSAC-2) and checked by my
code review.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/xen/pvcalls-front.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/pvcalls-front.c b/drivers/xen/pvcalls-front.c
index 2f11ca72a281..f2bbc06a0f7f 100644
--- a/drivers/xen/pvcalls-front.c
+++ b/drivers/xen/pvcalls-front.c
@@ -344,11 +344,11 @@ static int create_active(struct sock_mapping *map, int *evtchn)
 	init_waitqueue_head(&map->active.inflight_conn_req);
 
 	map->active.ring = (struct pvcalls_data_intf *)
-		__get_free_page(GFP_KERNEL | __GFP_ZERO);
+		__get_free_page(GFP_ATOMIC | __GFP_ZERO);
 	if (map->active.ring == NULL)
 		goto out_error;
 	map->active.ring->ring_order = PVCALLS_RING_ORDER;
-	bytes = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
+	bytes = (void *)__get_free_pages(GFP_ATOMIC | __GFP_ZERO,
 					PVCALLS_RING_ORDER);
 	if (bytes == NULL)
 		goto out_error;
-- 
2.17.0

