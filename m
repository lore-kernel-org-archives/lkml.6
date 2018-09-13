Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE5FC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6196C20839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOzJGeri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6196C20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbeIMQbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 12:31:12 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37299 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbeIMQbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 12:31:11 -0400
Received: by mail-wm0-f68.google.com with SMTP id n11-v6so5791251wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 04:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6IAsQA6hU2nCPGIGOd69vr3u1tuP9372Dtj3Q9Neyds=;
        b=lOzJGeri27oyM5PSoVkMpY+8m2bGZb4UTObAFthyIe2/AC1Fl4pn5iGVRDvW1ne8Hp
         qY3LSFujH9+BZbWfkhDVpMOpmPZPHlgu3eHHtBNCajX/34IFfMlmshq7YYGq4ffJJcsq
         uiDhlkXK3WUUZ2Y2EaTH+8+r+2fd/0YGWXncjIExsBo+r4dqN2nCG0g1RhorMHvSQoSu
         dCwQoTrydg1zl6Lst7/jwr+08KUPj2qPpZwt6Um1eo2zJDhgjD6oO/TJCPyUYsMmWTQB
         hC4lH1Z4mhZLHRMS2fdjAOvCDdoYu0ii1hj1cznGfHj/2pq9OHfpnAymQEZAP/LKOHaG
         Bg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6IAsQA6hU2nCPGIGOd69vr3u1tuP9372Dtj3Q9Neyds=;
        b=AyxLnyzB7lUc7MzWB88q8of3SQ2P/QS+tAkVLfi7sQCcS4/qP9iZpjVfKDLDY3uMsG
         m7HP5jMGBjb5zgGN1th4AuZDw9VD9jQf5lrL3pFJHlnbGwXg0hxkAaY7Z36qBTux/8E+
         f6lzVtIVguJt6Wcyi7LdSaUV+UtTH85Pmu+4g0B8m6/grEfGb87BOJQnWIHuFY0nPtto
         Cd4taciKkWakWn6ytxGlMOf3tIG4MSi3ZWJmbXb//FE2z5pUIhb1Gsw32EAH1SrXCpss
         WUaNcsFGi7MmRkCEsX68gkw+RWqyurWSPbXTp/ps9WdDIUfDuNOnLX95fEhGVPCdgHjZ
         d/nA==
X-Gm-Message-State: APzg51CgDcsJesw4W6mKcPhD4fPkQ3M9JrbIWL1y+6fC7dDxqvvJA+w3
        OviaOD5Ltsia7g21nP3SBqrViS9R
X-Google-Smtp-Source: ANB0VdYEb1p/c1PSsnn2RQd1vJ60tSo7nnocGymrSzs2ElnRG0Gy/2QS4ja+by48nVcLsdvHufJOcQ==
X-Received: by 2002:a1c:32c4:: with SMTP id y187-v6mr5019300wmy.31.1536837729613;
        Thu, 13 Sep 2018 04:22:09 -0700 (PDT)
Received: from baker.fritz.box ([2a02:908:1257:4460:c8f7:2479:525e:9500])
        by smtp.gmail.com with ESMTPSA id u65-v6sm5528748wmd.31.2018.09.13.04.22.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 04:22:09 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] list: introduce list_bulk_move_tail helper
Date:   Thu, 13 Sep 2018 13:22:07 +0200
Message-Id: <20180913112208.1353-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move all entries between @first and including @last before @head.

This is useful for LRU lists where a whole block of entries should be
moved to the end of an list.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 include/linux/list.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/list.h b/include/linux/list.h
index de04cc5ed536..edb7628e46ed 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -183,6 +183,29 @@ static inline void list_move_tail(struct list_head *list,
 	list_add_tail(list, head);
 }
 
+/**
+ * list_bulk_move_tail - move a subsection of a list to its tail
+ * @head: the head that will follow our entry
+ * @first: first entry to move
+ * @last: last entry to move, can be the same as first
+ *
+ * Move all entries between @first and including @last before @head.
+ * All three entries must belong to the same linked list.
+ */
+static inline void list_bulk_move_tail(struct list_head *head,
+				       struct list_head *first,
+				       struct list_head *last)
+{
+	first->prev->next = last->next;
+	last->next->prev = first->prev;
+
+	head->prev->next = first;
+	first->prev = head->prev;
+
+	last->next = head;
+	head->prev = last;
+}
+
 /**
  * list_is_last - tests whether @list is the last entry in list @head
  * @list: the entry to test
-- 
2.14.1

