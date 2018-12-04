Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF004C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6501C214F1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRQMHUTP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6501C214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbeLDK4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:56:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:39368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726433AbeLDK4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:56:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B6A2214E0;
        Tue,  4 Dec 2018 10:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543920973;
        bh=snsz46gomAVnQS/Jap3ESWcxcwYAN9r7BtDuW+dhXTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IRQMHUTPphvQs/HWYV6yS/fCViQzeg80mWoAr9NzjcBGXW82jLIsTzxiKnRtAj49G
         YaKFpAXkZRNyTFKcd/Dk5ndyoOeKXbfv7EnVvC6WV4xH3FdhAK01YOg3PbH/QungZX
         Gn/ILHdqNtRymhC2ni1bpFvPOe7LsJVsEHog2Ph0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Borislav Petkov <bp@suse.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wang YanQing <udknight@gmail.com>, dhaval.giani@oracle.com,
        srinivas.eeda@oracle.com
Subject: [PATCH 4.19 030/139] x86/speculation: Add RETPOLINE_AMD support to the inline asm CALL_NOSPEC variant
Date:   Tue,  4 Dec 2018 11:48:31 +0100
Message-Id: <20181204103651.217503073@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhenzhong Duan zhenzhong.duan@oracle.com

commit 0cbb76d6285794f30953bfa3ab831714b59dd700 upstream

..so that they match their asm counterpart.

Add the missing ANNOTATE_NOSPEC_ALTERNATIVE in CALL_NOSPEC, while at it.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wang YanQing <udknight@gmail.com>
Cc: dhaval.giani@oracle.com
Cc: srinivas.eeda@oracle.com
Link: http://lkml.kernel.org/r/c3975665-173e-4d70-8dee-06c926ac26ee@default
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/nospec-branch.h |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -170,11 +170,15 @@
  */
 # define CALL_NOSPEC						\
 	ANNOTATE_NOSPEC_ALTERNATIVE				\
-	ALTERNATIVE(						\
+	ALTERNATIVE_2(						\
 	ANNOTATE_RETPOLINE_SAFE					\
 	"call *%[thunk_target]\n",				\
 	"call __x86_indirect_thunk_%V[thunk_target]\n",		\
-	X86_FEATURE_RETPOLINE)
+	X86_FEATURE_RETPOLINE,					\
+	"lfence;\n"						\
+	ANNOTATE_RETPOLINE_SAFE					\
+	"call *%[thunk_target]\n",				\
+	X86_FEATURE_RETPOLINE_AMD)
 # define THUNK_TARGET(addr) [thunk_target] "r" (addr)
 
 #elif defined(CONFIG_X86_32) && defined(CONFIG_RETPOLINE)
@@ -184,7 +188,8 @@
  * here, anyway.
  */
 # define CALL_NOSPEC						\
-	ALTERNATIVE(						\
+	ANNOTATE_NOSPEC_ALTERNATIVE				\
+	ALTERNATIVE_2(						\
 	ANNOTATE_RETPOLINE_SAFE					\
 	"call *%[thunk_target]\n",				\
 	"       jmp    904f;\n"					\
@@ -199,7 +204,11 @@
 	"       ret;\n"						\
 	"       .align 16\n"					\
 	"904:	call   901b;\n",				\
-	X86_FEATURE_RETPOLINE)
+	X86_FEATURE_RETPOLINE,					\
+	"lfence;\n"						\
+	ANNOTATE_RETPOLINE_SAFE					\
+	"call *%[thunk_target]\n",				\
+	X86_FEATURE_RETPOLINE_AMD)
 
 # define THUNK_TARGET(addr) [thunk_target] "rm" (addr)
 #else /* No retpoline for C / inline asm */


