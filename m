Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49w49tt3YogYLtD8Kfe9ig3Dq9aaFgv96lZi9KpvUQdUayrAxYsyC59+HLhw5SUuyr+Sazy
ARC-Seal: i=1; a=rsa-sha256; t=1523399446; cv=none;
        d=google.com; s=arc-20160816;
        b=C0EjimXk7ZvWo62SYXwEn+npg82OvYL0+wz/9KrJR9OpvPaWpjj8xHOz6W8XeTDdam
         N4OGlA6tQy9Y5mdLP2H0oUr/sqiI+nY5U0oSTIn3JG4OFnU1tPfoUpB3kI4JmAfpI6g/
         IcSlRwLv16kksNugtQDSpFpRC+j4GOrsWh/unxV7axsRCPQv2dleyWBVkwMTDT/dNIp3
         HVQH/7R4hiwOPp9g5TfsKmfZYCUDzudt9MjzfVG8rd7otfd2cY6I5KSMBtlLDgPVxi+R
         K9CYWBpbEuBEWe2jt1sxYJWcRe1Yx5AJDF2/4WBvvFYIOM5NmjRF0W4rdyo1GA/mQMOv
         qsdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0hBx04s4eaJRK/e9PiAsVdFcTxxmJD6IUwITVcTmZDw=;
        b=s5qTc7W0LnqHmo3HMDJvV0hE+vEoHB5wAdfUgd+qFfuCEgEiq7QNg7or0kWu4GPyHS
         TRydTaR0RBinrucM0dyuHWajGwz1nbPnqsOiz8uBkKagE8rxaZJ5ZMRtTHsNhBNmRt6n
         ObjG7iKrj5k7Wvf0MygddsbK9qCOz0jx5G0aaHsbjrIwo25Msk3NuMqYsD0AMZ4KCJm5
         SEWmwzHYg9R2njkKEAgIEe26YaQM73o6s2iUxfDbDMskITzyvPI2j9hsFka4vWQQDn7w
         6gBLc6vHA0ByD96TS7EoUZ2Dw10N1vJo0AkAhKVt9MQRKemlnRTUbb0iJ6tfIpx2/reE
         OJEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ashok Raj <ashok.raj@intel.com>,
	Borislav Petkov <bp@suse.de>,
	Andy Lutomirski <luto@kernel.org>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.15 110/168] x86/CPU: Add a microcode loader callback
Date: Wed, 11 Apr 2018 00:24:12 +0200
Message-Id: <20180410212804.937372528@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400097812019407?=
X-GMAIL-MSGID: =?utf-8?q?1597400097812019407?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit 1008c52c09dcb23d93f8e0ea83a6246265d2cce0 upstream.

Add a callback function which the microcode loader calls when microcode
has been updated to a newer revision. Do the callback only when no error
was encountered during loading.

Tested-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180216112640.11554-3-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/processor.h     |    1 +
 arch/x86/kernel/cpu/common.c         |   10 ++++++++++
 arch/x86/kernel/cpu/microcode/core.c |    8 ++++++--
 3 files changed, 17 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -969,4 +969,5 @@ bool xen_set_default_idle(void);
 
 void stop_this_cpu(void *dummy);
 void df_debug(struct pt_regs *regs, long error_code);
+void microcode_check(void);
 #endif /* _ASM_X86_PROCESSOR_H */
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1749,3 +1749,13 @@ static int __init init_cpu_syscore(void)
 	return 0;
 }
 core_initcall(init_cpu_syscore);
+
+/*
+ * The microcode loader calls this upon late microcode load to recheck features,
+ * only when microcode has been updated. Caller holds microcode_mutex and CPU
+ * hotplug lock.
+ */
+void microcode_check(void)
+{
+	perf_check_microcode();
+}
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -509,6 +509,7 @@ static ssize_t reload_store(struct devic
 			    const char *buf, size_t size)
 {
 	enum ucode_state tmp_ret = UCODE_OK;
+	bool do_callback = false;
 	unsigned long val;
 	ssize_t ret = 0;
 	int cpu;
@@ -531,10 +532,13 @@ static ssize_t reload_store(struct devic
 			if (!ret)
 				ret = -EINVAL;
 		}
+
+		if (tmp_ret == UCODE_UPDATED)
+			do_callback = true;
 	}
 
-	if (!ret && tmp_ret == UCODE_UPDATED)
-		perf_check_microcode();
+	if (!ret && do_callback)
+		microcode_check();
 
 	mutex_unlock(&microcode_mutex);
 	put_online_cpus();
