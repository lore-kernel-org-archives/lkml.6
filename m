Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752150AbeENKwe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 06:52:34 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34049 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbeENKwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 06:52:32 -0400
X-Google-Smtp-Source: AB8JxZrJJTNC4MuhRHIHOAXxni514VJ+CM6Y6t5feA+SDb3JIRbZB3isoCAZRsVOYdiGtnPQ1l6uaQ==
From: Anders Roxell <anders.roxell@linaro.org>
To: axboe@kernel.dk, maximlevitsky@gmail.com
Cc: linux-kernel@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2] memstick: mspro_block: fix unused variable warning
Date: Mon, 14 May 2018 12:52:05 +0200
Message-Id: <20180514105205.9504-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514101756.2120-2-anders.roxell@linaro.org>
References: <20180514101756.2120-2-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building mspro_block a warning pops up unused variable 'host',
drivers/memstick/core/mspro_block.c: In function ‘mspro_block_init_disk’:
drivers/memstick/core/mspro_block.c:1173:24: warning: unused variable ‘host’ [-Wunused-variable]
  struct memstick_host *host = card->host;
                        ^~~~

Removing the declaration of 'host' in function mspro_block_init_disk.

Fixes: 7c2d748e8476 ("memstick: don't call blk_queue_bounce_limit")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/memstick/core/mspro_block.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
index a2fadc605750..5ee932631fae 100644
--- a/drivers/memstick/core/mspro_block.c
+++ b/drivers/memstick/core/mspro_block.c
@@ -1170,7 +1170,6 @@ static int mspro_block_init_card(struct memstick_dev *card)
 static int mspro_block_init_disk(struct memstick_dev *card)
 {
 	struct mspro_block_data *msb = memstick_get_drvdata(card);
-	struct memstick_host *host = card->host;
 	struct mspro_devinfo *dev_info = NULL;
 	struct mspro_sys_info *sys_info = NULL;
 	struct mspro_sys_attr *s_attr = NULL;
-- 
2.17.0
