Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2E2C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A14E2208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A14E2208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966142AbeFRI0V (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:26:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57222 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966044AbeFRI0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:26:14 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 690BBC9D;
        Mon, 18 Jun 2018 08:26:13 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Francis Deslauriers <francis.deslauriers@efficios.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Yonghong Song <yhs@fb.com>,
        Borislav Petkov <bp@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 233/279] objtool, kprobes/x86: Sync the latest <asm/insn.h> header with tools/objtool/arch/x86/include/asm/insn.h
Date:   Mon, 18 Jun 2018 10:13:38 +0200
Message-Id: <20180618080618.457548198@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ingo Molnar <mingo@kernel.org>

[ Upstream commit 4fe875e4bd3cae85ae6f6eaf77f63fabe613b66e ]

The following commit:

  ee6a7354a362: kprobes/x86: Prohibit probing on exception masking instructions

Modified <asm/insn.h>, adding the insn_masking_exception() function.

Sync the tooling version of the header to it, to fix this warning:

  Warning: synced file at 'tools/objtool/arch/x86/include/asm/insn.h' differs from latest kernel version at 'arch/x86/include/asm/insn.h'

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Francis Deslauriers <francis.deslauriers@efficios.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Yonghong Song <yhs@fb.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "David S . Miller" <davem@davemloft.net>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/objtool/arch/x86/include/asm/insn.h |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--- a/tools/objtool/arch/x86/include/asm/insn.h
+++ b/tools/objtool/arch/x86/include/asm/insn.h
@@ -208,4 +208,22 @@ static inline int insn_offset_immediate(
 	return insn_offset_displacement(insn) + insn->displacement.nbytes;
 }
 
+#define POP_SS_OPCODE 0x1f
+#define MOV_SREG_OPCODE 0x8e
+
+/*
+ * Intel SDM Vol.3A 6.8.3 states;
+ * "Any single-step trap that would be delivered following the MOV to SS
+ * instruction or POP to SS instruction (because EFLAGS.TF is 1) is
+ * suppressed."
+ * This function returns true if @insn is MOV SS or POP SS. On these
+ * instructions, single stepping is suppressed.
+ */
+static inline int insn_masking_exception(struct insn *insn)
+{
+	return insn->opcode.bytes[0] == POP_SS_OPCODE ||
+		(insn->opcode.bytes[0] == MOV_SREG_OPCODE &&
+		 X86_MODRM_REG(insn->modrm.bytes[0]) == 2);
+}
+
 #endif /* _ASM_X86_INSN_H */


