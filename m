Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753891AbeDJMpE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:45:04 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:33140 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752810AbeDJMpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:45:00 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180410124458epoutp0148ec1f418a2cb2f4a361d0c776d5d825~kE8ImMDeQ2465424654epoutp01e
X-AuditID: b6c32a38-d73ff70000001082-df-5accb1caafb5
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
Subject: [PATCH 17/17] thermal: warn on attempts to read temperature on
 disabled sensors
Date: Tue, 10 Apr 2018 14:42:11 +0200
Message-id: <1523364131-31059-18-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfyzUYRzHe+77476Oq2/HeMamdps/WJHG9qySmqZv8Uet+uf+iItvh+64
        3WFYrfMjv+9iJOxC9Ee7JTkX4m4V+ZEfbSKziJRa1J2W/Igo58t/r+fzfj2f957toTBRLuFO
        xcYnsqp4qVxMCvDmTm+/g32NA5JDzdMkaixvINDXhR6A6rVdOKoeGSXQi/RhgP59+k6gvpYM
        HsqqrMXRg5lpPhpu05NoQfsKIL1tnI9mpnUk+mZyQ8aHYyT601aFI8vkAjixl8mY7yaZyqlB
        knlW+YHPPH0fyNSZZ3mM0ZBHMhOjZpLRZtpIRmcyAKZltApjeu8u40zPWAuPWTB6nhNKBMei
        WXlsMqvyOx4piOlsuqrU7UkZas/FNKDFKR84UJAOgKWDI1g+EFAiuhXA9I1FPndYBvBHWwZ/
        x8rOyttiEd0O4PPJw5y0CqAuYxazByR9BBbnGEA+oCgXOgyaHlF2B6MrcPhzomvLcaYl0PzE
        itsZp72g9uM6aWchfQaOj9ZhXJknfN1dQtjZYXO+Zpkn7IsgfZsPjW02wEmnYElZA86xM5zr
        MfHtxZD2gG+7gjg/E8ClVvP20iIAzQ0ijo/Czp6hrQKM3g1ti4UEd1cIc7O3FQZq1ha3xyeh
        Va/i3q4H8N1fYRFwrwG7DMCVVaoVMlbtrwzwVUsV6qR4mW9UgsIItv6HD2oF5jfhHYCmgNhJ
        WPSyXyIipMnqVEUHgBQmdhHK6wckImG0NDWNVSVEqJLkrLoDeFC42E34JXwzomXSRPYayypZ
        1U7KoxzcNSAtpGB9eOQ6WRWkilnRBEbHng2IN4QWVmgVtcq++Q2r6x1HedyBql+2ZEvv3IWI
        4F26Zv+CJa9bskRJyVTw/ijic37x6rygfCL30sVSEEmk3fh97/zjnGpH+VT/Te/T3inGFfeQ
        sibrnLXm/j7NZf1ItJMpzgAsEcGhM2FX+Dwxro6R+vtgKrX0P6HcTRAbAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsVy+t9jAd2TG89EGVy8KGqxccZ6Votnn48z
        WqztPcpiMf/KNVaLA42XGS3+P3rNanFqexOTRcusRSwWS548ZLe4vGsOm8Xn3iOMFnPe3Wa3
        ePKwj83ixRZxi00rbrBZ/Nw1j8Vi773PjA6CHk3vj7F5zLp/ls1j56y77B5bb5l6LN7zkslj
        06pONo871/awefQ2v2Pz6NuyitFj+7V5zB4npn9n8Th+YzuTx+dNcgG8UVw2Kak5mWWpRfp2
        CVwZhzenFfTxV1zc3cHcwLidp4uRk0NCwESiraWTvYuRi0NIYCejxIGOZSwQzi9GiQlNt9hA
        qtgErCQmtq9i7GLk4BAR8JbYsoYDpIZZYCaLRNvUp4wgNcICURJ7NrxlAbFZBFQleh/8Bevl
        FfCUuH1tMTPENjmJk8cms4LYnEDx33vfs4LMFBLwkPg2xXoCI88CRoZVjJKpBcW56bnFRgWG
        eanlesWJucWleel6yfm5mxiBIb/tsFbfDsb7S+IPMQpwMCrx8E44eDpKiDWxrLgy9xCjBAez
        kghvztozUUK8KYmVValF+fFFpTmpxYcYpTlYlMR5b+cdixQSSE8sSc1OTS1ILYLJMnFwSjUw
        Woi5Sqlz2PnP2DXV7eGNRqX9n1RO8b1ec7vPXlj533FOEd+ICQuOLFlxuSNBlSeqJSv+nWv2
        1pMrj10IYstr66opT1IoN1iZzPjQLLTy7PcIOz4O9q9PGRh2z4sVNVZf8vJQ2OeJ7g+C1t9d
        d3WP1VTRvcy7Q0RNy6Ue3N5hMWHT/o0SdQneSizFGYmGWsxFxYkAzgJugnUCAAA=
X-CMS-MailID: 20180410124457epcas1p33e959cf61c2a7f54227e29ef5ba9b0eb
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180410124457epcas1p33e959cf61c2a7f54227e29ef5ba9b0eb
X-RootMTR: 20180410124457epcas1p33e959cf61c2a7f54227e29ef5ba9b0eb
References: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180410124457epcas1p33e959cf61c2a7f54227e29ef5ba9b0eb@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Add ops_of_thermal flag to struct thermal_zone_device_ops and
  set it in of-thermal.c.

* Add checking sensor mode for drivers using of-thermal.c to
  thermal_zone_get_temp() (print a warning if sensor is disabled).

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/of-thermal.c      |  2 ++
 drivers/thermal/thermal_helpers.c | 12 ++++++++++++
 include/linux/thermal.h           |  1 +
 3 files changed, 15 insertions(+)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index f60ccf1..68ebcda 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -392,6 +392,8 @@ static int of_thermal_get_crit_temp(struct thermal_zone_device *tz,
 
 	.bind = of_thermal_bind,
 	.unbind = of_thermal_unbind,
+
+	.ops_of_thermal = true,
 };
 
 /***   sensor API   ***/
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index bd10b4d..e3fc1c6 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -87,6 +87,18 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 	if (!tz || IS_ERR(tz) || !tz->ops->get_temp)
 		goto exit;
 
+	if (tz->ops->ops_of_thermal) {
+		enum thermal_device_mode mode;
+
+		ret = tz->ops->get_mode(tz, &mode);
+		if (ret)
+			goto exit;
+
+		if (mode == THERMAL_DEVICE_DISABLED)
+			dev_warn_once(&tz->device,
+				 "trying to read out disabled thermal zone\n");
+	}
+
 	mutex_lock(&tz->lock);
 
 	ret = tz->ops->get_temp(tz, temp);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 7de102f..31560b4 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -130,6 +130,7 @@ struct thermal_zone_device_ops {
 		       enum thermal_trip_type);
 
 	bool set_mode_skip_check;
+	bool ops_of_thermal;
 };
 
 struct thermal_cooling_device_ops {
-- 
1.9.1
