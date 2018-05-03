Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751652AbeECT3s (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 15:29:48 -0400
Received: from mail-yb0-f201.google.com ([209.85.213.201]:53346 "EHLO
        mail-yb0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751214AbeECT3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 15:29:47 -0400
X-Google-Smtp-Source: AB8JxZpwE9pL7csxUBN7xLJjv7iMV4InZ/tkz2Rm2yAF35Azmm81jISZWuqwKQTy7aOQnSKI0ZJAgccystrf
MIME-Version: 1.0
Date: Thu,  3 May 2018 12:29:40 -0700
Message-Id: <20180503192940.94971-1-gthelen@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH] memcg: mark memcg1_events static const
From: Greg Thelen <gthelen@google.com>
To: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark memcg1_events static: it's only used by memcontrol.c.
And mark it const: it's not modified.

Signed-off-by: Greg Thelen <gthelen@google.com>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2bd3df3d101a..c9c7e5ea0e2f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3083,7 +3083,7 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
 #endif /* CONFIG_NUMA */
 
 /* Universal VM events cgroup1 shows, original sort order */
-unsigned int memcg1_events[] = {
+static const unsigned int memcg1_events[] = {
 	PGPGIN,
 	PGPGOUT,
 	PGFAULT,
-- 
2.17.0.441.gb46fe60e1d-goog
