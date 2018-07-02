Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A711AC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68DCB25CC2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68DCB25CC2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965510AbeGBLHA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:07:00 -0400
Received: from foss.arm.com ([217.140.101.70]:57618 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030441AbeGBLFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:05:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D4BB1AC1;
        Mon,  2 Jul 2018 04:05:05 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 437D13F5BA;
        Mon,  2 Jul 2018 04:05:03 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org, will.deacon@arm.com
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        dave.martin@arm.com, hch@infradead.org, james.morse@arm.com,
        linux@dominikbrodowski.net, linux-fsdevel@vger.kernel.org,
        marc.zyngier@arm.com, mark.rutland@arm.com, viro@zeniv.linux.org.uk
Subject: [PATCHv4 15/19] arm64: remove in-kernel call to sys_personality()
Date:   Mon,  2 Jul 2018 12:04:11 +0100
Message-Id: <20180702110415.10465-16-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180702110415.10465-1-mark.rutland@arm.com>
References: <20180702110415.10465-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With pt_regs syscall wrappers, the calling convention for
sys_personality() will change. Use ksys_personality(), which is
functionally equivalent.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/sys.c b/arch/arm64/kernel/sys.c
index 31045f3fed92..a82c3f7a9a90 100644
--- a/arch/arm64/kernel/sys.c
+++ b/arch/arm64/kernel/sys.c
@@ -42,7 +42,7 @@ SYSCALL_DEFINE1(arm64_personality, unsigned int, personality)
 	if (personality(personality) == PER_LINUX32 &&
 		!system_supports_32bit_el0())
 		return -EINVAL;
-	return sys_personality(personality);
+	return ksys_personality(personality);
 }
 
 /*
-- 
2.11.0

