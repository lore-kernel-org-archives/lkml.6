Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753537AbeDJMnq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:43:46 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:57481 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753106AbeDJMnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:43:42 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180410124340epoutp0316a982fba9afa283c051781574f99cb1~kE6-9KQrE0503205032epoutp03_
X-AuditID: b6c32a45-6ebff70000000fe4-bc-5accb17c8053
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
Subject: [PATCH 07/17] thermal: hisi_thermal: enable/check sensor after its
 setup is finished
Date: Tue, 10 Apr 2018 14:42:01 +0200
Message-id: <1523364131-31059-8-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTURzHO9u9Z3fm4jYlDxr+seoPjSxD46ChlUY3VFBChEHYyotam65N
        TaPAR5SvmT21tSw0UYcPtOlMJzjN9yPEuImZZYqYb1pmVlLNzf8+h9/nfL+/A4fiizWkKxWf
        kMSqEmRyCXQgmjo9fA/dqB+UHtnUQ1xfXEfiWUsPwDWaLgI/f8eRuD1jFOC/XxZI3G/M5OFb
        2lICv5yZEuDRFh3EFs0bgHXLHwR4ZqoA4jmDC26oHIN4o6WEwG2TFnBiN5O50g0Z7achyLzW
        fhQwjeO+TJnpK49p0OdAZoIzQUaTtQyZAoMeMEauhM/0Fq0TTM+YkcdYGtzDRVKH4zGsPD6F
        VR0OuOAQ93h6ASpzdqZyFRaQDvTCXCCkEO2DLL1FRC5woMR0M0CGZ/l822EdoPyah/xtq/xt
        lt1qBWi8PNdu/QKofMkMrRak/dC9O3qQCyjKmQ5BhmrK6vDpJwRanejaSnKio9EQN01YmaAP
        oPWVvC0W0QzSbAzb29xRX/cD0spC+iz63bZCWoMQfVeAvk2ZoE0KRnX9esLGTmi+xyCwsRua
        1dcD24UsgH40m+yphQCZ6sQ29kedPSNbDXx6F8ru3BRYt0a0CGXftisMGrlfbe86iQa6SqHt
        xTqAWo2ZZCFwfQF26MEeVqlWxLLqo0pvL7VMoU5OiPW6lKhoAFufxPN0MygeDu0ANAUkjqJC
        84BUTMpS1GmKDoAovsRZJK8ZlIpFMbK066wqMVqVLGfVHcCNIiQuovSw/yM6VpbEXmFZJava
        nvIooWs6CGweFx3sNy2OrMovR17dd8pcs1Abwa1F1fZxfvBiamXG/qBS4ue5EXO7T1kwN62b
        H624+eq9OXD9T9KER/GZp58tkctr3ORclbI36BEvqin1vCpK2KWpWkjxF3v5h9ftLbpGTo8e
        i44IWTzlaFzSwjYyQNGYRevCvudxodoWCaGOk3l78lVq2T/GkINQIAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsVy+t9jAd3qjWeiDH7PU7HYOGM9q8Wzz8cZ
        Ldb2HmWxmH/lGqvFgcbLjBb/H71mtTi1vYnJomXWIhaLJU8esltc3jWHzeJz7xFGiznvbrNb
        PHnYx2bxYou4xaYVN9gsfu6ax2Kx995nRgdBj6b3x9g8Zt0/y+axc9Zddo+tt0w9Fu95yeSx
        aVUnm8eda3vYPHqb37F59G1Zxeix/do8Zo8T07+zeBy/sZ3J4/MmuQDeKC6blNSczLLUIn27
        BK6MaY9fsxV0cldcW/6ZsYFxFWcXIyeHhICJxNLzzSwgtpDATkaJsx26XYxcQPYvRokXS9tY
        QRJsAlYSE9tXMXYxcnCICHhLbFnDAVLDLDCTRaJt6lNGkBphgXiJs9cegw1iEVCV+P6+G8zm
        FfCQ6P15jhlimZzEyWOTwWZyCnhK/N77nhVkphBQzbcp1hMYeRYwMqxilEwtKM5Nzy02KjDK
        Sy3XK07MLS7NS9dLzs/dxAgM+W2Htfp3MD5eEn+IUYCDUYmHd8LB01FCrIllxZW5hxglOJiV
        RHhz1p6JEuJNSaysSi3Kjy8qzUktPsQozcGiJM7Ln38sUkggPbEkNTs1tSC1CCbLxMEp1cC4
        KPKGjMRC051TTt6b6y/0n2fZXZdVC76tv63Bcsv3atDeB1pHrNqWzP9st/PRFGYG9RAD3WsZ
        pnVzd9nOvnV4Vu7/hZ03dj+fM71+gzvX4aVhmleeLzi+ytBrna/JZw3vvIUs0+IW3jp9JaE5
        +VZueabQtkKBBw9ubNwraSUYN8tVdtvkogazx0osxRmJhlrMRcWJAL8Boj91AgAA
X-CMS-MailID: 20180410124339epcas2p31bdbdc3d5fc602b3c7fe60b02e8faacd
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180410124339epcas2p31bdbdc3d5fc602b3c7fe60b02e8faacd
X-RootMTR: 20180410124339epcas2p31bdbdc3d5fc602b3c7fe60b02e8faacd
References: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180410124339epcas2p31bdbdc3d5fc602b3c7fe60b02e8faacd@epcas2p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Enable/check sensor after checking ntrips and doing chipset specific
  enable operation.

* Remove superfluous second sensor enable/check attempt.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/hisi_thermal.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 1936eb4..d4c5055 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -488,9 +488,6 @@ static int hisi_thermal_register_sensor(struct platform_device *pdev,
 		return ret;
 	}
 
-	thermal_zone_device_toggle(sensor->tzd, true);
-	thermal_zone_device_check(sensor->tzd);
-
 	trip = of_thermal_get_trip_points(sensor->tzd);
 
 	for (i = 0; i < of_thermal_get_ntrips(sensor->tzd); i++) {
@@ -553,6 +550,9 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	thermal_zone_device_toggle((&data->sensor)->tzd, true);
+	thermal_zone_device_check((&data->sensor)->tzd);
+
 	if (data->irq) {
 		ret = devm_request_threaded_irq(dev, data->irq, NULL,
 				hisi_thermal_alarm_irq_thread,
@@ -563,9 +563,6 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 		}
 	}
 
-	thermal_zone_device_toggle((&data->sensor)->tzd, true);
-	thermal_zone_device_check((&data->sensor)->tzd);
-
 	return 0;
 }
 
-- 
1.9.1
