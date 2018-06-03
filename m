Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751325AbeFCLMH (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 07:12:07 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37733 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751013AbeFCLMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 07:12:05 -0400
X-Google-Smtp-Source: ADUXVKIxJmmlLWxyMyM2VjtZ/RH3iampG3NMf8ypobIidDWzxKhHRnWzyWZFlUXINglzgOzxCJtOFQ==
From: Varsha Rao <rvarsha016@gmail.com>
To: Stanislav Yakovlev <stas.yakovlev@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <der.herr@hofr.at>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Varsha Rao <rvarsha016@gmail.com>
Subject: [PATCH] net: ipw2x00: Replace NULL comparison with !priv
Date: Sun,  3 Jun 2018 16:41:35 +0530
Message-Id: <20180603111136.4262-1-rvarsha016@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove extra parentheses and replace NULL comparison with !priv, to fix
clang warning of extraneous parentheses and check patch issue. Following
coccinelle script is used to fix it.

@disable is_null,paren@
expression e;
statement s;
@@
if (
- (e==NULL)
+!e
 )
s

Signed-off-by: Varsha Rao <rvarsha016@gmail.com>
---
 drivers/net/wireless/intel/ipw2x00/ipw2200.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.c b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
index 87a5e414c2f7..7d55bb09413b 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2200.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
@@ -7112,7 +7112,7 @@ static u32 ipw_qos_get_burst_duration(struct ipw_priv *priv)
 {
 	u32 ret = 0;
 
-	if ((priv == NULL))
+	if (!priv)
 		return 0;
 
 	if (!(priv->ieee->modulation & LIBIPW_OFDM_MODULATION))
-- 
2.17.0
