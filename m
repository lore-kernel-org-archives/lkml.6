Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932271AbeCIRPF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 12:15:05 -0500
Received: from gateway21.websitewelcome.com ([192.185.45.155]:24529 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751205AbeCIRPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 12:15:04 -0500
From: Matheus Castello <matheus@castello.eng.br>
To: stefan.wahren@i2se.com, eric@anholt.net
Cc: linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: Re: [PATCH v4 0/3] pinctrl: bcm2835: Add generic pinctrl support
Date: Fri,  9 Mar 2018 13:13:57 -0400
Message-Id: <1520615640-9153-1-git-send-email-matheus@castello.eng.br>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <483687035.384686.1520596004410@email.1und1.de>
References: <483687035.384686.1520596004410@email.1und1.de>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.189.21.134
X-Source-L: No
X-Exim-ID: 1euLbi-0035bK-IC
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [191.189.21.134]:9308
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 3
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for generic binding for pinctrl bcm2835 driver,
and add the code for set output buffer of a pin using the output-low and
output-high generic properties.

Tested on Raspberry Pi Zero W, based on bcm2835 SoC.

Changes since v3:
(Suggested by Stefan Wahren)
- Change dt-bindings docs patch order and subject

Changes since v2:
(Suggested by Eric Anholt)
- Remove PACK and UNPACK macros
- Use pinconf_to_config_* functions
(Suggested by Stefan Wahren)
- Fold Kconfig changes with the driver changes in a single patch
- Add devicetree bindings documentations about generic properties support
- Add devicetree bindings maintainers

Matheus Castello (3):
  dt-bindings: pinctrl: bcm2835-gpio: Add generic pinctrl support
  pinctrl: bcm2835: Add support for generic pinctrl binding
  pinctrl: bcm2835: Add support for output-low output-high properties

 drivers/pinctrl/bcm/Kconfig                        |  1 +
 drivers/pinctrl/bcm/pinctrl-bcm2835.c              | 92 ++++++++++++++--------
 .../bindings/pinctrl/brcm,bcm2835-gpio.txt         | 19 +++++
 3 files changed, 79 insertions(+), 33 deletions(-)

-- 
2.7.4
