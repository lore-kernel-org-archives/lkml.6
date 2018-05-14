Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752621AbeENLnK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:43:10 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:22384 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752177AbeENLnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:43:05 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180514114303epoutp013c7f15893d5982d44e9e6801a3c51a72~ugBxy2dU60435504355epoutp01e
X-AuditID: b6c32a36-b6dff70000001027-34-5af97646d941
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 01/14] thermal: ti-soc-thermal: fix TALERT IRQ handling for
 DRA752
Date: Mon, 14 May 2018 13:42:08 +0200
Message-id: <1526298141-14045-2-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsWy7bCmvq5b2c8ogz+rZS02zljPajH/yjVW
        i1Pbm5gsLu+aw2Yxe0k/i8Xn3iOMFk8e9rE5sHvsnHWX3WPxnpdMHn1bVjF6HL+xncnj8ya5
        ANYoLpuU1JzMstQifbsErozWS1cZCz6xV+x9083WwPiOrYuRk0NCwETiZv9yIJuLQ0hgB6PE
        vyUtzBDOd0aJ5XMfsXcxcoBV9S1VhIjvZpSY0b6OBcL5xSjx880edpBRbAJWEhPbVzGC2CIC
        bhKzlvwBs5kFpjJKbJpQD2ILC4RIXO3tB4uzCKhKbOvfA2bzCnhILNp5ixHiJDmJk8cms4LY
        nAKeEhvaX4KdJyEwgU3ixpb9zBAXuUj8aQ2GqBeWeHV8C9Sh0hKXjtpClDczSnzbsYcZomYC
        o8Se9UIQtrXE4eMXWSFu45N497WHFaKXV6KjDarEQ2LFwussELajxN+dW6H+ncMo8XnlLNYJ
        jFILGBlWMYqlFhTnpqcWGxYY6RUn5haX5qXrJefnbmIEx6SW2Q7GRed8DjEKcDAq8fAGLP8R
        JcSaWFZcmXuIUYKDWUmEd7fRzygh3pTEyqrUovz4otKc1OJDjNIcLErivHOUvkYJCaQnlqRm
        p6YWpBbBZJk4OKUaGBu3Fdx75rkkdM/BlkntXOFvcnaIH/w8ab6v0NJZUfOULm/4/WepQQXT
        lLUTP93/xppswbSLWfiRiegUo2eqB7j65Rm2VcZcd1b+s//Mh0afkywn2VqW6EW5Sl84db7r
        nfmfc1xFrVWRe66FqeXeal5iyReWv3cDS6PI3GNHGzZ7cxnJxM+WtlRiKc5INNRiLipOBADF
        RLzwxQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphluLIzCtJLcpLzFFi42I5/e+xgK5b2c8og3eHuCw2zljPajH/yjVW
        i1Pbm5gsLu+aw2Yxe0k/i8Xn3iOMFk8e9rE5sHvsnHWX3WPxnpdMHn1bVjF6HL+xncnj8ya5
        ANYoLpuU1JzMstQifbsErozWS1cZCz6xV+x9083WwPiOrYuRg0NCwESib6liFyMXh5DATkaJ
        SV0b2CCcX4wSrddesHcxcnKwCVhJTGxfxQhiiwi4Scxa8ocRpIhZYCqjxORPp9hAEsICIRJX
        e/vBilgEVCW29e8Bs3kFPCQW7bwFZksIyEmcPDaZFcTmFPCU2ND+EqxXCKjm9u8WtgmMPAsY
        GVYxSqYWFOem5xYbFRjmpZbrFSfmFpfmpesl5+duYgSG0bbDWn07GO8viT/EKMDBqMTDu2Ll
        jygh1sSy4srcQ4wSHMxKIry7jX5GCfGmJFZWpRblxxeV5qQWH2KU5mBREue9nXcsUkggPbEk
        NTs1tSC1CCbLxMEp1cA4S6d72tnFC1ea+vPJKn2wVV646AMTn+Qcgzqmbe8YJf9dye4+eybp
        A3NQeFdL6dMPyr0b0vdMffQs/sOUB96TN7wzSl+5JqLo9oZik2sLBex+9muHlT0RnPbLxVOD
        ZX2oyfKAnElLHr63XhL5XCCi18HZ5Y9Lfuip2yqnhN3X1H4wWX8m0DBeiaU4I9FQi7moOBEA
        JLnhpR8CAAA=
X-CMS-MailID: 20180514114302epcas1p1890ad3296302900a736262b5d67aa10e
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180514114302epcas1p1890ad3296302900a736262b5d67aa10e
X-RootMTR: 20180514114302epcas1p1890ad3296302900a736262b5d67aa10e
References: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180514114302epcas1p1890ad3296302900a736262b5d67aa10e@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.report_temperature is not set in dra752_data which
results in temperature updates not being propagated by
ti_bandgap_talert_irq_handler() (it doesn't make much
sense to handle TALERT IRQ without reporting temperature
updates to the thermal core). Fix it.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/ti-soc-thermal/dra752-thermal-data.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c b/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
index 33a3030..e8ab7e5 100644
--- a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
+++ b/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
@@ -338,6 +338,7 @@
 	.adc_end_val = DRA752_ADC_END_VALUE,
 	.expose_sensor = ti_thermal_expose_sensor,
 	.remove_sensor = ti_thermal_remove_sensor,
+	.report_temperature = ti_thermal_report_sensor_temperature,
 	.sensors = {
 		{
 		.registers = &dra752_mpu_temp_sensor_registers,
-- 
1.9.1
