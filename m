Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753811AbeDPKN5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 06:13:57 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:31932 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753630AbeDPKNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 06:13:53 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180416101351epoutp030e554f210e7368b5ee891fe3bcd70d9b~l4v6OxTQe1183911839epoutp03j
X-AuditID: b6c32a39-591ff70000000ff4-59-5ad4775fc631
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 02/14] thermal: exynos: Propagate error value from
 tmu_read()
Date: Mon, 16 Apr 2018 12:11:53 +0200
Message-id: <1523873525-23718-3-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsWy7bCmgW58+ZUog2krFCw2zljPajHvs6zF
        /CvXWC36H79mtjh/fgO7xeVdc9gsPvceYbSYcX4fk8XaI3fZLZ487GNz4PLYOesuu8fiPS+Z
        PDat6mTzuHNtD5tH35ZVjB6fN8kFsEVx2aSk5mSWpRbp2yVwZbxc9ZG94AV3xYW2k0wNjO85
        uxg5OSQETCQe9N9jB7GFBHYwSmydI9fFyAVkf2eUeNx4lxWm6NTa/cwQiQ2MEm9/fmSCcH4x
        SkybOgusnU3ASmJi+ypGEFtEQEvixKXtYEXMAvuZJHqXzQUbJSzgLzF/bydYEYuAqsTO+V/B
        4rwCHhJ3X79mg1gnJ3Hy2GSwOKeAp0TTmmtsIIMkBFawSXQemAeU4AByXCQap8dB1AtLvDq+
        hR0iLC1x6agtRHkzo8S3HXuYIWomMErsWS8EYVtLHD5+EWw+swCfxLuvPVAjeSU62qBKPCRO
        X/wAdY6jRPOBs4wQD89hlDh6aTfTBEapBYwMqxjFUguKc9NTiw0LTPWKE3OLS/PS9ZLzczcx
        gmNXy3IH47FzPocYBTgYlXh4d5y9HCXEmlhWXJl7iFGCg1lJhHdZIlCINyWxsiq1KD++qDQn
        tfgQozQHi5I471OfM1FCAumJJanZqakFqUUwWSYOTqkGRnO/boO58Yvv63W2mW/5sal5kzCn
        CXcYQ+/jAy6bD8zlC3gbufaqgvOVopMHncqLH9gZifYefvH7pHry2sbHM21+Bd74eGri4odS
        f2olH3r0tAQKW7SuKd/E/7f918MJ7TeDKip9vZyFBVbKZKy4Xz1Xwkt8R3n7zi2Oaa6lb2/M
        2rvonNxJSSWW4oxEQy3mouJEANM5E0XZAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPLMWRmVeSWpSXmKPExsVy+t9jQd248itRBrumSVhsnLGe1WLeZ1mL
        +VeusVr0P37NbHH+/AZ2i8u75rBZfO49wmgx4/w+Jou1R+6yWzx52MfmwOWxc9Zddo/Fe14y
        eWxa1cnmcefaHjaPvi2rGD0+b5ILYIvisklJzcksSy3St0vgyni56iN7wQvuigttJ5kaGN9z
        djFyckgImEicWrufGcQWEljHKLFplWAXIxeQ/YtRYs7m86wgCTYBK4mJ7asYQWwRAS2JE5e2
        M4EUMQvsZ5L4MO06C0hCWMBXonlmExOIzSKgKrFz/lewZl4BD4m7r1+zQWyTkzh5bDJYnFPA
        U6JpzTU2iM0eEo0TrzJOYORZwMiwilEytaA4Nz232KjAMC+1XK84Mbe4NC9dLzk/dxMjMNi2
        Hdbq28F4f0n8IUYBDkYlHt4dZy9HCbEmlhVX5h5ilOBgVhLhXZYIFOJNSaysSi3Kjy8qzUkt
        PsQozcGiJM57O+9YpJBAemJJanZqakFqEUyWiYNTqoFx2vwi1fl/X53/5Vl+lzHGWpvJR2L2
        Zc2jhkLpkZvnFpS8sxVkPXotk+07N3f5NxnLWTuyJ368taKotL7XbE6JW+GOf0Jqk8w9RK4c
        vM8XNkNsRqVertbzCMaS3rLlpRZsj6fV1d6rWLRB1IzjtNh8j6m/Nj8rP/FGMy9Y4HVzs6TF
        lQaG6ONKLMUZiYZazEXFiQCNtNHPMgIAAA==
X-CMS-MailID: 20180416101350epcas1p46d9415458ec463afb2a071a9f765f0ed
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180416101350epcas1p46d9415458ec463afb2a071a9f765f0ed
X-RootMTR: 20180416101350epcas1p46d9415458ec463afb2a071a9f765f0ed
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180416101350epcas1p46d9415458ec463afb2a071a9f765f0ed@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

tmu_read() in case of Exynos4210 might return error for out of bound
values. Current code ignores such value, what leads to reporting critical
temperature value. Add proper error code propagation to exynos_get_temp()
function.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
CC: stable@vger.kernel.org # v4.6+
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 986cbd0..ac83f72 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -892,6 +892,7 @@ static void exynos7_tmu_control(struct platform_device *pdev, bool on)
 static int exynos_get_temp(void *p, int *temp)
 {
 	struct exynos_tmu_data *data = p;
+	int value, ret = 0;
 
 	if (!data || !data->tmu_read || !data->enabled)
 		return -EINVAL;
@@ -899,12 +900,16 @@ static int exynos_get_temp(void *p, int *temp)
 	mutex_lock(&data->lock);
 	clk_enable(data->clk);
 
-	*temp = code_to_temp(data, data->tmu_read(data)) * MCELSIUS;
+	value = data->tmu_read(data);
+	if (value < 0)
+		ret = value;
+	else
+		*temp = code_to_temp(data, value) * MCELSIUS;
 
 	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
 
-	return 0;
+	return ret;
 }
 
 #ifdef CONFIG_THERMAL_EMULATION
-- 
1.9.1
