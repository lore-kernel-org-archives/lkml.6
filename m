Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752170AbeENIZo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:25:44 -0400
Received: from verein.lst.de ([213.95.11.211]:35173 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751894AbeENIZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:25:42 -0400
Date: Mon, 14 May 2018 10:29:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jens Axboe <axboe@kernel.dk>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: build warning after merge of the block tree
Message-ID: <20180514082951.GA20978@lst.de>
References: <20180514125139.459a058d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514125139.459a058d@canb.auug.org.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 12:51:39PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the block tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:

The look entirely correct, but oddly enough my compiler did not bother
to warn.

Fix below:

--
>From 6610bd5bbbf05fa1d925b0601a09e84cada9e0a2 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Mon, 14 May 2018 10:24:34 +0200
Subject: memstick: remove unused variables

Fixes: 7c2d748e8476 ("memstick: don't call blk_queue_bounce_limit")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/memstick/core/ms_block.c    | 1 -
 drivers/memstick/core/mspro_block.c | 1 -
 2 files changed, 2 deletions(-)

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
