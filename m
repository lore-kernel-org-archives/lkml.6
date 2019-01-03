Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A21C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 01:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38062073F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 01:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="EbVYgPoF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbfACBLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 20:11:47 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:24302 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729197AbfACBLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 20:11:32 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x031Apkg032182;
        Thu, 3 Jan 2019 10:10:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x031Apkg032182
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1546477854;
        bh=xng7cKvHc9taSx3wp9YQJUBHRqX4eq/PufOtkl4V43E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EbVYgPoFHttZdzAfx1yw3j42dPAhvMIzjC7DmpX41nF5gwop9DNuj6aKB13OL3NVf
         OBQTLJqyLWZaE26gLnCgOwMfp2sSioWJDSjtCwmIL276j3h1pdcAIuEAcDQyqxbgmy
         LVek2PCkVYkWxMCw3nflwlNk8SSgpNDjpbxdbEUv6Fl8GgCRkFXB7jZQhk/DeetkXN
         AwdgN8lP8fmAQCmUSBLSLAAiMuSG55dmqt5zrYLTDy/YH3kETO6rIkGmIHy8fppUDA
         xcItDFCQuR9Q04xe4sceZN/7s5YiQYjor07k58NO2J160DQuq9oEncj4jU4ffPBgBh
         1akXv8Lvv1pAA==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 4/5] arch: remove redundant generic-y defines
Date:   Thu,  3 Jan 2019 10:10:39 +0900
Message-Id: <1546477840-14278-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546477840-14278-1-git-send-email-yamada.masahiro@socionext.com>
References: <1546477840-14278-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that Kbuild automatically creates asm-generic wrappers for missing
mandatory headers, it is redundant to list the same headers in
generic-y and mandatory-y.

Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---

Changes in v2:
  - update csky as well
  - resolve merge conflicts

 arch/alpha/include/uapi/asm/Kbuild      |  6 ------
 arch/arc/include/uapi/asm/Kbuild        | 24 ------------------------
 arch/arm/include/uapi/asm/Kbuild        | 17 -----------------
 arch/arm64/include/uapi/asm/Kbuild      | 17 -----------------
 arch/c6x/include/uapi/asm/Kbuild        | 26 --------------------------
 arch/csky/include/uapi/asm/Kbuild       | 27 ---------------------------
 arch/h8300/include/uapi/asm/Kbuild      | 26 --------------------------
 arch/hexagon/include/uapi/asm/Kbuild    | 23 -----------------------
 arch/ia64/include/uapi/asm/Kbuild       |  6 ------
 arch/m68k/include/uapi/asm/Kbuild       | 19 -------------------
 arch/microblaze/include/uapi/asm/Kbuild | 25 -------------------------
 arch/mips/include/uapi/asm/Kbuild       |  2 --
 arch/nds32/include/uapi/asm/Kbuild      | 25 -------------------------
 arch/nios2/include/uapi/asm/Kbuild      | 25 -------------------------
 arch/openrisc/include/uapi/asm/Kbuild   | 27 ---------------------------
 arch/parisc/include/uapi/asm/Kbuild     |  6 ------
 arch/powerpc/include/uapi/asm/Kbuild    |  6 ------
 arch/riscv/include/uapi/asm/Kbuild      | 27 ---------------------------
 arch/s390/include/uapi/asm/Kbuild       | 15 ---------------
 arch/sh/include/uapi/asm/Kbuild         | 18 ------------------
 arch/sparc/include/uapi/asm/Kbuild      |  2 --
 arch/unicore32/include/uapi/asm/Kbuild  | 28 ----------------------------
 arch/x86/include/uapi/asm/Kbuild        |  2 --
 arch/xtensa/include/uapi/asm/Kbuild     |  9 ---------
 24 files changed, 408 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/Kbuild b/arch/alpha/include/uapi/asm/Kbuild
index 50dea7f..439f515 100644
--- a/arch/alpha/include/uapi/asm/Kbuild
+++ b/arch/alpha/include/uapi/asm/Kbuild
@@ -1,9 +1,3 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
-generic-y += bpf_perf_event.h
-generic-y += ipcbuf.h
-generic-y += msgbuf.h
-generic-y += poll.h
-generic-y += sembuf.h
-generic-y += shmbuf.h
diff --git a/arch/arc/include/uapi/asm/Kbuild b/arch/arc/include/uapi/asm/Kbuild
index 42ac23e..0febf1a 100644
--- a/arch/arc/include/uapi/asm/Kbuild
+++ b/arch/arc/include/uapi/asm/Kbuild
@@ -1,28 +1,4 @@
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += auxvec.h
-generic-y += bitsperlong.h
-generic-y += bpf_perf_event.h
-generic-y += errno.h
-generic-y += fcntl.h
-generic-y += ioctl.h
-generic-y += ioctls.h
-generic-y += ipcbuf.h
 generic-y += kvm_para.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += param.h
-generic-y += poll.h
-generic-y += posix_types.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += shmbuf.h
-generic-y += siginfo.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += stat.h
-generic-y += statfs.h
-generic-y += termbits.h
-generic-y += termios.h
-generic-y += types.h
 generic-y += ucontext.h
diff --git a/arch/arm/include/uapi/asm/Kbuild b/arch/arm/include/uapi/asm/Kbuild
index 393fe32..eee8f7d 100644
--- a/arch/arm/include/uapi/asm/Kbuild
+++ b/arch/arm/include/uapi/asm/Kbuild
@@ -4,20 +4,3 @@ include include/uapi/asm-generic/Kbuild.asm
 generated-y += unistd-common.h
 generated-y += unistd-oabi.h
 generated-y += unistd-eabi.h
-
-generic-y += bitsperlong.h
-generic-y += bpf_perf_event.h
-generic-y += errno.h
-generic-y += ioctl.h
-generic-y += ipcbuf.h
-generic-y += msgbuf.h
-generic-y += param.h
-generic-y += poll.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += shmbuf.h
-generic-y += siginfo.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += termbits.h
-generic-y += termios.h
diff --git a/arch/arm64/include/uapi/asm/Kbuild b/arch/arm64/include/uapi/asm/Kbuild
index eb43543..87eea29 100644
--- a/arch/arm64/include/uapi/asm/Kbuild
+++ b/arch/arm64/include/uapi/asm/Kbuild
@@ -1,21 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += errno.h
-generic-y += ioctl.h
-generic-y += ioctls.h
-generic-y += ipcbuf.h
 generic-y += kvm_para.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += poll.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += shmbuf.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += swab.h
-generic-y += termbits.h
-generic-y += termios.h
-generic-y += types.h
-generic-y += siginfo.h
diff --git a/arch/c6x/include/uapi/asm/Kbuild b/arch/c6x/include/uapi/asm/Kbuild
index 633f386..0febf1a 100644
--- a/arch/c6x/include/uapi/asm/Kbuild
+++ b/arch/c6x/include/uapi/asm/Kbuild
@@ -1,30 +1,4 @@
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += auxvec.h
-generic-y += bitsperlong.h
-generic-y += bpf_perf_event.h
-generic-y += errno.h
-generic-y += fcntl.h
-generic-y += ioctl.h
-generic-y += ioctls.h
-generic-y += ipcbuf.h
 generic-y += kvm_para.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += param.h
-generic-y += poll.h
-generic-y += posix_types.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += shmbuf.h
-generic-y += shmparam.h
-generic-y += siginfo.h
-generic-y += signal.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += stat.h
-generic-y += statfs.h
-generic-y += termbits.h
-generic-y += termios.h
-generic-y += types.h
 generic-y += ucontext.h
diff --git a/arch/csky/include/uapi/asm/Kbuild b/arch/csky/include/uapi/asm/Kbuild
index 7449fde..c1b06dc 100644
--- a/arch/csky/include/uapi/asm/Kbuild
+++ b/arch/csky/include/uapi/asm/Kbuild
@@ -1,30 +1,3 @@
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += auxvec.h
-generic-y += param.h
-generic-y += bpf_perf_event.h
-generic-y += errno.h
-generic-y += fcntl.h
-generic-y += ioctl.h
-generic-y += ioctls.h
-generic-y += ipcbuf.h
-generic-y += shmbuf.h
-generic-y += bitsperlong.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += poll.h
-generic-y += posix_types.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += siginfo.h
-generic-y += signal.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += statfs.h
-generic-y += stat.h
-generic-y += setup.h
-generic-y += swab.h
-generic-y += termbits.h
-generic-y += termios.h
-generic-y += types.h
 generic-y += ucontext.h
diff --git a/arch/h8300/include/uapi/asm/Kbuild b/arch/h8300/include/uapi/asm/Kbuild
index c1a994e..0febf1a 100644
--- a/arch/h8300/include/uapi/asm/Kbuild
+++ b/arch/h8300/include/uapi/asm/Kbuild
@@ -1,30 +1,4 @@
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += auxvec.h
-generic-y += bpf_perf_event.h
-generic-y += errno.h
-generic-y += fcntl.h
-generic-y += ioctl.h
-generic-y += ioctls.h
-generic-y += ipcbuf.h
 generic-y += kvm_para.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += param.h
-generic-y += poll.h
-generic-y += posix_types.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += setup.h
-generic-y += shmbuf.h
-generic-y += shmparam.h
-generic-y += siginfo.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += stat.h
-generic-y += statfs.h
-generic-y += swab.h
-generic-y += termbits.h
-generic-y += termios.h
-generic-y += types.h
 generic-y += ucontext.h
diff --git a/arch/hexagon/include/uapi/asm/Kbuild b/arch/hexagon/include/uapi/asm/Kbuild
index bcc65a2..c1b06dc 100644
--- a/arch/hexagon/include/uapi/asm/Kbuild
+++ b/arch/hexagon/include/uapi/asm/Kbuild
@@ -1,26 +1,3 @@
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += auxvec.h
-generic-y += bpf_perf_event.h
-generic-y += errno.h
-generic-y += fcntl.h
-generic-y += ioctl.h
-generic-y += ioctls.h
-generic-y += ipcbuf.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += poll.h
-generic-y += posix_types.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += shmbuf.h
-generic-y += shmparam.h
-generic-y += siginfo.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += stat.h
-generic-y += statfs.h
-generic-y += termbits.h
-generic-y += termios.h
-generic-y += types.h
 generic-y += ucontext.h
diff --git a/arch/ia64/include/uapi/asm/Kbuild b/arch/ia64/include/uapi/asm/Kbuild
index 3536c78..5b819e5 100644
--- a/arch/ia64/include/uapi/asm/Kbuild
+++ b/arch/ia64/include/uapi/asm/Kbuild
@@ -1,10 +1,4 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_64.h
-generic-y += bpf_perf_event.h
-generic-y += ipcbuf.h
 generic-y += kvm_para.h
-generic-y += msgbuf.h
-generic-y += poll.h
-generic-y += sembuf.h
-generic-y += shmbuf.h
diff --git a/arch/m68k/include/uapi/asm/Kbuild b/arch/m68k/include/uapi/asm/Kbuild
index 2d75dbc..960bf1e 100644
--- a/arch/m68k/include/uapi/asm/Kbuild
+++ b/arch/m68k/include/uapi/asm/Kbuild
@@ -1,23 +1,4 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
-generic-y += auxvec.h
-generic-y += bitsperlong.h
-generic-y += bpf_perf_event.h
-generic-y += errno.h
-generic-y += ioctl.h
-generic-y += ipcbuf.h
 generic-y += kvm_para.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += shmbuf.h
-generic-y += shmparam.h
-generic-y += siginfo.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += statfs.h
-generic-y += termbits.h
-generic-y += termios.h
-generic-y += types.h
diff --git a/arch/microblaze/include/uapi/asm/Kbuild b/arch/microblaze/include/uapi/asm/Kbuild
index c95da41..97823ec 100644
--- a/arch/microblaze/include/uapi/asm/Kbuild
+++ b/arch/microblaze/include/uapi/asm/Kbuild
@@ -1,30 +1,5 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
-generic-y += bitsperlong.h
-generic-y += bpf_perf_event.h
-generic-y += errno.h
-generic-y += fcntl.h
-generic-y += ioctl.h
-generic-y += ioctls.h
-generic-y += ipcbuf.h
 generic-y += kvm_para.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += param.h
-generic-y += poll.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += shmbuf.h
-generic-y += shmparam.h
-generic-y += siginfo.h
-generic-y += signal.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += stat.h
-generic-y += statfs.h
-generic-y += swab.h
-generic-y += termbits.h
-generic-y += termios.h
-generic-y += types.h
 generic-y += ucontext.h
diff --git a/arch/mips/include/uapi/asm/Kbuild b/arch/mips/include/uapi/asm/Kbuild
index 215d808..0851c10 100644
--- a/arch/mips/include/uapi/asm/Kbuild
+++ b/arch/mips/include/uapi/asm/Kbuild
@@ -6,5 +6,3 @@ generated-y += unistd_o32.h
 generated-y += unistd_nr_n32.h
 generated-y += unistd_nr_n64.h
 generated-y += unistd_nr_o32.h
-generic-y += bpf_perf_event.h
-generic-y += ipcbuf.h
diff --git a/arch/nds32/include/uapi/asm/Kbuild b/arch/nds32/include/uapi/asm/Kbuild
index ddd2a28..c1b06dc 100644
--- a/arch/nds32/include/uapi/asm/Kbuild
+++ b/arch/nds32/include/uapi/asm/Kbuild
@@ -1,28 +1,3 @@
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += bpf_perf_event.h
-generic-y += errno.h
-generic-y += ioctl.h
-generic-y += ioctls.h
-generic-y += ipcbuf.h
-generic-y += shmbuf.h
-generic-y += bitsperlong.h
-generic-y += fcntl.h
-generic-y += stat.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += poll.h
-generic-y += posix_types.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += setup.h
-generic-y += siginfo.h
-generic-y += signal.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += swab.h
-generic-y += statfs.h
-generic-y += termbits.h
-generic-y += termios.h
-generic-y += types.h
 generic-y += ucontext.h
diff --git a/arch/nios2/include/uapi/asm/Kbuild b/arch/nios2/include/uapi/asm/Kbuild
index 37bec5d..0febf1a 100644
--- a/arch/nios2/include/uapi/asm/Kbuild
+++ b/arch/nios2/include/uapi/asm/Kbuild
@@ -1,29 +1,4 @@
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += auxvec.h
-generic-y += bitsperlong.h
-generic-y += bpf_perf_event.h
-generic-y += errno.h
-generic-y += fcntl.h
-generic-y += ioctl.h
-generic-y += ioctls.h
-generic-y += ipcbuf.h
 generic-y += kvm_para.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += param.h
-generic-y += poll.h
-generic-y += posix_types.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += setup.h
-generic-y += shmbuf.h
-generic-y += siginfo.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += stat.h
-generic-y += statfs.h
-generic-y += termbits.h
-generic-y += termios.h
-generic-y += types.h
 generic-y += ucontext.h
diff --git a/arch/openrisc/include/uapi/asm/Kbuild b/arch/openrisc/include/uapi/asm/Kbuild
index bb850fa..0febf1a 100644
--- a/arch/openrisc/include/uapi/asm/Kbuild
+++ b/arch/openrisc/include/uapi/asm/Kbuild
@@ -1,31 +1,4 @@
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += auxvec.h
-generic-y += bitsperlong.h
-generic-y += bpf_perf_event.h
-generic-y += errno.h
-generic-y += fcntl.h
-generic-y += ioctl.h
-generic-y += ioctls.h
-generic-y += ipcbuf.h
 generic-y += kvm_para.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += poll.h
-generic-y += posix_types.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += setup.h
-generic-y += shmbuf.h
-generic-y += shmparam.h
-generic-y += siginfo.h
-generic-y += signal.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += stat.h
-generic-y += statfs.h
-generic-y += swab.h
-generic-y += termbits.h
-generic-y += termios.h
-generic-y += types.h
 generic-y += ucontext.h
diff --git a/arch/parisc/include/uapi/asm/Kbuild b/arch/parisc/include/uapi/asm/Kbuild
index 99c0c73..c54353d 100644
--- a/arch/parisc/include/uapi/asm/Kbuild
+++ b/arch/parisc/include/uapi/asm/Kbuild
@@ -2,10 +2,4 @@ include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
 generated-y += unistd_64.h
-generic-y += auxvec.h
-generic-y += bpf_perf_event.h
 generic-y += kvm_para.h
-generic-y += param.h
-generic-y += poll.h
-generic-y += resource.h
-generic-y += siginfo.h
diff --git a/arch/powerpc/include/uapi/asm/Kbuild b/arch/powerpc/include/uapi/asm/Kbuild
index 6e7574e..214a39a 100644
--- a/arch/powerpc/include/uapi/asm/Kbuild
+++ b/arch/powerpc/include/uapi/asm/Kbuild
@@ -2,9 +2,3 @@ include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
 generated-y += unistd_64.h
-generic-y += param.h
-generic-y += poll.h
-generic-y += resource.h
-generic-y += sockios.h
-generic-y += statfs.h
-generic-y += siginfo.h
diff --git a/arch/riscv/include/uapi/asm/Kbuild b/arch/riscv/include/uapi/asm/Kbuild
index 5945a59..d2ee86b 100644
--- a/arch/riscv/include/uapi/asm/Kbuild
+++ b/arch/riscv/include/uapi/asm/Kbuild
@@ -1,28 +1 @@
 include include/uapi/asm-generic/Kbuild.asm
-
-generic-y += setup.h
-generic-y += unistd.h
-generic-y += bpf_perf_event.h
-generic-y += errno.h
-generic-y += fcntl.h
-generic-y += ioctl.h
-generic-y += ioctls.h
-generic-y += ipcbuf.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += param.h
-generic-y += poll.h
-generic-y += posix_types.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += shmbuf.h
-generic-y += signal.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += stat.h
-generic-y += statfs.h
-generic-y += swab.h
-generic-y += termbits.h
-generic-y += termios.h
-generic-y += types.h
-generic-y += siginfo.h
diff --git a/arch/s390/include/uapi/asm/Kbuild b/arch/s390/include/uapi/asm/Kbuild
index 89b4582..da3e0d4 100644
--- a/arch/s390/include/uapi/asm/Kbuild
+++ b/arch/s390/include/uapi/asm/Kbuild
@@ -3,18 +3,3 @@ include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
 generated-y += unistd_64.h
-
-generic-y += errno.h
-generic-y += fcntl.h
-generic-y += ioctl.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += param.h
-generic-y += poll.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += shmbuf.h
-generic-y += sockios.h
-generic-y += swab.h
-generic-y += termbits.h
-generic-y += siginfo.h
\ No newline at end of file
diff --git a/arch/sh/include/uapi/asm/Kbuild b/arch/sh/include/uapi/asm/Kbuild
index 7ef099e..eaa30bc 100644
--- a/arch/sh/include/uapi/asm/Kbuild
+++ b/arch/sh/include/uapi/asm/Kbuild
@@ -2,23 +2,5 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
-generic-y += bitsperlong.h
-generic-y += bpf_perf_event.h
-generic-y += errno.h
-generic-y += fcntl.h
-generic-y += ioctl.h
-generic-y += ipcbuf.h
 generic-y += kvm_para.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += param.h
-generic-y += poll.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += shmbuf.h
-generic-y += siginfo.h
-generic-y += socket.h
-generic-y += statfs.h
-generic-y += termbits.h
-generic-y += termios.h
 generic-y += ucontext.h
diff --git a/arch/sparc/include/uapi/asm/Kbuild b/arch/sparc/include/uapi/asm/Kbuild
index 7064bfb..214a39a 100644
--- a/arch/sparc/include/uapi/asm/Kbuild
+++ b/arch/sparc/include/uapi/asm/Kbuild
@@ -2,5 +2,3 @@ include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
 generated-y += unistd_64.h
-generic-y += bpf_perf_event.h
-generic-y += types.h
diff --git a/arch/unicore32/include/uapi/asm/Kbuild b/arch/unicore32/include/uapi/asm/Kbuild
index 3620f6a..0febf1a 100644
--- a/arch/unicore32/include/uapi/asm/Kbuild
+++ b/arch/unicore32/include/uapi/asm/Kbuild
@@ -1,32 +1,4 @@
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += auxvec.h
-generic-y += bitsperlong.h
-generic-y += bpf_perf_event.h
-generic-y += errno.h
-generic-y += fcntl.h
-generic-y += ioctl.h
-generic-y += ioctls.h
-generic-y += ipcbuf.h
 generic-y += kvm_para.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += param.h
-generic-y += poll.h
-generic-y += posix_types.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += setup.h
-generic-y += shmbuf.h
-generic-y += shmparam.h
-generic-y += siginfo.h
-generic-y += signal.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += stat.h
-generic-y += statfs.h
-generic-y += swab.h
-generic-y += termbits.h
-generic-y += termios.h
-generic-y += types.h
 generic-y += ucontext.h
diff --git a/arch/x86/include/uapi/asm/Kbuild b/arch/x86/include/uapi/asm/Kbuild
index d15343a..f6648e9 100644
--- a/arch/x86/include/uapi/asm/Kbuild
+++ b/arch/x86/include/uapi/asm/Kbuild
@@ -1,7 +1,5 @@
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += bpf_perf_event.h
 generated-y += unistd_32.h
 generated-y += unistd_64.h
 generated-y += unistd_x32.h
-generic-y += poll.h
diff --git a/arch/xtensa/include/uapi/asm/Kbuild b/arch/xtensa/include/uapi/asm/Kbuild
index 3ae1bbd..960bf1e 100644
--- a/arch/xtensa/include/uapi/asm/Kbuild
+++ b/arch/xtensa/include/uapi/asm/Kbuild
@@ -1,13 +1,4 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
-generic-y += bitsperlong.h
-generic-y += bpf_perf_event.h
-generic-y += errno.h
-generic-y += fcntl.h
-generic-y += ioctl.h
 generic-y += kvm_para.h
-generic-y += resource.h
-generic-y += siginfo.h
-generic-y += statfs.h
-generic-y += termios.h
-- 
2.7.4

