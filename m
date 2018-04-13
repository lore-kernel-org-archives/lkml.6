Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753888AbeDMIJE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 04:09:04 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:50029 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753800AbeDMIJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 04:09:02 -0400
X-IronPort-AV: E=Sophos;i="5.48,444,1517842800";
   d="scan'208";a="276685107"
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Hoan Tran <hotran@apm.com>, Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH v2 2/2] mfd: intel_quark_i2c_gpio: Update Synopsys GPIO interrupts
Date: Fri, 13 Apr 2018 09:08:20 +0100
Message-Id: <1523606900-2332-3-git-send-email-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523606900-2332-1-git-send-email-phil.edworthy@renesas.com>
References: <1523606900-2332-1-git-send-email-phil.edworthy@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the way the Synopsys GPIO interrupts are stored has changed, this
driver needs to be updated in line with the changes.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
v2:
 - New patch in v2 to fix the only other user of struct dwapb_port_property.
---
 drivers/mfd/intel_quark_i2c_gpio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/intel_quark_i2c_gpio.c b/drivers/mfd/intel_quark_i2c_gpio.c
index 90e35de..5bddb84 100644
--- a/drivers/mfd/intel_quark_i2c_gpio.c
+++ b/drivers/mfd/intel_quark_i2c_gpio.c
@@ -233,7 +233,8 @@ static int intel_quark_gpio_setup(struct pci_dev *pdev, struct mfd_cell *cell)
 	pdata->properties->idx		= 0;
 	pdata->properties->ngpio	= INTEL_QUARK_MFD_NGPIO;
 	pdata->properties->gpio_base	= INTEL_QUARK_MFD_GPIO_BASE;
-	pdata->properties->irq		= pdev->irq;
+	pdata->properties->irq[0]	= pdev->irq;
+	pdata->properties->has_irq	= true;
 	pdata->properties->irq_shared	= true;
 
 	cell->platform_data = pdata;
-- 
2.7.4
