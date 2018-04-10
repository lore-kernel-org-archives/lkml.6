Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753707AbeDJMoQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:44:16 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:32957 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753680AbeDJMoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:44:12 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180410124410epoutp01b03bedb0d91f1e0baa381f6ad5235d02~kE7b_ttpP2510025100epoutp013
X-AuditID: b6c32a48-8d9ff70000000ff2-a0-5accb199bb62
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
Subject: [PATCH 11/17] thermal: rockchip_thermal: enable/check sensor after
 its setup is finished
Date: Tue, 10 Apr 2018 14:42:05 +0200
Message-id: <1523364131-31059-12-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUhTURyHPfdt19XiNkUPan6Y9UGrqal0shIjP9xK0a9JkEMvU5ovbCop
        RJuWb6FZYuWQKSlU8y115ppa4tKlTUXUZb5FJjIVpmQoKlrOi9+e8/s95/zPgUPj4mLSi05J
        y+SUaTKFhBISH8z+6HxVqzU+aKzYD7W+aiHR0oYFoKbSfgLVTNhI1KsZB+jfwiqJhjrzMPRI
        +5pA9Yu/BGjcVE2hjdIvAFU7ZgRo8VcZhewGT9T2dopC2yYdgXrmN0DkSTZvbYBitT+HKfaj
        dk7AdkyHsXXdyxjbpi+m2FlbN8WW5jsotsygB2ynTYezX19uEaxlqhNjN9p840TxwitJnCIl
        m1MGRiQIk584cjI6RPd1L8yUGtQeKwGuNGRCYc/MtMDJYsYIYEHD7RIgPOAtAPt3TOBIsk9U
        EnzRBeC2vhfjFzsAzle+w5wWxYTDZ4X6gx007c7cgoZG2ungTBUB12f7cafjxiRCXbOecDLB
        nIEV2sLDXMTcgO12G8ZP84WDAxWkk10P8t2eNZLPnwqguj6I5yhotOwTPLvBFYtBwLM3XNK3
        AudgyOQDuGnsxvmiHMDuFjHPl6HZMnZ4KM6cgEXmPYHz0pARwaICMY8sbFiN4e1rUFPnwPn3
        VgO4XjOKlQOvWuCiBx5chipVzqkuZIRKVbJUVVaaXJqYntoGDj9IAGsEvSPRfYChgeS4CH3+
        Fi8mZdmqnNQ+AGlc4i5SNFnjxaIkWU4up0y/q8xScKo+4E0TEk+ROuagYuSyTO4ex2VwyqMW
        o1291MAkL9ruGkyM+TstCXEkxc3GLtv82r0v/Vk+HbK6OmINP/cwofqx1+7OaILp7BuPU9Yf
        Uaa9Ap/nkZu2pLLgSbLRQ+9i16pbBuYafkfqYhc0F5vvXO9S+KebCfnN713S/uT9B9KRTxIr
        Iq+G5datTPpER2AjQ8GazeG8hJTA7fcSQpUsCw7AlSrZf847jnUcAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsVy+t9jAd3pG89EGcx7bG6xccZ6Votnn48z
        WqztPcpiMf/KNVaLA42XGS3+P3rNanFqexOTRcusRSwWS548ZLe4vGsOm8Xn3iOMFnPe3Wa3
        ePKwj83ixRZxi00rbrBZ/Nw1j8Vi773PjA6CHk3vj7F5zLp/ls1j56y77B5bb5l6LN7zkslj
        06pONo871/awefQ2v2Pz6NuyitFj+7V5zB4npn9n8Th+YzuTx+dNcgG8UVw2Kak5mWWpRfp2
        CVwZ3e8qC7byVsybdpitgXEBdxcjJ4eEgInEiytTWboYuTiEBHYySsxb+44JwvnFKHHryVEm
        kCo2ASuJie2rGLsYOThEBLwltqzhAKlhFpjJItE29SkjSI2wQLLE62MvWEFsFgFVicmz2plB
        bF4BT4nNL64xQWyTkzh5bDJYDSdQ/Pfe96wgM4UEPCS+TbGewMizgJFhFaNkakFxbnpusVGB
        UV5quV5xYm5xaV66XnJ+7iZGYMhvO6zVv4Px8ZL4Q4wCHIxKPLwTDp6OEmJNLCuuzD3EKMHB
        rCTCm7P2TJQQb0piZVVqUX58UWlOavEhRmkOFiVxXv78Y5FCAumJJanZqakFqUUwWSYOTqkG
        Rm9+DuZddq+tHy7gb9+4NenuKZOOGq6dCt13185LFyh9GxfwpVWa50z0ki8azqXlRRezpnbU
        NG08fdXj9aRVtxuOarp4/X31yEae6zNnoaPIgWDXQwGv/sh58/zo/c73qzOpkdG5JklZ47bw
        xq/rHJb/Z3x9LzTeg3fTUu97060fuU7dHXNaX4mlOCPRUIu5qDgRAATFObB1AgAA
X-CMS-MailID: 20180410124407epcas2p4c537eb52653af45b85af6b69969c4e52
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180410124407epcas2p4c537eb52653af45b85af6b69969c4e52
X-RootMTR: 20180410124407epcas2p4c537eb52653af45b85af6b69969c4e52
References: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180410124407epcas2p4c537eb52653af45b85af6b69969c4e52@epcas2p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Enable/check sensor explicitly in rockchip_thermal_probe() (also
  check sensor after doing chipset specific control operation).

* Remove superfluous second sensor enable/check attempt.

Cc: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
This driver may require some more fixing (probably IRQ should be
requested after ->control call).

 drivers/thermal/rockchip_thermal.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 500cfc3..0b3509b 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1161,9 +1161,6 @@ static int rockchip_configure_from_dt(struct device *dev,
 		return error;
 	}
 
-	thermal_zone_device_toggle(sensor->tzd, true);
-	thermal_zone_device_check(sensor->tzd);
-
 	return 0;
 }
 
@@ -1272,6 +1269,9 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 		}
 	}
 
+	for (i = 0; i < thermal->chip->chn_num; i++)
+		thermal_zone_device_toggle((&thermal->sensors[i])->tzd, true);
+
 	error = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 					  &rockchip_thermal_alarm_irq_thread,
 					  IRQF_ONESHOT,
@@ -1284,10 +1284,8 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 
 	thermal->chip->control(thermal->regs, true);
 
-	for (i = 0; i < thermal->chip->chn_num; i++) {
-		thermal_zone_device_toggle((&thermal->sensors[i])->tzd, true);
+	for (i = 0; i < thermal->chip->chn_num; i++)
 		thermal_zone_device_check((&thermal->sensors[i])->tzd);
-	}
 
 	platform_set_drvdata(pdev, thermal);
 
-- 
1.9.1
