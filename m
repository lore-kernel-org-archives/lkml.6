Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1433061-1527346325-2-3009325063141125682
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527346325; b=A0UxGSdXsJUEmkPZoO9iqULARbWqzkZS/XlWV3E7YfyWvI6gJx
    0oDd6wAjtC9lnLMzlTj1ZrCHTahCy2I/SkV6rmwCHCB8lXPyIMw5vsHrVyfNjyy1
    GHEcL7JGx8zb8gif8Ah0yyAJ1ss+i9SbnRXnScFwXadtIr8D8wzYGkUwwEgpbOW0
    Rz1jVANoG6JmBte8h8VxSFKZhCc/DPp6ziVWxhExvLAILdiYo7ENzzpEIqMfJcce
    R8A3qGOdTaqlTPz0ozjCPR803NqxOKNEVzSNw88HnhMsCiIP5rBbBYp1AnJXKIrf
    BwLBEE9iLqbNBZGz/elaPyXxRIihxNnSCvFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1527346325; bh=TMS1yJR56Xnmm+9yv1ZW/BF3VLu8BF
    XkKTwcVjBT5BI=; b=lZAQXHaNMnaUgxPxX8Ytj3a1+bc+293JUAHXHKjuSLuaFA
    +epPlfv1rayaS7jDaBqCbjkQqvP2sxzKfILnVbh7gfDoWMQucklcFaSmtgj6WnIn
    gJm2XhyijmDmNwnjWM5XGNfkRrWhAqEvMzPPkzD3SAcavQ1ifaS+HKCLqlR9pITs
    C1NwKi2PlWgOi+ztsPOHQy3Cft6DsqCWYhksNsoTM+iHi+lHP37BhOKmzC/V1nkJ
    AFbdToJgtQhifMROjtEpF0BOaN0CMCNt4qlmzKL96ehcSawS0J2x9WCz428i+uBM
    u2KrEwHUeZbeFpgl8cbJcLfeD27zHpTaiNZ0vO9Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=amhVAVdm x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=LQD52hmq;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=amhVAVdm x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=LQD52hmq;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFcx2An+zZtvASC90f8oqs9HpjGQjZ7Atao5pfr9taMefc/LvArhLXd5+qTPNGAJGl+zxZrOvFuE+GYqhMZKxaLmWcivv+F/l4HYDiog4jiUKRwKv1Rn
    a2LC02EtuHDJBjhWG3W6K4ydhq7kwcmziyLkfcNR81KHm/RxzDc2dH/lEYdnuNFnDDTlj7cVoBIAyL1EDLDVtODWAITlcPj56fp/g8D0Xikduam67lbuYocH
    9L/zymrYL8sTrJ/FMWy4gQ==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=8r6i9kuyV-oA:10
    a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=BTVdrXGKk-GX6iRifyYA:9
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031790AbeEZOvH (ORCPT <rfc822;linux@kroah.com>);
        Sat, 26 May 2018 10:51:07 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52461 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031779AbeEZOvG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 26 May 2018 10:51:06 -0400
X-Google-Smtp-Source: AB8JxZpI70kIaDfx2zeQp74N1Uws4eSWwa1+Z6S2l/N7BhtggKwUrtaUM1ThT4lWvQfNFrmAIcvtdw==
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
To: kernel-hardening@lists.openwall.com
Cc: linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] proc: prevent a task from writing on its own /proc/*/mem
Date: Sat, 26 May 2018 16:50:46 +0200
Message-Id: <1527346246-1334-1-git-send-email-s.mesoraca16@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Prevent a task from opening, in "write" mode, any /proc/*/mem
file that operates on the task's mm.
/proc/*/mem is mainly a debugging means and, as such, it shouldn't
be used by the inspected process itself.
Current implementation always allow a task to access its own
/proc/*/mem file.
A process can use it to overwrite read-only memory, making
pointless the use of security_file_mprotect() or other ways to
enforce RO memory.

Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
---
 fs/proc/base.c       | 25 ++++++++++++++++++-------
 fs/proc/internal.h   |  3 ++-
 fs/proc/task_mmu.c   |  4 ++--
 fs/proc/task_nommu.c |  2 +-
 4 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 1a76d75..01ecfec 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -762,8 +762,9 @@ static int proc_single_open(struct inode *inode, struct file *filp)
 	.release	= single_release,
 };
 
-
-struct mm_struct *proc_mem_open(struct inode *inode, unsigned int mode)
+struct mm_struct *proc_mem_open(struct inode *inode,
+				unsigned int mode,
+				fmode_t f_mode)
 {
 	struct task_struct *task = get_proc_task(inode);
 	struct mm_struct *mm = ERR_PTR(-ESRCH);
@@ -773,10 +774,20 @@ struct mm_struct *proc_mem_open(struct inode *inode, unsigned int mode)
 		put_task_struct(task);
 
 		if (!IS_ERR_OR_NULL(mm)) {
-			/* ensure this mm_struct can't be freed */
-			mmgrab(mm);
-			/* but do not pin its memory */
-			mmput(mm);
+			/*
+			 * Prevent this interface from being used as a mean
+			 * to bypass memory restrictions, including those
+			 * imposed by LSMs.
+			 */
+			if (mm == current->mm &&
+			    f_mode & FMODE_WRITE)
+				mm = ERR_PTR(-EACCES);
+			else {
+				/* ensure this mm_struct can't be freed */
+				mmgrab(mm);
+				/* but do not pin its memory */
+				mmput(mm);
+			}
 		}
 	}
 
@@ -785,7 +796,7 @@ struct mm_struct *proc_mem_open(struct inode *inode, unsigned int mode)
 
 static int __mem_open(struct inode *inode, struct file *file, unsigned int mode)
 {
-	struct mm_struct *mm = proc_mem_open(inode, mode);
+	struct mm_struct *mm = proc_mem_open(inode, mode, file->f_mode);
 
 	if (IS_ERR(mm))
 		return PTR_ERR(mm);
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 0f1692e..8d38cc7 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -275,7 +275,8 @@ struct proc_maps_private {
 #endif
 } __randomize_layout;
 
-struct mm_struct *proc_mem_open(struct inode *inode, unsigned int mode);
+struct mm_struct *proc_mem_open(struct inode *inode, unsigned int mode,
+				fmode_t f_mode);
 
 extern const struct file_operations proc_pid_maps_operations;
 extern const struct file_operations proc_tid_maps_operations;
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index c486ad4..efb6535 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -227,7 +227,7 @@ static int proc_maps_open(struct inode *inode, struct file *file,
 		return -ENOMEM;
 
 	priv->inode = inode;
-	priv->mm = proc_mem_open(inode, PTRACE_MODE_READ);
+	priv->mm = proc_mem_open(inode, PTRACE_MODE_READ, file->f_mode);
 	if (IS_ERR(priv->mm)) {
 		int err = PTR_ERR(priv->mm);
 
@@ -1534,7 +1534,7 @@ static int pagemap_open(struct inode *inode, struct file *file)
 {
 	struct mm_struct *mm;
 
-	mm = proc_mem_open(inode, PTRACE_MODE_READ);
+	mm = proc_mem_open(inode, PTRACE_MODE_READ, file->f_mode);
 	if (IS_ERR(mm))
 		return PTR_ERR(mm);
 	file->private_data = mm;
diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
index 5b62f57..dc38516 100644
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -280,7 +280,7 @@ static int maps_open(struct inode *inode, struct file *file,
 		return -ENOMEM;
 
 	priv->inode = inode;
-	priv->mm = proc_mem_open(inode, PTRACE_MODE_READ);
+	priv->mm = proc_mem_open(inode, PTRACE_MODE_READ, file->f_mode);
 	if (IS_ERR(priv->mm)) {
 		int err = PTR_ERR(priv->mm);
 
-- 
1.9.1

