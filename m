Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5503C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E232084D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51E232084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbeJZQEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:04:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37535 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbeJZQEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:04:30 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9Q7SU6D136025
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 26 Oct 2018 00:28:30 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9Q7SUQ3136022;
        Fri, 26 Oct 2018 00:28:30 -0700
Date:   Fri, 26 Oct 2018 00:28:30 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for David Miller <tipbot@zytor.com>
Message-ID: <tip-0ab41886648bb75b951bd41d8b5cecaca8e0ad66@git.kernel.org>
Cc:     tglx@linutronix.de, acme@redhat.com, hpa@zytor.com,
        mingo@kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, davem@davemloft.net,
          linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
          acme@redhat.com
In-Reply-To: <20181016.205555.1070918198627611771.davem@davemloft.net>
References: <20181016.205555.1070918198627611771.davem@davemloft.net>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annotate: Add Sparc support
Git-Commit-ID: 0ab41886648bb75b951bd41d8b5cecaca8e0ad66
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  0ab41886648bb75b951bd41d8b5cecaca8e0ad66
Gitweb:     https://git.kernel.org/tip/0ab41886648bb75b951bd41d8b5cecaca8e0ad66
Author:     David Miller <davem@davemloft.net>
AuthorDate: Tue, 16 Oct 2018 20:55:55 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 18 Oct 2018 11:16:38 -0300

perf annotate: Add Sparc support

E.g.:

  $ perf annotate --stdio2
  Samples: 7K of event 'cycles:ppp', 4000 Hz, Event count (approx.): 3086733887
  __gettimeofday  /lib32/libc-2.27.so [Percent: local period]
  Percent│
         │
         │
         │    Disassembly of section .text:
         │
         │    000a6fa0 <__gettimeofday@@GLIBC_2.0>:
    0.47 │      save   %sp, -96, %sp
    0.73 │      sethi  %hi(0xe9000), %l7
         │    → call   __frame_state_for@@GLIBC_2.0+0x480
    0.30 │      add    %l7, 0x58, %l7     ! e9058 <nftw64@@GLIBC_2.3.3+0x818>
    1.33 │      mov    %i0, %o0
         │      mov    %i1, %o1
    0.43 │      mov    0x74, %g1
         │      ta     0x10
   88.92 │    ↓ bcc    30
    2.95 │      clr    %g1
         │      neg    %o0
         │      mov    1, %g1
    0.31 │30:   cmp    %g1, 0
         │      bne,pn %icc, a6fe4 <__gettimeofday@@GLIBC_2.0+0x44>
         │      mov    %o0, %i0
    1.96 │    ← return %i7 + 8
    2.62 │      nop
         │      sethi  %hi(0), %g1
         │      neg    %o0, %g2
         │      add    %g1, 0x160, %g1
         │      ld     [ %l7 + %g1 ], %g1
         │      st     %g2, [ %g7 + %g1 ]
         │    ← return %i7 + 8
         │      mov    -1, %o0

Signed-off-by: David S. Miller <davem@davemloft.net>
Link: http://lkml.kernel.org/r/20181016.205555.1070918198627611771.davem@davemloft.net
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/sparc/annotate/instructions.c | 169 ++++++++++++++++++++++++++
 tools/perf/util/annotate.c                    |   8 ++
 2 files changed, 177 insertions(+)

diff --git a/tools/perf/arch/sparc/annotate/instructions.c b/tools/perf/arch/sparc/annotate/instructions.c
new file mode 100644
index 000000000000..2614c010c235
--- /dev/null
+++ b/tools/perf/arch/sparc/annotate/instructions.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0
+
+static int is_branch_cond(const char *cond)
+{
+	if (cond[0] == '\0')
+		return 1;
+
+	if (cond[0] == 'a' && cond[1] == '\0')
+		return 1;
+
+	if (cond[0] == 'c' &&
+	    (cond[1] == 'c' || cond[1] == 's') &&
+	    cond[2] == '\0')
+		return 1;
+
+	if (cond[0] == 'e' &&
+	    (cond[1] == '\0' ||
+	     (cond[1] == 'q' && cond[2] == '\0')))
+		return 1;
+
+	if (cond[0] == 'g' &&
+	    (cond[1] == '\0' ||
+	     (cond[1] == 't' && cond[2] == '\0') ||
+	     (cond[1] == 'e' && cond[2] == '\0') ||
+	     (cond[1] == 'e' && cond[2] == 'u' && cond[3] == '\0')))
+		return 1;
+
+	if (cond[0] == 'l' &&
+	    (cond[1] == '\0' ||
+	     (cond[1] == 't' && cond[2] == '\0') ||
+	     (cond[1] == 'u' && cond[2] == '\0') ||
+	     (cond[1] == 'e' && cond[2] == '\0') ||
+	     (cond[1] == 'e' && cond[2] == 'u' && cond[3] == '\0')))
+		return 1;
+
+	if (cond[0] == 'n' &&
+	    (cond[1] == '\0' ||
+	     (cond[1] == 'e' && cond[2] == '\0') ||
+	     (cond[1] == 'z' && cond[2] == '\0') ||
+	     (cond[1] == 'e' && cond[2] == 'g' && cond[3] == '\0')))
+		return 1;
+
+	if (cond[0] == 'b' &&
+	    cond[1] == 'p' &&
+	    cond[2] == 'o' &&
+	    cond[3] == 's' &&
+	    cond[4] == '\0')
+		return 1;
+
+	if (cond[0] == 'v' &&
+	    (cond[1] == 'c' || cond[1] == 's') &&
+	    cond[2] == '\0')
+		return 1;
+
+	if (cond[0] == 'b' &&
+	    cond[1] == 'z' &&
+	    cond[2] == '\0')
+		return 1;
+
+	return 0;
+}
+
+static int is_branch_reg_cond(const char *cond)
+{
+	if ((cond[0] == 'n' || cond[0] == 'l') &&
+	    cond[1] == 'z' &&
+	    cond[2] == '\0')
+		return 1;
+
+	if (cond[0] == 'z' &&
+	    cond[1] == '\0')
+		return 1;
+
+	if ((cond[0] == 'g' || cond[0] == 'l') &&
+	    cond[1] == 'e' &&
+	    cond[2] == 'z' &&
+	    cond[3] == '\0')
+		return 1;
+
+	if (cond[0] == 'g' &&
+	    cond[1] == 'z' &&
+	    cond[2] == '\0')
+		return 1;
+
+	return 0;
+}
+
+static int is_branch_float_cond(const char *cond)
+{
+	if (cond[0] == '\0')
+		return 1;
+
+	if ((cond[0] == 'a' || cond[0] == 'e' ||
+	     cond[0] == 'z' || cond[0] == 'g' ||
+	     cond[0] == 'l' || cond[0] == 'n' ||
+	     cond[0] == 'o' || cond[0] == 'u') &&
+	    cond[1] == '\0')
+		return 1;
+
+	if (((cond[0] == 'g' && cond[1] == 'e') ||
+	     (cond[0] == 'l' && (cond[1] == 'e' ||
+				 cond[1] == 'g')) ||
+	     (cond[0] == 'n' && (cond[1] == 'e' ||
+				 cond[1] == 'z')) ||
+	     (cond[0] == 'u' && (cond[1] == 'e' ||
+				 cond[1] == 'g' ||
+				 cond[1] == 'l'))) &&
+	    cond[2] == '\0')
+		return 1;
+
+	if (cond[0] == 'u' &&
+	    (cond[1] == 'g' || cond[1] == 'l') &&
+	    cond[2] == 'e' &&
+	    cond[3] == '\0')
+		return 1;
+
+	return 0;
+}
+
+static struct ins_ops *sparc__associate_instruction_ops(struct arch *arch, const char *name)
+{
+	struct ins_ops *ops = NULL;
+
+	if (!strcmp(name, "call") ||
+	    !strcmp(name, "jmp") ||
+	    !strcmp(name, "jmpl")) {
+		ops = &call_ops;
+	} else if (!strcmp(name, "ret") ||
+		   !strcmp(name, "retl") ||
+		   !strcmp(name, "return")) {
+		ops = &ret_ops;
+	} else if (!strcmp(name, "mov")) {
+		ops = &mov_ops;
+	} else {
+		if (name[0] == 'c' &&
+		    (name[1] == 'w' || name[1] == 'x'))
+			name += 2;
+
+		if (name[0] == 'b') {
+			const char *cond = name + 1;
+
+			if (cond[0] == 'r') {
+				if (is_branch_reg_cond(cond + 1))
+					ops = &jump_ops;
+			} else if (is_branch_cond(cond)) {
+				ops = &jump_ops;
+			}
+		} else if (name[0] == 'f' && name[1] == 'b') {
+			if (is_branch_float_cond(name + 2))
+				ops = &jump_ops;
+		}
+	}
+
+	if (ops)
+		arch__associate_ins_ops(arch, name, ops);
+
+	return ops;
+}
+
+static int sparc__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
+{
+	if (!arch->initialized) {
+		arch->initialized = true;
+		arch->associate_instruction_ops = sparc__associate_instruction_ops;
+		arch->objdump.comment_char = '#';
+	}
+
+	return 0;
+}
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 28cd6a17491b..6936daf89ddd 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -139,6 +139,7 @@ static int arch__associate_ins_ops(struct arch* arch, const char *name, struct i
 #include "arch/x86/annotate/instructions.c"
 #include "arch/powerpc/annotate/instructions.c"
 #include "arch/s390/annotate/instructions.c"
+#include "arch/sparc/annotate/instructions.c"
 
 static struct arch architectures[] = {
 	{
@@ -170,6 +171,13 @@ static struct arch architectures[] = {
 			.comment_char = '#',
 		},
 	},
+	{
+		.name = "sparc",
+		.init = sparc__annotate_init,
+		.objdump = {
+			.comment_char = '#',
+		},
+	},
 };
 
 static void ins__delete(struct ins_operands *ops)
