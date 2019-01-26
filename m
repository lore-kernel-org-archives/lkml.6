Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38110C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 19:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E88A218A2
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 19:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfAZTgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 14:36:24 -0500
Received: from www1392ue.sakura.ne.jp ([219.94.233.166]:51036 "EHLO
        www1392ue.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfAZTgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 14:36:24 -0500
X-Greylist: delayed 478 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Jan 2019 14:36:23 EST
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: alicef@alicef.me)
        by www1392ue.sakura.ne.jp (Postcow) with ESMTPSA id 3E1C020B25;
        Sun, 27 Jan 2019 04:28:19 +0900 (JST)
From:   Alice Ferrazzi <alicef@alicef.me>
To:     jpoimboe@redhat.com, jeyu@kernel.org, jikos@kernel.org,
        mbenes@suse.cz, pmladek@suse.com, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alice Ferrazzi <alicef@alicef.me>,
        Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: [PATCH] livepatch: core: Return ENOTSUPP instead of ENOSYS
Date:   Sun, 27 Jan 2019 04:26:30 +0900
Message-Id: <20190126192630.6163-1-alicef@alicef.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a checkpatch warning:
    WARNING: ENOSYS means 'invalid syscall nr' and nothing else

Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
---
 kernel/livepatch/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 5b77a7314e01..eea6b94fef89 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -897,7 +897,7 @@ int klp_register_patch(struct klp_patch *patch)
 
 	if (!klp_have_reliable_stack()) {
 		pr_err("This architecture doesn't have support for the livepatch consistency model.\n");
-		return -ENOSYS;
+		return -ENOTSUPP;
 	}
 
 	return klp_init_patch(patch);
-- 
2.19.2

