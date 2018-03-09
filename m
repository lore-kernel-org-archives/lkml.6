Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751262AbeCIMWn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 07:22:43 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46444 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751167AbeCIMWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 07:22:36 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180309122234euoutp014078bdce0921cc62a8882175ee41e332~aP-cNPk3s1679816798euoutp014
X-AuditID: cbfec7f2-1c1ff70000011644-b2-5aa27c89ee21
From: Maciej Purski <m.purski@samsung.com>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>,
        Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Doug Anderson <dianders@chromium.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH v6 2/6] regulator: bindings: Add properties for coupled
 regulators
Date: Fri, 09 Mar 2018 13:22:04 +0100
Message-id: <1520598128-11768-3-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1520598128-11768-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsWy7djP87qdNYuiDE78lLLYOGM9q8XUh0/Y
        LOYfOcdqcXbZQTaLh1f9Lb5d6WCyuLxrDpvFgpe3WCzWHrnLbrH0+kUmi9a9R9gt9l/xcuDx
        WDNvDaPHt6+TWDxmN1xk8dg56y67x6ZVnWwefVtWMXp83iQXwB7FZZOSmpNZllqkb5fAlXHu
        wzfmgk2cFa+WrWZsYGzl6GLk5JAQMJGY+PQrSxcjF4eQwApGiemTfrBCOJ8ZJf4e/8QMU9XR
        cJ4RIrGMUaL1/yNmCOc/o8TOnQuBWjg42AS0JNa0x4M0iAjYSLy9cQCsgVmgn1liclMrC0iN
        sECIxOQD0iA1LAKqEtPnvGQDCfMKuEh8+psOsUtO4ua5TrC9nAKuEueuvwEbIyGwg03idN8y
        NogiF4nui29ZIGxhiVfHt7BD2DISlyd3Q8WrJS5+3QVVXyPReHsDVI21xOdJW8AWMAvwSUza
        Np0Z5AYJAV6JjjYhiBIPiQert7FC2I4Spx+ArAV5dwajxM/L9xknMEotYGRYxSieWlqcm55a
        bJiXWq5XnJhbXJqXrpecn7uJERjXp/8d/7SD8eulpEOMAhyMSjy8DxwXRgmxJpYVV+YeYpTg
        YFYS4a2qWBQlxJuSWFmVWpQfX1Sak1p8iFGag0VJnDdOoy5KSCA9sSQ1OzW1ILUIJsvEwSnV
        wNi73PUR16mfJgo7Z7h/Lw5nOxnCm5nou+w2o/ahtE0XpC6qh73S00xcs9ru5q7pN37Vhihn
        y4etkBcNLhIpetgpcU7kyD8ZJoYLT0RDfbYuljPgvr/n4s1PAYs3GadsCf992GD3F+u446t9
        bwata++c21ZT6PW2P/hTxl3ug3cPce1RYqk+kaXEUpyRaKjFXFScCAC8Np5f5wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGLMWRmVeSWpSXmKPExsVy+t/xy7odNYuiDBYttLTYOGM9q8XUh0/Y
        LOYfOcdqcXbZQTaLh1f9Lb5d6WCyuLxrDpvFgpe3WCzWHrnLbrH0+kUmi9a9R9gt9l/xcuDx
        WDNvDaPHt6+TWDxmN1xk8dg56y67x6ZVnWwefVtWMXp83iQXwB7FZZOSmpNZllqkb5fAlXHu
        wzfmgk2cFa+WrWZsYGzl6GLk5JAQMJHoaDjP2MXIxSEksIRRYuXir6wQTiOTxO5NS4EyHBxs
        AloSa9rjQRpEBGwk3t44ANbALDCRWWLh4iusIDXCAiESkw9Ig9SwCKhKTJ/zkg0kzCvgIvHp
        bzrELjmJm+c6mUFsTgFXiXPX3zCC2EJAJR0znrNPYORZwMiwilEktbQ4Nz232EivODG3uDQv
        XS85P3cTIzD0th37uWUHY9e74EOMAhyMSjy8DxwXRgmxJpYVV+YeYpTgYFYS4a2qWBQlxJuS
        WFmVWpQfX1Sak1p8iFGag0VJnPe8QWWUkEB6YklqdmpqQWoRTJaJg1OqgVHMS6/eszhr4dz1
        nAsXibztfRg26WxUOp/9Og6df4/vKs4utGyOX8u97vA789c+TyuU99pFidU5yz8+ZStT/9eG
        bcG/43fWvHFLMzEUEHu9XHyjUP/OkAp/W/vVi+dy31ss+vtSd1KK48m0IA+765a3rz9a7W6u
        cFU0X3Gd87cAgScv0x9aWCuxFGckGmoxFxUnAgBf19siOQIAAA==
X-CMS-MailID: 20180309122233eucas1p14d57674d3e9539db144c401593679c08
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180309122233eucas1p14d57674d3e9539db144c401593679c08
X-RootMTR: 20180309122233eucas1p14d57674d3e9539db144c401593679c08
References: <1520598128-11768-1-git-send-email-m.purski@samsung.com>
        <CGME20180309122233eucas1p14d57674d3e9539db144c401593679c08@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some regulators require keeping their voltage spread below defined
max_spread.

Add properties to provide information on regulators' coupling.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 Documentation/devicetree/bindings/regulator/regulator.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/regulator.txt b/Documentation/devicetree/bindings/regulator/regulator.txt
index 2babe15b..a096fae 100644
--- a/Documentation/devicetree/bindings/regulator/regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/regulator.txt
@@ -68,6 +68,11 @@ Optional properties:
 	0: Disable active discharge.
 	1: Enable active discharge.
 	Absence of this property will leave configuration to default.
+- regulator-coupled-with: Regulators with which the regulator
+  is coupled. The linkage is 2-way - all coupled regulators should be linked
+  with each other. A regulator should not be coupled with its supplier.
+- regulator-coupled-max-spread: Max spread between voltages of coupled regulators
+  in microvolts.
 
 Deprecated properties:
 - regulator-compatible: If a regulator chip contains multiple
-- 
2.7.4
