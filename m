Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933610AbeDXNT2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:19:28 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53084 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757992AbeDXNTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:19:21 -0400
X-Google-Smtp-Source: AIpwx493owDAuoJa37O0y9D6nY1SpkgBV0hh8sldHYGnsVQMB77twX1i8A6ouZpNxw1faPKglIZ42A==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jemma Denson <jdenson@gmail.com>,
        Patrick Boettcher <patrick.boettcher@posteo.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: [PATCH] media: cx24120: fix cx24120_get_algo()'s return type
Date: Tue, 24 Apr 2018 15:19:18 +0200
Message-Id: <20180424131918.5969-1-luc.vanoostenryck@gmail.com>
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
 drivers/media/dvb-frontends/cx24120.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/cx24120.c b/drivers/media/dvb-frontends/cx24120.c
index 810f68acd..ccbabdae6 100644
--- a/drivers/media/dvb-frontends/cx24120.c
+++ b/drivers/media/dvb-frontends/cx24120.c
@@ -1491,7 +1491,7 @@ static int cx24120_tune(struct dvb_frontend *fe, bool re_tune,
 	return cx24120_read_status(fe, status);
 }
 
-static int cx24120_get_algo(struct dvb_frontend *fe)
+static enum dvbfe_algo cx24120_get_algo(struct dvb_frontend *fe)
 {
 	return DVBFE_ALGO_HW;
 }
-- 
2.17.0
