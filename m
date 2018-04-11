Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752041AbeDKFUH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 01:20:07 -0400
Received: from gateway36.websitewelcome.com ([50.116.125.2]:23711 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750797AbeDKFUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 01:20:06 -0400
From: Matheus Castello <matheus@castello.eng.br>
To: robh@kernel.org, stefan.wahren@i2se.com, eric@anholt.net
Cc: linus.walleij@linaro.org, mark.rutland@arm.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: Re: [PATCH v5 0/3] pinctrl: bcm2835: Add generic pinctrl support
Date: Wed, 11 Apr 2018 00:58:43 -0400
Message-Id: <1523422726-7910-1-git-send-email-matheus@castello.eng.br>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <f500b25c-eea0-9f01-7d7b-5a9dd90c50fa@castello.eng.br>
References: <f500b25c-eea0-9f01-7d7b-5a9dd90c50fa@castello.eng.br>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.189.21.134
X-Source-L: No
X-Exim-ID: 1f67qQ-002CSG-4Y
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [191.189.21.134]:21541
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 14
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for generic binding for pinctrl bcm2835 driver,
and add the code for set output buffer of a pin using the output-low and
output-high generic properties.

Tested on Raspberry Pi Zero W, based on bcm2835 SoC.

Changes since v4:
(Suggested by Rob Herring)
- Change dt-bindings docs driver reference to hardware in case the BCM2835 pin
configuration and multiplexing

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

 .../bindings/pinctrl/brcm,bcm2835-gpio.txt         | 18 +++++
 drivers/pinctrl/bcm/Kconfig                        |  1 +
 drivers/pinctrl/bcm/pinctrl-bcm2835.c              | 92 ++++++++++++++--------
 3 files changed, 78 insertions(+), 33 deletions(-)

--
2.7.4
