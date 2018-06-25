Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DE2C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D2126227
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lQf+Ys1d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D2126227
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755725AbeFYWmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:42:31 -0400
Received: from mail-yb0-f201.google.com ([209.85.213.201]:51226 "EHLO
        mail-yb0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964802AbeFYWmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:42:25 -0400
Received: by mail-yb0-f201.google.com with SMTP id h6-v6so11068145ybm.18
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 15:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=lRn9EQ4qGSeHmfN0semOwuZ4D4PmrhNt/DbyFqDShzo=;
        b=lQf+Ys1d4Spz8xS5uEWO1N0hT/Xp8c0aHLGnjlxPgwQhEDbi3Vrnuycm9LmIFJAzk1
         dpwAT7YaRZG6s7GE25m3EZWvhy5P084W88AP5c3g0duifH2Sk7SHjytjJ/nF7zuhZBkp
         nWkXPYVCSBO02wG9itNus8eAh3PcInot3f0EImi/o/KgmYNTiyTr+/6uh06/nsuSjNSd
         ly5TgyqowwmGDavayTVVBg98HwORAvrpMbNh8qjfD1PR3rXUzVE6+Tgg6lvozU86xCwT
         q2NOorLOgA+aOgN/MEEOH1I8e0ZKIYMh5HBy5EJQb5DlNzp/p2z9JcxRm4+Ek1f5SQK+
         ksew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=lRn9EQ4qGSeHmfN0semOwuZ4D4PmrhNt/DbyFqDShzo=;
        b=T5GC2zPMWRs8LpzJx37YTxnW50J3cZ/doWhDoaQJuUwarSzB83TPZrx7+j11ziy/d7
         FbN8KjT7hNni/Qc/qCN6IXmwOE8i1wFVpKBryIMtNUg119VTrrQ66GTBOaBOP8SsVc7O
         RZGoJPl5pGL+2yV9vhOZuf+u0vhd78sIyQ6kfsaJJlncbcSSH9H7BcOaOthH6+A2Nsyf
         hqwq1WecsfrzOgIhypKczSmf/gKSn52OATp03rEERgAlV0AldR73FMdIoEW4gUXOlKEb
         hUjXgefBAe3XIfpM9QLsBQhwUXorGiAjz1QdMm7bBYkuj7u3vhl8pnn1llsR0w9CJUni
         WTGQ==
X-Gm-Message-State: APt69E1YfEtha3Eoy9OtUMmZH/I6A5WKISCWep9ihbFwpjVexbPlam90
        lqt+3HmCM7ta41AILkMPyoAmj2oLIszVGQ==
X-Google-Smtp-Source: AAOMgpde1GMuNdCsp5JDju0B7L5l3dmx3UBTd7M6+GaFh6vLQ35xVGIoLEyZo9YT1V6v9G+Va0QBtbezd0j7sg==
MIME-Version: 1.0
X-Received: by 2002:a0d:e2c3:: with SMTP id l186-v6mr3689571ywe.91.1529966544863;
 Mon, 25 Jun 2018 15:42:24 -0700 (PDT)
Date:   Mon, 25 Jun 2018 15:39:09 -0700
In-Reply-To: <20180625224014.134829-1-thgarnie@google.com>
Message-Id: <20180625224014.134829-22-thgarnie@google.com>
References: <20180625224014.134829-1-thgarnie@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v5 21/27] x86/ftrace: Adapt function tracing for PIE support
From:   Thomas Garnier <thgarnie@google.com>
To:     kernel-hardening@lists.openwall.com
Cc:     Thomas Garnier <thgarnie@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        James Hogan <jhogan@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        nixiaoming <nixiaoming@huawei.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using PIE with function tracing, the compiler generates a
call through the GOT (call *__fentry__@GOTPCREL). This instruction
takes 6-bytes instead of 5-bytes with a relative call.

If PIE is enabled, replace the 6th byte of the GOT call by a 1-byte nop
so ftrace can handle the previous 5-bytes as before.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 arch/x86/kernel/ftrace.c | 51 +++++++++++++++++++++++++-
 scripts/recordmcount.c   | 79 +++++++++++++++++++++++++++-------------
 2 files changed, 102 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 01ebcb6f263e..2194a5d3e095 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -102,7 +102,7 @@ static const unsigned char *ftrace_nop_replace(void)
 
 static int
 ftrace_modify_code_direct(unsigned long ip, unsigned const char *old_code,
-		   unsigned const char *new_code)
+			  unsigned const char *new_code)
 {
 	unsigned char replaced[MCOUNT_INSN_SIZE];
 
@@ -135,6 +135,53 @@ ftrace_modify_code_direct(unsigned long ip, unsigned const char *old_code,
 	return 0;
 }
 
+/* Bytes before call GOT offset */
+static const unsigned char got_call_preinsn[] = { 0xff, 0x15 };
+
+static int
+ftrace_modify_initial_code(unsigned long ip, unsigned const char *old_code,
+			   unsigned const char *new_code)
+{
+	unsigned char replaced[MCOUNT_INSN_SIZE + 1];
+
+	/*
+	 * If PIE is not enabled default to the original approach to code
+	 * modification.
+	 */
+	if (!IS_ENABLED(CONFIG_X86_PIE))
+		return ftrace_modify_code_direct(ip, old_code, new_code);
+
+	ftrace_expected = old_code;
+
+	/* Ensure the instructions point to a call to the GOT */
+	if (probe_kernel_read(replaced, (void *)ip, sizeof(replaced))) {
+		WARN_ONCE(1, "invalid function");
+		return -EFAULT;
+	}
+
+	if (memcmp(replaced, got_call_preinsn, sizeof(got_call_preinsn))) {
+		WARN_ONCE(1, "invalid function call");
+		return -EINVAL;
+	}
+
+	/*
+	 * Build a nop slide with a 5-byte nop and 1-byte nop to keep the ftrace
+	 * hooking algorithm working with the expected 5 bytes instruction.
+	 */
+	memset(replaced, ideal_nops[1][0], sizeof(replaced));
+	memcpy(replaced, new_code, MCOUNT_INSN_SIZE);
+
+	ip = text_ip_addr(ip);
+
+	if (probe_kernel_write((void *)ip, replaced, sizeof(replaced)))
+		return -EPERM;
+
+	sync_core();
+
+	return 0;
+
+}
+
 int ftrace_make_nop(struct module *mod,
 		    struct dyn_ftrace *rec, unsigned long addr)
 {
@@ -153,7 +200,7 @@ int ftrace_make_nop(struct module *mod,
 	 * just modify the code directly.
 	 */
 	if (addr == MCOUNT_ADDR)
-		return ftrace_modify_code_direct(rec->ip, old, new);
+		return ftrace_modify_initial_code(rec->ip, old, new);
 
 	ftrace_expected = NULL;
 
diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index 895c40e8679f..aa71b912958d 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -171,33 +171,9 @@ umalloc(size_t size)
 	return addr;
 }
 
-static unsigned char ideal_nop5_x86_64[5] = { 0x0f, 0x1f, 0x44, 0x00, 0x00 };
-static unsigned char ideal_nop5_x86_32[5] = { 0x3e, 0x8d, 0x74, 0x26, 0x00 };
-static unsigned char *ideal_nop;
-
 static char rel_type_nop;
-
 static int (*make_nop)(void *map, size_t const offset);
-
-static int make_nop_x86(void *map, size_t const offset)
-{
-	uint32_t *ptr;
-	unsigned char *op;
-
-	/* Confirm we have 0xe8 0x0 0x0 0x0 0x0 */
-	ptr = map + offset;
-	if (*ptr != 0)
-		return -1;
-
-	op = map + offset - 1;
-	if (*op != 0xe8)
-		return -1;
-
-	/* convert to nop */
-	ulseek(fd_map, offset - 1, SEEK_SET);
-	uwrite(fd_map, ideal_nop, 5);
-	return 0;
-}
+static unsigned char *ideal_nop;
 
 static unsigned char ideal_nop4_arm_le[4] = { 0x00, 0x00, 0xa0, 0xe1 }; /* mov r0, r0 */
 static unsigned char ideal_nop4_arm_be[4] = { 0xe1, 0xa0, 0x00, 0x00 }; /* mov r0, r0 */
@@ -447,6 +423,50 @@ static void MIPS64_r_info(Elf64_Rel *const rp, unsigned sym, unsigned type)
 	}).r_info;
 }
 
+static unsigned char ideal_nop5_x86_64[5] = { 0x0f, 0x1f, 0x44, 0x00, 0x00 };
+static unsigned char ideal_nop6_x86_64[6] = { 0x66, 0x0f, 0x1f, 0x44, 0x00, 0x00 };
+static unsigned char ideal_nop5_x86_32[5] = { 0x3e, 0x8d, 0x74, 0x26, 0x00 };
+static size_t ideal_nop_x86_size;
+
+static unsigned char stub_default_x86[2] = { 0xe8, 0x00 };   /* call relative */
+static unsigned char stub_got_x86[3] = { 0xff, 0x15, 0x00 }; /* call .got */
+static unsigned char *stub_x86;
+static size_t stub_x86_size;
+
+static int make_nop_x86(void *map, size_t const offset)
+{
+	uint32_t *ptr;
+	size_t stub_offset = offset - stub_x86_size;
+
+	/* confirm we have the expected stub */
+	ptr = map + stub_offset;
+	if (memcmp(ptr, stub_x86, stub_x86_size)) {
+		return -1;
+	}
+
+	/* convert to nop */
+	ulseek(fd_map, stub_offset, SEEK_SET);
+	uwrite(fd_map, ideal_nop, ideal_nop_x86_size);
+	return 0;
+}
+
+/* Swap the stub and nop for a got call if the binary is built with PIE */
+static int is_fake_mcount_x86_x64(Elf64_Rel const *rp)
+{
+	if (ELF64_R_TYPE(rp->r_info) == R_X86_64_GOTPCREL) {
+		ideal_nop = ideal_nop6_x86_64;
+		ideal_nop_x86_size = sizeof(ideal_nop6_x86_64);
+		stub_x86 = stub_got_x86;
+		stub_x86_size = sizeof(stub_got_x86);
+		mcount_adjust_64 = 1 - stub_x86_size;
+	}
+
+	/* Once the relocation was checked, rollback to default */
+	is_fake_mcount64 = fn_is_fake_mcount64;
+	return is_fake_mcount64(rp);
+}
+
+
 static void
 do_file(char const *const fname)
 {
@@ -509,6 +529,9 @@ do_file(char const *const fname)
 		rel_type_nop = R_386_NONE;
 		make_nop = make_nop_x86;
 		ideal_nop = ideal_nop5_x86_32;
+		ideal_nop_x86_size = sizeof(ideal_nop5_x86_32);
+		stub_x86 = stub_default_x86;
+		stub_x86_size = sizeof(stub_default_x86);
 		mcount_adjust_32 = -1;
 		break;
 	case EM_ARM:	 reltype = R_ARM_ABS32;
@@ -533,9 +556,13 @@ do_file(char const *const fname)
 	case EM_X86_64:
 		make_nop = make_nop_x86;
 		ideal_nop = ideal_nop5_x86_64;
+		ideal_nop_x86_size = sizeof(ideal_nop5_x86_64);
+		stub_x86 = stub_default_x86;
+		stub_x86_size = sizeof(stub_default_x86);
 		reltype = R_X86_64_64;
 		rel_type_nop = R_X86_64_NONE;
-		mcount_adjust_64 = -1;
+		is_fake_mcount64 = is_fake_mcount_x86_x64;
+		mcount_adjust_64 = 1 - stub_x86_size;
 		break;
 	}  /* end switch */
 
-- 
2.18.0.rc2.346.g013aa6912e-goog

