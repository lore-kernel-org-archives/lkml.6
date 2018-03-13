Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsLLKc/ufUYihwVEOE8Yg8jgPD4VY1S/1EHNMJdN5wSFD4FwOD9/AN+RcEcpbPwuBOINWFh
ARC-Seal: i=1; a=rsa-sha256; t=1520955045; cv=none;
        d=google.com; s=arc-20160816;
        b=cGnLgmxSKLb3rsYN1OcTJ7UTV6AM2xA5zq69d7dj8fTZdegQ6FQKXiNd/NmhKFeFJ0
         LwKqLD8gCJxGLk3mtrLq9mxgl6RBh69pal8pTz0uDA8wyoCj5wG1owNRzaeha10ch/MW
         8UAIOrAqvLLc4ZKuTaKR3Q3H7eaoTO+vDRZqVBkBqBWhoZHOlTO14bxxr8UVxqijOEPY
         Jl/eRzC9E7QRLYFopH90P2tHn5AqSdy5e4OSDIYwXZFuA6JYKHtOdIrM+y37ZFwCGj1b
         UfadfL/Ql4pzkyGaRD4oK03MaZhgHpA8SCeK3uhdeodpPI6HR4VY6NJJi8Ry3/SfSEGO
         umrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qUdM0u6sCnQKT6bh+catMSGQ9YU74HAvqk2nrohjaOQ=;
        b=V/Y4dp7VzuUw1MSzyhJeZ/03BJptc7NNBPf+SUz6rfPGvdHO9GHK3f4lE4qZcOBBEa
         TrhHMlTf/yuoovw2nlPG8pWthchiOVO2G3/S/P4kET6RiLv9268AK/krMKLKmVFYT9p2
         f6FY6+XC00B+XYloaQZfQFAC2g4CWEzNq3GWo2a8XTLz/dld1HnRntUGegL5pTzg6uiZ
         xS+mD5krVmygpez7QFPSH+DzSYmwDSHOEzK8HQ9jzOBhZWtDWDSyF6XKQe6GsQiY8IsD
         Gq7OHRAdaL3bNP2ClozIvDOA2DnTQPzWMIRNM/tdbNEei9BKvzJJYudC/2C1yi1nSlII
         QDMw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Richard Weinberger <richard.weinberger@gmail.com>
Subject: [PATCH 4.15 046/146] bug: use %pB in BUG and stack protector failure
Date: Tue, 13 Mar 2018 16:23:33 +0100
Message-Id: <20180313152324.186566555@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836957898376024?=
X-GMAIL-MSGID: =?utf-8?q?1594836957898376024?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit 0862ca422b79cb5aa70823ee0f07f6b468f86070 upstream.

The BUG and stack protector reports were still using a raw %p.  This
changes it to %pB for more meaningful output.

Link: http://lkml.kernel.org/r/20180301225704.GA34198@beast
Fixes: ad67b74d2469 ("printk: hash addresses printed with %p")
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Richard Weinberger <richard.weinberger@gmail.com>,
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/panic.c |    2 +-
 lib/bug.c      |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -640,7 +640,7 @@ device_initcall(register_warn_debugfs);
  */
 __visible void __stack_chk_fail(void)
 {
-	panic("stack-protector: Kernel stack is corrupted in: %p\n",
+	panic("stack-protector: Kernel stack is corrupted in: %pB\n",
 		__builtin_return_address(0));
 }
 EXPORT_SYMBOL(__stack_chk_fail);
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -191,7 +191,7 @@ enum bug_trap_type report_bug(unsigned l
 	if (file)
 		pr_crit("kernel BUG at %s:%u!\n", file, line);
 	else
-		pr_crit("Kernel BUG at %p [verbose debug info unavailable]\n",
+		pr_crit("Kernel BUG at %pB [verbose debug info unavailable]\n",
 			(void *)bugaddr);
 
 	return BUG_TRAP_TYPE_BUG;
