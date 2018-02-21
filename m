Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2268gtO9pe2nkD1R18PBtFWTA4F/Z5ZPdkW35/IkOVCx/0LyXSxUKmc1kHrCQTclP+3tRNfi
ARC-Seal: i=1; a=rsa-sha256; t=1519218483; cv=none;
        d=google.com; s=arc-20160816;
        b=iXc78OCGCumV5ge19/CqsqfpnCcClV3YiEffBxwB01bjDJcRRYjWyzU2YII3K2VHC5
         GM1ASOH7sJL5WRqavR6lSBpgB3D9B0M3HkHcY1+mnomJ2panMyGjgEET7mTflnW4WFpC
         RWAOI3lHt3/YvhEIBedRNFyRx6skgTiVr6jIST5SEkFh3y5i74R+w0fhwWQJis326N1G
         mypTKVUT5A4T9eizXGgWNMdTdcKDzOaARh2nnptOi8PxGPjFG6jFik8vzbzTTKsPy8tG
         ilaiDlrntysz5xHKz/mTIkBNYYnxPOhhIotVZv084ZT8B2W/RgBpgsiVoVAkIOgSGVTd
         NeQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=x6g0mvIDsnZb/tj1AmOqehcz23oBE9dkRwE66IAT2uk=;
        b=H929FzE6TWZVz5YBPAtRgLk5UvYxiW669esPkT+thmJVMXQ/0iNuxJhlwKy6MIcdDW
         H7vzMiscML36SJfP5zX9CKFTECTahTuSBaGXuTVRCLy7Hxlr+cg0eoJtNBXJm5vFi27K
         g9sPXOOIwB+zv4jjqBT7NLyzckVKed1hHVWneFAS0awVArLUNkM7molrbgTwT+S3eHiS
         ZyscVVZ/q/+T1E12cfpm7dZEno7tvkYL+gFDVw3lbFEO44Crcg3usMcT8vT7hQfAPg0S
         mktzEwjReMD9w4EX4dKo/zjlc+9vuEeN1Kr7JWpg5Wbgu7T67PoVMLTa6jO+qUE9uUhQ
         YV/Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Woodhouse <dwmw@amazon.co.uk>,
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
Subject: [PATCH 4.15 054/163] x86/speculation: Clean up various Spectre related details
Date: Wed, 21 Feb 2018 13:48:03 +0100
Message-Id: <20180221124533.450391058@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015317807560579?=
X-GMAIL-MSGID: =?utf-8?q?1593016041124802902?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ingo Molnar <mingo@kernel.org>

commit 21e433bdb95bdf3aa48226fd3d33af608437f293 upstream.

Harmonize all the Spectre messages so that a:

    dmesg | grep -i spectre

... gives us most Spectre related kernel boot messages.

Also fix a few other details:

 - clarify a comment about firmware speculation control

 - s/KPTI/PTI

 - remove various line-breaks that made the code uglier

Acked-by: David Woodhouse <dwmw@amazon.co.uk>
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
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/bugs.c |   28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -162,8 +162,7 @@ static enum spectre_v2_mitigation_cmd __
 	if (cmdline_find_option_bool(boot_command_line, "nospectre_v2"))
 		return SPECTRE_V2_CMD_NONE;
 	else {
-		ret = cmdline_find_option(boot_command_line, "spectre_v2", arg,
-					  sizeof(arg));
+		ret = cmdline_find_option(boot_command_line, "spectre_v2", arg, sizeof(arg));
 		if (ret < 0)
 			return SPECTRE_V2_CMD_AUTO;
 
@@ -175,8 +174,7 @@ static enum spectre_v2_mitigation_cmd __
 		}
 
 		if (i >= ARRAY_SIZE(mitigation_options)) {
-			pr_err("unknown option (%s). Switching to AUTO select\n",
-			       mitigation_options[i].option);
+			pr_err("unknown option (%s). Switching to AUTO select\n", mitigation_options[i].option);
 			return SPECTRE_V2_CMD_AUTO;
 		}
 	}
@@ -185,8 +183,7 @@ static enum spectre_v2_mitigation_cmd __
 	     cmd == SPECTRE_V2_CMD_RETPOLINE_AMD ||
 	     cmd == SPECTRE_V2_CMD_RETPOLINE_GENERIC) &&
 	    !IS_ENABLED(CONFIG_RETPOLINE)) {
-		pr_err("%s selected but not compiled in. Switching to AUTO select\n",
-		       mitigation_options[i].option);
+		pr_err("%s selected but not compiled in. Switching to AUTO select\n", mitigation_options[i].option);
 		return SPECTRE_V2_CMD_AUTO;
 	}
 
@@ -256,14 +253,14 @@ static void __init spectre_v2_select_mit
 			goto retpoline_auto;
 		break;
 	}
-	pr_err("kernel not compiled with retpoline; no mitigation available!");
+	pr_err("Spectre mitigation: kernel not compiled with retpoline; no mitigation available!");
 	return;
 
 retpoline_auto:
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
 	retpoline_amd:
 		if (!boot_cpu_has(X86_FEATURE_LFENCE_RDTSC)) {
-			pr_err("LFENCE not serializing. Switching to generic retpoline\n");
+			pr_err("Spectre mitigation: LFENCE not serializing, switching to generic retpoline\n");
 			goto retpoline_generic;
 		}
 		mode = retp_compiler() ? SPECTRE_V2_RETPOLINE_AMD :
@@ -281,7 +278,7 @@ retpoline_auto:
 	pr_info("%s\n", spectre_v2_strings[mode]);
 
 	/*
-	 * If neither SMEP or KPTI are available, there is a risk of
+	 * If neither SMEP nor PTI are available, there is a risk of
 	 * hitting userspace addresses in the RSB after a context switch
 	 * from a shallow call stack to a deeper one. To prevent this fill
 	 * the entire RSB, even when using IBRS.
@@ -295,21 +292,20 @@ retpoline_auto:
 	if ((!boot_cpu_has(X86_FEATURE_PTI) &&
 	     !boot_cpu_has(X86_FEATURE_SMEP)) || is_skylake_era()) {
 		setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
-		pr_info("Filling RSB on context switch\n");
+		pr_info("Spectre v2 mitigation: Filling RSB on context switch\n");
 	}
 
 	/* Initialize Indirect Branch Prediction Barrier if supported */
 	if (boot_cpu_has(X86_FEATURE_IBPB)) {
 		setup_force_cpu_cap(X86_FEATURE_USE_IBPB);
-		pr_info("Enabling Indirect Branch Prediction Barrier\n");
+		pr_info("Spectre v2 mitigation: Enabling Indirect Branch Prediction Barrier\n");
 	}
 }
 
 #undef pr_fmt
 
 #ifdef CONFIG_SYSFS
-ssize_t cpu_show_meltdown(struct device *dev,
-			  struct device_attribute *attr, char *buf)
+ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	if (!boot_cpu_has_bug(X86_BUG_CPU_MELTDOWN))
 		return sprintf(buf, "Not affected\n");
@@ -318,16 +314,14 @@ ssize_t cpu_show_meltdown(struct device
 	return sprintf(buf, "Vulnerable\n");
 }
 
-ssize_t cpu_show_spectre_v1(struct device *dev,
-			    struct device_attribute *attr, char *buf)
+ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1))
 		return sprintf(buf, "Not affected\n");
 	return sprintf(buf, "Mitigation: __user pointer sanitization\n");
 }
 
-ssize_t cpu_show_spectre_v2(struct device *dev,
-			    struct device_attribute *attr, char *buf)
+ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
 		return sprintf(buf, "Not affected\n");
