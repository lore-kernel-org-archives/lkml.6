Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDB0ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 12:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B0521477
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 12:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhNsNoPM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B0521477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbeIOSPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 14:15:07 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54470 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbeIOSPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 14:15:07 -0400
Received: by mail-wm1-f68.google.com with SMTP id c14-v6so4712463wmb.4
        for <linux-kernel@vger.kernel.org>; Sat, 15 Sep 2018 05:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=9NUWOubg/5F0jfoH+UrRA7UQ2UsjLOrTdGm27KLq3e0=;
        b=BhNsNoPMdsMW3tbyRES0W+XCnNKazSAIZqCz8UuAxFQvbi9ZkiMkhLRa4qN9q6ZRFD
         GjqhsE8TH+leFASw/A1UDJyfAuVDKbrpYP8L38Tc720uLzxKtnzVlBh5gd3iZ2agtQMV
         vOmLOuA4WTK0mznd8vyxgXzziOZQCGBJ9jhrGwpmHJkBr+oPnQXqIH1WrUFq45+cY1zM
         HkQHL5Tnf9hOnG5ZrFjIdxgQNf9OIiDl8bqM1Qh6EIojTH5HJHYs+CR49Szg5Ky5B47U
         a/ltpIfDSrdCM8RNsl8AsL7FnVg8M/f5fmsk2Y8x3ZCXB36HfDj65WaizV/v8xoR0O0M
         CWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=9NUWOubg/5F0jfoH+UrRA7UQ2UsjLOrTdGm27KLq3e0=;
        b=Mr3Oatwz9kRozbYXiKFlqZ0yxkt0lQyFMBcKAne9RDiDbFUXe6dqeH87pI8R0ItEI2
         f2Tqb0rHEoDwqGdbn5CkLA8Fxh+QCUd0dei6nATEpHd/9w5WhAuMqIMY/awDKNNu6Oja
         L6TnQmqMw9lGqrCp4brgZWgtseZZ66PGH68rCRFCxhyv9LdnJSMGabkfeeTmokbnkiJ9
         f0iu7SBiF23xu78fD9+KvtgKpOR/EKTk0eQOFWKGbvCO00jpo3QKji9tdlryVPtocmkt
         Gzrg9dE0V8W50ITtPG9xWn58IxkSD+KlZL0bJEWIMsfe5BBLtyHIZdlO/KCbBk7p84mK
         o43Q==
X-Gm-Message-State: APzg51B4tVDCIfjrqxINrZJDfnCWDGfvz30OVBHXUj/FH9wxx5kgKSxq
        q/opO4riynYgrwFcKA5med8=
X-Google-Smtp-Source: ANB0VdZ9kWBkODGWCORIXRy50Fq2fvHHckDrYiFlzdFxKGDjmMoHKU/dU7+tD/nFvQ2A3ZRNOY6H+Q==
X-Received: by 2002:a1c:2e11:: with SMTP id u17-v6mr5257814wmu.102.1537016170415;
        Sat, 15 Sep 2018 05:56:10 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id j11-v6sm8219011wrr.37.2018.09.15.05.56.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Sep 2018 05:56:09 -0700 (PDT)
Date:   Sat, 15 Sep 2018 14:56:07 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        "Paul E. McKenney" <paulmck@us.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] locking fixes
Message-ID: <20180915125607.GA60178@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest locking-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-for-linus

   # HEAD: 0b405c65ad459f5f4d3db1672246172bd19d946d locking/ww_mutex: Fix spelling mistake "cylic" -> "cyclic"

Misc fixes: liblockdep fixes and ww_mutex fixes.

 Thanks,

	Ingo

------------------>
Ben Hutchings (1):
      locking/lockdep: Delete unnecessary #include

Borislav Petkov (1):
      jump_label: Fix typo in warning message

Colin Ian King (1):
      locking/ww_mutex: Fix spelling mistake "cylic" -> "cyclic"

Sasha Levin (3):
      tools/lib/lockdep: Update Sasha Levin email to MSFT
      tools/lib/lockdep: Add empty nmi.h
      tools/lib/lockdep: Add dummy task_struct state member

Thomas Hellstrom (1):
      locking/mutex: Fix mutex debug call and ww_mutex documentation


 MAINTAINERS                    | 2 +-
 kernel/jump_label.c            | 2 +-
 kernel/locking/lockdep.c       | 1 -
 kernel/locking/mutex.c         | 3 +--
 kernel/locking/test-ww_mutex.c | 2 +-
 tools/include/linux/lockdep.h  | 3 +++
 tools/include/linux/nmi.h      | 0
 7 files changed, 7 insertions(+), 6 deletions(-)
 create mode 100644 tools/include/linux/nmi.h

diff --git a/MAINTAINERS b/MAINTAINERS
index d870cb57c887..f999786cfa90 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8300,7 +8300,7 @@ F:	include/linux/libata.h
 F:	Documentation/devicetree/bindings/ata/
 
 LIBLOCKDEP
-M:	Sasha Levin <alexander.levin@verizon.com>
+M:	Sasha Levin <alexander.levin@microsoft.com>
 S:	Maintained
 F:	tools/lib/lockdep/
 
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 01ebdf1f9f40..2e62503bea0d 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -678,7 +678,7 @@ jump_label_module_notify(struct notifier_block *self, unsigned long val,
 	case MODULE_STATE_COMING:
 		ret = jump_label_add_module(mod);
 		if (ret) {
-			WARN(1, "Failed to allocatote memory: jump_label may not work properly.\n");
+			WARN(1, "Failed to allocate memory: jump_label may not work properly.\n");
 			jump_label_del_module(mod);
 		}
 		break;
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e406c5fdb41e..dd13f865ad40 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -55,7 +55,6 @@
 
 #include "lockdep_internals.h"
 
-#include <trace/events/preemptirq.h>
 #define CREATE_TRACE_POINTS
 #include <trace/events/lock.h>
 
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 1a81a1257b3f..3f8a35104285 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -389,7 +389,7 @@ static bool __ww_mutex_wound(struct mutex *lock,
 		/*
 		 * wake_up_process() paired with set_current_state()
 		 * inserts sufficient barriers to make sure @owner either sees
-		 * it's wounded in __ww_mutex_lock_check_stamp() or has a
+		 * it's wounded in __ww_mutex_check_kill() or has a
 		 * wakeup pending to re-read the wounded state.
 		 */
 		if (owner != current)
@@ -946,7 +946,6 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	}
 
 	debug_mutex_lock_common(lock, &waiter);
-	debug_mutex_add_waiter(lock, &waiter, current);
 
 	lock_contended(&lock->dep_map, ip);
 
diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index 5b915b370d5a..0be047dbd897 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -324,7 +324,7 @@ static int __test_cycle(unsigned int nthreads)
 		if (!cycle->result)
 			continue;
 
-		pr_err("cylic deadlock not resolved, ret[%d/%d] = %d\n",
+		pr_err("cyclic deadlock not resolved, ret[%d/%d] = %d\n",
 		       n, nthreads, cycle->result);
 		ret = -EINVAL;
 		break;
diff --git a/tools/include/linux/lockdep.h b/tools/include/linux/lockdep.h
index 6b0c36a58fcb..e56997288f2b 100644
--- a/tools/include/linux/lockdep.h
+++ b/tools/include/linux/lockdep.h
@@ -30,9 +30,12 @@ struct task_struct {
 	struct held_lock held_locks[MAX_LOCK_DEPTH];
 	gfp_t lockdep_reclaim_gfp;
 	int pid;
+	int state;
 	char comm[17];
 };
 
+#define TASK_RUNNING 0
+
 extern struct task_struct *__curr(void);
 
 #define current (__curr())
diff --git a/tools/include/linux/nmi.h b/tools/include/linux/nmi.h
new file mode 100644
index 000000000000..e69de29bb2d1
