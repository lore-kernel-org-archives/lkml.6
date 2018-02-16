Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034150AbeBPOUA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 09:20:00 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38080 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033347AbeBPOTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 09:19:54 -0500
X-Google-Smtp-Source: AH8x224QQTYqnG8n65fF30ZtJ4sZ2oQi6c/wOp8aYaS5Hj39vIhMKaLhmizzWclH4hF9ifFJ5I9H+A==
From: Progyan Bhattacharya <bprogyan@gmail.com>
X-Google-Original-From: Progyan Bhattacharya <progyanb@acm.org>
To: linux-kernel@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Nicholas Mc Guire <der.herr@hofr.at>
Subject: [PATCH] objtool/x86: Replace Non-standard Range Expression in Case
Date: Fri, 16 Feb 2018 19:49:47 +0530
Message-Id: <20180216141947.9324-1-progyanb@acm.org>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace range expressions with seperate individual cases, i.e. convert case 1...3: to case 1: case 2: case 3
Range expression within case statements are non-standard C code and can create issues over compiler and platform variety.

While compiling with gcc 4.8 (RHEL) I encountered this error on range expression in case statements:
error: range expressions in switch statements are non-standard [-Werror=pedantic]

Signed-off-by: Progyan Bhattacharya <progyanb@acm.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Nick Desaulniers <nick.desaulniers@gmail.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Nicholas Mc Guire <der.herr@hofr.at>
Cc: linux-kernel@vger.kernel.org
---
 tools/objtool/arch/x86/decode.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 540a209b78ab..b4433433863b 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -143,7 +143,14 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
 		}
 		break;
 
-	case 0x50 ... 0x57:
+	case 0x50:
+    case 0x51:
+    case 0x52:
+    case 0x53:
+    case 0x54:
+    case 0x55:
+    case 0x56:
+    case 0x57:
 
 		/* push reg */
 		*type = INSN_STACK;
@@ -153,7 +160,14 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
 
 		break;
 
-	case 0x58 ... 0x5f:
+	case 0x58:
+    case 0x59:
+    case 0x5a:
+    case 0x5b:
+    case 0x5c:
+    case 0x5d:
+    case 0x5e:
+    case 0x5f:
 
 		/* pop reg */
 		*type = INSN_STACK;
@@ -171,7 +185,22 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
 		op->dest.type = OP_DEST_PUSH;
 		break;
 
-	case 0x70 ... 0x7f:
+	case 0x70:
+    case 0x71:
+    case 0x72:
+    case 0x73:
+    case 0x74:
+    case 0x75:
+    case 0x76:
+    case 0x77:
+    case 0x78:
+    case 0x79:
+    case 0x7a:
+    case 0x7b:
+    case 0x7c:
+    case 0x7d:
+    case 0x7e:
+    case 0x7f:
 		*type = INSN_JUMP_CONDITIONAL;
 		break;
 
-- 
2.16.1
