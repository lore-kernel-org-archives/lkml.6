Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751832AbeFDSAG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 14:00:06 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:37520 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751439AbeFDSAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 14:00:02 -0400
X-IronPort-AV: E=Sophos;i="5.49,476,1520870400";
   d="scan'208";a="81550576"
From: adam.manzanares@wdc.com
To: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Cc: axboe@kernel.dk, bcrl@kvack.org, mingo@kernel.org, tglx@linutronix.de,
        kstewart@linuxfoundation.org, peterz@infradead.org,
        pombredanne@nexb.com, gregkh@linuxfoundation.org,
        bigeasy@linutronix.de, rgoldwyn@suse.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org,
        linux-api@vger.kernel.org, hch@infradread.org, jmoyer@redhat.com,
        willy@infradead.org, smfrench@gmail.com,
        Adam Manzanares <adam.manzanares@wdc.com>
Subject: [PATCH 2/2] fs: aio ioprio use ioprio_check_cap ret val
Date: Mon,  4 Jun 2018 10:59:57 -0700
Message-Id: <20180604175957.2647-2-adam.manzanares@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180604175957.2647-1-adam.manzanares@wdc.com>
References: <20180604175957.2647-1-adam.manzanares@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adam Manzanares <adam.manzanares@wdc.com>

Previously the value was ignored.

Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
---
 fs/aio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 9527ededa669..134e5b635d64 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1443,8 +1443,8 @@ static int aio_prep_rw(struct kiocb *req, struct iocb *iocb)
 		 */
 		ret = ioprio_check_cap(iocb->aio_reqprio);
 		if (ret) {
-			pr_debug("aio ioprio check cap error\n");
-			return -EINVAL;
+			pr_debug("aio ioprio check cap error: %d\n", ret);
+			return ret;
 		}
 
 		req->ki_ioprio = iocb->aio_reqprio;
-- 
2.17.0
