Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5C8C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C392080A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbfBLNvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:51:23 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39016 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbfBLNvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:51:23 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gtYT0-0000YZ-QG; Tue, 12 Feb 2019 13:51:18 +0000
From:   Colin King <colin.king@canonical.com>
To:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau/falcon: fix a few indentation issues
Date:   Tue, 12 Feb 2019 13:51:18 +0000
Message-Id: <20190212135118.8498-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are a few statements that are indented incorrectly. Fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/nouveau/nvkm/falcon/msgqueue.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/falcon/msgqueue.c b/drivers/gpu/drm/nouveau/nvkm/falcon/msgqueue.c
index 771e16a16267..a8bee1e046aa 100644
--- a/drivers/gpu/drm/nouveau/nvkm/falcon/msgqueue.c
+++ b/drivers/gpu/drm/nouveau/nvkm/falcon/msgqueue.c
@@ -269,7 +269,7 @@ cmd_write(struct nvkm_msgqueue *priv, struct nvkm_msgqueue_hdr *cmd,
 		commit = false;
 	}
 
-	   cmd_queue_close(priv, queue, commit);
+	cmd_queue_close(priv, queue, commit);
 
 	return ret;
 }
@@ -347,7 +347,7 @@ nvkm_msgqueue_post(struct nvkm_msgqueue *priv, enum msgqueue_msg_priority prio,
 	ret = cmd_write(priv, cmd, queue);
 	if (ret) {
 		seq->state = SEQ_STATE_PENDING;
-		      msgqueue_seq_release(priv, seq);
+		msgqueue_seq_release(priv, seq);
 	}
 
 	return ret;
@@ -373,7 +373,7 @@ msgqueue_msg_handle(struct nvkm_msgqueue *priv, struct nvkm_msgqueue_hdr *hdr)
 	if (seq->completion)
 		complete(seq->completion);
 
-	   msgqueue_seq_release(priv, seq);
+	msgqueue_seq_release(priv, seq);
 
 	return 0;
 }
-- 
2.20.1

