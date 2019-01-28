Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7777AC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48183214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690250;
	bh=HjyI+ZYByPbAcYVUfAbbI5+uQjoPQ7YlKhMHTBRD8u8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rRQtORZwkj/4ve5aw3xC2OuvQtyENrij6YgCbQwGp2W3nDG1eXy3YTXipIMg+ZapP
	 kyiXTTUKOP1nOwM4CabP6Nhwb2jZmktm9OYT8iaywAQZLLsnRB9aN6SkXiu5bOJXpk
	 dRQdGeBfWCpsYlK4Ra8en84NzpQnDTK7i2yzTXsM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfA1PoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:44:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:57332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727146AbfA1PoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:44:05 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE54720880;
        Mon, 28 Jan 2019 15:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690245;
        bh=HjyI+ZYByPbAcYVUfAbbI5+uQjoPQ7YlKhMHTBRD8u8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EkMYJODeBjdVzBnvPyzkeHHZpML7QAVvfXONGQNm7vIqhy4Mk1u0Nbosye1B+I0A3
         nqMhwYf9+6jsgOLBCr9uEKC6dVZ10Yl/oUT2lXbzjmF3mtkKoHnHgJW98BT+Pp8E6c
         C8kV47tpBRhJoRX/aAc3HRwVnB9ViMe4sEhRTqF0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nickhu <nickhu@andestech.com>, Zong Li <zong@andestech.com>,
        Greentime Hu <greentime@andestech.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 014/304] nds32: Fix gcc 8.0 compiler option incompatible.
Date:   Mon, 28 Jan 2019 10:38:51 -0500
Message-Id: <20190128154341.47195-14-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
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

