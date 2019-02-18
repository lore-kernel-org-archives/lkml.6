Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98407C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A99F2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550501158;
	bh=ENJu57nRz0rW2Gfynn6Sq1T0VvmkbIZMOCBxxC9ob+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LoRK5Oi+UU2/KQ0Z3sb8s0hNpAIYlVNuqAjnap58FnBG2WMKDe+PApHkOj5j0ibzf
	 iIfmclsVrVtF0ULkFHIaPvfDtQ/mXbeAoq972gBmbN0twg3/h1bidpnFI+oGLtoQv/
	 zulz2VAB3sf4QxgmoroKyiGC96Do4+3+xdyO5BEA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732013AbfBROp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:45:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:53762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728626AbfBRNrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:47:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04F1E218FC;
        Mon, 18 Feb 2019 13:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497629;
        bh=ENJu57nRz0rW2Gfynn6Sq1T0VvmkbIZMOCBxxC9ob+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CFt8OZ6zRgL3Z7XqsLL3rNiBytbR+HeWaNEBPduVV1SSBRW/e1jyxwgE9SNrJZTRq
         esC4rkZ5tTSrqHedS2zHcdAeJUE3+2QANFlO3g9P5r1BWjhBD1aYK/bYilT7OwvF2X
         xFC/AZSam0Aei9TwiTXghFPA4IsqCdI+9F144G8M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 37/92] csky: fixup compile error with CPU 810.
Date:   Mon, 18 Feb 2019 14:42:40 +0100
Message-Id: <20190218133458.185734906@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 70c25259537c073584eb906865307687275b527f ]

This bug is from commit f553aa1c13cb ("csky: fixup relocation error with
807 & 860").

I forgot to compile with 810 for that patch.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/csky/kernel/module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/csky/kernel/module.c b/arch/csky/kernel/module.c
index 0b028ee3c764..b5ad7d9de18c 100644
--- a/arch/csky/kernel/module.c
+++ b/arch/csky/kernel/module.c
@@ -28,7 +28,7 @@
 
 static void jsri_2_lrw_jsr(uint32_t *location)
 {
-	uint16_t location_tmp = (uint16_t *)location;
+	uint16_t *location_tmp = (uint16_t *)location;
 
 	if (IS_BSR32(*location_tmp, *(location_tmp + 1)))
 		return;
-- 
2.19.1



