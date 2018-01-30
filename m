Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752792AbeA3S27 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 13:28:59 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:39082 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751452AbeA3S26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 13:28:58 -0500
X-Google-Smtp-Source: AH8x226ZdyzCMHIc6RQS5iXmUQchpdbrLplzFUgWVTX62vtDO3ThdwFdt5DqGqxUdz/w50zRCymjWw==
Date: Tue, 30 Jan 2018 10:28:55 -0800
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>
Subject: [GIT PULL] percpu changes for v4.16-rc1
Message-ID: <20180130182855.GI1121507@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

One trivial patch to convert the return type from int to bool.

Thanks.

The following changes since commit 032b4cc8ff84490c4bc7c4ef8c91e6d83a637538:

  Merge tag 'pm-4.15-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm (2017-12-14 18:25:03 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/percpu.git for-4.16

for you to fetch changes up to 85dcbba3b8b15c17d3237695440d09d12825184d:

  percpu: percpu_counter_initialized can be boolean (2017-12-15 05:28:06 -0800)

----------------------------------------------------------------
guoyayun (1):
      percpu: percpu_counter_initialized can be boolean

 include/linux/percpu_counter.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
index 73a7bf3..4f05249 100644
--- a/include/linux/percpu_counter.h
+++ b/include/linux/percpu_counter.h
@@ -86,7 +86,7 @@ static inline s64 percpu_counter_read_positive(struct percpu_counter *fbc)
 	return 0;
 }
 
-static inline int percpu_counter_initialized(struct percpu_counter *fbc)
+static inline bool percpu_counter_initialized(struct percpu_counter *fbc)
 {
 	return (fbc->counters != NULL);
 }
@@ -167,9 +167,9 @@ static inline s64 percpu_counter_sum(struct percpu_counter *fbc)
 	return percpu_counter_read(fbc);
 }
 
-static inline int percpu_counter_initialized(struct percpu_counter *fbc)
+static inline bool percpu_counter_initialized(struct percpu_counter *fbc)
 {
-	return 1;
+	return true;
 }
 
 #endif	/* CONFIG_SMP */

-- 
tejun
