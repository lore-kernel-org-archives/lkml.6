Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753454AbeE3Llt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:41:49 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60744 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752141AbeE3LHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:00 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Chien Tin Tung" <chien.tin.tung@intel.com>,
        "Jason Gunthorpe" <jgg@mellanox.com>,
        "Shiraz Saleem" <shiraz.saleem@intel.com>,
        "Leon Romanovsky" <leonro@mellanox.com>
Date: Wed, 30 May 2018 11:52:42 +0100
Message-ID: <lsq.1527677562.809887726@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 137/153] RDMA/ucma: Correct option size check using optlen
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Chien Tin Tung <chien.tin.tung@intel.com>

commit 5f3e3b85cc0a5eae1c46d72e47d3de7bf208d9e2 upstream.

The option size check is using optval instead of optlen
causing the set option call to fail. Use the correct
field, optlen, for size check.

Fixes: 6a21dfc0d0db ("RDMA/ucma: Limit possible option size")
Signed-off-by: Chien Tin Tung <chien.tin.tung@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/infiniband/core/ucma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1009,7 +1009,7 @@ static ssize_t ucma_set_option(struct uc
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
-	if (unlikely(cmd.optval > KMALLOC_MAX_SIZE))
+	if (unlikely(cmd.optlen > KMALLOC_MAX_SIZE))
 		return -EINVAL;
 
 	optval = kmalloc(cmd.optlen, GFP_KERNEL);
