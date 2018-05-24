Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161284AbeEXUh4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 16:37:56 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:37506 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969126AbeEXUhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 16:37:53 -0400
X-Google-Smtp-Source: AB8JxZoLAn8Qw2fAAyKT4iUARkOE1kq09+9VVjai1ZdYctX1aQYolZteJ0+47HXlln7wd18wdLQr9Q==
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 1/2] iio: 104-quad-8: Fix off-by-one error in register selection
Date: Thu, 24 May 2018 16:37:46 -0400
Message-Id: <7c1d9be4338ab822680b9ca6ce6eb24ceba32f4e.1527193661.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1527193661.git.vilhelm.gray@gmail.com>
References: <cover.1527193661.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reset flags operation is selected by bit 2 in the "Reset and Load
Signals Decoders" register, not bit 1.

Fixes: 28e5d3bb0325 ("iio: 104-quad-8: Add IIO support for the ACCES 104-QUAD-8")
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/iio/counter/104-quad-8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/counter/104-quad-8.c b/drivers/iio/counter/104-quad-8.c
index b56985078d8c..4be85ec54af4 100644
--- a/drivers/iio/counter/104-quad-8.c
+++ b/drivers/iio/counter/104-quad-8.c
@@ -138,7 +138,7 @@ static int quad8_write_raw(struct iio_dev *indio_dev,
 			outb(val >> (8 * i), base_offset);
 
 		/* Reset Borrow, Carry, Compare, and Sign flags */
-		outb(0x02, base_offset + 1);
+		outb(0x04, base_offset + 1);
 		/* Reset Error flag */
 		outb(0x06, base_offset + 1);
 
-- 
2.17.0
