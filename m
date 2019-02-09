Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56157C282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A9B22192B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738108;
	bh=bolxdIRHX7ktMlRtXeGX5290TGCwf0d8ZGQxePt8yK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dWduHTd/dvaQ0M/aephSoR/ga0jo9YMGzR5vAzdfaYWl+YRB8osg39JSGo5MM0mZj
	 7aPtkCic34iSXx6WY/vxGzZs6km8O2r059zW3LOloBFSFrbxBsKAVyWiHTxaN0BO2j
	 pdbhhZW2pkpgEOs3u4mkB5JiEdb3sCBNTXFRllJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfBISs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:48:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:33240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727648AbfBISsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:48:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7F792192B;
        Sat,  9 Feb 2019 18:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738103;
        bh=bolxdIRHX7ktMlRtXeGX5290TGCwf0d8ZGQxePt8yK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L9i3huPlqCw79vses/hmGX6E/TYfBeOLOYEHvRj5HrfScCEhAlMsxAW/oeAIogplw
         V4tR5NHxQkLdkYxuZMmMBGo8Gsv4PArXlsarApKW+dIUoWpeAzZVODy9Y5yshqBL+U
         QgQwORO1IwUyE/tFYNAhf9V4K/XmPpyQWlk1s0e8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guo Ren <ren_guo@c-sky.com>, Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 34/42] csky: fixup compile error with CPU 810.
Date:   Sat,  9 Feb 2019 13:47:26 -0500
Message-Id: <20190209184734.125935-34-sashal@kernel.org>
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

From: Guo Ren <ren_guo@c-sky.com>

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

