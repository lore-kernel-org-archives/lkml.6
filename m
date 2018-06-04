Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753251AbeFDH0c (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:26:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752872AbeFDHBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:01:22 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.14 25/52] dma-buf: remove redundant initialization of sg_table
Date: Mon,  4 Jun 2018 08:58:20 +0200
Message-Id: <20180604065607.580878314@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604065606.532044490@linuxfoundation.org>
References: <20180604065606.532044490@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>

commit 531beb067c6185aceabfdee0965234c6a8fd133b upstream.

sg_table is being initialized and is never read before it is updated
again later on, hence making the initialization redundant. Remove
the initialization.

Detected by clang scan-build:
"warning: Value stored to 'sg_table' during its initialization is
never read"

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20170914230516.6056-1-colin.king@canonical.com
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma-buf/dma-buf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -625,7 +625,7 @@ EXPORT_SYMBOL_GPL(dma_buf_detach);
 struct sg_table *dma_buf_map_attachment(struct dma_buf_attachment *attach,
 					enum dma_data_direction direction)
 {
-	struct sg_table *sg_table = ERR_PTR(-EINVAL);
+	struct sg_table *sg_table;
 
 	might_sleep();
 
