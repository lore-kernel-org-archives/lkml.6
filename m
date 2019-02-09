Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3979EC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087F42192D
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738071;
	bh=Nj3hLQTvNJdWPBY8DVuGlS3oTYEnGWLTpHB3b4Kzh3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SqVs76MrqbMfGtL5xx7n+ByfdM/XzYKpyQhCmaJkCRW0mBOgFF2eqMvQgeJl2dF3l
	 zl7CC2Gyb74D5k/sVo3p0etemvLgJhbPoYDSSFdKZpzHlFHU/u/vTSujY1AS/fEuVV
	 wPXTNsAd7U6NnVV/c2g4n21qBaljZ8pFrXxkiThk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfBISrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:47:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:60334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727300AbfBISro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:47:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CEC121919;
        Sat,  9 Feb 2019 18:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738064;
        bh=Nj3hLQTvNJdWPBY8DVuGlS3oTYEnGWLTpHB3b4Kzh3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IsbpmOJO8vxtf3vEgDoRciY/wTpqqZuzzo3lQrBy7UsJKRYwHrwe8kIoV03QTaAg+
         /4tX10NXZsHo91V9GXl4I1VchC/n00WbBJJ0YKHRgQrkd30jf0eGopM1HCK5SBQ5Jo
         NqVZmflrPP89teT1RToMA2gHDRoaypZ6kh+UQc2o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 08/42] riscv: fix trace_sys_exit hook
Date:   Sat,  9 Feb 2019 13:47:00 -0500
Message-Id: <20190209184734.125935-8-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190209184734.125935-1-sashal@kernel.org>
References: <20190209184734.125935-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Abdurachmanov <david.abdurachmanov@gmail.com>

[ Upstream commit 775800b0f1d7303d4fd8ce0e0d9eca4ff2f338f2 ]

Fix compilation error.

Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/kernel/ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 60f1e02eed36..6c898d540d9d 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -172,6 +172,6 @@ void do_syscall_trace_exit(struct pt_regs *regs)
 
 #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
-		trace_sys_exit(regs, regs->regs[0]);
+		trace_sys_exit(regs, regs_return_value(regs));
 #endif
 }
-- 
2.19.1

