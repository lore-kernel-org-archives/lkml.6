Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971517AbeCSUy1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 16:54:27 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:56147 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S971687AbeCSUyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 16:54:16 -0400
X-ME-Helo: linux.numericable.fr
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 19 Mar 2018 21:54:14 +0100
X-ME-IP: 77.198.79.136
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: masaki.ota@jp.alps.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 4/4] HID: alps: Fix some style in 't4_read_write_register()'
Date: Mon, 19 Mar 2018 21:53:29 +0100
Message-Id: <50b54e595830cc86edfb977e045f5a7b2b1b726a.1521492069.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1521492069.git.christophe.jaillet@wanadoo.fr>
References: <cover.1521492069.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <cover.1521492069.git.christophe.jaillet@wanadoo.fr>
References: <cover.1521492069.git.christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Better indent the code to improve readability.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/hid/hid-alps.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index 137b963779c6..60d3950692d9 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -223,20 +223,20 @@ static int t4_read_write_register(struct hid_device *hdev, u32 address,
 
 		if (*(u32 *)&readbuf[6] != address) {
 			dev_err(&hdev->dev, "read register address error (%x,%x)\n",
-			*(u32 *)&readbuf[6], address);
+				*(u32 *)&readbuf[6], address);
 			goto exit_readbuf;
 		}
 
 		if (*(u16 *)&readbuf[10] != 1) {
 			dev_err(&hdev->dev, "read register size error (%x)\n",
-			*(u16 *)&readbuf[10]);
+				*(u16 *)&readbuf[10]);
 			goto exit_readbuf;
 		}
 
 		check_sum = t4_calc_check_sum(readbuf, 6, 7);
 		if (*(u16 *)&readbuf[13] != check_sum) {
 			dev_err(&hdev->dev, "read register checksum error (%x,%x)\n",
-			*(u16 *)&readbuf[13], check_sum);
+				*(u16 *)&readbuf[13], check_sum);
 			goto exit_readbuf;
 		}
 
-- 
2.14.1
