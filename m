Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753964AbeDPKOE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 06:14:04 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:51964 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752979AbeDPKN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 06:13:59 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180416101357epoutp028ad1839a5eef8a2b80b51fd92b83651d~l4v-0jMEg0411004110epoutp02y
X-AuditID: b6c32a48-8c1ff70000000ff2-a9-5ad477657b11
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
Subject: [PATCH 04/14] thermal: exynos: remove unused "type" field from
 struct exynos_tmu_platform_data
Date: Mon, 16 Apr 2018 12:11:55 +0200
Message-id: <1523873525-23718-5-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsWy7bCmmW5q+ZUog3/f5S02zljPajHvs6zF
        /CvXWC36H79mtjh/fgO7xeVdc9gsPvceYbSYcX4fk8WTh31sDpweO2fdZfdYvOclk8emVZ1s
        Hneu7WHz6NuyitHj8ya5ALYoLpuU1JzMstQifbsEroxXp5ewFTRyVFzd/YOxgfEcWxcjJ4eE
        gInEw39nmLoYuTiEBHYwSlx9+p0VwvnOKPF18VMmmKrXDcuZIRIbGCWObDnCAuH8YpTY8/wQ
        C0gVm4CVxMT2VYwgtoiAlsSJS9vB5jILTGCSePpqJthCYYFMiZP/TrGC2CwCqhJrbq0DGsvB
        wSvgIXFuRQ3ENjmJk8cmg5VwCnhKNK25xgYyR0JgAZtEZ98nqJNcJL5eWgdlC0u8Or6FHcKW
        lni2aiMjREMzo8S3HXuYIRITgE5dLwRhW0scPn4RbAOzAJ9Ex+G/7CBHSAjwSnS0QZV4SCz8
        eJkRIuwo8e9yPMTDcxgl/pycwTqBUWoBI8MqRrHUguLc9NRiowITveLE3OLSvHS95PzcTYzg
        mNXy2MF44JzPIUYBDkYlHt4dZy9HCbEmlhVX5h5ilOBgVhLhXZYIFOJNSaysSi3Kjy8qzUkt
        PsQozcGiJM7b4HsmSkggPbEkNTs1tSC1CCbLxMEp1cBoYR2+yG6zkvfvk9z3gl5N8wqTYJ9q
        lHvi+pETJeonlK+KpXnaSk5U37g2olq3y6rJaIe+5wTj78x899NnL6zlquzjerplZuCZ6048
        F1sXfxUs+dwn+vzjYqeT+45HHl1+MG1KAefVRvspH57bll9OPJIe4tO8UkLqUFiD79fUo7Mq
        N4sf+amsxFKckWioxVxUnAgAcPjERdUCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFLMWRmVeSWpSXmKPExsVy+t9jQd2U8itRBl03LS02zljPajHvs6zF
        /CvXWC36H79mtjh/fgO7xeVdc9gsPvceYbSYcX4fk8WTh31sDpweO2fdZfdYvOclk8emVZ1s
        Hneu7WHz6NuyitHj8ya5ALYoLpuU1JzMstQifbsEroxXp5ewFTRyVFzd/YOxgfEcWxcjJ4eE
        gInE64blzF2MXBxCAusYJQ4d7mCEcH4xSnzq3sUOUsUmYCUxsX0VI4gtIqAlceLSdiaQImaB
        CUwSS9YuAisSFsiUmDn/OSuIzSKgKrHm1jqgsRwcvAIeEudW1EBsk5M4eWwyWAmngKdE05pr
        YFcIAZU0TrzKOIGRZwEjwypGydSC4tz03GKjAqO81HK94sTc4tK8dL3k/NxNjMAQ23ZYq38H
        4+Ml8YcYBTgYlXh4d5y9HCXEmlhWXJl7iFGCg1lJhHdZIlCINyWxsiq1KD++qDQntfgQozQH
        i5I4L3/+sUghgfTEktTs1NSC1CKYLBMHp1QD48yXZ8XS+Cwi1i/N2nT4KW8vz5OXhiUCKWb2
        K7qSirz0v/9Vf3DmTSzPktSNyUvW6ztoiBgHcKrtMDuhVn9YJeWrb/Pmwk0x8sUZC/0M1MNy
        j2UHnJkSHXhNqT/1c2ta2eODR0vcrh2K3KT6ruDalk8TP9brhCVLJC3YveNbn7pgi3iQ7a2/
        SizFGYmGWsxFxYkA+xh8uS0CAAA=
X-CMS-MailID: 20180416101357epcas2p16992f345f7dcebd90e3d4e50afbeeb88
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180416101357epcas2p16992f345f7dcebd90e3d4e50afbeeb88
X-RootMTR: 20180416101357epcas2p16992f345f7dcebd90e3d4e50afbeeb88
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180416101357epcas2p16992f345f7dcebd90e3d4e50afbeeb88@epcas2p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused "type" field from struct exynos_tmu_platform_data.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index 5149c2a..8c468b6 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -47,7 +47,6 @@ enum soc_type {
  *	0 < reference_voltage <= 31
  * @noise_cancel_mode: noise cancellation mode
  *	000, 100, 101, 110 and 111 can be different modes
- * @type: determines the type of SOC
  * @efuse_value: platform defined fuse value
  * @min_efuse_value: minimum valid trimming data
  * @max_efuse_value: maximum valid trimming data
@@ -68,7 +67,6 @@ struct exynos_tmu_platform_data {
 	u8 second_point_trim;
 	u8 default_temp_offset;
 
-	enum soc_type type;
 	u32 cal_type;
 };
 
-- 
1.9.1
