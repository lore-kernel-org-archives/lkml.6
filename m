Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226oARUxEebGiB+yVOgvbMXBXTdzrEM6I0VR41fsOLykf3rgewnoTiZ/2UwMiX7WkDLM0grA
ARC-Seal: i=1; a=rsa-sha256; t=1519217794; cv=none;
        d=google.com; s=arc-20160816;
        b=ksZPSYkUAjOTrZmlvpFEw++lrkD0tau2jhc/xxjVlhGxxzs9VjGOpk86tcUOY0gLeN
         wNhh0XpDHGwVgFJYZKpBJIKcicHQG6/m6nWaKpN670Rv7ak1AGA6NF7h3Wh6FDK/h/Go
         JSxEcjrvuBQJJwqwTj4PyJ+sWlDj7Fjk3xIrFQRWXizZ4lw//iTDJFLeIF3PNO2Ri6yS
         YrLgG3Bv5Mi6zSkuJoI08xfL+UatlzaS6lZj22jTVdyCoVUCIX6lvDGCaNFySCwy1lh2
         NV/w8VCEqk1Xb0OOlJ+bAm9b1pthnZJ55733z4kuL2gbyf/4YVi4M1esQ9bnyDt1uOZT
         VDDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6MdcRUcwWqKbOQmF725ABrbD8S7td8dsUX7YOg2JONA=;
        b=PV9kv5MtakyDjIbP4RHA8QrQqQ6CHVT0QYHv219hFjZvv7musFITxU9N996Y4oUI5L
         CnDlH0J5Ye6QZYl7b1sHorEzF+2qDcX4hTq8HdAhF7rqcuMILvjIGAB63zSO17oxQaXd
         LYsxHdsBAH3Cmr2ZEzp86G8Qtkqb3FbKaHZCV4R3tMXh4sFBAyomF+qk+ev0fgvOaYRw
         fdiZ+gzeV6xc/fuICICls4VE1mp5Cax5l2YZ6bXwi+6g9lHrLR+N3m2EvnlWeh+S/OH8
         E+i9uepejVzARf20gcFBK+OtdjEyV2BW2Zbuua03J5F/kqsmFYPIbFcKG1Ayenk1xVk7
         sSSA==
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
Subject: [PATCH 4.9 56/77] x86/speculation: Clean up various Spectre related details
Date: Wed, 21 Feb 2018 13:49:05 +0100
Message-Id: <20180221124434.575054820@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015317807560579?=
X-GMAIL-MSGID: =?utf-8?q?1593015317807560579?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -161,8 +161,7 @@ static enum spectre_v2_mitigation_cmd __
 	if (cmdline_find_option_bool(boot_command_line, "nospectre_v2"))
 		return SPECTRE_V2_CMD_NONE;
 	else {
-		ret = cmdline_find_option(boot_command_line, "spectre_v2", arg,
-					  sizeof(arg));
+		ret = cmdline_find_option(boot_command_line, "spectre_v2", arg, sizeof(arg));
 		if (ret < 0)
 			return SPECTRE_V2_CMD_AUTO;
 
@@ -174,8 +173,7 @@ static enum spectre_v2_mitigation_cmd __
 		}
 
 		if (i >= ARRAY_SIZE(mitigation_options)) {
-			pr_err("unknown option (%s). Switching to AUTO select\n",
-			       mitigation_options[i].option);
+			pr_err("unknown option (%s). Switching to AUTO select\n", mitigation_options[i].option);
 			return SPECTRE_V2_CMD_AUTO;
 		}
 	}
@@ -184,8 +182,7 @@ static enum spectre_v2_mitigation_cmd __
 	     cmd == SPECTRE_V2_CMD_RETPOLINE_AMD ||
 	     cmd == SPECTRE_V2_CMD_RETPOLINE_GENERIC) &&
 	    !IS_ENABLED(CONFIG_RETPOLINE)) {
-		pr_err("%s selected but not compiled in. Switching to AUTO select\n",
-		       mitigation_options[i].option);
+		pr_err("%s selected but not compiled in. Switching to AUTO select\n", mitigation_options[i].option);
 		return SPECTRE_V2_CMD_AUTO;
 	}
 
@@ -255,14 +252,14 @@ static void __init spectre_v2_select_mit
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
@@ -280,7 +277,7 @@ retpoline_auto:
 	pr_info("%s\n", spectre_v2_strings[mode]);
 
 	/*
-	 * If neither SMEP or KPTI are available, there is a risk of
+	 * If neither SMEP nor PTI are available, there is a risk of
 	 * hitting userspace addresses in the RSB after a context switch
 	 * from a shallow call stack to a deeper one. To prevent this fill
 	 * the entire RSB, even when using IBRS.
@@ -294,21 +291,20 @@ retpoline_auto:
 	if ((!boot_cpu_has(X86_FEATURE_KAISER) &&
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
@@ -317,16 +313,14 @@ ssize_t cpu_show_meltdown(struct device
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
