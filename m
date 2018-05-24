Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1886372-1527163748-2-17354878503135265328
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527163747; b=Xxp1UykPZYMZSeLdUes6v7tugsbT8KkSJ963W4AiVPlurHCcTG
    RVc8hDBKiAd4Mb2YU+zxyydXos5keJ7pOXYRpk0XHEnRuT9lIEYi6TLIiTk+YXcZ
    aeYct66O11bkY74eZUGSg+1vmk6f5LVs/Z/ARNlTnSkubgSoSayMFtJ/FZQTrZkI
    IvbVfIwIbOM88+6veP9cTjOn1STC6Kz2aL1/Xh2VAp7A52tdr/+w8V2Z5UjY1LDs
    wPmCrlu7roVgD5FgCOfufLXV6mzmu5pcb+21khYvctezzp2PlcuepLg4VBeygsVg
    zROttQX+YlJxf1v8Gy0Sp6KMbZw7MAObmwqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527163747; bh=K8suFdM8Cut7r4HbawjIxLg/GU4h9i
    wFEDWQhriqIkk=; b=FCZtV2jxeSUh1Fx8C8/qaH1HXkIDKe3hDPvsdwzC4GuilH
    zWuXIuKp0TCk1mrHsl1SZLrSMZM/IA7iBeWgQHqIkqEFk+PUFIA8b/8+A+LQO7l9
    xMqEo9d5KaK6hvhVvHdnEBsJtzxRPlRNLEhNGNEM02VvwLewxqFWGhNxlYyNRkjX
    TKtkwPLuRyICbggp7YHRM1VrMn2Lfu+oNyWprrISGBuTFNPzBmUE+XDXYZcJfwnr
    nIki4Qc19W774eLjBEw5I0TwHFb1mADCPKOr6y7gwMPmuMC6nfJBoDindCIOPDZz
    RmAH3k5V6jwr3US8o/A/bTIERS6royQr3isUTHlg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=REs4J37Y x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=REs4J37Y x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN6q/rOdvyH8APMFOFNQ6fi+RV8I6qSb3nKlItCZJ25nDQ7ftUoovuD6Pl3EyVaSpUvnmKV5PyU2lPyXajrXnAsOU1EBYOaM1FnmWpUA0HTiOmXj8Ou3
    TTHCDIvEpUEmh45DibufYf7qnPHSPqOWLfwHgdLikvLGAtQVTSJWEMezn2ScnwAUeGs0fcBsVv/HQcNny7MTpWHMp42PCb08GVwKvaW75j1xcRuYeDCzIUVz
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=Z4Rwk6OoAAAA:8
    a=1EsaE_6oAAAA:8 a=ag1SF4gXAAAA:8 a=slupqQmDAudJdxUzSA0A:9
    a=ys9DF2YAJlsp0ms6:21 a=IJZE8uwCOMZLE3_G:21 a=QEXdDO2ut3YA:10
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
    a=HkZW87K1Qel5hWWM3VKY:22 a=3ZumFrijQQ-2J9H5h8ct:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966778AbeEXMIo (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 08:08:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966019AbeEXJne (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:43:34 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 24/92] futex: Remove unnecessary warning from get_futex_key
Date: Thu, 24 May 2018 11:38:01 +0200
Message-Id: <20180524093201.292871511@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mel Gorman <mgorman@suse.de>

commit 48fb6f4db940e92cfb16cd878cddd59ea6120d06 upstream.

Commit 65d8fc777f6d ("futex: Remove requirement for lock_page() in
get_futex_key()") removed an unnecessary lock_page() with the
side-effect that page->mapping needed to be treated very carefully.

Two defensive warnings were added in case any assumption was missed and
the first warning assumed a correct application would not alter a
mapping backing a futex key.  Since merging, it has not triggered for
any unexpected case but Mark Rutland reported the following bug
triggering due to the first warning.

  kernel BUG at kernel/futex.c:679!
  Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
  Modules linked in:
  CPU: 0 PID: 3695 Comm: syz-executor1 Not tainted 4.13.0-rc3-00020-g307fec773ba3 #3
  Hardware name: linux,dummy-virt (DT)
  task: ffff80001e271780 task.stack: ffff000010908000
  PC is at get_futex_key+0x6a4/0xcf0 kernel/futex.c:679
  LR is at get_futex_key+0x6a4/0xcf0 kernel/futex.c:679
  pc : [<ffff00000821ac14>] lr : [<ffff00000821ac14>] pstate: 80000145

The fact that it's a bug instead of a warning was due to an unrelated
arm64 problem, but the warning itself triggered because the underlying
mapping changed.

This is an application issue but from a kernel perspective it's a
recoverable situation and the warning is unnecessary so this patch
removes the warning.  The warning may potentially be triggered with the
following test program from Mark although it may be necessary to adjust
NR_FUTEX_THREADS to be a value smaller than the number of CPUs in the
system.

    #include <linux/futex.h>
    #include <pthread.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include <sys/mman.h>
    #include <sys/syscall.h>
    #include <sys/time.h>
    #include <unistd.h>

    #define NR_FUTEX_THREADS 16
    pthread_t threads[NR_FUTEX_THREADS];

    void *mem;

    #define MEM_PROT  (PROT_READ | PROT_WRITE)
    #define MEM_SIZE  65536

    static int futex_wrapper(int *uaddr, int op, int val,
                             const struct timespec *timeout,
                             int *uaddr2, int val3)
    {
        syscall(SYS_futex, uaddr, op, val, timeout, uaddr2, val3);
    }

    void *poll_futex(void *unused)
    {
        for (;;) {
            futex_wrapper(mem, FUTEX_CMP_REQUEUE_PI, 1, NULL, mem + 4, 1);
        }
    }

    int main(int argc, char *argv[])
    {
        int i;

        mem = mmap(NULL, MEM_SIZE, MEM_PROT,
               MAP_SHARED | MAP_ANONYMOUS, -1, 0);

        printf("Mapping @ %p\n", mem);

        printf("Creating futex threads...\n");

        for (i = 0; i < NR_FUTEX_THREADS; i++)
            pthread_create(&threads[i], NULL, poll_futex, NULL);

        printf("Flipping mapping...\n");
        for (;;) {
            mmap(mem, MEM_SIZE, MEM_PROT,
                 MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1, 0);
        }

        return 0;
    }

Reported-and-tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Mel Gorman <mgorman@suse.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org # 4.7+
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/futex.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -666,13 +666,14 @@ again:
 		 * this reference was taken by ihold under the page lock
 		 * pinning the inode in place so i_lock was unnecessary. The
 		 * only way for this check to fail is if the inode was
-		 * truncated in parallel so warn for now if this happens.
+		 * truncated in parallel which is almost certainly an
+		 * application bug. In such a case, just retry.
 		 *
 		 * We are not calling into get_futex_key_refs() in file-backed
 		 * cases, therefore a successful atomic_inc return below will
 		 * guarantee that get_futex_key() will still imply smp_mb(); (B).
 		 */
-		if (WARN_ON_ONCE(!atomic_inc_not_zero(&inode->i_count))) {
+		if (!atomic_inc_not_zero(&inode->i_count)) {
 			rcu_read_unlock();
 			put_page(page_head);
 
