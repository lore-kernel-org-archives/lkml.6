Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F5FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 374DF26C92
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 374DF26C92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752754AbeFZQD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 12:03:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41758 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752661AbeFZQD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 12:03:57 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fXqRf-0002HC-6c; Tue, 26 Jun 2018 16:03:55 +0000
From:   Colin King <colin.king@canonical.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/panel: ILI9881c: fix missing assignment to error return ret
Date:   Tue, 26 Jun 2018 17:03:54 +0100
Message-Id: <20180626160354.1363-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently, ret is being checked for an error condition however it
is not being assigned in the previous statement on the call of
function mipi_dsi_dcs_exit_sleep_mode.  Add in the missing assignment
of ret.

Detected by CoverityScan, CID#1470174, 1470178 ("Unchecked return value")

Fixes: 26aec25593c2 ("drm/panel: Add Ilitek ILI9881c panel driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
index e848af235df5..3ad4a46c4e94 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
@@ -334,7 +334,7 @@ static int ili9881c_prepare(struct drm_panel *panel)
 	if (ret)
 		return ret;
 
-	mipi_dsi_dcs_exit_sleep_mode(ctx->dsi);
+	ret = mipi_dsi_dcs_exit_sleep_mode(ctx->dsi);
 	if (ret)
 		return ret;
 
-- 
2.17.1

