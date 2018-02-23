Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226WpDfgmiThXq9LycZHzq56M0AuKxgkzZYwlNis75G2bT5xzMEY2haBFYjhGNwCOM7C6HX5
ARC-Seal: i=1; a=rsa-sha256; t=1519411616; cv=none;
        d=google.com; s=arc-20160816;
        b=k0rzJukws/8UNjtLl4lWHV7G+Kgb4TcGzEfoKUowrteUeph8H7rA0MUl2t1JXjOrJh
         t1sm2mtCTF9m0qejwpbp4kKOoGD55iuc+9F5/sjf24Ani5CygpLpZ530d3gHkdnD/ciM
         Dcd7egr1wICjNuVyFd79XLtwEudIJGJrZzAbI5Np8fRaUzU6PvL53HfWDQPpAWLAkGVk
         LKeb9VT59WrQ3xjh4rK4xVmE+E6zkBpP/EDYRYIaoe7pT7LBF3rErs2SguXCuB6TY9rX
         1P4cb1h+l7HmRdjHphKGm1PtXKQs/If6zAdKABtdIjVGvUowSE8KuYAs/c8ctSfL+bHI
         Bb1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nCDuSEDRjKkncHNSBTa8VnVt+tnixk4xHNxXTUF/5+o=;
        b=s2+HZdrKrGipOxRKjVSuxfhNCWkzYjCmmwIUNKTbao3TXHFDfnxFnEfFrIQpmkTkVt
         DRHvgsSkZLlIgnkAngCOKk2/OwMspJvvZ8Z4xeNbOM0RlUgmz8+SyHVIaS2TK0Q8jhMc
         mS/u8+wbeEXwH22hO2UoG81OhWqKvY43mxUKLM8aY3hj3rpEK+pfebFPZXqV3k7LTA0H
         N4rN4inyai1MRmI3AEEjMKH8SPEnorQImObNCrmmdFq3X3k/NEyQE+ipb7WdLxJvYXRb
         xcVRf40eDeYgF+gDA9bvdBMTOhH9cCDCyWs0L9tqvvzF11GzkEznCQvKAo7y/sqNERSI
         ltBg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tony Luck <tony.luck@intel.com>,
	Yazen Ghannam <Yazen.Ghannam@amd.com>,
	linux-edac <linux-edac@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 104/145] x86/ras/inject: Make it depend on X86_LOCAL_APIC=y
Date: Fri, 23 Feb 2018 19:26:50 +0100
Message-Id: <20180223170738.240335474@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217862812726856?=
X-GMAIL-MSGID: =?utf-8?q?1593218555743937418?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit d4b2ac63b0eae461fc10c9791084be24724ef57a upstream.

... and get rid of the annoying:

  arch/x86/kernel/cpu/mcheck/mce-inject.c:97:13: warning: ‘mce_irq_ipi’ defined but not used [-Wunused-function]

when doing randconfig builds.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Link: http://lkml.kernel.org/r/20170123183514.13356-2-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/Kconfig                        |    2 +-
 arch/x86/kernel/cpu/mcheck/mce-inject.c |    5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1057,7 +1057,7 @@ config X86_MCE_THRESHOLD
 	def_bool y
 
 config X86_MCE_INJECT
-	depends on X86_MCE
+	depends on X86_MCE && X86_LOCAL_APIC
 	tristate "Machine check injector support"
 	---help---
 	  Provide support for injecting machine checks for testing purposes.
--- a/arch/x86/kernel/cpu/mcheck/mce-inject.c
+++ b/arch/x86/kernel/cpu/mcheck/mce-inject.c
@@ -152,7 +152,6 @@ static void raise_mce(struct mce *m)
 	if (context == MCJ_CTX_RANDOM)
 		return;
 
-#ifdef CONFIG_X86_LOCAL_APIC
 	if (m->inject_flags & (MCJ_IRQ_BROADCAST | MCJ_NMI_BROADCAST)) {
 		unsigned long start;
 		int cpu;
@@ -192,9 +191,7 @@ static void raise_mce(struct mce *m)
 		raise_local();
 		put_cpu();
 		put_online_cpus();
-	} else
-#endif
-	{
+	} else {
 		preempt_disable();
 		raise_local();
 		preempt_enable();
