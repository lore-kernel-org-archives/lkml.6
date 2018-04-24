Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934179AbeDXNVv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:21:51 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38444 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757896AbeDXNTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:19:45 -0400
X-Google-Smtp-Source: AIpwx4/BFPLDzVznnObVlsZawUGlJzyp92qNSBIv2h1YOs9NDCxk2M/pmZDnynmBhAwpv8zCfC/5Mg==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: [PATCH] media: bt8xx: fix dst_get_tuning_algo()'s return type
Date: Tue, 24 Apr 2018 15:19:40 +0200
Message-Id: <20180424131942.6320-1-luc.vanoostenryck@gmail.com>
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
 drivers/media/pci/bt8xx/dst.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/bt8xx/dst.c b/drivers/media/pci/bt8xx/dst.c
index 4f0bba9e4..2e33b7236 100644
--- a/drivers/media/pci/bt8xx/dst.c
+++ b/drivers/media/pci/bt8xx/dst.c
@@ -1657,7 +1657,7 @@ static int dst_tune_frontend(struct dvb_frontend* fe,
 	return 0;
 }
 
-static int dst_get_tuning_algo(struct dvb_frontend *fe)
+static enum dvbfe_algo dst_get_tuning_algo(struct dvb_frontend *fe)
 {
 	return dst_algo ? DVBFE_ALGO_HW : DVBFE_ALGO_SW;
 }
-- 
2.17.0
