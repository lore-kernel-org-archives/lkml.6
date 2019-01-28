Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11141C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C980C2082E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691198;
	bh=HjyI+ZYByPbAcYVUfAbbI5+uQjoPQ7YlKhMHTBRD8u8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xrs6d98acj6yFO9D5bF+1qqKitsMgoMgQNQvGeCzvw/DmhONfFHJnRoa4noZ7Z5wJ
	 7USURfAIpfiku10sDGRPaayVt1Eso9BV9tgYlKNt7mynEpsbVnje/zxm3eNB5nhS7B
	 a6NwQ8grASxB00jzNPtRmnTKwH7Q+vFk3WPiEjDI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbfA1P75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:59:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:45222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727858AbfA1P7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:59:54 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A317B21852;
        Mon, 28 Jan 2019 15:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691194;
        bh=HjyI+ZYByPbAcYVUfAbbI5+uQjoPQ7YlKhMHTBRD8u8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Skz4F3UUcZkHZRv1TBphZ4176RJoIZLxeTw+yp3fn8PHJka6UhxBhpORL1qsgVugo
         fdCopHLj5aki2+4Ogsi/0rNCuzzNMpIg998PmzkKBYR+qFVLVpNyseeYiSeO08JgXC
         G39aldF3oC7KteMqJL3A75f5bQCFzHxhCetHpZyk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nickhu <nickhu@andestech.com>, Zong Li <zong@andestech.com>,
        Greentime Hu <greentime@andestech.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 010/258] nds32: Fix gcc 8.0 compiler option incompatible.
Date:   Mon, 28 Jan 2019 10:55:16 -0500
Message-Id: <20190128155924.51521-10-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nickhu <nickhu@andestech.com>

[ Upstream commit 4c3d6174e0e17599549f636ec48ddf78627a17fe ]

When the kernel configs of ftrace and frame pointer options are
choosed, the compiler option of kernel will incompatible.
	Error message:
		nds32le-linux-gcc: error: -pg and -fomit-frame-pointer are incompatible

Signed-off-by: Nickhu <nickhu@andestech.com>
Signed-off-by: Zong Li <zong@andestech.com>
Acked-by: Greentime Hu <greentime@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/nds32/mm/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/nds32/mm/Makefile b/arch/nds32/mm/Makefile
index 6b6855852223..7c5c15ad854a 100644
--- a/arch/nds32/mm/Makefile
+++ b/arch/nds32/mm/Makefile
@@ -4,4 +4,8 @@ obj-y				:= extable.o tlb.o \
 
 obj-$(CONFIG_ALIGNMENT_TRAP)	+= alignment.o
 obj-$(CONFIG_HIGHMEM)           += highmem.o
-CFLAGS_proc-n13.o		+= -fomit-frame-pointer
+
+ifdef CONFIG_FUNCTION_TRACER
+CFLAGS_REMOVE_proc.o     = $(CC_FLAGS_FTRACE)
+endif
+CFLAGS_proc.o              += -fomit-frame-pointer
-- 
2.19.1

