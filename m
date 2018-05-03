Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751138AbeECLM4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 07:12:56 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:14766 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbeECLMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 07:12:51 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180503111249epoutp01e81320a3bc27bc46817eb1d568e33344~rHhPt8nKk2602326023epoutp01d
X-AuditID: b6c32a4a-a79ff700000010d4-9d-5aeaeeb15c23
From: Satendra Singh Thakur <satendra.t@samsung.com>
To: Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Satendra Singh Thakur <satendra.t@samsung.com>,
        Hans Verkuil <hans.verkuil@cisco.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc: Madhur Verma <madhur.verma@samsung.com>,
        Hemanshu Srivastava <hemanshu.s@samsung.com>
Subject: [PATCH 13/13] drm/kms/mode/bridge-adv7533: using helper func
 drm_display_mode_to_videomode for calculating timing parameters
Date: Thu,  3 May 2018 16:42:02 +0530
Message-Id: <45d991d4700fcb0ea4f1d4e18b8fc00b69082cc0.1525087679.git.satendra.t@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1525087679.git.satendra.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplk+LIzCtJLcpLzFFi42LZdlhTQ3fju1dRBrMncFrcWneO1aL33Ekm
        i6aOt6wWV76+Z7NY8nMXk8Wr82+YLTonLmG3uLxrDpvF4alL2CzWnm9lceDymPJ7I6vH5b5e
        Jo/ZHTNZPbZ/e8Dqcb/7OJNH35ZVjB6fN8kFsEel2mSkJqakFimk5iXnp2TmpdsqeQfHO8eb
        mhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYA3aekUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVWK
        NjQ00jM0MNczMjLSMzGNtTIyBSpJSM3Yf6OBpaBLruLxphXsDYwnJbsYOTkkBEwkJj+Yz9jF
        yMUhJLCbUeLtlvdMEM4nRolPVx6xglQJCXxjlGjckAHTMenTWVaIor2MEq823mKBcL4ySmxo
        /sUCUsUGVPV8zgywKhGBI0wS35+tZwZJMAtES0y7tIMZJCEs0M4oseDGazaQBIuAqsSBtl5G
        EJtXIEbi36sNbBD75CRunusEauDg4BSwktjzJQmkV0LgCJvEhJ/H2UHiEgIuEtduKECUC0u8
        Or6FHcKWknjZ38YOUd/MKPFg3UIop4dRoqPzGFSVvUTLlAMsIIOYBTQl1u/ShwjbSryae4MV
        4mg+id7fT5ggdvFKdLQJQZSoSKx8cZgZZtefBV2sELaHxI/mKywQtqPEtolb2CAh1Mso8WbT
        TZYJjPKzELYtYGRcxSiZWlCcm55abFpglJdarlecmFtcmpeul5yfu4kRnBS1vHYwLjvnc4hR
        gINRiYf3wNmXUUKsiWXFlbmHGCU4mJVEeKd0v4oS4k1JrKxKLcqPLyrNSS0+xGgKDNiJzFKi
        yfnAhJ1XEm9oYmlgYmZmbmhgYGmiJM578+S9KCGB9MSS1OzU1ILUIpg+Jg5OqQZGrhXeO4yv
        GZa2MLNkpjgo3tr4M5EttX/dr0WvjDOCFrE4pbTMvRjUd4h5A/8KIzavNX+X+XRzLnseeXHV
        3yJZo2MFcaH3toTWeE2X7jjcs1vH6KuwAWfy94gLEnf4Pnaox816uuqgZ3fTq5Z/V3WPfjMX
        ltvnHZ43qTDnZmyg63PWr1Hpbt+VWIozEg21mIuKEwEldBYuoAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLLMWRmVeSWpSXmKPExsWy7bCSnO6Gd6+iDHZNVra4te4cq0XvuZNM
        Fk0db1ktrnx9z2ax5OcuJotX598wW3ROXMJucXnXHDaLw1OXsFmsPd/K4sDlMeX3RlaPy329
        TB6zO2ayemz/9oDV4373cSaPvi2rGD0+b5ILYI/isklJzcksSy3St0vgyth/o4GloEuu4vGm
        FewNjCcluxg5OSQETCQmfTrL2sXIxSEksJtR4kd3PzNEQkpi2ZttbBC2sMTKf8/ZQWwhgc+M
        Encm2oDYbEDNz+fMAGsWETjFJNE/p5sJJMEsEC3x7sZdJpCEsEAro8Sk639YQBIsAqoSB9p6
        GUFsXoEYiX+vNkBtkJO4ea4TaDMHB6eAlcSeL0kQyywl2vsOs05g5FvAyLCKUTK1oDg3PbfY
        sMAoL7Vcrzgxt7g0L10vOT93EyM4ULW0djCeOBF/iFGAg1GJh/fA2ZdRQqyJZcWVuYcYJTiY
        lUR4p3S/ihLiTUmsrEotyo8vKs1JLT7EKM3BoiTOK59/LFJIID2xJDU7NbUgtQgmy8TBKdXA
        KHXvW5L38V3z9W3UJe95e35lv6Ox/ZvJ811XJ93Uq8qX9Wd5bCx225TNckLK4hOKkxu+tEt9
        m+Am2DUre/JrJuHq7sgJBzLS5VQ53qctFTeXluOcqnzh9dt7eoXvVWOvnRfTzHxR/sZr8coc
        4xgB7y99D/1rItYtcmkNqBRt/Bph16GwcepjJZbijERDLeai4kQAjX931FACAAA=
X-CMS-MailID: 20180503111248epcas5p4c2b8d1fd447cfbe0b53cf535faaf92c2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180503111248epcas5p4c2b8d1fd447cfbe0b53cf535faaf92c2
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180503111248epcas5p4c2b8d1fd447cfbe0b53cf535faaf92c2
X-RootMTR: 20180503111248epcas5p4c2b8d1fd447cfbe0b53cf535faaf92c2
References: <cover.1525087679.git.satendra.t@samsung.com>
        <CGME20180503111248epcas5p4c2b8d1fd447cfbe0b53cf535faaf92c2@epcas5p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid duplicate logic for the same:
There is a function in drm-core to calculate display timing parameters:
horizontal front porch, back porch, sync length,
vertical front porch, back porch, sync length and
clock in Hz.
However, some drivers are still calculating these parameters themselves.
Therefore, there is a duplication of the code.
This patch series replaces this redundant code with the function
drm_display_mode_to_videomode.
This removes nearly 100 redundant lines from the related drivers.

Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
Cc: Madhur Verma <madhur.verma@samsung.com>
Cc: Hemanshu Srivastava <hemanshu.s@samsung.com>
---
 drivers/gpu/drm/bridge/adv7511/adv7533.c | 35 ++++++++++++++------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7533.c b/drivers/gpu/drm/bridge/adv7511/adv7533.c
index 185b6d8..881a703 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7533.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7533.c
@@ -14,6 +14,7 @@
 #include <linux/of_graph.h>
 
 #include "adv7511.h"
+#include <video/videomode.h>
 
 static const struct reg_sequence adv7533_fixed_registers[] = {
 	{ 0x16, 0x20 },
@@ -36,15 +37,9 @@ static void adv7511_dsi_config_timing_gen(struct adv7511 *adv)
 {
 	struct mipi_dsi_device *dsi = adv->dsi;
 	struct drm_display_mode *mode = &adv->curr_mode;
-	unsigned int hsw, hfp, hbp, vsw, vfp, vbp;
+	struct videomode vm;
 	u8 clock_div_by_lanes[] = { 6, 4, 3 };	/* 2, 3, 4 lanes */
-
-	hsw = mode->hsync_end - mode->hsync_start;
-	hfp = mode->hsync_start - mode->hdisplay;
-	hbp = mode->htotal - mode->hsync_end;
-	vsw = mode->vsync_end - mode->vsync_start;
-	vfp = mode->vsync_start - mode->vdisplay;
-	vbp = mode->vtotal - mode->vsync_end;
+	drm_display_mode_to_videomode(mode, &vm);
 
 	/* set pixel clock divider mode */
 	regmap_write(adv->regmap_cec, 0x16,
@@ -53,22 +48,22 @@ static void adv7511_dsi_config_timing_gen(struct adv7511 *adv)
 	/* horizontal porch params */
 	regmap_write(adv->regmap_cec, 0x28, mode->htotal >> 4);
 	regmap_write(adv->regmap_cec, 0x29, (mode->htotal << 4) & 0xff);
-	regmap_write(adv->regmap_cec, 0x2a, hsw >> 4);
-	regmap_write(adv->regmap_cec, 0x2b, (hsw << 4) & 0xff);
-	regmap_write(adv->regmap_cec, 0x2c, hfp >> 4);
-	regmap_write(adv->regmap_cec, 0x2d, (hfp << 4) & 0xff);
-	regmap_write(adv->regmap_cec, 0x2e, hbp >> 4);
-	regmap_write(adv->regmap_cec, 0x2f, (hbp << 4) & 0xff);
+	regmap_write(adv->regmap_cec, 0x2a, vm.hsync_len >> 4);
+	regmap_write(adv->regmap_cec, 0x2b, (vm.hsync_len << 4) & 0xff);
+	regmap_write(adv->regmap_cec, 0x2c, vm.hfront_porch >> 4);
+	regmap_write(adv->regmap_cec, 0x2d, (vm.hfront_porch << 4) & 0xff);
+	regmap_write(adv->regmap_cec, 0x2e, vm.hback_porch >> 4);
+	regmap_write(adv->regmap_cec, 0x2f, (vm.hback_porch << 4) & 0xff);
 
 	/* vertical porch params */
 	regmap_write(adv->regmap_cec, 0x30, mode->vtotal >> 4);
 	regmap_write(adv->regmap_cec, 0x31, (mode->vtotal << 4) & 0xff);
-	regmap_write(adv->regmap_cec, 0x32, vsw >> 4);
-	regmap_write(adv->regmap_cec, 0x33, (vsw << 4) & 0xff);
-	regmap_write(adv->regmap_cec, 0x34, vfp >> 4);
-	regmap_write(adv->regmap_cec, 0x35, (vfp << 4) & 0xff);
-	regmap_write(adv->regmap_cec, 0x36, vbp >> 4);
-	regmap_write(adv->regmap_cec, 0x37, (vbp << 4) & 0xff);
+	regmap_write(adv->regmap_cec, 0x32, vm.vsync_len >> 4);
+	regmap_write(adv->regmap_cec, 0x33, (vm.vsync_len << 4) & 0xff);
+	regmap_write(adv->regmap_cec, 0x34, vm.vfront_porch >> 4);
+	regmap_write(adv->regmap_cec, 0x35, (vm.vfront_porch << 4) & 0xff);
+	regmap_write(adv->regmap_cec, 0x36, vm.vback_porch >> 4);
+	regmap_write(adv->regmap_cec, 0x37, (vm.vback_porch << 4) & 0xff);
 }
 
 void adv7533_dsi_power_on(struct adv7511 *adv)
-- 
2.7.4
