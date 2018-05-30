Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932495AbeE3V6l (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 17:58:41 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:55583 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932222AbeE3V6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 17:58:39 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Steve Wise <swise@chelsio.com>, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Arnd Bergmann <arnd@arndb.de>, Yuval Shaia <yuval.shaia@oracle.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iw_cxgb4: add INFINIBAND_ADDR_TRANS dependency
Date: Wed, 30 May 2018 23:58:18 +0200
Message-Id: <20180530215826.1343234-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:uS5RcDf2FTQDEjDIBi4fSbu5DPxQ7KMNGrZfG0zR5ZTOh9qQpYM
 vs4ZhRMNBgiaAFJpSLdM+eajaWCJot3n/QbXG4PXo6OMmDxm7H4Djk8kH3SBlIdHSSEcXKg
 Q6SbBlE93WgjwmymCytRH0ObHcFWNszxZuZ4o8kJNgHKeUYHzsibCpYZKJ69i0iKVBkMckT
 RmFs54B6QmudncBD0D9Rw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9TpMMkemPJc=:8iyKcMs0ZI7vVKqGq5B21T
 rRdx8Zy94Iy5VZxaHNRLHwGAdXtwZH0Q1+q0e42b1RTjguQncRVLqjE9Ko1xYNnm+Lwpzt1WK
 UnBuh1eK0k3AxsDUyNEelgfO94BJy61c/eaWYRxefY1ZHMGtt8sSJyjpgMiMSxQrCZrUJQ46z
 90UqNDqpJleGZ5o9AF0QbHYhNbeswODV9qtczPiz/Pjv6KTAlbh56sRPbC2bVeDf8eXpNUeHk
 QGgYprTTtzqP/+v28FJPoBnQbgQapPdh9b3IMI8scUbn/MaKFOya3kklHxZRV6RDPNZEtqMUJ
 s3RRiKIi8flPWFTND/AGgB9m57tRHXMu+VoaknBjMHLKR7MvtKoEih9F+SkGVEM8MLaviGa97
 3Yoi+OTa34F41Ks19vrbqgEDI2nahBZ7Vk51VOlpIorc9Ol7BBAxY4EZ5p3kZbj9jTq9U/ybr
 U8RpV8X7sEYCrfYwHTPNWQfMGifJ3QFwNZC/PqS/gbq4hkWcfFaNbaVvkJYKQUky0HFSGhOf0
 Cu9Nqnp4Dguco6x9LYQ64nQdb8TAnII93PjIftW7qi+bg987TCDfOGfke+3nAe274IiYN7+ez
 G+vY8UYeydQ78i0CUi3co/Q9XCotiq4IcyKKkZivbJUTPgxW+2HO1iM56M9a3nX90UT+FbTV1
 7w5l+z8xnCuzjq7yiFKODVj8ynxfYwedCkcvOfQsimbAplN94Ei2DPg3a9Cice/CyZfo=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly added fill_res_ep_entry function fails to link if
CONFIG_INFINIBAND_ADDR_TRANS is not set:

drivers/infiniband/hw/cxgb4/restrack.o: In function `fill_res_ep_entry':
restrack.c:(.text+0x3cc): undefined reference to `rdma_res_to_id'
restrack.c:(.text+0x3d0): undefined reference to `rdma_iw_cm_id'

This adds a Kconfig dependency for the driver.

Fixes: 116aeb887371 ("iw_cxgb4: provide detailed provider-specific CM_ID information")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/infiniband/hw/cxgb4/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/cxgb4/Kconfig b/drivers/infiniband/hw/cxgb4/Kconfig
index 0a671a61fc92..e0522a5d5a06 100644
--- a/drivers/infiniband/hw/cxgb4/Kconfig
+++ b/drivers/infiniband/hw/cxgb4/Kconfig
@@ -1,6 +1,7 @@
 config INFINIBAND_CXGB4
 	tristate "Chelsio T4/T5 RDMA Driver"
 	depends on CHELSIO_T4 && INET
+	depends on INFINIBAND_ADDR_TRANS
 	select CHELSIO_LIB
 	select GENERIC_ALLOCATOR
 	---help---
-- 
2.9.0
