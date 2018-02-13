Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965878AbeBMVRs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 16:17:48 -0500
Received: from mout.web.de ([212.227.15.4]:50115 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965795AbeBMVRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 16:17:46 -0500
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] PM / devfreq: exynos-ppmu: Delete an error message for a
 failed memory allocation in exynos_ppmu_probe()
Message-ID: <e4d3a870-f420-5a06-1665-59152c1924a3@users.sourceforge.net>
Date: Tue, 13 Feb 2018 22:17:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:kmS5l1vBdn9hJpFav17A+zL5/wXTvAUz95pIWbvO1aXYaRa+JcL
 bEd386Z4R37GfB6GZGSaOWF19OibAeLRFfruq4IOCy3Lr/2U76o75M+DxDNyaU5JhLNW7JY
 5fViMI64QdbMSj4qc33fOvDmegt3xRaTHpU+thSSM7yKODLtRRTr193TTEqq42LY4M/OKL0
 3tty4YA5C2kTt31HRGZTw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sTshyhJhPq4=:HAXU6RUlnZweW8vXAKImlW
 ffwTeQpXGDRTgRowb0CT68HvzxUgI/RY1DMuLQDwaWpeQ8ti2SgAvoewgAGCKbM9pPDljkfhZ
 eCdpactHzEnJU7rU+P6NZprmVdCSFIuAg1mA2zKiKnuUeRWipqk+LL4YzpitHhlqeXCCdhFbj
 YGE5GmOg1yE6fkd83W7YGEY83iwv5ieXFKFEMtvSXpGiG986W+HqP8aWsgthaqXAPhWurnlPr
 48nRySoZzZol3tXTTC1UPf8IvUMs7A4t8EzdHrtBmj+N9KSZJ4ddgNImYJ6yQn9mAo1W2qmjY
 SedNOzcuz8iPw7q6ru4KkxY3MGDCwoukB3K7n7k72IwNOvAGPRxqqlOqbahdUDFOJQrCdm9FC
 9A35GgQ1RDp8XMle9VQJduMFW/HXh/uxgNTv2rMN1HR2RlzcvvmcM9FoYoe+LdqlvGgRjPXrO
 t0BeqmqasL1p8hODMaFZB3WwL9FD09AsDJi2TqEV/okxDxxHsKpiImpsUQcj6NUWh+pSKhFWh
 zoAxXa7ZMl2InjUBcj+VWLQRLwsg/40oANzr2+eHHq8Pcwb19ppcBGfrEAnAsXDOjNXdqlFt9
 DL13JFXTMEzaGvxlK851luZGR+QZwLFOoxkIB+IaedQuQ4zSOaj8FVhG0lcJlcWjSdAwzf5d3
 mbeLHG17bYCXyNo58UXfrTj6lWba69Vu4Q2H7/uyCvNBAdlqeCuOHrDBIASzvnweo1ZtJvcxM
 7msbRLOqu6itQ/h0ALBo6xyT/I4LzC0A0YpsP9uPSkD6Tl7cQw8S3CJW6PpRMjal5776KdkMQ
 n6OzDbAXEpxLrefy+9nKNdEkKyqLiOzacIhXhL2xHWnHBvlkVw=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 13 Feb 2018 22:10:42 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/devfreq/event/exynos-ppmu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
index d96e3dc71cf8..72ac9113500d 100644
--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -627,11 +627,9 @@ static int exynos_ppmu_probe(struct platform_device *pdev)
 
 	size = sizeof(struct devfreq_event_dev *) * info->num_events;
 	info->edev = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
-	if (!info->edev) {
-		dev_err(&pdev->dev,
-			"failed to allocate memory devfreq-event devices\n");
+	if (!info->edev)
 		return -ENOMEM;
-	}
+
 	edev = info->edev;
 	platform_set_drvdata(pdev, info);
 
-- 
2.16.1
