Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1D981607CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932535AbeFFIGI (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 04:06:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42317 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932330AbeFFIGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 04:06:06 -0400
From: Colin King <colin.king@canonical.com>
To: Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] staging: vc04_services: make a couple of pointers static
Date: Wed,  6 Jun 2018 09:06:00 +0100
Message-Id: <20180606080600.29042-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pointers vchiq_dbg_dir and vchiq_dbg_clients are local to the
source and do not need to be in global scope, so make them static.

Cleans up sparse warnings:
warning: symbol 'vchiq_dbg_dir' was not declared. Should it be static?
warning: symbol 'vchiq_dbg_clients' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
index 38805504d462..6a9e71a61142 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
@@ -52,8 +52,8 @@
 #define VCHIQ_LOG_TRACE_STR   "trace"
 
 /* Global 'vchiq' debugfs and clients entry used by all instances */
-struct dentry *vchiq_dbg_dir;
-struct dentry *vchiq_dbg_clients;
+static struct dentry *vchiq_dbg_dir;
+static struct dentry *vchiq_dbg_clients;
 
 /* Log category debugfs entries */
 struct vchiq_debugfs_log_entry {
-- 
2.17.0
