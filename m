Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753529AbeBIOA5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 09:00:57 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:56087 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752752AbeBIOAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 09:00:53 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180209140051epoutp04c96aa96c653070fb4ac5782fdb0fcc14~RrRQolw9S2020120201epoutp04C
X-AuditID: b6c32a37-44bff70000001029-4a-5a7da9921043
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] fbdev fix for v4.16
Date: Fri, 09 Feb 2018 15:00:47 +0100
Message-id: <2724350.XWj4eWGWql@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsWy7bCmnu6klbVRBlM+C1lc+fqezeJE3wdW
        i8u75rBZrJ9/i81i/xUvi0d9b9kd2Dy+fZ3E4nFixm8Wj/vdx5k8jt/YzuTxeZNcAGsUl01K
        ak5mWWqRvl0CV8bNrYoFT8Uqnnw5x9zA+Fa4i5GDQ0LARKL9hlUXIxeHkMAORon37SeYIZzv
        jBIzd/9ihCnqP8AGEd/NKNH7+jkThPOVUWLr1fPsXYycHGwCVhIT21cxgtgiAkYSn19cYQUp
        YhZYwyhxfGsPWJGwgLrE4Rk9TCA2i4CqRP+JqcwgNq+ApkTDo1tgzaICXhJb9rUzQcQFJX5M
        vscCYjMLyEvs2z+VFcLWkTh7bB1YvYTAHDaJxvZqCNtF4tumflYIW1ji1fEt7BAfSEtcOmoL
        co+EwCpGiZ9X/zJCOJsZJT5f/wrVYC1x+PhFqAV8Eu++9rBCNPNKdLQJQZR4SLRtbYba6yhx
        p+8CG4gtJBAr8XfJccYJjDKzkJw9C8nZs5CcvYCReRWjWGpBcW56arFhgbFecWJucWleul5y
        fu4mRnD0a5nvYNxwzucQowAHoxIP74u4migh1sSy4srcQ4wSHMxKIryXV9RGCfGmJFZWpRbl
        xxeV5qQWH2KU5mBREucNCHCJEhJITyxJzU5NLUgtgskycXBKNTCafns7Y7aqaHzh5AkabNl6
        4udlX3C8bl8bv+HmxpeV39ceXK2geYz3JP8v6VluMSfklGQaqhIeHrNZotG5MOvRLoVUlebf
        7htXlShOeMp5Ys/J60mzONpvenPO4euSYQk8ypidnP6GJ2CmU1VCWtGCFA6bxuzDN+JYnl+c
        OemogLS93nrbdiMlluKMREMt5qLiRAD7JkFh+gIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCLMWRmVeSWpSXmKPExsVy+t9jAd2JK2ujDNaf1bK48vU9m8WJvg+s
        Fpd3zWGzWD//FpvF/iteFo/63rI7sHl8+zqJxePEjN8sHve7jzN5HL+xncnj8ya5ANYoLpuU
        1JzMstQifbsEroybWxULnopVPPlyjrmB8a1wFyMHh4SAiUT/AbYuRi4OIYGdjBJTPz9lhHC+
        Mkos+/uTuYuRk4NNwEpiYvsqRhBbRMBI4vOLK6wgNrPAGkaJt5N1QGxhAXWJwzN6mEBsFgFV
        if4TU8F6eQU0JRoe3QLrFRXwktiyr50JIi4o8WPyPRaIOfIS+/ZPhZqpJbF+53GmCYy8s5CU
        zUJSNgtJ2QJG5lWMkqkFxbnpucVGBYZ5qeV6xYm5xaV56XrJ+bmbGIFhue2wVt8OxvtL4g8x
        CnAwKvHwToipiRJiTSwrrsw9xCjBwawkwnt5RW2UEG9KYmVValF+fFFpTmrxIUZpDhYlcd7b
        eccihQTSE0tSs1NTC1KLYLJMHJxSDYxlUcHmjUUK+65EBAmX/ROxNHkRKu2/j/9vG5/5rqxp
        gs84ty+b3/WMpWjt53Xmkrylizca6D08yO+/Pjoy13//BdHNPhW3vHP8l3NOKM5Rt7D+d+Hl
        2dijydEJB/fv9zJU/zBFZ3KfwNKLyRN/HUntV+JOf2JwX6Vp0v1HN5pvdzaxmLzatlOJpTgj
        0VCLuag4EQA5PamjRwIAAA==
X-CMS-MailID: 20180209140049epcas1p2f634bd4306a16e4cf7ee7b411b811f0b
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180209140049epcas1p2f634bd4306a16e4cf7ee7b411b811f0b
X-RootMTR: 20180209140049epcas1p2f634bd4306a16e4cf7ee7b411b811f0b
References: <CGME20180209140049epcas1p2f634bd4306a16e4cf7ee7b411b811f0b@epcas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Please pull fbdev fix for v4.16 (just a single fix to make
omapfb driver build again).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


The following changes since commit f1517df8701c9f12dae9ce7f43a5d300a6917619:

  Merge tag 'nfsd-4.16' of git://linux-nfs.org/~bfields/linux (2018-02-08 15:18:32 -0800)

are available in the git repository at:

  https://github.com/bzolnier/linux.git tags/fbdev-v4.16-fix

for you to fetch changes up to b9058afcd6c725a8d293bb0a1b30bad68113235e:

  video: omapfb: fix missing #includes (2018-02-09 14:43:49 +0100)

----------------------------------------------------------------
fbdev fix for v4.16:

- fix building of the omapfb driver (Tomi Valkeinen)

----------------------------------------------------------------
Tomi Valkeinen (1):
      video: omapfb: fix missing #includes

 drivers/video/fbdev/omap2/omapfb/dss/dss.c      | 1 +
 drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c | 2 ++
 drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c | 1 +
 drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c  | 2 ++
 4 files changed, 6 insertions(+)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dss.c b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
index 39fe724..f0cac9e 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dss.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
@@ -40,6 +40,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/suspend.h>
 #include <linux/component.h>
+#include <linux/pinctrl/consumer.h>
 
 #include <video/omapfb_dss.h>
 
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
index eee09b4b..11dbc05 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
@@ -13,6 +13,8 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/seq_file.h>
+
 #include <video/omapfb_dss.h>
 
 #include "dss.h"
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c
index eac3665..bc591fc 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c
@@ -16,6 +16,7 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
+#include <linux/seq_file.h>
 
 #include <video/omapfb_dss.h>
 
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c
index 705373e..4af6ba2 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c
@@ -14,6 +14,8 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
+#include <linux/seq_file.h>
+
 #include <video/omapfb_dss.h>
 
 #include "dss.h"
