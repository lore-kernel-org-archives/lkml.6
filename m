Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1376423-1526531772-2-15112928792013989768
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526531772; b=d3WM7LTs2PhnrhHVlNouN5TO3stmGsV48KIFiNs0DQF+l6JyDF
    urhx1XWa79z4jWYWmr8+12hW8cPEYobKeZVG15+u2Ge32YEJLwIPbD0UrItqF7fy
    JtsMNEoU1R68KLv6vFg+9puFtT9R372pPRlEFOQZM3j68HORDe1TedcI58lMZBe9
    AscF5VUHYZVP8G3RQMWSPoUAcRKmyluIQ6RU50LiBjGJgIfUO0rou5fqv1ftHXy5
    RYWak3uPdyDKwOqCA9JaCapxxVfiX6tbD9StRU2EtAJ38ebBu+dZz6A5V1M9Nu3/
    vdAgHn1aOVAnU4EGf7HlNFOezUPpoeZg9b5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526531772; bh=
    /voFbP6mJW8vvbwSoOdnhR9mMWUgZuzAgS6EOBHoY+w=; b=Bbqe5uDd+29TZwSA
    VaAgYLxv7ItsoVxROIV9MgvzHVng3WY/Xl/OwkszsU7QQ5yoJStIJYwWtBRP6l9w
    BbSWMUc0ZXfjvCmOI/RyyRewc5YXwJzMARHoO4MsV9wH4PQ9MMFNkJDF77K8Oytt
    GMVOnHqg11etIk6PZrLc+KGgj2FmuRHKa/6c0b3KMgN1+pEKkkH3Zgm0ui/pU+WA
    ni6uOI5J4cNMWOZpRsJZEVrbH0ZqTta1mFBOEgrCZmBDRAUz9/hnq8+NJadyk+N0
    MwJGF+zvhvsEpZMET2YeyeK/uYUPBwzuhosZXG03Y+J4/0HwMuYxBFhIdET7vy6Q
    vAmw6g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=RiC6hQQ9 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=eIZl9In1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=RiC6hQQ9 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=eIZl9In1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPQ52ABjJ8SUn62dJnY/uNUWXCMXuy0myVJysB1y988LRr3nqP8Omujo94thp7ng687FpsJQdUQP4zWynrfBEi7HS9x1aANLmfxMFEZemDPDLThsu3CR
    lC+NLVfzew82J/D6rravs6XEujR2244M9zrs6jl0EfdF+zBZJdz19jOPnZAo2y/MgkeFzlKvGR8bbmbCuvjaDlfVgM5e9RgELOQsPhBNb1C/HsLWx+QIsPmC
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=Z4Rwk6OoAAAA:8 a=1VKGSEjmpg4MURoCSicA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751665AbeEQEfD (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 00:35:03 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:45868 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeEQEe7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 17 May 2018 00:34:59 -0400
X-Google-Smtp-Source: AB8JxZr4Gc8WfriEY+4avXEbhE0AQa0velBEqTHOBy/YLPyBG0EDdN3saSQGuiJbRWdkiSsz+jbK8g==
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        kernel-team@fb.com, csmall@enc.com.au, Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/6] proc: Don't allow empty /proc/PID/cmdline for user tasks
Date: Wed, 16 May 2018 21:34:43 -0700
Message-Id: <20180517043448.3152269-2-tj@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180517043448.3152269-1-tj@kernel.org>
References: <20180517043448.3152269-1-tj@kernel.org>
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
 fs/proc/base.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 1b2ede6..2eee4d7 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -224,9 +224,10 @@ static ssize_t proc_pid_cmdline_read(struct file *file, char __user *buf,
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
@@ -367,8 +368,23 @@ static ssize_t proc_pid_cmdline_read(struct file *file, char __user *buf,
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
 
-- 
2.9.5

