Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753883AbeCFOsj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:48:39 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:53271 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932773AbeCFOok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:44:40 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180306144437epoutp018d2cb4533f36e55fd22fc60fb2462878~ZW-nNsyO42727327273epoutp01N
X-AuditID: b6c32a45-3ebff70000001023-d4-5a9ea9551a45
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
Subject: [PATCH 02/12] thermal: exynos: remove parsing of
 samsung,tmu_default_temp_offset property
Date: Tue, 06 Mar 2018 15:43:45 +0100
Message-id: <1520347435-22970-3-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsWy7bCmhW7oynlRBi/ucVlsnLGe1WL+kXNA
        4so1Vov+x6+ZLc6f38BusekxkHt51xw2i8+9RxgtZpzfx2RxaOpeRoul1y8yWbTuPcJu8eRh
        H5sDr8eaeWsYPS5fu8jssXPWXXaPxXteMnlsWtXJ5rF5Sb1H35ZVjB6fN8kFcERx2aSk5mSW
        pRbp2yVwZWy9Mp+5oEukonPCH5YGxs8CXYycHBICJhJ3tqxg7mLk4hAS2MEocfLzMijnO6NE
        x/qvbDBV7/40skAkdjNKTGhdywbh/GKUWPxqHzNIFZuAlcTE9lWMILaIQInEtFW9jCBFzAJn
        mSR2bH/HApIQFkiRuH7wMTuIzSKgKtHV/hqsmVfAQ2LRMph1chInj01mBbE5BTwlTnScA9sm
        IXCETeLZ9fdMEEUuEqf6JkDZwhKvjm9hh7ClJZ6t2sgI0dDMKPFtxx5miMQERok964UgbGuJ
        w8cvgm1gFuCT6Dj8F6iZAyjOK9HRBlXiIXHy/TuoVkeJQ1ca2SFensMoceT+a6YJjFILGBlW
        MYqlFhTnpqcWGxUY6hUn5haX5qXrJefnbmIEx7yW6w7GGed8DjEKcDAq8fBu8JgbJcSaWFZc
        mXuIUYKDWUmEN0J/XpQQb0piZVVqUX58UWlOavEhRmkOFiVx3rYAlyghgfTEktTs1NSC1CKY
        LBMHp1QD47mlvVGujPulFxxwCP5ksDtzelB0+MqC/oI01QjOkvVlWlPDeR4pi/n6NO7SmnFS
        tkNl6+FX3rN+n/jLKjd90/+H8vI7b/xOOipgKCLwmT9QjiVklv26rU0v2qseOUby/xeTmCkh
        lCHzUXGLzY0fBccDTjxTlCl/WuavfC5xr92rqsmu1ixXlFiKMxINtZiLihMBwXAsbvUCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBLMWRmVeSWpSXmKPExsVy+t9jAd2QlfOiDNrmsVtsnLGe1WL+kXNA
        4so1Vov+x6+ZLc6f38BusekxkHt51xw2i8+9RxgtZpzfx2RxaOpeRoul1y8yWbTuPcJu8eRh
        H5sDr8eaeWsYPS5fu8jssXPWXXaPxXteMnlsWtXJ5rF5Sb1H35ZVjB6fN8kFcERx2aSk5mSW
        pRbp2yVwZWy9Mp+5oEukonPCH5YGxs8CXYycHBICJhLv/jSydDFycQgJ7GSUePt6NyOE84tR
        4uKyTYwgVWwCVhIT21eB2SICJRKd014zg9jMAmeZJA7+5wCxhQVSJK4ffMwOYrMIqEp0tUPU
        8Ap4SCxa9pUNYpucxMljk1lBbE4BT4kTHefA4kJANYu7f7NNYORZwMiwilEytaA4Nz232KjA
        KC+1XK84Mbe4NC9dLzk/dxMjMDy3Hdbq38H4eEn8IUYBDkYlHt4NHnOjhFgTy4orcw8xSnAw
        K4nwRujPixLiTUmsrEotyo8vKs1JLT7EKM3BoiTOy59/LFJIID2xJDU7NbUgtQgmy8TBKdXA
        uFBQJm7vpB8WL11PlGR8fsiVHGMgX79CdZJIZnh/x8kWK4U+6SjZy/Yd4S6nop7HcHJv17tc
        cujz0rueBhteTzsb2cOzt69fNzxMavmG7zF6jKcF3EL/pyy9GmjrmVAh6mX86ESio7Y+z6dj
        Sh/KBZ4u+z+zV/jmKaZ3fdOvOvdMvLumveqCEktxRqKhFnNRcSIA/wV0NksCAAA=
X-CMS-MailID: 20180306144436epcas2p2f26ee2297cbd0e654930e8bb85512fe6
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180306144436epcas2p2f26ee2297cbd0e654930e8bb85512fe6
X-RootMTR: 20180306144436epcas2p2f26ee2297cbd0e654930e8bb85512fe6
References: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180306144436epcas2p2f26ee2297cbd0e654930e8bb85512fe6@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trimming (one point based or two points based) is always used for
the temperature calibration and the default non-trimming code should
never be reached.

Modify temp_to_code() and code_to_temp() accordingly (WARN_ON(1)
in the default cases) and then remove no longer needed parsing of
samsung,tmu_default_temp_offset property.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 6 ++----
 drivers/thermal/samsung/exynos_tmu.h | 2 --
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index ed805c7..e42a08b 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -260,7 +260,7 @@ static int temp_to_code(struct exynos_tmu_data *data, u8 temp)
 		temp_code = temp + data->temp_error1 - pdata->first_point_trim;
 		break;
 	default:
-		temp_code = temp + pdata->default_temp_offset;
+		WARN_ON(1);
 		break;
 	}
 
@@ -287,7 +287,7 @@ static int code_to_temp(struct exynos_tmu_data *data, u16 temp_code)
 		temp = temp_code - data->temp_error1 + pdata->first_point_trim;
 		break;
 	default:
-		temp = temp_code - pdata->default_temp_offset;
+		WARN_ON(1);
 		break;
 	}
 
@@ -1164,8 +1164,6 @@ static int exynos_of_sensor_conf(struct device_node *np,
 	pdata->first_point_trim = (u8)value;
 	of_property_read_u32(np, "samsung,tmu_second_point_trim", &value);
 	pdata->second_point_trim = (u8)value;
-	of_property_read_u32(np, "samsung,tmu_default_temp_offset", &value);
-	pdata->default_temp_offset = (u8)value;
 
 	of_property_read_u32(np, "samsung,tmu_cal_type", &pdata->cal_type);
 
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index 8c468b6..a7e81b4 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -50,7 +50,6 @@ enum soc_type {
  * @efuse_value: platform defined fuse value
  * @min_efuse_value: minimum valid trimming data
  * @max_efuse_value: maximum valid trimming data
- * @default_temp_offset: default temperature offset in case of no trimming
  * @cal_type: calibration type for temperature
  *
  * This structure is required for configuration of exynos_tmu driver.
@@ -65,7 +64,6 @@ struct exynos_tmu_platform_data {
 	u32 max_efuse_value;
 	u8 first_point_trim;
 	u8 second_point_trim;
-	u8 default_temp_offset;
 
 	u32 cal_type;
 };
-- 
1.9.1
