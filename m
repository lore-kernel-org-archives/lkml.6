Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752938AbeDJMq3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:46:29 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:32700 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753210AbeDJMng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:43:36 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180410124334epoutp01cadf91d6d0a3717c90ef903bc030c366~kE66ZgB-r2510025100epoutp01n
X-AuditID: b6c32a45-6d3ff70000000fe4-ab-5accb1758d6b
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc: Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, Keerthy <j-keerthy@ti.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jun Nie <jun.nie@linaro.org>, Baoyou Xie <baoyou.xie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
Subject: [PATCH 06/17] thermal: brcmstb: enable/check sensor after its setup
 is finished
Date: Tue, 10 Apr 2018 14:42:00 +0200
Message-id: <1523364131-31059-7-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTYRjG/XauTk8cp+iHgcUgKyFNS/jSkKKiYxcKipSF6NCTk5zKjor6
        T+qsvGOIpbZMSimGOmbzMp1g3mY5pdDMTA1DTI1UGmrZfR7773nf5/e8vO/HR2OyYsKbTkhK
        5TVJykQ5KcVbe/cHH0gz2hQHtc+CkLHSQKB5uxWgxpJ+HD0cGydQd84oQH8+fibQy7ZcCcqr
        foSjurlZCo126EhkL+kDSLf8nkJzs6UkWjB5oeanEyT63lGDo64ZOzjmxuWuDJBc9YdhkjNX
        T1Ncy2Qw99iyKOGa9QUkNzVuIbkS7TLJlZr0gGsbr8G4wXsbOGedaJNw9mafi4xCejSOT0xI
        5zUBYTFSVf2gmUrRURnFna/IbFBBFgJnGrKHoWHETBUCKS1j2wEcq7i/XWwAaJvOxwsBvUU1
        GRix3wmgfb6XFItNADeGjLhjFMmGwDu39cAR8GDPQlMD7WAwtgqHq1P9mINxZxXQtvaJcGic
        3QO/PliTODTDcrCguBKIK/nAFwPlW4wzGw5/dK0QjkGQLadg5bcuSoROwnfGZULU7nDJatru
        74TzeiMQA1oA19stmGiUAWgxyEQdCnutr7fCGLsD5vf+osQzGZh/axvhYGvh5vYbHYe1pkWJ
        eLEOQO14C1kGvGuBkx548imCOp4XglIC/QWlWkhLivePTVY3g60/4neqHVSOnOsBLA3krkzZ
        8yGFjFCmC5nqHgBpTO7BJDbaFDImTpmZxWuSozVpibzQA3bSuNyLyT7/z2Ljlan8dZ5P4TX/
        XQnt7J0NXCeu7M2c3D1qu9AhXQ9JM93tdrtRlOWrLXJlzH21VYTTzfYTs5G/35QESD3q1ULe
        LsuR5Gur1rqpmuAvIY3DRfGqFlWsZ07VobrpaMxwWvgZhufK3/q6zDq5XBq6SroMO/udmYmI
        upyxFNUQXlYVyviF7ItY0QmlcU6RT2KaFuS4oFIG+mEaQfkXhCpzPh8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsVy+t9jAd3SjWeiDI7+E7HYOGM9q8Wzz8cZ
        Ldb2HmWxmH/lGqvFgcbLjBb/H71mtTi1vYnJomXWIhaLJU8esltc3jWHzeJz7xFGiznvbrNb
        PHnYx2bxYou4xaYVN9gsfu6ax2Kx995nRgdBj6b3x9g8Zt0/y+axc9Zddo+tt0w9Fu95yeSx
        aVUnm8eda3vYPHqb37F59G1Zxeix/do8Zo8T07+zeBy/sZ3J4/MmuQDeKC6blNSczLLUIn27
        BK6MpSd2shfMYa/o2X2BrYFxKlsXIweHhICJxLr1vF2MXBxCAjsZJS63L2PvYuQEcn4xSvQ8
        8wOx2QSsJCa2r2IEqRcR8JbYsoYDpJ5ZYCaLRNvUp4wgNcICURIz/pxhA7FZBFQlPs39ygRi
        8wp4SHT2zACrkRCQkzh5bDIriM0p4Cnxe+97VpCZQkA136ZYT2DkWcDIsIpRMrWgODc9t9io
        wCgvtVyvODG3uDQvXS85P3cTIzDgtx3W6t/B+HhJ/CFGAQ5GJR7eCQdPRwmxJpYVV+YeYpTg
        YFYS4c1ZeyZKiDclsbIqtSg/vqg0J7X4EKM0B4uSOC9//rFIIYH0xJLU7NTUgtQimCwTB6dU
        A6O2TRmLXc7loJeNN9dL/wifaMP3bHHopYmT1O5/9nuX8HwC79ISoeMV5hH/V3WFXpH4cOuh
        zbYFCo8jv34Sjpr+IMPy9bq637mbHf4G7ndoMzvrfMVh+uQu1vqfsSZ6zoWlLIqZzdWvgx8c
        W8nxXj/MTHP/y7qAl+n9T0MOrVhmmrGs5dKFXdxKLMUZiYZazEXFiQAbJEuydAIAAA==
X-CMS-MailID: 20180410124333epcas2p2491f24a23bc90b06dd7cf46bd469babd
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180410124333epcas2p2491f24a23bc90b06dd7cf46bd469babd
X-RootMTR: 20180410124333epcas2p2491f24a23bc90b06dd7cf46bd469babd
References: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180410124333epcas2p2491f24a23bc90b06dd7cf46bd469babd@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable/check sensor after setting priv->thermal.

Cc: Markus Mayer <mmayer@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/broadcom/brcmstb_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index fead74f..eada8c1 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -336,11 +336,11 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	priv->thermal = thermal;
+
 	thermal_zone_device_toggle(thermal, true);
 	thermal_zone_device_check(thermal);
 
-	priv->thermal = thermal;
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "could not get IRQ\n");
-- 
1.9.1
