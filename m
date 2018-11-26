Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234F2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF04521104
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBtHxccj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF04521104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeKZVsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:48:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:56808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726475AbeKZVsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:48:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E1DA20817;
        Mon, 26 Nov 2018 10:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229676;
        bh=WAXTVzzrzvFzWX/E8HE102NNUp5wcdMdFXR+kzRrkgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WBtHxccjmYaSNNDQjlhRuDUxfW7OpPyOVU5/hu/yQ8/+5e5xujEj0Go2Fg9lIaFNl
         B+iNObDWOMRYEM3xAviveyNMrib/eGUrIOLE1fzeU+dA7VIiPM2sdMGSiUfAB3/FFW
         CTVtls7a8pLVy9k2YKEllA1z9XxYJ+i/QS7NA0DQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        Greg Hackmann <ghackmann@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Davidson <md@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, grundler@chromium.org,
        Ingo Molnar <mingo@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.4 29/70] x86/kbuild: Use cc-option to enable -falign-{jumps/loops}
Date:   Mon, 26 Nov 2018 11:50:44 +0100
Message-Id: <20181126105049.588008241@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105046.722096341@linuxfoundation.org>
References: <20181126105046.722096341@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Kaehlcke <mka@chromium.org>

commit 2c4fd1ac3ff167c91272dc43c7bfd2269ef61557 upstream.

clang currently does not support these optimizations, only enable them
when they are available.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Cc: Greg Hackmann <ghackmann@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michael Davidson <md@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: grundler@chromium.org
Link: http://lkml.kernel.org/r/20170413172609.118122-1-mka@chromium.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/Makefile |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -88,10 +88,10 @@ else
         KBUILD_CFLAGS += -m64
 
         # Align jump targets to 1 byte, not the default 16 bytes:
-        KBUILD_CFLAGS += -falign-jumps=1
+        KBUILD_CFLAGS += $(call cc-option,-falign-jumps=1)
 
         # Pack loops tightly as well:
-        KBUILD_CFLAGS += -falign-loops=1
+        KBUILD_CFLAGS += $(call cc-option,-falign-loops=1)
 
         # Don't autogenerate traditional x87 instructions
         KBUILD_CFLAGS += $(call cc-option,-mno-80387)


