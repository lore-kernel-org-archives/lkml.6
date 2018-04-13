Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753611AbeDMIIj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 04:08:39 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:16656 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753103AbeDMIIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 04:08:37 -0400
X-IronPort-AV: E=Sophos;i="5.48,444,1517842800";
   d="scan'208";a="276685054"
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Hoan Tran <hotran@apm.com>, Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH v2 0/2] gpio: dwapb: Add support for 1 interrupt per port A GPIO
Date: Fri, 13 Apr 2018 09:08:18 +0100
Message-Id: <1523606900-2332-1-git-send-email-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All details about the change is in patch 0001. patch 0002 fixes up other users
of 'struct dwapb_port_property'.

One point to mention is that I have made it possible for users to have
unconncted interrupts by specifying holes in the list of interrupts. This is
done by supporting the interrupts-extended DT prop.
However, I have no use for this and had to hack some test case for this.
Perhaps the driver should support 1 interrupt or all GPIOa as interrupts?

Phil Edworthy (2):
  gpio: dwapb: Add support for 1 interrupt per port A GPIO
  mfd: intel_quark_i2c_gpio: Update Synopsys GPIO interrupts

 .../devicetree/bindings/gpio/snps-dwapb-gpio.txt   |  9 ++++-
 drivers/gpio/gpio-dwapb.c                          | 43 +++++++++++++++++-----
 drivers/mfd/intel_quark_i2c_gpio.c                 |  3 +-
 include/linux/platform_data/gpio-dwapb.h           |  3 +-
 4 files changed, 45 insertions(+), 13 deletions(-)

-- 
2.7.4
