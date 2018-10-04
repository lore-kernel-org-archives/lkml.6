Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F14C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA692098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AA692098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbeJEAoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 20:44:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49270 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbeJEAoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 20:44:16 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1g87l3-0000Oo-El; Thu, 04 Oct 2018 17:49:53 +0000
From:   Colin King <colin.king@canonical.com>
To:     VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Sinclair Yeh <syeh@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][drm-next] drm/vmwgfx: remove redundant return ret statement
Date:   Thu,  4 Oct 2018 18:49:53 +0100
Message-Id: <20181004174953.28107-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The return statement is redundant as there is a return statement
immediately before it so we have dead code that can be removed.
Also remove the unused declaration of ret.

Detected by CoverityScan, CID#1473793 ("Structurally dead code")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index 5a6b70ba137a..260650bb5560 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -1738,7 +1738,6 @@ static int vmw_cmd_check_define_gmrfb(struct vmw_private *dev_priv,
 				      void *buf)
 {
 	struct vmw_buffer_object *vmw_bo;
-	int ret;
 
 	struct {
 		uint32_t header;
@@ -1748,7 +1747,6 @@ static int vmw_cmd_check_define_gmrfb(struct vmw_private *dev_priv,
 	return vmw_translate_guest_ptr(dev_priv, sw_context,
 				       &cmd->body.ptr,
 				       &vmw_bo);
-	return ret;
 }
 
 
-- 
2.17.1

