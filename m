Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165075AbeCBIvj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 03:51:39 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:32787 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1165044AbeCBIva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 03:51:30 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180302085128euoutp010fb3946450acc48bd2c905d9610e4c46~YDmIAY15j2751827518euoutp01W
X-AuditID: cbfec7f2-1dbff70000011644-e3-5a99108f4ce6
From: Maciej Purski <m.purski@samsung.com>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Doug Anderson <dianders@chromium.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH v5 1/5] regulator: bindings: Add properties for coupled
 regulators
Date: Fri, 02 Mar 2018 09:42:45 +0100
Message-id: <1519980169-8491-2-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1519980169-8491-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsWy7djPc7r9AjOjDGbuF7bYOGM9q8XUh0/Y
        LOYfOcdqcXbZQTaLb1c6mCwu75rDZrHg5S0Wi7VH7rJbLL1+kcmide8RdgcujzXz1jB6zG64
        yOKxc9Zddo9NqzrZPPq2rGL0+LxJLoAtissmJTUnsyy1SN8ugStj64Q3zAUrOStWX5rH3sDY
        wNHFyMkhIWAisahhJlMXIxeHkMAKRomzZ5YyQzifGSW+7rnHDlP17+1VFojEMkaJNTNWs0I4
        /xkles8tAern4GAT0JJY0x4P0iAiYCPx9sYBRpAaZoHjTBLXp25kAkkIC4RI7Gu/zQZiswio
        Sly6dJ8VxOYVcJbYcuAIM8Q2OYmb5zrBbE4BF4mfD1axgQySEFjCJrFjRx/USS4S73efYYGw
        hSVeHd8CFZeR6Ow4yARhV0tc/LqLDcKukWi8vQGqxlri86QtYAuYBfgkJm2bzgzygIQAr0RH
        mxBEiYdE96KtUPc4Shw5v5Ad4uHpjBKv7/1jmsAotYCRYRWjeGppcW56arFhXmq5XnFibnFp
        Xrpecn7uJkZgBJ/+d/zTDsavl5IOMQpwMCrx8Ga8nxElxJpYVlyZe4hRgoNZSYS35QNQiDcl
        sbIqtSg/vqg0J7X4EKM0B4uSOG+cRl2UkEB6YklqdmpqQWoRTJaJg1OqgbG08Ok//xcVXpOi
        q36Fpt+4X3a/ZPL21IKTKqGXlFpLm7e09LFJnOT6UeJWbhtx1e6/+aorctr9JknJ/64VCOx5
        +al3371Lc6Z08r0NXP42J7102yaWFI++wJY5pTqPz5xZ+lA6yURr1sXz8aYhr48fit3v73j7
        +CeJVb/fFL+0cN252bNCIkCJpTgj0VCLuag4EQBkIrQW3AIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFLMWRmVeSWpSXmKPExsVy+t/xy7p9AjOjDB5c0bPYOGM9q8XUh0/Y
        LOYfOcdqcXbZQTaLb1c6mCwu75rDZrHg5S0Wi7VH7rJbLL1+kcmide8RdgcujzXz1jB6zG64
        yOKxc9Zddo9NqzrZPPq2rGL0+LxJLoAtissmJTUnsyy1SN8ugStj64Q3zAUrOStWX5rH3sDY
        wNHFyMkhIWAi8e/tVRYQW0hgCaPE69/VXYxcQHYjk8SnzyeAEhwcbAJaEmva40FqRARsJN7e
        OMAIUsMscJJJ4s/FdYwgCWGBEIl97bfZQGwWAVWJS5fus4LYvALOElsOHGGGWCYncfNcJ5jN
        KeAi8fPBKjaIxc4SjUfXsU9g5FnAyLCKUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMMS2Hfu5
        eQfjpY3BhxgFOBiVeHgPfJwRJcSaWFZcmXuIUYKDWUmEt+UDUIg3JbGyKrUoP76oNCe1+BCj
        NAeLkjjveYPKKCGB9MSS1OzU1ILUIpgsEwenVAOjitQSr8pYxvNuzAd2nn/+p+VhXPWRT7fn
        TrtX8WqltBuL1SkRjWUe7gL5JukuDy83Vy6qyzTIuHng7jbpgyEvTha1rL5/3/B3H3PrNsb3
        DaYzhffOzO6b13vXIP9o5+tLh3/5303T4nmRuugmh4PbiVVFddafLh8O4NJ8VsztcuJA+7U7
        t49IK7EUZyQaajEXFScCAGAVEv4tAgAA
X-CMS-MailID: 20180302085126eucas1p10efa5726623b9b8a31ac438eec9fb726
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180302085126eucas1p10efa5726623b9b8a31ac438eec9fb726
X-RootMTR: 20180302085126eucas1p10efa5726623b9b8a31ac438eec9fb726
References: <1519980169-8491-1-git-send-email-m.purski@samsung.com>
        <CGME20180302085126eucas1p10efa5726623b9b8a31ac438eec9fb726@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some regulators require keeping their voltage spread below defined
max_spread.

Add properties to provide information on regulators' coupling.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 Documentation/devicetree/bindings/regulator/regulator.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/regulator.txt b/Documentation/devicetree/bindings/regulator/regulator.txt
index 2babe15b..62510d6 100644
--- a/Documentation/devicetree/bindings/regulator/regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/regulator.txt
@@ -68,6 +68,11 @@ Optional properties:
 	0: Disable active discharge.
 	1: Enable active discharge.
 	Absence of this property will leave configuration to default.
+- regulator-coupled-with: Regulators with which the regulator
+  is coupled. The linkage is 2-way - all coupled regulators should be linked
+  with each other.
+- regulator-coupled-max-spread: Max spread between voltages of coupled regulators
+  in microvolts.
 
 Deprecated properties:
 - regulator-compatible: If a regulator chip contains multiple
-- 
2.7.4
