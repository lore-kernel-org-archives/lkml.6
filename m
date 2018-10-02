Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273E9C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 16:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8082083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 16:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="QcoxN2VA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC8082083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbeJBXED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 19:04:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45300 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbeJBXED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 19:04:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id q5-v6so2892564wrw.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 09:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=dVKmxQVrpJZvJn5/VP1CGLfRDCwvpj/jGRXVi3uRGZs=;
        b=QcoxN2VAs2N5Q1NYLKQxeewfB3zvI9XuMvNeu/znNJojq++3LNi1acunL6WGfNhfZn
         /ehQgUKwqgjbQlYS8cRct1pqLc4uXoIjGLW2Telb1bCXhs10YGIntGV10WDCpEKsBWmx
         8AuNKSNzTD+S/VCfgMcHeU0MyLaAZUiMmYA+ijhdHNPXKbH5b35JebcU3Cz2ZoaO+0cS
         J2pVph2wUZlYYbWQBcpMqw8ohn62jaZpDXu7o62J3H+5x4+55bttBxLRnHSY5QHevavY
         udkS6QTi/U1LAtbfUMrln2PYxja5YnzXUasnVewVZSRFUEg2BxzzqP/bne6OOYEhP9SG
         5BWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dVKmxQVrpJZvJn5/VP1CGLfRDCwvpj/jGRXVi3uRGZs=;
        b=oHuyTdy/gNxIpRoKkV3cTrhCQ6eczf+DjOrCgdF56Gu0vWwpqahuA6/FvaBktWLETL
         tCDZatrPxTLQtGzCLKyf1Y+YE6xmeF0BRR/82nHAmOjILRr4nDkaloTcgmLWNN9Zqq9M
         WIptwzGWvNmBsxR3dZLaqz/YzZgkYkNN4YgeodoH1RO4pHmjLX6oWy/nHrKjlokKmpVH
         4tTFLXiis0uCXXFUPDjgxeB0MzqOOX3hLJaK6bZp+xFRX6A3SdkrzTVAyI7FNR4BMVAA
         ok2OI4gofHSj2jOqVQBehhP7Hs/uaGuigNE7gpx5Erl6tBeiGLfEw58HSx5GLJOzAt2/
         oEZg==
X-Gm-Message-State: ABuFfojK3lUxMG2gTyphFhwL8UEhf5EUWdYLz6B/z4KllR8BOa/Tvupa
        bHMedNWficF+/EsavUzclmfGrVulHM0=
X-Google-Smtp-Source: ACcGV60wBGlF+e7oq8VOrjWM0k6fWe4EXUFVQMf4bvmzQjyIqJE/Ta4cf3qzf/LjS+MQtCy3DVIj0Q==
X-Received: by 2002:adf:8382:: with SMTP id 2-v6mr2938704wre.13.1538497192488;
        Tue, 02 Oct 2018 09:19:52 -0700 (PDT)
Received: from localhost.localdomain (p200300D993C77B00B5EB8DB179490446.dip0.t-ipconnect.de. [2003:d9:93c7:7b00:b5eb:8db1:7949:446])
        by smtp.googlemail.com with ESMTPSA id n14-v6sm9132139wmc.14.2018.10.02.09.19.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 09:19:51 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Cc:     1vier1@web.de, Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [RFC, PATCH] ipc/util.c: use idr_alloc_cyclic() for ipc allocations
Date:   Tue,  2 Oct 2018 18:19:42 +0200
Message-Id: <20181002161942.1037-1-manfred@colorfullife.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A bit related to the patch series that increases IPC_MNI:

(User space) id reuse create the risk of data corruption:

Process A: calls ipc function
Process A: sleeps just at the beginning of the syscall
Process B: Frees the ipc object (i.e.: calls ...ctl(IPC_RMID)
Process B: Creates a new ipc object (i.e.: calls ...get())
	<If new object and old object have the same id>
Process A: is woken up, and accesses the new object

To reduce the probability that the new and the old object
have the same id, the current implementation adds a
sequence number to the index of the object in the idr tree.

To further reduce the probability for a reuse, switch from
idr_alloc to idr_alloc_cyclic.

The patch cycles over at least RADIX_TREE_MAP_SIZE, i.e.
if there is only a small number of objects, the accesses
continue to be direct.

As an option, this could be made dependent on the extended
mode: In extended mode, cycle over e.g. at least 16k ids.

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
---

Open questions:
- Is there a significant performance advantage, especially
  there are many ipc ids?
- Over how many ids should the code cycle always?
- Further review remarks?

 ipc/util.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/ipc/util.c b/ipc/util.c
index 0af05752969f..6f83841f6761 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -216,10 +216,30 @@ static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
 	 */
 
 	if (next_id < 0) { /* !CHECKPOINT_RESTORE or next_id is unset */
+		int idr_max;
+
 		new->seq = ids->seq++;
 		if (ids->seq > IPCID_SEQ_MAX)
 			ids->seq = 0;
-		idx = idr_alloc(&ids->ipcs_idr, new, 0, 0, GFP_NOWAIT);
+
+		/*
+		 * If a user space visible id is reused, then this creates a
+		 * risk for data corruption. To reduce the probability that
+		 * a number is reduced, two approaches are used:
+		 * 1) the idr index is allocated cyclically.
+		 * 2) the use space id is build by concatenating the
+		 *    internal idr index with a sequence number
+		 * To avoid that both numbers have the same cycle time, try
+		 * to set the size for the cyclic alloc to an odd number.
+		 */
+		idr_max = ids->in_use*2+1;
+		if (idr_max < RADIX_TREE_MAP_SIZE-1)
+			idr_max = RADIX_TREE_MAP_SIZE-1;
+		if (idr_max > IPCMNI)
+			idr_max = IPCMNI;
+
+		idx = idr_alloc_cyclic(&ids->ipcs_idr, new, 0, idr_max,
+					GFP_NOWAIT);
 	} else {
 		new->seq = ipcid_to_seqx(next_id);
 		idx = idr_alloc(&ids->ipcs_idr, new, ipcid_to_idx(next_id),
-- 
2.17.1

