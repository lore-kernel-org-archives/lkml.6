Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425097AbeE1NYB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:24:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:38488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163222AbeE1Ksg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:48:36 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 166/496] nbd: fix return value in error handling path
Date: Mon, 28 May 2018 11:59:11 +0200
Message-Id: <20180528100326.858140919@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

[ Upstream commit 0979962f5490abe75b3e2befb07a564fa0cf631b ]

It seems that the proper value to return in this particular case is the
one contained into variable new_index instead of ret.

Addresses-Coverity-ID: 1465148 ("Copy-paste error")
Fixes: e46c7287b1c2 ("nbd: add a basic netlink interface")
Reviewed-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/nbd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1591,7 +1591,7 @@ again:
 			if (new_index < 0) {
 				mutex_unlock(&nbd_index_mutex);
 				printk(KERN_ERR "nbd: failed to add new device\n");
-				return ret;
+				return new_index;
 			}
 			nbd = idr_find(&nbd_index_idr, new_index);
 		}
