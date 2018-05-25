Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967562AbeEYRqz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 13:46:55 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33401 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967490AbeEYRqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 13:46:50 -0400
X-Google-Smtp-Source: ADUXVKIzzs3WnyzxBmE2QXvzs7dFt8mgCwkGWiBzSZktt1nhe9yxF1HWSs8VVppqQs431sj3hxuBhw==
From: Ivan Bornyakov <brnkv.i1@gmail.com>
To: 3chas3@gmail.com
Cc: linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ivan Bornyakov <brnkv.i1@gmail.com>
Subject: [PATCH] atm: zatm: fix memcmp casting
Date: Fri, 25 May 2018 20:49:52 +0300
Message-Id: <20180525174952.21965-1-brnkv.i1@gmail.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memcmp() returns int, but eprom_try_esi() cast it to unsigned char. One
can lose significant bits and get 0 from non-0 value returned by the
memcmp().

Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
---
 drivers/atm/zatm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/atm/zatm.c b/drivers/atm/zatm.c
index 9c9a22958717..a8d2eb0ceb8d 100644
--- a/drivers/atm/zatm.c
+++ b/drivers/atm/zatm.c
@@ -1151,8 +1151,8 @@ static void eprom_get_byte(struct zatm_dev *zatm_dev, unsigned char *byte,
 }
 
 
-static unsigned char eprom_try_esi(struct atm_dev *dev, unsigned short cmd,
-				   int offset, int swap)
+static int eprom_try_esi(struct atm_dev *dev, unsigned short cmd, int offset,
+			 int swap)
 {
 	unsigned char buf[ZEPROM_SIZE];
 	struct zatm_dev *zatm_dev;
-- 
2.16.1
