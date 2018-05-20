Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752660AbeETRC3 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 13:02:29 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:7183 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751685AbeETRCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 13:02:20 -0400
X-UUID: 51cd62e6a8a2491588ef01900f521f7f-20180521
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linus.walleij@linaro.org>, <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 1/7] dt-bindings: pinctrl: add external interrupt support to MT7622 pinctrl
Date: Mon, 21 May 2018 01:01:47 +0800
Message-ID: <3898620ef606004aaddc332591ca467f56773029.1526835466.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1526835466.git.sean.wang@mediatek.com>
References: <cover.1526835466.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Extend the capability of MT7622 pinctrl with adding EINT so that each
GPIO can be used to notify CPU when a signal state is changing on the
line as an external interrupt.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 Documentation/devicetree/bindings/pinctrl/pinctrl-mt7622.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt7622.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt7622.txt
index f18ed99..743b32d 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt7622.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt7622.txt
@@ -9,6 +9,16 @@ Required properties for the root node:
  - #gpio-cells: Should be two. The first cell is the pin number and the
    second is the GPIO flags.
 
+Optional properties:
+- interrupt-controller  : Marks the device node as an interrupt controller
+
+If the property interrupt-controller is defined, following property is required
+- reg-names: A string describing the "reg" entries. Must contain "eint".
+- interrupts : The interrupt output from the controller.
+- #interrupt-cells: Should be two.
+- interrupt-parent: Phandle of the interrupt parent to which the external
+  GPIO interrupts are forwarded to.
+
 Please refer to pinctrl-bindings.txt in this directory for details of the
 common pinctrl bindings used by client devices, including the meaning of the
 phrase "pin configuration node".
-- 
2.7.4
