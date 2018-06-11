Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id SrVnHa6cHlslGAAAmS7hNA
	; Mon, 11 Jun 2018 16:00:46 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 69BC7607BB; Mon, 11 Jun 2018 16:00:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EA3C3600D0;
	Mon, 11 Jun 2018 16:00:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EA3C3600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752814AbeFKQAn (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 12:00:43 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48410 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751862AbeFKQAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 12:00:41 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fSPFG-00024V-2E; Mon, 11 Jun 2018 16:00:38 +0000
From: Colin King <colin.king@canonical.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/guc: remove redundant GEM_BUG_ON check
Date: Mon, 11 Jun 2018 17:00:37 +0100
Message-Id: <20180611160037.23402-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The check for level being less than zero is redundant as level
is an unsigned u32 and hence will never be less than zero.
Remove this redundant check.

Detected by CoverityScan, CID#1468363 ("Macro compares unsigned to 0")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/i915/intel_guc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_guc.c b/drivers/gpu/drm/i915/intel_guc.c
index 116f4ccf1bbd..a2f782a4f97d 100644
--- a/drivers/gpu/drm/i915/intel_guc.c
+++ b/drivers/gpu/drm/i915/intel_guc.c
@@ -208,8 +208,6 @@ static u32 get_log_control_flags(void)
 	u32 level = i915_modparams.guc_log_level;
 	u32 flags = 0;
 
-	GEM_BUG_ON(level < 0);
-
 	if (!GUC_LOG_LEVEL_IS_ENABLED(level))
 		flags |= GUC_LOG_DEFAULT_DISABLED;
 
-- 
2.17.0
