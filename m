Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E6EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3531920874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WZg3/m8n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3531920874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756377AbeFSIWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:22:09 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44951 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937314AbeFSIUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:20:04 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180619082001euoutp02cab07cb841117fafd33f1ae4b979a05b~5geyq6t4c1395713957euoutp02V;
        Tue, 19 Jun 2018 08:20:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180619082001euoutp02cab07cb841117fafd33f1ae4b979a05b~5geyq6t4c1395713957euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1529396402;
        bh=MjYV6Z0spjvBKdUtalbQImc093hTlmAsPryLiObkG9M=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=WZg3/m8n5GskpnPFYRpkHdMP8vSfQjF17ZfzPr7l6vvQ4LRRL1YxvGS+4DaYo6Rn2
         nFs9UwzrE5YYx1xz0z/MGN1ACxkh9R4pKN0IlbpKUswN47EENOkO+P8mlf8Txd99Ot
         mGzU671VEDP95kb85E42yeA6amsBhHinxr/S7VpU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180619082001eucas1p239bed3c04b50496cacdec48d6b35b9fb~5gex4LTgC2285022850eucas1p2O;
        Tue, 19 Jun 2018 08:20:01 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id DF.79.17380.0BCB82B5; Tue, 19
        Jun 2018 09:20:00 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180619082000eucas1p1c5cc2b526583c3fd5e9fc13656ed4858~5gew6nTKj0546705467eucas1p1W;
        Tue, 19 Jun 2018 08:20:00 +0000 (GMT)
X-AuditID: cbfec7f4-6f9ff700000043e4-dc-5b28bcb0df50
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id CE.56.04178.FACB82B5; Tue, 19
        Jun 2018 09:20:00 +0100 (BST)
Received: from AMDC2075.DIGITAL.local ([106.120.51.25]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PAK00EJ59T2RV00@eusync4.samsung.com>;
        Tue, 19 Jun 2018 09:19:59 +0100 (BST)
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
Subject: [PATCH v3 4/9] dt-bindings: display: add DT bindings for BOE
 HV070WSA-100 panel
Date:   Tue, 19 Jun 2018 10:19:25 +0200
Message-id: <1529396370-18761-5-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1529396370-18761-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTURzHO7v37l6ni8tUPJlIDLJhS+0BnehBhMaF/ukP01BKZ14fNB9s
        07KXomXOx3yMcD5SSU2bS22alZRDG60SXWI+QZdN8k0PLTGkcl7773O+v8/vnN8PDoWJsglP
        Kj5RxSoSZXIxX4B3vFmz7mt9KQkPyPouRePN/QQq6H/HQ5k5SwR6omshULV5I/v48ysfldiK
        cDQ7OYCjQvsChqzWVhL1ZS6SSF1cRyKjfZhAg52VfKSzdvFQzdw4jh6bJ0hUPzLAQ3demUmk
        087x0VpnFX7SnTFUGQAzqCngMS/KJ0imIqeMYIx6NZ959usTwdjyLDymrS6d0bTrAbNs9D4r
        CBMci2bl8amswv9EpCBOV2gDyUXCq5+rjUQG0DjnAicK0odghXWUzAUCSkQ3AmgY7sMdBRG9
        DGDv++25gNqUCrvEnPMQwKy1rK2GvwCqa2dJh8SnfaHhboQjd6P1ALaNLgHHAaPvEfBD9QLh
        uNWVDoNNU4PAwTi9Gw5pzZsspANhc34VwY3kDcf61ZiDneggWH5/lcflWhKatP4cB8Kp+UaM
        Y1c4b2knOfaC6pzuLf86fDTXgDuGgHQGgCsTg1sNR+Fry8DmYxi9HZZ0lGLcmkKYky3iFAY2
        j5oAt6UOwOJ6KygCO2rANj3wYFOUCbGs8kAie8VPKUtQpiTG+l1KSjCCjd/R+8ey8hx0rkf1
        AJoCYhehpGVPuIiQpSrTEnoApDCxm/BpvSRcJIyWpV1jFUkRihQ5q+wBOylc7CG8KLkVJqJj
        ZSr2Mssms4r/VR7l5JkBguJt0770t9DpsejR0grjTFRwqWrR70HoWPp6g73PVDepkV6YiDgn
        XzYt3ohzOR1yW1vifnO4tXvIOVj6Jb7Rdt4WtXc1P1jy1oNsCFC5eh2PHvGx+5SFxOxqqqmt
        DhnrmD2TX/nbMzCInc6lYw+fOrhukLoYCwzrRyKD8mZifohxZZxsvy+mUMr+AYWrIEgZAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsVy+t/xa7ob9mhEGyxaxGRxa905VovecyeZ
        LJo63rJabJyxntVi/hGg2JWv79ksJt2fwGLx4t5FFov+x6+ZLc6f38BucbbpDbtF58Ql7Bab
        Hl9jtbi8aw6bxYzz+5gsFry8xWKx9shddoul1y8yWbTuPcJuMWPySzaLn7vmsTiIeqyZt4bR
        43JfL5PHzll32T1md8xk9di0qpPNY/u3B6we97uPM3lsXlLv0bdlFaPH501yAVxRXDYpqTmZ
        ZalF+nYJXBkz+u8zFkzgrXg0fxNrA2MfdxcjB4eEgIlE/z6lLkYuDiGBJYwS85q3snUxcgI5
        jUwSs64LgNSwCWhJrGmPB6kREVjFKDH17x12EIdZYDarxKtHExhBGoQFoiRWP7wMZrMIqEpc
        nXwEzOYVcJFY1zOPFcSWEJCTuHmukxnE5hRwlZg19zsTxDIXiRerrzBNYORZwMiwilEktbQ4
        Nz232FCvODG3uDQvXS85P3cTIzDstx37uXkH46WNwYcYBTgYlXh4GzaqRwuxJpYVV+YeYpTg
        YFYS4d26VCNaiDclsbIqtSg/vqg0J7X4EKM0B4uSOO95g8ooIYH0xJLU7NTUgtQimCwTB6dU
        A2NLiOyH7vcJnAlBcnZa5i3foj9dy+p9KZ5s2LrUddccfdUDWXImLJJH7i/mL1476Vvtqv+H
        Fm38X5LJM7u44f6kipKnYXPSD+w/ISN5b2X9nFs6szfG3Xwm+s5jrvhOPu2t/F+3LZoo/Iun
        YHfp+4A36Uy3D+TWs8duyLfoVlCvNNjOdtX5yT0lluKMREMt5qLiRADdd2QkdwIAAA==
X-CMS-MailID: 20180619082000eucas1p1c5cc2b526583c3fd5e9fc13656ed4858
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180619082000eucas1p1c5cc2b526583c3fd5e9fc13656ed4858
References: <1529396370-18761-1-git-send-email-m.purski@samsung.com>
        <CGME20180619082000eucas1p1c5cc2b526583c3fd5e9fc13656ed4858@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrzej Hajda <a.hajda@samsung.com>

The patch adds bindings to BOE HV070-WSA WSVGA panel.
Bindings are compatible with simple panel bindings.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 .../bindings/display/panel/boe,hv070wsa-100.txt    | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/boe,hv070wsa-100.txt

diff --git a/Documentation/devicetree/bindings/display/panel/boe,hv070wsa-100.txt b/Documentation/devicetree/bindings/display/panel/boe,hv070wsa-100.txt
new file mode 100644
index 0000000..9e8eea8
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/boe,hv070wsa-100.txt
@@ -0,0 +1,28 @@
+BOE HV070WSA-100 7.01" WSVGA TFT LCD panel
+
+Required properties:
+- compatible: should be "boe,hv070wsa-100"
+- power-supply: regulator to provide the VCC supply voltage (3.3 volts)
+- enable-gpio: GPIO pin to enable and disable panel (active high)
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
+
+The device node can contain one 'port' child node with one child
+'endpoint' node, according to the bindings defined in [1]. This
+node should describe panel's video bus.
+
+[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
+
+Example:
+
+	panel: panel {
+		compatible = "boe,hv070wsa-100";
+		power-supply = <&vcc_3v3_reg>;
+		enable-gpios = <&gpd1 3 GPIO_ACTIVE_HIGH>;
+		port {
+			panel_ep: endpoint {
+				remote-endpoint = <&bridge_out_ep>;
+			};
+		};
+	};
-- 
2.7.4

