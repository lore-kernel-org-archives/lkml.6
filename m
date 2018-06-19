Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03440C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C2720874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KMhdkrKN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8C2720874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937541AbeFSIVz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:21:55 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44997 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937350AbeFSIUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:20:07 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180619082003euoutp0297ab1a2a4bfee5074684b81915b2d175~5ge0GmiOM1395713957euoutp02X;
        Tue, 19 Jun 2018 08:20:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180619082003euoutp0297ab1a2a4bfee5074684b81915b2d175~5ge0GmiOM1395713957euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1529396403;
        bh=m9+5fGIaV7hVeM97iQhqANwX70QMp8/FJ15S612+OGw=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=KMhdkrKN54fWbOUaGp0UHC2AG9Yp5nTeoT11SR+Iiird5s7Q58IT70PoLGbrA/T5m
         bNGOIC5y4NZ8JwfGCCKzBLWlvT9Ehq7ur54HT1C+ARwHK+FbOOXbvrOPxb5y/mH/Cg
         +usoM7dzzuUHIkShw7JjGk7qKevkGvB00DLS8cJU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180619082002eucas1p1f50ef31796ffe8763ac0864cee812100~5gezRs01w0261802618eucas1p1g;
        Tue, 19 Jun 2018 08:20:02 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id F1.89.17380.2BCB82B5; Tue, 19
        Jun 2018 09:20:02 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180619082001eucas1p1df565ba7d1eaa320c2703e7dc019792b~5geycdppU0262702627eucas1p1u;
        Tue, 19 Jun 2018 08:20:01 +0000 (GMT)
X-AuditID: cbfec7f4-713ff700000043e4-e1-5b28bcb204e2
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 33.66.04178.1BCB82B5; Tue, 19
        Jun 2018 09:20:01 +0100 (BST)
Received: from AMDC2075.DIGITAL.local ([106.120.51.25]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PAK00EJ59T2RV00@eusync4.samsung.com>;
        Tue, 19 Jun 2018 09:20:01 +0100 (BST)
From:   Maciej Purski <m.purski@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH v3 6/9] dt-bindings: tc358754: add DT bindings
Date:   Tue, 19 Jun 2018 10:19:27 +0200
Message-id: <1529396370-18761-7-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1529396370-18761-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTYRjHe3cuOxtOTtPwrcQPC0m6Wii8kEilwaGgom9maKsdNdym7Kjd
        xNaodil1mtaalRHr4lq3eSmlmybOLm6OVaZht0F4pYurGDnNefTb7//8/8/zvA+8FCY1Ekuo
        A+oiVqOWK2WkGG/pCnpWOx8lZCaGxqVo4I6bQOXuFwKkM4wT6L7lLoHqO2dqb35/J1H1JzOO
        hj56cVTpH8WQx3NPiHp0Y0JkrLIJkdP/jkC+tosksnieCNCV4QEc3e4cFKJrfV4BOvm4U4gs
        Z4dJFGy7jG9cxDguOwDjqygXMK3WQSFTZ7hAME67kWQe/PlMMJ9OuwRMo+0YU9FkB8yEM26n
        eLc4RcEqD5SwmrWpe8V55ZMNRGFH5CHvszpCCwwRJiCiIJ0EtVYdbgJiSkrfBLC2KojxYgLA
        r+c+gPnUWL+N4I3rAIa8J+bENIADY4aZFooi6RXQoc8O16NpO4CN78dBWGB0LQF760eJ8Kgo
        OhUaJ+1kmHE6Hv4MVc6ukNDp8FR3O8mvi4P9biMWZhG9BVov/RWEB0H6rBBO156cC6VDm+0G
        znMUHHE1CXmOhUZDu4Dno7Bh+AbON2sBDAz6MN7YAJ+7vLMvwuhIWN1yfvYESEug4ZSUjzCw
        t2aa5M+0AGj9FSDNYPEVsMAOYthiTpXLcuvV7ME1nFzFFatz1+wvUDnBzAd5NeUKPARtk/s6
        AE0BWYQk4e7yTCkhL+EOqzoApDBZtKT5WkKmVKKQHz7CagqyNcVKlusASylcFiPJSijbLaVz
        5UVsPssWspp5V0CJlmhBouJeTqRJZAmOkH7PymOujJDOvEzq0OQHdzx1q/LT00ojYPLCjOO7
        TPUBv377lz3xb9N++0SO2FV5qqyr27L6FieZp147X8b+sJ/pfqxXeJQ9yfqalM29Oa0S0637
        m2Tilo3OkX9dZc07Ui9tVQ+V1mg8Rd+VXHL+6LeAdrVehnN58nUrMA0n/w+QvzVsHAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsVy+t/xa7ob92hEG7z+pmlxa905VovecyeZ
        LJo63rJabJyxntVi/hGg2JWv79ksJt2fwGLx4t5FFov+x6+ZLc6f38BucbbpDbtF58Ql7Bab
        Hl9jtbi8aw6bxYzz+5gsFry8xWKx9shddoul1y8yWbTuPcJuMWPySzaLn7vmsTiIeqyZt4bR
        43JfL5PHzll32T1md8xk9di0qpPNY/u3B6we97uPM3lsXlLv0bdlFaPH501yAVxRXDYpqTmZ
        ZalF+nYJXBm9f1ayFhziq7h4YDZrA2MHTxcjJ4eEgInEm5tLWLsYuTiEBJYwSkz98JMNwmlk
        kpjaN42pi5GDg01AS2JNezxIXERgFVDR3zvsIA6zwGxWiVePJjCCjBIWsJPo/LOKDcRmEVCV
        +Pi3HyzOK+Ai0XbiIBvEOjmJm+c6mUFsTgFXiVlzvzOB2EJANS9WX2GawMizgJFhFaNIamlx
        bnpusaFecWJucWleul5yfu4mRmDobzv2c/MOxksbgw8xCnAwKvHwNmxUjxZiTSwrrsw9xCjB
        wawkwrt1qUa0EG9KYmVValF+fFFpTmrxIUZpDhYlcd7zBpVRQgLpiSWp2ampBalFMFkmDk6p
        BsaqfU+jQ7c+596yb/aL6Nkt6euPrViY5bH8384PPJevaMhEsT2tFNPL+CHLdeGhcklph0K7
        y4vyD/43pSerxP5mqeh6U5x+KGrVjDmHWooP/2o6p16SOCNY7mP2DH1ZiWTHvXy6B4ze6Wls
        C8rTM7FtL35VzX/g1H7ZS99nTBd+nKFs4ZQzSVGJpTgj0VCLuag4EQCU4DL1eQIAAA==
X-CMS-MailID: 20180619082001eucas1p1df565ba7d1eaa320c2703e7dc019792b
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180619082001eucas1p1df565ba7d1eaa320c2703e7dc019792b
References: <1529396370-18761-1-git-send-email-m.purski@samsung.com>
        <CGME20180619082001eucas1p1df565ba7d1eaa320c2703e7dc019792b@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrzej Hajda <a.hajda@samsung.com>

The patch adds bindings to Toshiba DSI/LVDS bridge TC358764.
Bindings describe power supplies, reset gpio and video interfaces.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 .../bindings/display/bridge/toshiba,tc358764.txt   | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt

diff --git a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
new file mode 100644
index 0000000..8f9abf2
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
@@ -0,0 +1,35 @@
+TC358764 MIPI-DSI to LVDS panel bridge
+
+Required properties:
+  - compatible: "toshiba,tc358764"
+  - reg: the virtual channel number of a DSI peripheral
+  - vddc-supply: core voltage supply, 1.2V
+  - vddio-supply: I/O voltage supply, 1.8V or 3.3V
+  - vddlvds-supply: LVDS1/2 voltage supply, 3.3V
+  - reset-gpios: a GPIO spec for the reset pin
+
+The device node can contain following 'port' child nodes,
+according to the OF graph bindings defined in [1]:
+  0: DSI Input, not required, if the bridge is DSI controlled
+  1: LVDS Output, mandatory
+
+[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
+
+Example:
+
+	bridge@0 {
+		reg = <0>;
+		compatible = "toshiba,tc358764";
+		vddc-supply = <&vcc_1v2_reg>;
+		vddio-supply = <&vcc_1v8_reg>;
+		vddlvds-supply = <&vcc_3v3_reg>;
+		reset-gpios = <&gpd1 6 GPIO_ACTIVE_LOW>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		port@1 {
+			reg = <1>;
+			lvds_ep: endpoint {
+				remote-endpoint = <&panel_ep>;
+			};
+		};
+	};
-- 
2.7.4

