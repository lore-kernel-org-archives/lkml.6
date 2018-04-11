Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752652AbeDKIJp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 04:09:45 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35706 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752498AbeDKIJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 04:09:39 -0400
X-Google-Smtp-Source: AIpwx4+WKcUBW8raODtTIFrkHdEjsBhyQ0WgcyMdJhBdH0IfCAYkYjUAsYV1y8KvC3oiGhAaTsWAkw==
From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To: linux-mm@kvack.org
Cc: Michal Hocko <mhocko@kernel.org>, Zi Yan <zi.yan@sent.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] mm: migrate: vm event counter for hugepage migration
Date: Wed, 11 Apr 2018 17:09:25 +0900
Message-Id: <1523434167-19995-1-git-send-email-n-horiguchi@ah.jp.nec.com>
X-Mailer: git-send-email 2.7.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I wrote patches introducing separate vm event counters for hugepage migration
(both for hugetlb and thp.)
Hugepage migration is different from normal page migration in event frequency
and/or how likely it succeeds, so maintaining statistics for them in mixed
counters might not be helpful both for develors and users.

Thanks,
Naoya Horiguchi
---
Summary:

Naoya Horiguchi (2):
      mm: migrate: add vm event counters thp_migrate_(success|fail)
      mm: migrate: add vm event counters hugetlb_migrate_(success|fail)

 include/linux/vm_event_item.h |   7 +++
 mm/migrate.c                  | 103 +++++++++++++++++++++++++++++++++++-------
 mm/vmstat.c                   |   8 ++++
 3 files changed, 102 insertions(+), 16 deletions(-)
