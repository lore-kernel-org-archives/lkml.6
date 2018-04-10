Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753746AbeDJMoY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:44:24 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:32993 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753711AbeDJMoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:44:19 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180410124417epoutp01223659360e6fde0b8423f98a77ee6ac9~kE7ipp6dh2507725077epoutp019
X-AuditID: b6c32a37-575ff70000000fe6-2e-5accb1a15599
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
Subject: [PATCH 12/17] thermal: exynos: enable/check sensor after its setup
 is finished
Date: Tue, 10 Apr 2018 14:42:06 +0200
Message-id: <1523364131-31059-13-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTYRjG+7Zzzo6zyXFafihYDSQU8kJKX1pSUHBKif7MBebIg5e8rB2v
        QWIqmsvNG5E685J2cSXeZi5T8ZLaxRIviMx5Sw1Tm5KZaKS5Hfvved/n9z4vL7wkX6zEHcmI
        mDhGESOLkhBC7HWPq+eJyoYBqefUthA1FNXh6Nt6P0C1ql4MlY+O4ajz3ghAu1+XcfSxJY2H
        MkqeYKh6flaARlpLCbSuegdQqWlCgOZn1QRa1DmgxhfjBNpqLcNQ+9Q6OGdLp632EXTJ9GeC
        flMyKaCbDT50Vdt3Ht2ozSZo41gbQavSTQSt1mkB3TJWxqffP9rE6P7xFh693uh8VSQVngll
        oiISGIWHf4gwXJ3WAeR/rZLquwt4qaCJVAKShJQ37MiGSmBFiik9gJVlkUog3NObADY1N+Fm
        w8wM6jWAM94CWFU4J+CKbQD19VPATBGUL8zP0gJzqj0VAHWvSDPDp4oxuGbs5ZsZOyoIqjXV
        llSMcoEFnY8tsyLqEiz6qSW4bc7wQ1+hhbHa6/9pX8XNQZDKFcDi1hUBB12AK8+e8DhtB5f6
        dQLuHCc43HuW49MB/K1v43NMHoBtdWJO+8Ge/iHLAj5lA00bOTg3K4L3M/cRGqb+WtmPPw/V
        k7n715cCWJ2l5eUBxwpwQAsOM3I2OoxhveQn3VlZNBsfE+Z+Mza6EVg+xO2UHtR/CewGFAkk
        B0V5XZ+kYlyWwCZHdwNI8iX2oqjaAalYFCpLvsMoYm8o4qMYths4kZjEQbQQuGdRYbI45hbD
        yBnFf5dHWjmmArX3jvyatSFYpyp7Hqxbc3V5aL0SwvtRMRWwdsxwdGY1JLmms9y4u6jRzWhQ
        zYIpa9ltSBRUVR9v41dy2pB4peCl0aEw6dBx9+vTmVtPwaCzr+DIbcVwyoNIZYrPFmuaaLmY
        ke2nqch3X+4K9VDtbMzV4pdtN0P8RxMNOXeXjBKMDZd5ufEVrOwf0as5Cx0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsVy+t9jAd0FG89EGWzpUbPYOGM9q8Wzz8cZ
        Ldb2HmWxmH/lGqvFgcbLjBb/H71mtTi1vYnJomXWIhaLJU8esltc3jWHzeJz7xFGiznvbrNb
        PHnYx2bxYou4xaYVN9gsfu6ax2Kx995nRgdBj6b3x9g8Zt0/y+axc9Zddo+tt0w9Fu95yeSx
        aVUnm8eda3vYPHqb37F59G1Zxeix/do8Zo8T07+zeBy/sZ3J4/MmuQDeKC6blNSczLLUIn27
        BK6MvqZ9jAV/OSs2HJrE1MC4maOLkZNDQsBE4vyO2YxdjFwcQgI7GSW+3Z7ODuH8YpS4PWcO
        O0gVm4CVxMT2VUBVHBwiAt4SW9ZwgNQwC8xkkWib+pQRpEZYIFLiWu9zMJtFQFVi0oG5YDav
        gKfEjE+r2CC2yUmcPDaZFcTmBIr/3vueFWSmkICHxLcp1hMYeRYwMqxilEwtKM5Nzy02KjDM
        Sy3XK07MLS7NS9dLzs/dxAgM+m2Htfp2MN5fEn+IUYCDUYmHd8LB01FCrIllxZW5hxglOJiV
        RHhz1p6JEuJNSaysSi3Kjy8qzUktPsQozcGiJM57O+9YpJBAemJJanZqakFqEUyWiYNTqoFx
        0uy1DJE9E26LrLI5bzqT9VyPxkvl218/vY1fG26fd6XsyJLVupH5VyWTLNTFjlm2zYx8rzzp
        07pnjnvizW3qil0V7qr9X/PI8/nu6/lHs96Z8Ov2eMh85NbijfqwP1HKQPT2/awyc71LN6Vz
        1JftL2nhqBSNzZth+WaidW+IucrFjzzpUWlKLMUZiYZazEXFiQCPPSyAdgIAAA==
X-CMS-MailID: 20180410124416epcas1p284cf4e47c0231f764ed81efcee7c0e14
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180410124416epcas1p284cf4e47c0231f764ed81efcee7c0e14
X-RootMTR: 20180410124416epcas1p284cf4e47c0231f764ed81efcee7c0e14
References: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180410124416epcas1p284cf4e47c0231f764ed81efcee7c0e14@epcas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable sensor after doing chipset specific initialization operation and
check sensor after doing chipset specific control operation.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index af1902d..68457f5 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1403,15 +1403,14 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		goto err_sclk;
 	}
 
-	thermal_zone_device_toggle(data->tzd, true);
-	thermal_zone_device_check(data->tzd);
-
 	ret = exynos_tmu_initialize(pdev);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to initialize TMU\n");
 		goto err_thermal;
 	}
 
+	thermal_zone_device_toggle(data->tzd, true);
+
 	ret = devm_request_irq(&pdev->dev, data->irq, exynos_tmu_irq,
 		IRQF_TRIGGER_RISING | IRQF_SHARED, dev_name(&pdev->dev), data);
 	if (ret) {
@@ -1420,6 +1419,9 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	}
 
 	exynos_tmu_control(pdev, true);
+
+	thermal_zone_device_check(data->tzd);
+
 	return 0;
 
 err_thermal:
-- 
1.9.1
