Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDEEC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C8B2082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbfBDSuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 13:50:32 -0500
Received: from www1392ue.sakura.ne.jp ([219.94.233.166]:50454 "EHLO
        www1392ue.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfBDSuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 13:50:32 -0500
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: alicef@alicef.me)
        by www1392ue.sakura.ne.jp (Postcow) with ESMTPSA id 11F0920DB3;
        Tue,  5 Feb 2019 03:50:27 +0900 (JST)
From:   Alice Ferrazzi <alicef@alicef.me>
To:     jpoimboe@redhat.com, jeyu@kernel.org, jikos@kernel.org,
        mbenes@suse.cz, pmladek@suse.com, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: [PATCH v2] livepatch: core: Return EOPNOTSUPP instead of ENOSYS
Date:   Tue,  5 Feb 2019 03:33:28 +0900
Message-Id: <20190204183324.30775-1-alicef@alicef.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>

As a result of an unsupported operation is better to use EOPNOTSUPP
as error code.
ENOSYS is only used for 'invalid syscall nr' and nothing else.

Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
---
Changes v1->v2:
- Use EOPNOTSUPP instead of ENOTSUPP (Petr)

 kernel/livepatch/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index fe1993399823..075eb5c0813d 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -1004,7 +1004,7 @@ int klp_enable_patch(struct klp_patch *patch)
 
 	if (!klp_have_reliable_stack()) {
 		pr_err("This architecture doesn't have support for the livepatch consistency model.\n");
-		return -ENOSYS;
+		return -EOPNOTSUPP;
 	}
 
 
-- 
2.19.2

