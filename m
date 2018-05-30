Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932544AbeE3ViJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 17:38:09 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:39069 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932222AbeE3ViI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 17:38:08 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Gerd Hoffmann <kraxel@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Joe Lawrence <joe.lawrence@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] samples: mbochs: add DMA_SHARED_BUFFER dependency
Date: Wed, 30 May 2018 23:37:31 +0200
Message-Id: <20180530213801.731288-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:xHKTQwAu2V2kFGH0gm7DzCklJ2irOBM1J1MWufskyojxbqzLl1G
 dnG4NTeWtndwiOLp/Y8sYl6+ZszlPIWcdBowrlzipDHQl4rSQP9PdGUqxiAiTg+bwdexinr
 e0clvob4LIdPoEbV78nnCkQjSsOPr5Mc8eIuQSonDvGXfLTv/Ap2aCFnYLQvkW4aSh6f1NK
 knkdKxQyCsWPWfXUXNSmQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mxgtVHquPpU=:nN6qDr9OCw6nWzxg3mdNXy
 wcT6ECkn9QCNgslp+SrpeMpTgWKu79wRLDMk07JTzsBijy5De+Gk+tr0MZl+P0uMhUocdK1Ao
 Pet9HNxEHoD9bDyTWZ3KfGMCmAbKgRcsz31nGk9xTh/wW3Xb846CKVYYqcN9Wzc1JFHM4zUqb
 ZI3xlzgIfGFPJGMUt7oAACmO/425zPmnaPBZKExMkn2UT3tPnIU6VK9DPpf0n4Rfp+j2FeTTU
 kK6EheTGbujaHliA3elHqrIO2p8w3W8ZdIZ4mzbXVDLVc4UTzT6BbA5OzZ/s5DF58xG6PSuf7
 y38toj3evw4MS3xTw8fZNUtutfIokS5I3ES3qTQLdOjpFpZDtSAlTMUR5vyrz0tre1qWoczrb
 A+Pu0l1izy5LEb5/TxodE7FsbpsvNg8VU9rMRwuj64eAc7JyJhGQKgskRRqWGF8QYomR/z5xJ
 JV5gQ43iEJ00nv2QKZaVxh+Me1ecvGViPXNPuYctLblpZw+HtXvUZ3G/32xcWa9K5/pqKae5M
 LXYrexZj9HpGKMNniJLPpO2OFrX6aC+vm6mW5KHgpPJs80i5tffCy3QqWd4hDIeUfr7qUYA/3
 O1PWp04CPogZ3FHEvhLJydyGr3n6lVTJRtKkzbxQe3QXQtC2ld21NkyhdsEDZliA+yiCQtX2V
 rR4e4CCukZ28GPAq/Jo4u8N5Lf9oPFCeXuxHb1AzQetptoa7+M2KJIjiauPD+0qsdCmE=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new bochs vbe sample fails to link when DMA_SHARED_BUFFER is
disabled:

ERROR: "dma_buf_export" [samples/vfio-mdev/mbochs.ko] undefined!
ERROR: "dma_buf_fd" [samples/vfio-mdev/mbochs.ko] undefined!

This uses a 'select' statement to enable that framework, like all
other users do.

Fixes: 8021194eb3da ("sample: vfio bochs vbe display (host device for bochs-drm)")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 samples/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/samples/Kconfig b/samples/Kconfig
index 3aeaaca77831..bd133efc1a56 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -135,6 +135,7 @@ config SAMPLE_VFIO_MDEV_MDPY_FB
 config SAMPLE_VFIO_MDEV_MBOCHS
 	tristate "Build VFIO mdpy example mediated device sample code -- loadable modules only"
 	depends on VFIO_MDEV_DEVICE && m
+	select DMA_SHARED_BUFFER
 	help
 	  Build a virtual display sample driver for use as a VFIO
 	  mediated device.  It supports the region display interface
-- 
2.9.0
