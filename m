Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751232AbeCIEkE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 23:40:04 -0500
Received: from gateway34.websitewelcome.com ([192.185.150.114]:41905 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750848AbeCIEkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 23:40:01 -0500
From: Matheus Castello <matheus@castello.eng.br>
To: stefan.wahren@i2se.com, eric@anholt.net
Cc: linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v3 2/3] pinctrl: bcm2835: Add support for output-low output-high properties
Date: Fri,  9 Mar 2018 00:16:13 -0400
Message-Id: <1520568974-15547-3-git-send-email-matheus@castello.eng.br>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520568974-15547-1-git-send-email-matheus@castello.eng.br>
References: <5b3419be-12ca-75d7-6f5e-d3338ddd7f14@castello.eng.br>
 <1520568974-15547-1-git-send-email-matheus@castello.eng.br>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.189.21.134
X-Source-L: No
X-Exim-ID: 1eu9Sf-003CXR-0C
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [191.189.21.134]:8442
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 18
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Properties to set initial value of pin output buffer.
This can be useful for configure hardware in overlay files, and in early boot
for checking it states in QA sanity tests.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
 drivers/pinctrl/bcm/pinctrl-bcm2835.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index 010c565..28acd06 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -965,6 +965,11 @@ static int bcm2835_pinconf_set(struct pinctrl_dev *pctldev,
 			bcm2835_pull_config_set(pc, pin, BCM2835_PUD_UP);
 			break;
 
+		/* Set output-high or output-low */
+		case PIN_CONFIG_OUTPUT:
+			bcm2835_gpio_set_bit(pc, arg ? GPSET0 : GPCLR0, pin);
+			break;
+
 		default:
 			return -EINVAL;
 
-- 
2.7.4
