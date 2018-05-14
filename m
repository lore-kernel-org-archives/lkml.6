Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752087AbeENKSE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 06:18:04 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:39470 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750917AbeENKSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 06:18:02 -0400
X-Google-Smtp-Source: AB8JxZpYJpJrTUM11EALhAFhRg7GUHQtgUHHwhTKnhoyfLRBrQ1Fn/XfpEBhzRjphn07W6/tW0Mprw==
From: Anders Roxell <anders.roxell@linaro.org>
To: axboe@kernel.dk, maximlevitsky@gmail.com
Cc: linux-kernel@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] memstick: ms_block: fix unused variable warning
Date: Mon, 14 May 2018 12:17:55 +0200
Message-Id: <20180514101756.2120-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building a warning pops up unused variable 'host'
drivers/memstick/core/ms_block.c: In function ‘msb_init_disk’:
drivers/memstick/core/ms_block.c:2097:24: warning: unused variable ‘host’ [-Wunused-variable]
  struct memstick_host *host = card->host;
                        ^~~~

Removing the declaration of 'host' in function msb_init_disk.

Fixes: 7c2d748e8476 ("memstick: don't call blk_queue_bounce_limit")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/memstick/core/ms_block.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index b2d025f42d14..a15181fa45f7 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -2094,7 +2094,6 @@ static const struct block_device_operations msb_bdops = {
 static int msb_init_disk(struct memstick_dev *card)
 {
 	struct msb_data *msb = memstick_get_drvdata(card);
-	struct memstick_host *host = card->host;
 	int rc;
 	unsigned long capacity;
 
-- 
2.17.0
