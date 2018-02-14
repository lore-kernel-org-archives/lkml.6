Return-Path: <keescook@chromium.org>
X-Cyrus-Session-Id: sloti22d1t05-3714631-1518638816-8-17158025470864920587
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H3 -0.01,
  RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.160.68', Host='mail-pl0-f68.google.com', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: keescook@chromium.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518638816; b=eVfckVSMEILXqHB/d8QCOsV9F4IqhxrLyAKO5SAc0IPPMvX
    GRu2n8/3eHQoWUD36IBJG+4eoQ9hfqMkrsBdZyYSf5Norz78Z6f0Jt7ze3vXugpG
    sSnxvcWbtH9P72mdmOpF0thypjnr8SRBOr7cokrA3X6TNdLr3IjNS4GJSRgAtqZ1
    Y4d+mi3twecKXqjfrDhmcH6s8iLa9Ta/TTFFqS0NJdFswYVajzpSq1C9yBQqQVUi
    hTx/yG8aRHlG63vim4D2xtV/QG0lXIHGp4Tb/0K3/iKpgma+DN6Vtispv53KkcAl
    fyyMeJVzwhsUDPLwx5SiVfHMv0r5U2AaxILmH6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references; s=arctest; t=1518638816; bh=rXFAN8U6MUR
    2Ms1O38JAINd4/CR3pDfFKafU1ChRMiA=; b=qiB1iaeOulj+jc49T/NaT9EVWK3
    nDqMBN/tR+x2aggIy2M7F2a7ovDdGJTSiRmOmX3wmEdj5tta/9vB23jfcDmCua8k
    RZclK0xf+JnYFgEUtRYwCMghUsleiSPR4lSPdpp1A/nV9aOOtN1rLI9YMnpgwj5t
    MPsYdDsbBE3w8k3RQIp7Zsy5/0xLal9IXbv38x06qQx4I374HQ5ZfS2Wzd4WxWKP
    jqskzoPCTHgiIJSBKuhvJBoxDjVdGdgKspaFRmlo0EkaEH7F5Kdk1i68Qatduf/G
    hfRVWhplbge5JoICrcB9D66pQFkrluXEGeQ8C1bxvG0P5CUVHGDlDJEwNSQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=L1rbVTWK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.85.160.68 (mail-pl0-f68.google.com);
    spf=pass smtp.mailfrom=keescook@chromium.org smtp.helo=mail-pl0-f68.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=t6yw1lCC;
    x-ptr=pass x-ptr-helo=mail-pl0-f68.google.com x-ptr-lookup=mail-pl0-f68.google.com;
    x-return-mx=pass smtp.domain=chromium.org smtp.result=pass smtp_is_org_domain=yes header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=L1rbVTWK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.85.160.68 (mail-pl0-f68.google.com);
    spf=pass smtp.mailfrom=keescook@chromium.org smtp.helo=mail-pl0-f68.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=t6yw1lCC;
    x-ptr=pass x-ptr-helo=mail-pl0-f68.google.com x-ptr-lookup=mail-pl0-f68.google.com;
    x-return-mx=pass smtp.domain=chromium.org smtp.result=pass smtp_is_org_domain=yes header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x227I31bID5Y34ljArxOf3c4WKSwwXWgn3S3IAKCMr9z5TQoVYaRI15+U4tI+DM7kBrTeJTm3MQ==
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
Subject: [PATCH 2/3] exec: Introduce finalize_exec() before start_thread()
Date: Wed, 14 Feb 2018 12:06:35 -0800
Message-Id: <1518638796-20819-3-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518638796-20819-1-git-send-email-keescook@chromium.org>
References: <1518638796-20819-1-git-send-email-keescook@chromium.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Provide a final call back into fs/exec.c before start_thread() takes
over, to handle any last-minute changes, like the coming restoration of
the stack limit.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
As an alternative, fs/exec.c could provide a wrapper for start_thread()...
---
 fs/binfmt_aout.c        | 1 +
 fs/binfmt_elf.c         | 1 +
 fs/binfmt_elf_fdpic.c   | 1 +
 fs/binfmt_flat.c        | 1 +
 fs/exec.c               | 6 ++++++
 include/linux/binfmts.h | 1 +
 6 files changed, 11 insertions(+)

diff --git a/fs/binfmt_aout.c b/fs/binfmt_aout.c
index ce1824f47ba6..c3deb2e35f20 100644
--- a/fs/binfmt_aout.c
+++ b/fs/binfmt_aout.c
@@ -330,6 +330,7 @@ static int load_aout_binary(struct linux_binprm * bprm)
 #ifdef __alpha__
 	regs->gp = ex.a_gpvalue;
 #endif
+	finalize_exec(bprm);
 	start_thread(regs, ex.a_entry, current->mm->start_stack);
 	return 0;
 }
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index bdb201230bae..3edca6cb9a33 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1155,6 +1155,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	ELF_PLAT_INIT(regs, reloc_func_desc);
 #endif
 
+	finalize_exec(bprm);
 	start_thread(regs, elf_entry, bprm->p);
 	retval = 0;
 out:
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 429326b6e2e7..d90993adeffa 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -463,6 +463,7 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 			    dynaddr);
 #endif
 
+	finalize_exec(bprm);
 	/* everything is now ready... get the userspace context ready to roll */
 	entryaddr = interp_params.entry_addr ?: exec_params.entry_addr;
 	start_thread(regs, entryaddr, current->mm->start_stack);
diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index 5d6b94475f27..82a48e830018 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -994,6 +994,7 @@ static int load_flat_binary(struct linux_binprm *bprm)
 	FLAT_PLAT_INIT(regs);
 #endif
 
+	finalize_exec(bprm);
 	pr_debug("start_thread(regs=0x%p, entry=0x%lx, start_stack=0x%lx)\n",
 		 regs, start_addr, current->mm->start_stack);
 	start_thread(regs, start_addr, current->mm->start_stack);
diff --git a/fs/exec.c b/fs/exec.c
index 7074913ad2e7..e4ae20ff6278 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1384,6 +1384,12 @@ void setup_new_exec(struct linux_binprm * bprm)
 }
 EXPORT_SYMBOL(setup_new_exec);
 
+/* Runs immediately before start_thread() takes over. */
+void finalize_exec(struct linux_binprm *bprm)
+{
+}
+EXPORT_SYMBOL(finalize_exec);
+
 /*
  * Prepare credentials and lock ->cred_guard_mutex.
  * install_exec_creds() commits the new creds and drops the lock.
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index b0abe21d6cc9..40e52afbb2b0 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -118,6 +118,7 @@ extern int __must_check remove_arg_zero(struct linux_binprm *);
 extern int search_binary_handler(struct linux_binprm *);
 extern int flush_old_exec(struct linux_binprm * bprm);
 extern void setup_new_exec(struct linux_binprm * bprm);
+extern void finalize_exec(struct linux_binprm *bprm);
 extern void would_dump(struct linux_binprm *, struct file *);
 
 extern int suid_dumpable;
-- 
2.7.4
