Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751131AbeFCDNi (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 23:13:38 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36881 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbeFCDNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 23:13:37 -0400
X-Google-Smtp-Source: ADUXVKLX/RTd6XZR8v1nFfaD0SletLDJff3VYpRv8muvU2hDtdBmhTBKKbuG2ANtpNAEhpLnKdvn1A==
From: Janani Sankara Babu <jananis37@gmail.com>
To: gregkh@linuxfoundation.org
Cc: greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Janani Sankara Babu <jananis37@gmail.com>
Subject: [PATCH] Staging:greybus Fix comparison to NULL
Date: Sun,  3 Jun 2018 08:52:51 -0400
Message-Id: <1528030371-3822-1-git-send-email-jananis37@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces comparison of var to NULL with !var

Signed-off-by: Janani Sankara Babu <jananis37@gmail.com>
---
 drivers/staging/greybus/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/core.c b/drivers/staging/greybus/core.c
index dafa430..5d14a4e 100644
--- a/drivers/staging/greybus/core.c
+++ b/drivers/staging/greybus/core.c
@@ -48,7 +48,7 @@ static bool greybus_match_one_id(struct gb_bundle *bundle,
 static const struct greybus_bundle_id *
 greybus_match_id(struct gb_bundle *bundle, const struct greybus_bundle_id *id)
 {
-	if (id == NULL)
+	if (!id)
 		return NULL;

 	for (; id->vendor || id->product || id->class || id->driver_info;
--
1.9.1
