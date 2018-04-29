Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754179AbeD2T7t (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 15:59:49 -0400
Received: from gateway22.websitewelcome.com ([192.185.46.225]:44810 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753817AbeD2T7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 15:59:48 -0400
X-Authority-Reason: nr=8
From: Matheus Castello <matheus@castello.eng.br>
To: linus.walleij@linaro.org, stefan.wahren@i2se.com, eric@anholt.net
Cc: swarren@wwwdotorg.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v6 3/3] pinctrl: bcm2835: Add support for output-low output-high properties
Date: Sun, 29 Apr 2018 15:28:12 -0400
Message-Id: <1525030092-3643-3-git-send-email-matheus@castello.eng.br>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525030092-3643-1-git-send-email-matheus@castello.eng.br>
References: <CACRpkdaH6kgbM+3UHVJ_JfKZ367XXRhSjXhvsZ-8b0Ovbkpmew@mail.gmail.com>
 <1525030092-3643-1-git-send-email-matheus@castello.eng.br>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.189.21.134
X-Source-L: No
X-Exim-ID: 1fCs10-001ixz-Ms
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [191.189.21.134]:22196
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 22
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Properties to set initial value of pin output buffer.
This can be useful for configure hardware in overlay files, and in early
boot for checking it states in QA sanity tests.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
 drivers/pinctrl/bcm/pinctrl-bcm2835.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index 0231107..3bc0d04 100644
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
