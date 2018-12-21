Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33FBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8847E21908
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545395423;
	bh=Mos/EK8uRqZjoZ/ri3ZBKJKMbrplPrO3wiT7bZspYwQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=lbjCPoIe2nAutTxf8Z0AZ+RM4w9m/Fka7gIdFvIlTJywtcPJDdGITET6OB/2qkqKH
	 5KBs9rD1ffpUEQhXeOhOEaoDXAMz4od9Q83e58wENnoiUYQyeAM3J91vJ1A0y9m3gq
	 mhwTiY8l49Yu4LwKiXksUNFiMMShe7APKccUzC40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390309AbeLUMaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 07:30:22 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40768 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732708AbeLUMaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 07:30:21 -0500
Received: by mail-wm1-f66.google.com with SMTP id f188so5530729wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 04:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=JJx6kdozMqFqKYg69bTBTWXtnZ8/Mn7kJPccKxhjcYA=;
        b=jjRrgtNxkHh1koeKPq7UTFZ89YOSuRXq0fZnL/A6GGtq299/p2P/OA8y+yDihbcJ+4
         p5VpmSXY86DT+ClQXVapWuo+AWB9dp8QqgIPev6VPc68zqv7vvDC9aSt9jpdhxA/+z04
         5V1HTfhrBzKeyZwh9iJIlRjfO0aqKkIKuPzdQ/OCaNjy182UwMrkSMquXgZc8M1fQaur
         OY4lmmunDQMQLc/KujDqpSAV3sLX8e0cZ5ZoYVIJqMw/segEdejpFscVSJ2Ai5+muMD1
         sk6+Ov4+4PNXt8VzO3ecQnhRgm/PhbZgXfpmjB0wP8ZuaxTqXfVgHYv+vpia5iXisrOt
         tLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=JJx6kdozMqFqKYg69bTBTWXtnZ8/Mn7kJPccKxhjcYA=;
        b=KTJCUxQs39/LPqsOPEI/2judeoz3GAojBCgvl34MWEZua7Kbt6MjW7CQaQSzoLZ8nj
         AN7Cdr5L3VhqurwxR4mZpBokk51yOPpaaPPb9M45Ct7IkjBu7jWAUQvK13Fg/lKqTA96
         7mqN7aKD84Qs4s1etERgl3X7GbZx2lqfx9s5BUIg8LMzXBSxh5rcNimUZ74jR89N0E9B
         /oShgyYFGs1WG75AmAqMQqM42bEA9fvAcuFq4wVxIFP5c0tqSOBe4zJS1ye+agvXnXws
         fYmiz3bOtOVffklovrsGTTLgptwWbDCi4+UrkwCKP3qRFjwIuobcXMZnW6i8M8yq346a
         r8Xw==
X-Gm-Message-State: AJcUukduyDwwRDXNH7JRX0eOub6s8ryUg/GhFP5SowBjLxnSFc5+ACZb
        NfNoFRMEFiRzzrYWKgQ8SfU=
X-Google-Smtp-Source: ALg8bN7a/RWqas1plcVaDqGOr8RnUemHHxm4zpR/Xuenvp8jD7vyk2zsgCGhALTsLI/eefaESblLKw==
X-Received: by 2002:a7b:c7c2:: with SMTP id z2mr2567516wmk.47.1545395418427;
        Fri, 21 Dec 2018 04:30:18 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id v19sm18577564wrd.46.2018.12.21.04.30.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 04:30:17 -0800 (PST)
Date:   Fri, 21 Dec 2018 13:30:15 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] futex fix
Message-ID: <20181221123015.GA66918@gmail.com>
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

   # HEAD: da791a667536bf8322042e38ca85d55a78d3c273 futex: Cure exit race

A single fix for a robust futexes race between sys_exit() and 
sys_futex_lock_pi().

 Thanks,

	Ingo

------------------>
Thomas Gleixner (1):
      futex: Cure exit race


 kernel/futex.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 63 insertions(+), 6 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index f423f9b6577e..5cc8083a4c89 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1148,11 +1148,65 @@ static int attach_to_pi_state(u32 __user *uaddr, u32 uval,
 	return ret;
 }
 
+static int handle_exit_race(u32 __user *uaddr, u32 uval,
+			    struct task_struct *tsk)
+{
+	u32 uval2;
+
+	/*
+	 * If PF_EXITPIDONE is not yet set, then try again.
+	 */
+	if (tsk && !(tsk->flags & PF_EXITPIDONE))
+		return -EAGAIN;
+
+	/*
+	 * Reread the user space value to handle the following situation:
+	 *
+	 * CPU0				CPU1
+	 *
+	 * sys_exit()			sys_futex()
+	 *  do_exit()			 futex_lock_pi()
+	 *                                futex_lock_pi_atomic()
+	 *   exit_signals(tsk)		    No waiters:
+	 *    tsk->flags |= PF_EXITING;	    *uaddr == 0x00000PID
+	 *  mm_release(tsk)		    Set waiter bit
+	 *   exit_robust_list(tsk) {	    *uaddr = 0x80000PID;
+	 *      Set owner died		    attach_to_pi_owner() {
+	 *    *uaddr = 0xC0000000;	     tsk = get_task(PID);
+	 *   }				     if (!tsk->flags & PF_EXITING) {
+	 *  ...				       attach();
+	 *  tsk->flags |= PF_EXITPIDONE;     } else {
+	 *				       if (!(tsk->flags & PF_EXITPIDONE))
+	 *				         return -EAGAIN;
+	 *				       return -ESRCH; <--- FAIL
+	 *				     }
+	 *
+	 * Returning ESRCH unconditionally is wrong here because the
+	 * user space value has been changed by the exiting task.
+	 *
+	 * The same logic applies to the case where the exiting task is
+	 * already gone.
+	 */
+	if (get_futex_value_locked(&uval2, uaddr))
+		return -EFAULT;
+
+	/* If the user space value has changed, try again. */
+	if (uval2 != uval)
+		return -EAGAIN;
+
+	/*
+	 * The exiting task did not have a robust list, the robust list was
+	 * corrupted or the user space value in *uaddr is simply bogus.
+	 * Give up and tell user space.
+	 */
+	return -ESRCH;
+}
+
 /*
  * Lookup the task for the TID provided from user space and attach to
  * it after doing proper sanity checks.
  */
-static int attach_to_pi_owner(u32 uval, union futex_key *key,
+static int attach_to_pi_owner(u32 __user *uaddr, u32 uval, union futex_key *key,
 			      struct futex_pi_state **ps)
 {
 	pid_t pid = uval & FUTEX_TID_MASK;
@@ -1162,12 +1216,15 @@ static int attach_to_pi_owner(u32 uval, union futex_key *key,
 	/*
 	 * We are the first waiter - try to look up the real owner and attach
 	 * the new pi_state to it, but bail out when TID = 0 [1]
+	 *
+	 * The !pid check is paranoid. None of the call sites should end up
+	 * with pid == 0, but better safe than sorry. Let the caller retry
 	 */
 	if (!pid)
-		return -ESRCH;
+		return -EAGAIN;
 	p = find_get_task_by_vpid(pid);
 	if (!p)
-		return -ESRCH;
+		return handle_exit_race(uaddr, uval, NULL);
 
 	if (unlikely(p->flags & PF_KTHREAD)) {
 		put_task_struct(p);
@@ -1187,7 +1244,7 @@ static int attach_to_pi_owner(u32 uval, union futex_key *key,
 		 * set, we know that the task has finished the
 		 * cleanup:
 		 */
-		int ret = (p->flags & PF_EXITPIDONE) ? -ESRCH : -EAGAIN;
+		int ret = handle_exit_race(uaddr, uval, p);
 
 		raw_spin_unlock_irq(&p->pi_lock);
 		put_task_struct(p);
@@ -1244,7 +1301,7 @@ static int lookup_pi_state(u32 __user *uaddr, u32 uval,
 	 * We are the first waiter - try to look up the owner based on
 	 * @uval and attach to it.
 	 */
-	return attach_to_pi_owner(uval, key, ps);
+	return attach_to_pi_owner(uaddr, uval, key, ps);
 }
 
 static int lock_pi_update_atomic(u32 __user *uaddr, u32 uval, u32 newval)
@@ -1352,7 +1409,7 @@ static int futex_lock_pi_atomic(u32 __user *uaddr, struct futex_hash_bucket *hb,
 	 * attach to the owner. If that fails, no harm done, we only
 	 * set the FUTEX_WAITERS bit in the user space variable.
 	 */
-	return attach_to_pi_owner(uval, key, ps);
+	return attach_to_pi_owner(uaddr, newval, key, ps);
 }
 
 /**
