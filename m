Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934222AbeDXNWl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:22:41 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35473 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758010AbeDXNT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:19:26 -0400
X-Google-Smtp-Source: AIpwx497MHVuUYDIz47Qm61NeFXT7Njzubu4bXGvmiruw1oYJ11iRVopU07QnPww7I1oRCZPL6Xceg==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        linux-media@vger.kernel.org
Subject: [PATCH] media: cx24123: fix cx24123_get_algo()'s return type
Date: Tue, 24 Apr 2018 15:19:20 +0200
Message-Id: <20180424131922.6019-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The method dvb_frontend_ops::get_frontend_algo() is defined as
returning an 'enum dvbfe_algo', but the implementation in this
driver returns an 'int'.

Fix this by returning 'enum dvbfe_algo' in this driver too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/media/dvb-frontends/cx24123.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/cx24123.c b/drivers/media/dvb-frontends/cx24123.c
index 228ba1f4b..bf33e7390 100644
--- a/drivers/media/dvb-frontends/cx24123.c
+++ b/drivers/media/dvb-frontends/cx24123.c
@@ -1005,7 +1005,7 @@ static int cx24123_tune(struct dvb_frontend *fe,
 	return retval;
 }
 
-static int cx24123_get_algo(struct dvb_frontend *fe)
+static enum dvbfe_algo cx24123_get_algo(struct dvb_frontend *fe)
 {
 	return DVBFE_ALGO_HW;
 }
-- 
2.17.0
