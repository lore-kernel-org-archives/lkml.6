Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752037AbeBHPSP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 10:18:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:55248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750847AbeBHPSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 10:18:14 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1295A2172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH] x86/decoder: Update UD0 to have operands
Date: Fri,  9 Feb 2018 00:17:50 +0900
Message-Id: <151810306983.8735.9310416186567188423.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <201802071424.NwnXPOKq%fengguang.wu@intel.com>
References: <201802071424.NwnXPOKq%fengguang.wu@intel.com>
In-Reply-To: <201802071424.NwnXPOKq%fengguang.wu@intel.com>
References: <201802071424.NwnXPOKq%fengguang.wu@intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the December 2017 Intel SDM publication,
UD0 now has 2 operands by MODRM byte. So it's length should
be 3 bytes.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reported-by: kbuild test robot <fengguang.wu@intel.com>
---
 arch/x86/lib/x86-opcode-map.txt               |    3 ++-
 tools/objtool/arch/x86/lib/x86-opcode-map.txt |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index e0b85930dd77..131a76b3fa5e 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -607,7 +607,8 @@ fb: psubq Pq,Qq | vpsubq Vx,Hx,Wx (66),(v1)
 fc: paddb Pq,Qq | vpaddb Vx,Hx,Wx (66),(v1)
 fd: paddw Pq,Qq | vpaddw Vx,Hx,Wx (66),(v1)
 fe: paddd Pq,Qq | vpaddd Vx,Hx,Wx (66),(v1)
-ff: UD0
+# UD0 is special. This is changed in newer processor to have operands.
+ff: UD0 Gd,Ed
 EndTable
 
 Table: 3-byte opcode 1 (0x0f 0x38)
diff --git a/tools/objtool/arch/x86/lib/x86-opcode-map.txt b/tools/objtool/arch/x86/lib/x86-opcode-map.txt
index e0b85930dd77..131a76b3fa5e 100644
--- a/tools/objtool/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/objtool/arch/x86/lib/x86-opcode-map.txt
@@ -607,7 +607,8 @@ fb: psubq Pq,Qq | vpsubq Vx,Hx,Wx (66),(v1)
 fc: paddb Pq,Qq | vpaddb Vx,Hx,Wx (66),(v1)
 fd: paddw Pq,Qq | vpaddw Vx,Hx,Wx (66),(v1)
 fe: paddd Pq,Qq | vpaddd Vx,Hx,Wx (66),(v1)
-ff: UD0
+# UD0 is special. This is changed in newer processor to have operands.
+ff: UD0 Gd,Ed
 EndTable
 
 Table: 3-byte opcode 1 (0x0f 0x38)
