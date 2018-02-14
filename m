Return-Path: <keescook@chromium.org>
X-Cyrus-Session-Id: sloti22d1t05-3714631-1518638816-5-15650173831003044408
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H3 -0.01,
  RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='74.125.83.65', Host='mail-pg0-f65.google.com', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: keescook@chromium.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518638814; b=P1ON4t+9iKwZwjc4eYO6wbM0PQ8vgl0EOgyzaYIbptnrzdA
    qfQ7Lnxek0MUvYDLmf8HfoG6UAgBz5ZhU8dXVMTDse9aXr+lZ9Lrqg/90nsvTGTT
    GR5tD5VLKD3KznTJb6nzdQemKVztdEkBOtPF/v1GSYBlwfJQ+G8PrmVNjQbXkbS6
    gtPp/90QQD5icGWxHq30HDM85AFlmQ6GGinzHQC4XNPkUSNJKJIsqam38y79V81A
    4b8Egvk1asPDm3lm7XcT7Wbq4z9K11dtq4Y4E/5/1KtY+odnPQam4DZlcfhuqxoP
    yh3P+r+PLW93UdU86gxwBZvgw79zQhvA+FwUlHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references; s=arctest; t=1518638814; bh=LA7EJPmUwG9
    z/MnqwEBDBqi6ej4N+VzeN4FDY1vnsBY=; b=K11TY39gwY8ts/X3WoVXvQUdHfD
    U/ifDp9fj/pstaW66L8Q09Z39uQIf0w8qLMzAS+r0514lO9vFYl1TzOy7gmdWWGn
    lzZ26uu5d1uPTASHe3mrTVvn7Bj5pTFN6/eRyG22XMJ5RHoFdsI5lBYD5UGDa0WU
    cFd5NZ3Vr5ctePjtwT9WIFMARHJhjDtd8+Wkr9bVSIPRcCNtgj9D4dkPsHXsQvW9
    vRAhl6Y7G5A8+HTGwpNMSy7CKXdBI1WwK1E+1IZBHbL2UbpAPNK556PbUZsxb4bR
    /p7q1x7HjvGbGkB2YdpXZBE/v+w9JFGGCUNlaIVBgbeOfBW9rEFvIe/nvNA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=bwO9TWvW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=74.125.83.65 (mail-pg0-f65.google.com);
    spf=pass smtp.mailfrom=keescook@chromium.org smtp.helo=mail-pg0-f65.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SertIZpl;
    x-ptr=pass x-ptr-helo=mail-pg0-f65.google.com x-ptr-lookup=mail-pg0-f65.google.com;
    x-return-mx=pass smtp.domain=chromium.org smtp.result=pass smtp_is_org_domain=yes header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=bwO9TWvW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=74.125.83.65 (mail-pg0-f65.google.com);
    spf=pass smtp.mailfrom=keescook@chromium.org smtp.helo=mail-pg0-f65.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SertIZpl;
    x-ptr=pass x-ptr-helo=mail-pg0-f65.google.com x-ptr-lookup=mail-pg0-f65.google.com;
    x-return-mx=pass smtp.domain=chromium.org smtp.result=pass smtp_is_org_domain=yes header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x225aylc27OIApTBx4GZ19HovIEBn1agExyGpHV8ENUI8tbjJrrrLJCk5TahFHLtwxwo9wxN42w==
From: Kees Cook <keescook@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Ben Hutchings <ben@decadent.org.uk>,
	Willy Tarreau <w@1wt.eu>,
	Hugh Dickins <hughd@google.com>,
	Oleg Nesterov <oleg@redhat.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Rik van Riel <riel@redhat.com>,
	Laura Abbott <labbott@redhat.com>,
	Greg KH <greg@kroah.com>,
	Andy Lutomirski <luto@kernel.org>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Subject: [PATCH 3/3] exec: Pin stack limit during exec
Date: Wed, 14 Feb 2018 12:06:36 -0800
Message-Id: <1518638796-20819-4-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518638796-20819-1-git-send-email-keescook@chromium.org>
References: <1518638796-20819-1-git-send-email-keescook@chromium.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Since the stack rlimit is used in multiple places during exec and
it can be changed via other threads (via setrlimit()) or processes
(via prlimit()), the assumption that the value doesn't change cannot
be made. This leads to races with mm layout selection and argument size
calculations. This changes the exec path to use the rlimit stored in bprm
instead of in current. Before starting the thread, the bprm stack rlimit
is stored back to current.

Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Reported-by: Andy Lutomirski <luto@kernel.org>
Reported-by: Brad Spengler <spender@grsecurity.net>
Fixes: 64701dee4178e ("exec: Use sane stack rlimit under secureexec")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/exec.c               | 27 +++++++++++++++------------
 include/linux/binfmts.h |  2 ++
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index e4ae20ff6278..806936ad9387 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -257,7 +257,7 @@ static struct page *get_arg_page(struct linux_binprm *bprm, unsigned long pos,
 		 *    to work from.
 		 */
 		limit = _STK_LIM / 4 * 3;
-		limit = min(limit, rlimit(RLIMIT_STACK) / 4);
+		limit = min(limit, bprm->rlim_stack.rlim_cur / 4);
 		if (size > limit)
 			goto fail;
 	}
@@ -411,6 +411,11 @@ static int bprm_mm_init(struct linux_binprm *bprm)
 	if (!mm)
 		goto err;
 
+	/* Save current stack limit for all calculations made during exec. */
+	task_lock(current->group_leader);
+	bprm->rlim_stack = current->signal->rlim[RLIMIT_STACK];
+	task_unlock(current->group_leader);
+
 	err = __bprm_mm_init(bprm);
 	if (err)
 		goto err;
@@ -697,7 +702,7 @@ int setup_arg_pages(struct linux_binprm *bprm,
 
 #ifdef CONFIG_STACK_GROWSUP
 	/* Limit stack size */
-	stack_base = rlimit_max(RLIMIT_STACK);
+	stack_base = bprm->rlim_stack.rlim_max;
 	if (stack_base > STACK_SIZE_MAX)
 		stack_base = STACK_SIZE_MAX;
 
@@ -770,7 +775,7 @@ int setup_arg_pages(struct linux_binprm *bprm,
 	 * Align this down to a page boundary as expand_stack
 	 * will align it up.
 	 */
-	rlim_stack = rlimit(RLIMIT_STACK) & PAGE_MASK;
+	rlim_stack = bprm->rlim_stack.rlim_cur & PAGE_MASK;
 #ifdef CONFIG_STACK_GROWSUP
 	if (stack_size + stack_expand > rlim_stack)
 		stack_base = vma->vm_start + rlim_stack;
@@ -1323,8 +1328,6 @@ EXPORT_SYMBOL(would_dump);
 
 void setup_new_exec(struct linux_binprm * bprm)
 {
-	struct rlimit rlim_stack;
-
 	/*
 	 * Once here, prepare_binrpm() will not be called any more, so
 	 * the final state of setuid/setgid/fscaps can be merged into the
@@ -1343,15 +1346,11 @@ void setup_new_exec(struct linux_binprm * bprm)
 		 * RLIMIT_STACK, but after the point of no return to avoid
 		 * needing to clean up the change on failure.
 		 */
-		if (current->signal->rlim[RLIMIT_STACK].rlim_cur > _STK_LIM)
-			current->signal->rlim[RLIMIT_STACK].rlim_cur = _STK_LIM;
+		if (bprm->rlim_stack.rlim_cur > _STK_LIM)
+			bprm->rlim_stack.rlim_cur = _STK_LIM;
 	}
 
-	task_lock(current->group_leader);
-	rlim_stack = current->signal->rlim[RLIMIT_STACK];
-	task_unlock(current->group_leader);
-
-	arch_pick_mmap_layout(current->mm, &rlim_stack);
+	arch_pick_mmap_layout(current->mm, &bprm->rlim_stack);
 
 	current->sas_ss_sp = current->sas_ss_size = 0;
 
@@ -1387,6 +1386,10 @@ EXPORT_SYMBOL(setup_new_exec);
 /* Runs immediately before start_thread() takes over. */
 void finalize_exec(struct linux_binprm *bprm)
 {
+	/* Store any stack rlimit changes before starting thread. */
+	task_lock(current->group_leader);
+	current->signal->rlim[RLIMIT_STACK] = bprm->rlim_stack;
+	task_unlock(current->group_leader);
 }
 EXPORT_SYMBOL(finalize_exec);
 
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 40e52afbb2b0..4955e0863b83 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -61,6 +61,8 @@ struct linux_binprm {
 	unsigned interp_flags;
 	unsigned interp_data;
 	unsigned long loader, exec;
+
+	struct rlimit rlim_stack; /* Saved RLIMIT_STACK used during exec. */
 } __randomize_layout;
 
 #define BINPRM_FLAGS_ENFORCE_NONDUMP_BIT 0
-- 
2.7.4
