Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751114AbeBQIPt (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 03:15:49 -0500
Received: from forwardcorp1j.cmail.yandex.net ([5.255.227.105]:52021 "EHLO
        forwardcorp1j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751087AbeBQIPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 03:15:48 -0500
Authentication-Results: smtpcorp1p.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: [PATCH] Documentation/vm/pagemap.txt: document bit WAITERS
From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Date: Sat, 17 Feb 2018 11:15:43 +0300
Message-ID: <151885534363.17898.8456668269733387066.stgit@buzz>
In-Reply-To: <151834540184.176427.12174649162560874101.stgit@buzz>
References: <151834540184.176427.12174649162560874101.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 Documentation/vm/pagemap.txt |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/vm/pagemap.txt b/Documentation/vm/pagemap.txt
index eafcefa15261..eaa46771fa30 100644
--- a/Documentation/vm/pagemap.txt
+++ b/Documentation/vm/pagemap.txt
@@ -71,6 +71,7 @@ There are four components to pagemap:
     23. BALLOON
     24. ZERO_PAGE
     25. IDLE
+    26. WAITERS
 
  * /proc/kpagecgroup.  This file contains a 64-bit inode number of the
    memory cgroup each page is charged to, indexed by PFN. Only available when
@@ -127,6 +128,13 @@ Short descriptions to the page flags:
     stale in case the page was accessed via a PTE. To make sure the flag
     is up-to-date one has to read /sys/kernel/mm/page_idle/bitmap first.
 
+26. WAITERS
+    Indicates tasks are waiting when bits LOCKED or WRITEBACK will be cleared.
+    They might be blocked by undergoing IO or by contention on page lock.
+    Bit WAITERS might be false-positive, in this case next clear of LOCKED or
+    WRITEBACK will clear WAITERS too. I.e. without LOCKED and WRITEBACK it's
+    false-positive for sure.
+
     [IO related page flags]
  1. ERROR     IO error occurred
  3. UPTODATE  page has up-to-date data
