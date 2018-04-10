Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753818AbeDJMoo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:44:44 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:33073 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753130AbeDJMok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:44:40 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180410124438epoutp01da6f6ff0e6b03f5e81b9e62b008b3955~kE72SCIvu2465424654epoutp01Z
X-AuditID: b6c32a37-55dff70000000fe6-49-5accb1b5fb09
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
Subject: [PATCH 14/17] thermal: ti-soc-thermal: enable/check sensor after
 its setup is finished
Date: Tue, 10 Apr 2018 14:42:08 +0200
Message-id: <1523364131-31059-15-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAz2SaUhUURiGO3NXhyZuo+hJxWIgIsENs06lthB4Q3/0QxAsqkFvLrkMc1Wy
        slynMkcNidREK4100qaZ1DEXcmmc3AK1xNzKJVErzcQto3KW+vd+3/u8vHyHQ2Pi24Q9HRET
        x8ljpFESUojXtu11c6nRdAe7p2s8kSZfTaDpJQNAVUo9jkreDRCoOaUfoD8TXwjUqUsVoPTC
        RzgqmxqnUH99EYmWlK8BKpofptDUeDaJZqrtkLZ8kETr9cU4ahpbAke3s6kL7SRb+LGHZF8W
        jlJszZAXW9o4K2C1qlskOzLQSLLKtHmSza5WAVY3UIyxb+6t4qxhUCdgl7ROp0TBQu9QLioi
        gZO7+Z4XhpfqJjDZMn3p2xqVDMaoTGBFQ2Yf/PVkEmQCIS1m6gDsyU+zDKsATqbU/KfWy0YJ
        s9EAoOHrJwv1E8DarmbCSJHMIXjnhmrToGkbxh9WV9JGBmMKcPh9RI8ZGWtGCoc3Fk08zuyG
        5UotbtQi5iRUZZQQ5jYn2NGeZ9JWm/uNpgVTM2TyKJg1sYGZoRPwWcVvS8AazhmqKWMxZBxg
        n97HzKcBuFLXaOFzAWxUi836MGwz9JqyGLMNzi9nEeasCN5UWBAWlr/oI836GGwZMb6X8eAi
        ANV3FVQusH8AtqiALSfjo8M43kPm6cpLo/n4mDDXkNhoLTB9EecDdeD524BWwNBAslWU29IV
        LCakCXxidCuANCaxEUVVdQeLRaHSxMucPPacPD6K41uBA41L7ESfAzYtJkwax13kOBkn/+cK
        aCv7ZOBe6qevOJJAeUW4T9vMZdkevJoXufqhc6W0PGgmVd3xMN0vZH9ve2DkRlIXURY4O+Py
        1IsXKBZPz+fnZPkNacYfT1nFaRTvCxyKdqhb4nShsQGEf1rf9SR4wXdg+op3uiN5LbHTZ7Ii
        MvFV5ZmgvvuyjF0NZx1Tdtr8OL62h83hJTgfLvVwxuS89C+68JM7HgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsVy+t9jAd0tG89EGXzfr2qxccZ6Votnn48z
        WqztPcpiMf/KNVaLA42XGS3+P3rNanFqexOTRcusRSwWS548ZLe4vGsOm8Xn3iOMFnPe3Wa3
        ePKwj83ixRZxi00rbrBZ/Nw1j8Vi773PjA6CHk3vj7F5zLp/ls1j56y77B5bb5l6LN7zkslj
        06pONo871/awefQ2v2Pz6NuyitFj+7V5zB4npn9n8Th+YzuTx+dNcgG8UVw2Kak5mWWpRfp2
        CVwZi7c/Yi74ylHx9gd7A+M99i5GTg4JAROJn0vusnYxcnEICexklLh3YQUbhPOLUeLy8rWs
        IFVsAlYSE9tXMXYxcnCICHhLbFnDAVLDLDCTRaJt6lNGkBphgUSJ5pW3mEFsFgFViRW9m1hA
        bF4BT4lVrfNZIbbJSZw8NhnM5gSK/977nhVkppCAh8S3KdYTGHkWMDKsYpRMLSjOTc8tNiow
        zEst1ytOzC0uzUvXS87P3cQIDPlth7X6djDeXxJ/iFGAg1GJh3fCwdNRQqyJZcWVuYcYJTiY
        lUR4c9aeiRLiTUmsrEotyo8vKs1JLT7EKM3BoiTOezvvWKSQQHpiSWp2ampBahFMlomDU6qB
        scStsLRmTfTubVwrb5re/mojkjJz3YeHvc/8z9/78SRo58e4F3+PF0zc+uUqn7KF2PXswIKv
        D85Kf0tN+rp5mdWRl47fWc0sW5lPKf+xs2MwSpimyLJ3a+41oReTorqU/UWv317Ozfj2fC07
        08OLopYLFySGSeicZlT8+8guXmudw8WpDUfuOyuxFGckGmoxFxUnAgCDojjodQIAAA==
X-CMS-MailID: 20180410124436epcas1p3422f3653277634b8cc8bef223bc9298f
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180410124436epcas1p3422f3653277634b8cc8bef223bc9298f
X-RootMTR: 20180410124436epcas1p3422f3653277634b8cc8bef223bc9298f
References: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180410124436epcas1p3422f3653277634b8cc8bef223bc9298f@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable sensor after setting sensor data and check sensor after
writing update interval.

Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Keerthy <j-keerthy@ti.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 3c2299b..a9afbf9 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -197,13 +197,15 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
 		return PTR_ERR(data->ti_thermal);
 	}
 
+	ti_bandgap_set_sensor_data(bgp, id, data);
+
 	thermal_zone_device_toggle(data->ti_thermal, true);
-	thermal_zone_device_check(data->ti_thermal);
 
-	ti_bandgap_set_sensor_data(bgp, id, data);
 	ti_bandgap_write_update_interval(bgp, data->sensor_id,
 					data->ti_thermal->polling_delay);
 
+	thermal_zone_device_check(data->ti_thermal);
+
 	return 0;
 }
 
-- 
1.9.1
