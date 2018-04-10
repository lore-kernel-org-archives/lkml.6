Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753847AbeDJMo4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:44:56 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:53243 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753821AbeDJMow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:44:52 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180410124450epoutp0432e2d323c7139e2c092d1ae8d50a1c65~kE8BWqGNP0490804908epoutp04h
X-AuditID: b6c32a39-579ff70000000ff4-36-5accb1c179d7
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
Subject: [PATCH 16/17] thermal: zx2967: enable/check sensor after its setup
 is finished
Date: Tue, 10 Apr 2018 14:42:10 +0200
Message-id: <1523364131-31059-17-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSSUxTQRjHnb6lj4bqo2xjCRyaECOGLZE4IBpNODwCBw8YFA3ayGOJLZA+
        IMCJLaAsFYIGJaQIemAr2NJShBK1lCKLAhaxIGpQJKICJg2CGBdKy+038/9988+XDIWJqgkx
        lZGZwyoypTIJKcD7ho8GB5s0k0lhY9040tztIdCKfRQgdc0Ijppn5wj0tNgK0L+P3wg0bijh
        obLGVhw9XF7iI+tAE4nsNWaAmtbf8tHykpJEX3S+SNtmI9GvARWOht7bwRkPpmTDQjKNH16Q
        zOPGd3xGvxDBPDCu8hhtx02SWZwzkkxN6TrJKHUdgDHMqTDmecMWzozaDDzGrg04J0wSRKew
        sow8VhF6+qogfXmlmJetdstfHWzjFYFiqhK4UZA+Dm/1vMYqgYAS0f0Abj+qIJ2HLQA3b3eC
        fWtd3+oKBgFUmp+4RnYA/F42u2eRdBSsq+jYZYryouOgrotyOBh9D4c/Fkcwh+NJX4RWlRl3
        ME4HwpY3xr1ZIR0LNdYZV1sAHLPUEw52273/PbRBOB6CdD0fVu00YE4pBrZb1C72hF9HdXxH
        MaT94KuRU06/FMCf/UaXUwugsUfk5JNweHRmrwCjD8L1zWrCOSuEN8pdCgNbVrtJJ5+Fg+NV
        uHPhJgDXluaJWiC+Dw50AB82m5OnsVx4dkQIJ5VzuZlpIdey5Fqw90eCIvuB5WW8CdAUkLgL
        a59NJIkIaR5XIDcBSGESL6FMPZkkEqZICwpZRdYVRa6M5UzAj8IlvsLP8bsRnSbNYa+zbDar
        2E95lJu4CByO6BWbp+b7VJeP6Mq95e7Ti7JktbK3jJyeiC28Yw2aSUhorkr1upASZs2PjkGY
        r7Y48U+kafOQTfBxzqY9ERfePtDo/ikzai1s2KOrqzWwPqQueibUI0pT+ReGB+pT+/Xb8cmx
        Df7JcYaChUudPn7+sb21ifooq/fUvP38MQnOpUvDgzAFJ/0Pde0DsR8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsVy+t9jAd2DG89EGSx+KGCxccZ6Votnn48z
        WqztPcpiMf/KNVaLA42XGS3+P3rNanFqexOTRcusRSwWS548ZLe4vGsOm8Xn3iOMFnPe3Wa3
        ePKwj83ixRZxi00rbrBZ/Nw1j8Vi773PjA6CHk3vj7F5zLp/ls1j56y77B5bb5l6LN7zkslj
        06pONo871/awefQ2v2Pz6NuyitFj+7V5zB4npn9n8Th+YzuTx+dNcgG8UVw2Kak5mWWpRfp2
        CVwZT541MhWs5ax4uXsFUwNjI0cXIyeHhICJxLuti9i6GLk4hAR2MkpM+HqPCcL5xShx9tND
        VpAqNgEriYntqxi7GDk4RAS8Jbas4QCpYRaYySLRNvUpI0iNsECkRNf9XSwgNouAqsTC63vA
        4rwCnhIbL19khNgmJ3Hy2GSwmZxA8d9737OCzBQS8JD4NsV6AiPPAkaGVYySqQXFuem5xUYF
        hnmp5XrFibnFpXnpesn5uZsYgUG/7bBW3w7G+0viDzEKcDAq8fBOOHg6Sog1say4MvcQowQH
        s5IIb87aM1FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeW/nHYsUEkhPLEnNTk0tSC2CyTJxcEo1
        MFp2ZFt99xUM9nZba7Kb3yZ0P2uguMeUZ9P5r9/q82H2COCdOW++65N/rx5t119+9K/lmw+B
        sgJdn6cbl6ayPDSV+st3YMqj+c0XDBiuqG9Q+a9yJeiFdHmPSFPOGo0riTNP2k+TVlHIapmy
        3qamhX3m0n79HaxGEZfOF9+aN+/BxcfFx/YesVdiKc5INNRiLipOBABMq8C3dgIAAA==
X-CMS-MailID: 20180410124449epcas1p2dd40472146b417f7cb2d2bfdaea232ba
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180410124449epcas1p2dd40472146b417f7cb2d2bfdaea232ba
X-RootMTR: 20180410124449epcas1p2dd40472146b417f7cb2d2bfdaea232ba
References: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180410124449epcas1p2dd40472146b417f7cb2d2bfdaea232ba@epcas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable/check sensor after checking sensor coefficients.

Cc: Jun Nie <jun.nie@linaro.org>
Cc: Baoyou Xie <baoyou.xie@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/zx2967_thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/zx2967_thermal.c b/drivers/thermal/zx2967_thermal.c
index ffd2b07..45ed17f 100644
--- a/drivers/thermal/zx2967_thermal.c
+++ b/drivers/thermal/zx2967_thermal.c
@@ -168,9 +168,6 @@ static int zx2967_thermal_probe(struct platform_device *pdev)
 		goto disable_clk_all;
 	}
 
-	thermal_zone_device_toggle(priv->tzd, true);
-	thermal_zone_device_check(priv->tzd);
-
 	if (priv->tzd->tzp->slope == 0) {
 		thermal_zone_of_sensor_unregister(&pdev->dev, priv->tzd);
 		dev_err(&pdev->dev, "coefficients of sensor is invalid\n");
@@ -178,6 +175,9 @@ static int zx2967_thermal_probe(struct platform_device *pdev)
 		goto disable_clk_all;
 	}
 
+	thermal_zone_device_toggle(priv->tzd, true);
+	thermal_zone_device_check(priv->tzd);
+
 	priv->dev = &pdev->dev;
 	platform_set_drvdata(pdev, priv);
 
-- 
1.9.1
