Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058ACC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0BD2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Xkpa6DOW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfAGCKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 21:10:16 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:40743 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfAGCKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 21:10:15 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x0728I1G022620;
        Mon, 7 Jan 2019 11:08:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x0728I1G022620
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1546826899;
        bh=3qC/QbwPHGLHXMMXK75YADLfQze8MkxfsjczvjMNEco=;
        h=From:To:Cc:Subject:Date:From;
        b=Xkpa6DOW87LP4GK8wjZc4tpvOQQSG9LLeCwFjhxEWmGw4CuAsycwKfCyrbBSRtx4p
         e1S7CBnvDNOyjB4X06shN2a7LhVusN/d59bXeCYjXnhOUGYsb2b/PzQYtOFWWj9IP+
         hH6UHSB+2MG9xXev+2lw2rOPEEO1brBbppSuYMPl+C1lrJwCMfQ4JVQgcVRy7pA2SM
         y0i2+x1QGMXG5LSqL3AFCIFbaNw04TlNqs57HdPpSmPu9mdsIngp8R4oKWCQDoYcAa
         ZVaOekEcDsZwFhNlEHA6CyUrdBvS7A0+jhtRcua7V4BV1nE7obvEkfgE1gsiIu2LI8
         DdLOs1jMGQ8Xw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        Michal Simek <monstr@monstr.eu>,
        Stafford Horne <shorne@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Guan Xuetao <gxt@pku.edu.cn>, linux-c6x-dev@linux-c6x.org,
        linux-kernel@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        openrisc@lists.librecores.org
Subject: [URGENT FIX PATCH] arch: restore generic-y += shmparam.h for some architectures
Date:   Mon,  7 Jan 2019 11:08:08 +0900
Message-Id: <1546826888-29197-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some reasons, I accidentally got rid of "generic-y += shmparam.h"
from some architectures.

Restore them to fix building c6x, h8300, hexagon, m68k, microblaze,
openrisc, and unicore32.

Fixes: d6e4b3e326d8 ("arch: remove redundant UAPI generic-y defines")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Hi Linus,

Could you pick up this directly?
Apology for breakage.



 arch/c6x/include/uapi/asm/Kbuild        | 1 +
 arch/h8300/include/uapi/asm/Kbuild      | 1 +
 arch/hexagon/include/uapi/asm/Kbuild    | 1 +
 arch/m68k/include/uapi/asm/Kbuild       | 1 +
 arch/microblaze/include/uapi/asm/Kbuild | 1 +
 arch/openrisc/include/uapi/asm/Kbuild   | 1 +
 arch/unicore32/include/uapi/asm/Kbuild  | 1 +
 7 files changed, 7 insertions(+)

diff --git a/arch/c6x/include/uapi/asm/Kbuild b/arch/c6x/include/uapi/asm/Kbuild
index 0febf1a..6c6f630 100644
--- a/arch/c6x/include/uapi/asm/Kbuild
+++ b/arch/c6x/include/uapi/asm/Kbuild
@@ -1,4 +1,5 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += kvm_para.h
+generic-y += shmparam.h
 generic-y += ucontext.h
diff --git a/arch/h8300/include/uapi/asm/Kbuild b/arch/h8300/include/uapi/asm/Kbuild
index 0febf1a..6c6f630 100644
--- a/arch/h8300/include/uapi/asm/Kbuild
+++ b/arch/h8300/include/uapi/asm/Kbuild
@@ -1,4 +1,5 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += kvm_para.h
+generic-y += shmparam.h
 generic-y += ucontext.h
diff --git a/arch/hexagon/include/uapi/asm/Kbuild b/arch/hexagon/include/uapi/asm/Kbuild
index c1b06dc..61d955c 100644
--- a/arch/hexagon/include/uapi/asm/Kbuild
+++ b/arch/hexagon/include/uapi/asm/Kbuild
@@ -1,3 +1,4 @@
 include include/uapi/asm-generic/Kbuild.asm
 
+generic-y += shmparam.h
 generic-y += ucontext.h
diff --git a/arch/m68k/include/uapi/asm/Kbuild b/arch/m68k/include/uapi/asm/Kbuild
index 960bf1e..b8b3525 100644
--- a/arch/m68k/include/uapi/asm/Kbuild
+++ b/arch/m68k/include/uapi/asm/Kbuild
@@ -2,3 +2,4 @@ include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
 generic-y += kvm_para.h
+generic-y += shmparam.h
diff --git a/arch/microblaze/include/uapi/asm/Kbuild b/arch/microblaze/include/uapi/asm/Kbuild
index 97823ec..28823e3 100644
--- a/arch/microblaze/include/uapi/asm/Kbuild
+++ b/arch/microblaze/include/uapi/asm/Kbuild
@@ -2,4 +2,5 @@ include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
 generic-y += kvm_para.h
+generic-y += shmparam.h
 generic-y += ucontext.h
diff --git a/arch/openrisc/include/uapi/asm/Kbuild b/arch/openrisc/include/uapi/asm/Kbuild
index 0febf1a..6c6f630 100644
--- a/arch/openrisc/include/uapi/asm/Kbuild
+++ b/arch/openrisc/include/uapi/asm/Kbuild
@@ -1,4 +1,5 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += kvm_para.h
+generic-y += shmparam.h
 generic-y += ucontext.h
diff --git a/arch/unicore32/include/uapi/asm/Kbuild b/arch/unicore32/include/uapi/asm/Kbuild
index 0febf1a..6c6f630 100644
--- a/arch/unicore32/include/uapi/asm/Kbuild
+++ b/arch/unicore32/include/uapi/asm/Kbuild
@@ -1,4 +1,5 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += kvm_para.h
+generic-y += shmparam.h
 generic-y += ucontext.h
-- 
2.7.4

