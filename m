Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751882AbeDIGjD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 02:39:03 -0400
Received: from mx.socionext.com ([202.248.49.38]:3243 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750877AbeDIGjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 02:39:01 -0400
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: David Miller <davem@davemloft.net>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH net-next 0/3] ave: fix the activation issues for some UniPhier SoCs
Date: Mon,  9 Apr 2018 15:38:42 +0900
Message-Id: <1523255925-6469-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This add the following stuffs to fix the activation issues and satisfy
requirements for AVE ethernet driver implemented on some UniPhier SoCs.

- Add support for additional necessary clocks and resets, because the kernel
  is stalled on Pro4 due to lack of them.

- Check whether the SoC supports the specified phy-mode

- Add DT property support indicating system controller that has the feature
  for configurating phy-mode including built-in phy on LD11.

Kunihiko Hayashi (3):
  net: ethernet: ave: add multiple clocks and resets support as required
    property
  dt-bindings: net: ave: add syscon-phy-mode property to configure
    phy-mode setting
  net: ethernet: ave: add support for phy-mode setting of system
    controller

 .../bindings/net/socionext,uniphier-ave4.txt       |  19 +-
 drivers/net/ethernet/socionext/Kconfig             |   2 +
 drivers/net/ethernet/socionext/sni_ave.c           | 252 ++++++++++++++++++---
 3 files changed, 238 insertions(+), 35 deletions(-)

-- 
2.7.4
