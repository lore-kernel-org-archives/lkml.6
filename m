Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1127333-1526520118-2-4146050090668755820
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526520118; b=nS27rhe3dskcNFw3cQSoUd9XLbVPS4JKTOBsLMypf1RwVSf4CB
    H60GmaDtfCSqlkB3TLdIJlCpu+e8FJzAEVnyNbCr/4VipWiU1NpBz3if+OUnk8J6
    +FR/3ULgH/byJkdv9qRDgF4+P8RcHe9uUeqwFiQxJu+ZDwYLVJVU3EHqf2ERrylL
    53ipAMPsqSJv0qS601Wv8ewxIqhRbzdaDKPXXsMg5fzGPdhDduIQDYqfUVpUBuYz
    qiIJ2NcC9ZSzKa0IwZuxIRipsM0aZw50J5RV/3aZt1aEidRMIFlqCWveMhQ49+jc
    N2mRjSEpqk4AN96KE/YFa6kuMvn+NRT7Zjlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1526520118;
    bh=PnuaRU4zWl+RJBTVrfrpX6aq7Zixqz+Oq8QGKuiM5qk=; b=SAZhlNnvpTSt
    LYOHoLoTCA0Zj0bLk55VOgOaeTYkUu95+whFVc87GBVtZ4n8txYiIDlhrJl6ZKIw
    O2p6n5JJgCkoSEt0xxSreqDYqGddEFdb12tVM5iJhKTi24aQ3gGYhf1Kl9TB5bw9
    Dv4zHzruff0nOwh8CO7BTHIyKs/PlCh/rfUkGoaSoIydv2UHfRLmfYqFWJM3/vBt
    WSpsFXJhI+th66r2csNzTH4Lr5NXjBNtY7guX/7lkjuiHHY8+D4yZm4qlTpRzK1g
    BYh+8twgjJgkKR8Ju042hgD2TM1FxzeKQeZNDrNKo/zAocU0Oafto6GlmXRKIWqb
    dflLWCkt3w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=QISPCrdH x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=J5Nc+CYL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=QISPCrdH x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=J5Nc+CYL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEXrXDDzxLB1WJK0IoJBk1lji8kHgo/7YsrFQDj1SjmdDpgxU5FK8lRizPqB+3AKbRkhTrZeLnjOqCBv0i8BGPvYF4s2IOTbNi4WqfT30y/mCZBiKpec
    ddL6DFwvXgHnggX8sv2q/po14eApa4yLUX0yOMXpOjxq0lMG2+Oor1bMbwu311D+9RM+Uwuz5sLwp2yp143a9t/7YK2VEuk8LG0vbCMj/0AzINB+F1RO3Vj9
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=Z4Rwk6OoAAAA:8 a=Q6ehVHM7z4IfRtXPAvsA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751312AbeEQBVy (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 21:21:54 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:42259 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751290AbeEQBVx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 16 May 2018 21:21:53 -0400
X-Google-Smtp-Source: AB8JxZor0QQwm+gI3CjxZ8stNkI2npOwmYU3JFjJPEhwvNZ5m+6qNzT6xoc8/FJHj5eEyxcadMmF7A==
Date: Wed, 16 May 2018 18:21:49 -0700
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel-team <kernel-team@fb.com>,
        Lennart Poettering <lennart@poettering.net>
Subject: [PATCH] proc: Don't allow empty /proc/PID/cmdline for user tasks
Message-ID: <20180517012149.GA1718769@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Kernel threads have empty /proc/PID/cmdline and some userland tools
including ps(1) and older versions of systemd use this to detect
kernel threads.  However, any userland program can emulate the
behavior by making its argvs unavailable and trick the affected tools
into thinking that the task is a kernel thread.  Linus's reproducer
follows.

  #include <sys/prctl.h>
  #include <sys/mman.h>

  int main(void)
  {
	  char empty[16384];
	  unsigned long ptr;

	  asm volatile("" :"=r" (ptr) : "0" (empty):"memory");
	  ptr = (ptr+4095) & ~4095;
	  munmap((void *)ptr, 32768);

	  sleep(1000);
	  return 0;
  }

Compiling the above program into nullcmdline and running it on an
unpatche kernel shows the following behavior.

  $ ./nullcmdline &
  [1] 2382031
  [devbig577 ~/tmp]$ hexdump -C /proc/2382031/comm
  00000000  6e 75 6c 6c 63 6d 64 6c  69 6e 65 0a              |nullcmdline.|
  0000000c
  $ hexdump -C /proc/2382031/cmdline
  $ ps 2382031
      PID TTY      STAT   TIME COMMAND
  2382031 pts/2    S      0:00 [nullcmdline]

The empty cmdline makes ps(1) think that nullcmdline is a kernel
thread and put brackets around its name (comm), which is mostly a
nuisance but it's possible that this confusion can lead to more
harmful confusions.

This patch fixes the issue by making proc_pid_cmdline_read() never
return empty string for user tasks.  If the result is empty for
whatever reason, comm string is returned.  Even when the comm string
is empty, it still returns the null termnation character.  On a
patched kernel, running the same command as above gives us.

  $ ./nullcmdline &
  [1] 2317
  [test ~]# hexdump -C /proc/2317/comm
  00000000  6e 75 6c 6c 63 6d 64 6c  69 6e 65 0a              |nullcmdline.|
  0000000c
  $ hexdump -C /proc/2317/cmdline
  00000000  6e 75 6c 6c 63 6d 64 6c  69 6e 65 00              |nullcmdline.|
  0000000c
  $ ps 2317
    PID TTY      STAT   TIME COMMAND
   2317 pts/0    S      0:00 nullcmdline

Note that cmdline is a dup of comm and ps(1) is no longer confused.

Signed-off-by: Tejun Heo <tj@kernel.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
---
Hello,

Linus, this patch is somewhat different from the rest of workqueue
changes and it could make sense to apply separately, so please feel
free to apply directly.  If you want it to be routed together with the
other workqueue changes, please let me know.

Thanks.

 fs/proc/base.c |   22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -224,9 +224,10 @@ static ssize_t proc_pid_cmdline_read(str
 	if (!tsk)
 		return -ESRCH;
 	mm = get_task_mm(tsk);
-	put_task_struct(tsk);
-	if (!mm)
-		return 0;
+	if (!mm) {
+		rv = 0;
+		goto out_put_task;
+	}
 	/* Check if process spawned far enough to have cmdline. */
 	if (!mm->env_end) {
 		rv = 0;
@@ -367,8 +368,23 @@ out_free_page:
 	free_page((unsigned long)page);
 out_mmput:
 	mmput(mm);
+out_put_task:
+	/*
+	 * Some userland tools use empty cmdline to distinguish kthreads.
+	 * Avoid empty cmdline for user tasks by returning tsk->comm with
+	 * \0 termination when empty.
+	 */
+	if (*pos == 0 && rv == 0 && !(tsk->flags & PF_KTHREAD)) {
+		char tcomm[TASK_COMM_LEN];
+
+		get_task_comm(tcomm, tsk);
+		rv = min(strlen(tcomm) + 1, count);
+		if (copy_to_user(buf, tsk->comm, rv))
+			rv = -EFAULT;
+	}
 	if (rv > 0)
 		*pos += rv;
+	put_task_struct(tsk);
 	return rv;
 }
 
