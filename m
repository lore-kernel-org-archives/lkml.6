Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758067AbeDXNTz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:19:55 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51941 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758034AbeDXNTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:19:50 -0400
X-Google-Smtp-Source: AIpwx4/rHvqPkwsDURyBzgjs8Xrj1LAJ96NJC9v6JfRmTDtR7GPWCBI/0Ki9VuwC/Kj6ksI2rf1GiA==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: [PATCH] media: fix va1j5jf8007s_get_frontend_algo()'s return type
Date: Tue, 24 Apr 2018 15:19:44 +0200
Message-Id: <20180424131947.6371-1-luc.vanoostenryck@gmail.com>
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
 drivers/media/pci/pt1/va1j5jf8007s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/pt1/va1j5jf8007s.c b/drivers/media/pci/pt1/va1j5jf8007s.c
index f49867aef..3edc0fe2e 100644
--- a/drivers/media/pci/pt1/va1j5jf8007s.c
+++ b/drivers/media/pci/pt1/va1j5jf8007s.c
@@ -98,7 +98,7 @@ static int va1j5jf8007s_read_snr(struct dvb_frontend *fe, u16 *snr)
 	return 0;
 }
 
-static int va1j5jf8007s_get_frontend_algo(struct dvb_frontend *fe)
+static enum dvbfe_algo va1j5jf8007s_get_frontend_algo(struct dvb_frontend *fe)
 {
 	return DVBFE_ALGO_HW;
 }
-- 
2.17.0
