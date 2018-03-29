Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AIpwx48forTCQZl/226c3gmoL4XpSUEQcaBtQ4uC8Sd8FcSaMDprzgjISzhRlUn0junf4ur0QxSG
ARC-Seal: i=1; a=rsa-sha256; t=1522297643; cv=none;
        d=google.com; s=arc-20160816;
        b=x87IuLLuwGq9/aoDyy7BdFOGQljQJj9ZYR69uX89W0EhYGpVml0SmmG1Kgp10ZEfth
         Bb0QFksu9RrY7uzMlwDMJRO28qJ/9j/Py1oJhtRm00GfKSD0C7PNazKILXVOmJQYO5tz
         nzzj4Kohs5TTRx3XawG8DbhMAiIGmDsBAH9Zro4YdqmHh2xHKKHSM9xz7lHDfw/yuVlK
         ZfEmSJZRjIPob3gmafseK95fG8YsnR79Ri7+nMveNkyhKtcJdLXLIE7vtjFdyzoy1NB+
         kKCA5KwpBd99XiADIvJJAz1WchUKn1iTDsniM5596gsJ5z7OGjuSbnagD6NpnaulF4VT
         AY/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=XknVV4H+uBJ/TVSllaBdukppiSVz9ruwj0iR51eTNyU=;
        b=re11ph7tz0s/B8i8pCfoJSvxq6Ti80fA1W+4/JkVImceTW2vcIk/aN40RuZHpX6ZZx
         2XynEsmuXuCvjYGclsgXZxC+zpIAROl75YazzIVP0RXf9KcvO2E3QciiVEzgy/SKrpfj
         T7Ff7eGgHFqrCfnUgGY2gWw2yqiht8DuO8OIy88Ckd1VSeVMWnH2pI9KSI9C4sjH1hD2
         z1qG3mzlJKFrm6nt2DpQ808qoMmKqtmh1TnUK7TmuXQeOfYoZ2bYgLHfVqFovDyHjVgf
         9yPtMsWJm+peHUJ00wT1m4IlmKhSKNQgf8Ug+lbes/OyMcYYBhh/jz3KuQMQwnOT2JKy
         fNtw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Thu, 29 Mar 2018 15:26:48 +1100
Subject: [PATCH 02/17] staging: lustre: remove unused
 ldlm_completion_ast_async()
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152229760829.27689.12680083968318847851.stgit@noble>
In-Reply-To: <152229732768.27689.4800156943561963977.stgit@noble>
References: <152229732768.27689.4800156943561963977.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596244774179791010?=
X-GMAIL-MSGID: =?utf-8?q?1596244774179791010?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This function is unused.

Signed-off-by: NeilBrown <neilb@suse.com>
Reviewed-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/lustre/include/lustre_dlm.h |    1 -
 drivers/staging/lustre/lustre/ldlm/ldlm_request.c  |   23 --------------------
 2 files changed, 24 deletions(-)

diff --git a/drivers/staging/lustre/lustre/include/lustre_dlm.h b/drivers/staging/lustre/lustre/include/lustre_dlm.h
index 239aa2b1268f..7407acf60cf8 100644
--- a/drivers/staging/lustre/lustre/include/lustre_dlm.h
+++ b/drivers/staging/lustre/lustre/include/lustre_dlm.h
@@ -1227,7 +1227,6 @@ int ldlm_lock_change_resource(struct ldlm_namespace *, struct ldlm_lock *,
  * processing.
  * @{
  */
-int ldlm_completion_ast_async(struct ldlm_lock *lock, __u64 flags, void *data);
 int ldlm_completion_ast(struct ldlm_lock *lock, __u64 flags, void *data);
 /** @} ldlm_local_ast */
 
diff --git a/drivers/staging/lustre/lustre/ldlm/ldlm_request.c b/drivers/staging/lustre/lustre/ldlm/ldlm_request.c
index c3c9186b74ce..be43958e4090 100644
--- a/drivers/staging/lustre/lustre/ldlm/ldlm_request.c
+++ b/drivers/staging/lustre/lustre/ldlm/ldlm_request.c
@@ -191,29 +191,6 @@ static int ldlm_completion_tail(struct ldlm_lock *lock, void *data)
 	return result;
 }
 
-/**
- * Implementation of ->l_completion_ast() for a client, that doesn't wait
- * until lock is granted. Suitable for locks enqueued through ptlrpcd, of
- * other threads that cannot block for long.
- */
-int ldlm_completion_ast_async(struct ldlm_lock *lock, __u64 flags, void *data)
-{
-	if (flags == LDLM_FL_WAIT_NOREPROC) {
-		LDLM_DEBUG(lock, "client-side enqueue waiting on pending lock");
-		return 0;
-	}
-
-	if (!(flags & LDLM_FL_BLOCKED_MASK)) {
-		wake_up(&lock->l_waitq);
-		return ldlm_completion_tail(lock, data);
-	}
-
-	LDLM_DEBUG(lock,
-		   "client-side enqueue returned a blocked lock, going forward");
-	return 0;
-}
-EXPORT_SYMBOL(ldlm_completion_ast_async);
-
 /**
  * Generic LDLM "completion" AST. This is called in several cases:
  *
