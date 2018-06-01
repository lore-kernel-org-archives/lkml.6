Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753550AbeFASqp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 14:46:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:58976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753373AbeFASql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 14:46:41 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: devel@driverdev.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 5/5] staging: ipx: delete it from the tree
Date: Fri,  1 Jun 2018 20:45:47 +0200
Message-Id: <20180601184547.20213-6-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180601184547.20213-1-gregkh@linuxfoundation.org>
References: <20180601184547.20213-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ipx code moved into the staging tree back in November 2017 and no
one has complained or even noticed it was gone.  Because of that, let's
just delete it.

Note, the ipx header files are not removed here, that will come later
through the networking tree, as that takes a bit more work to unwind.

Cc: Stephen Hemminger <stephen@networkplumber.org>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/Kconfig              |    2 -
 drivers/staging/Makefile             |    1 -
 drivers/staging/ipx/Kconfig          |   61 -
 drivers/staging/ipx/Makefile         |    8 -
 drivers/staging/ipx/TODO             |    4 -
 drivers/staging/ipx/af_ipx.c         | 2082 --------------------------
 drivers/staging/ipx/ipx_proc.c       |  338 -----
 drivers/staging/ipx/ipx_route.c      |  293 ----
 drivers/staging/ipx/pe2.c            |   36 -
 drivers/staging/ipx/sysctl_net_ipx.c |   40 -
 10 files changed, 2865 deletions(-)
 delete mode 100644 drivers/staging/ipx/Kconfig
 delete mode 100644 drivers/staging/ipx/Makefile
 delete mode 100644 drivers/staging/ipx/TODO
 delete mode 100644 drivers/staging/ipx/af_ipx.c
 delete mode 100644 drivers/staging/ipx/ipx_proc.c
 delete mode 100644 drivers/staging/ipx/ipx_route.c
 delete mode 100644 drivers/staging/ipx/pe2.c
 delete mode 100644 drivers/staging/ipx/sysctl_net_ipx.c

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index b695560cab2f..563dd3ee682a 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -24,8 +24,6 @@ menuconfig STAGING
 
 if STAGING
 
-source "drivers/staging/ipx/Kconfig"
-
 source "drivers/staging/wlan-ng/Kconfig"
 
 source "drivers/staging/comedi/Kconfig"
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index d6d0e9266cb5..03e77ee05c2a 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -3,7 +3,6 @@
 
 obj-y				+= media/
 obj-y				+= typec/
-obj-$(CONFIG_IPX)		+= ipx/
 obj-$(CONFIG_PRISM2_USB)	+= wlan-ng/
 obj-$(CONFIG_COMEDI)		+= comedi/
 obj-$(CONFIG_FB_OLPC_DCON)	+= olpc_dcon/
diff --git a/drivers/staging/ipx/Kconfig b/drivers/staging/ipx/Kconfig
deleted file mode 100644
index cdff083d0ee6..000000000000
diff --git a/drivers/staging/ipx/Makefile b/drivers/staging/ipx/Makefile
deleted file mode 100644
index 440fafa9fd07..000000000000
diff --git a/drivers/staging/ipx/TODO b/drivers/staging/ipx/TODO
deleted file mode 100644
index 80db5d968264..000000000000
diff --git a/drivers/staging/ipx/af_ipx.c b/drivers/staging/ipx/af_ipx.c
deleted file mode 100644
index 5703dd176787..000000000000
diff --git a/drivers/staging/ipx/ipx_proc.c b/drivers/staging/ipx/ipx_proc.c
deleted file mode 100644
index b9232e4e2ed4..000000000000
diff --git a/drivers/staging/ipx/ipx_route.c b/drivers/staging/ipx/ipx_route.c
deleted file mode 100644
index 3cf93aa9f284..000000000000
diff --git a/drivers/staging/ipx/pe2.c b/drivers/staging/ipx/pe2.c
deleted file mode 100644
index ba7d4214bbff..000000000000
diff --git a/drivers/staging/ipx/sysctl_net_ipx.c b/drivers/staging/ipx/sysctl_net_ipx.c
deleted file mode 100644
index c3eef457db88..000000000000
-- 
2.17.1
