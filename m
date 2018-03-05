Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934312AbeCEMjE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 07:39:04 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:36291 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933263AbeCEMjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 07:39:00 -0500
From: Colin King <colin.king@canonical.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] regulator: core: use NULL rather than 0 for cells_name argument
Date: Mon,  5 Mar 2018 13:38:53 +0100
Message-Id: <20180305123853.25750-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The 3rd paramater is a pointer type and should be NULL rather than a
zero, clean up spare warning:

drivers/regulator/of_regulator.c:424:75: warning: Using plain integer
as NULL pointer

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/regulator/of_regulator.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index cf3210c3fae6..4dfa2aca7c73 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -421,7 +421,8 @@ int of_get_n_coupled(struct regulator_dev *rdev)
 	int n_phandles;
 
 	n_phandles = of_count_phandle_with_args(node,
-						"regulator-coupled-with", 0);
+						"regulator-coupled-with",
+						NULL);
 
 	return (n_phandles > 0) ? n_phandles : 0;
 }
-- 
2.15.1
