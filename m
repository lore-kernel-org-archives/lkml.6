Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755148AbeDWMto (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 08:49:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58329 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754985AbeDWMtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 08:49:41 -0400
From: Colin King <colin.king@canonical.com>
To: netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dca: make function dca_common_get_tag static
Date: Mon, 23 Apr 2018 13:49:38 +0100
Message-Id: <20180423124938.26070-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Function dca_common_get_tag is local to the source and does not need to be
in global scope, so make it static.

Cleans up sparse warning:
drivers/dca/dca-core.c:273:4: warning: symbol 'dca_common_get_tag' was
not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/dca/dca-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dca/dca-core.c b/drivers/dca/dca-core.c
index 7afbb28d6a0f..1bc5ffb338c8 100644
--- a/drivers/dca/dca-core.c
+++ b/drivers/dca/dca-core.c
@@ -270,7 +270,7 @@ EXPORT_SYMBOL_GPL(dca_remove_requester);
  * @dev - the device that wants dca service
  * @cpu - the cpuid as returned by get_cpu()
  */
-u8 dca_common_get_tag(struct device *dev, int cpu)
+static u8 dca_common_get_tag(struct device *dev, int cpu)
 {
 	struct dca_provider *dca;
 	u8 tag;
-- 
2.17.0
