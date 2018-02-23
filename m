Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvJPKASV26rnueT8ICtcUOrs7/txEKAMXeRuL9jwo0cqQ42a8y24rdk+yX3ACoWdxGooRY3
ARC-Seal: i=1; a=rsa-sha256; t=1519410956; cv=none;
        d=google.com; s=arc-20160816;
        b=XcHrbojIAv2DtogRUE+7yoLlvrKc8s36IkTSIV2ZjAevA7o2tvYS1iqGOgP9tjNlbh
         jArHbCJK1LjOSePieMk4T+ZgAb64jIUGi9bj7chzWJAMdzVU2tgV10751a1AlWfNJKiZ
         Hr7Ij4OpaE6ScUxiDbgtqefseMdPp0IWoHIiExId3UTkyGQNl0CGdkZabzCTViQAOv2e
         Auos71wRJtqfmgrHhjpbjrFcpj4kBZpGmiVtuu3aqko2Yd3qBv1XhC3EqAkMY15WyJPC
         jRUEoif8G8j7b2ia86KJG+/k3q6RTJ6MqH6bXusf8Xty2a1rr/0Qxc4uGfAgkJOC4dp4
         +jKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VF95gGtQir1geGeq9pyYk3dSk66hWyHhju/6qmBQZIs=;
        b=DKv7fRYbtfSuqn+AXoVanb5Q7ppmYQX2VSgUzsz7EPezqy6Ghe7VdIN7o4Dyzt3nNA
         v3FTO/GGJ/q+YXdelIRStqwzCG0sj2bCzRr4NAUslixZ7bJhhccrsN8/rSCCmR8DjQ3g
         yBsI1nGF2Cz2YBPJmtepnVg4DRjD+6Z/7whJQI8q0gPEfjjCyD36wU+d2pUtmzkbpUo2
         C8ApFCZuTkjzTLHERVAgz7/xvjXCfoRVQy6TD+mAKqbQS1UxQTVSng6PvH429k6kAxFU
         yewaiQo2NNTS4IVRNZMbz/hmvTvLXgrNQmqtaE83b/+94Q7+TWWkO0hjYVKwAs3+g9uz
         0xbQ==
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
Subject: [PATCH 4.4 069/193] x86/ras/inject: Make it depend on X86_LOCAL_APIC=y
Date: Fri, 23 Feb 2018 19:25:02 +0100
Message-Id: <20180223170336.756832745@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217862812726856?=
X-GMAIL-MSGID: =?utf-8?q?1593217862812726856?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1009,7 +1009,7 @@ config X86_MCE_THRESHOLD
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
@@ -193,9 +192,7 @@ static void raise_mce(struct mce *m)
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
