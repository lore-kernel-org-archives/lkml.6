Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1049172-1519203490-2-4735360408020759244
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519203490; b=DnIWxPTGTvdzbO3/lUaFt9GzD7GPCQtuRpkKVOSmMYotfEQ
    Xt77ILOm1wDebggi2jrQeQlAz7UrCVGOYuWq3GaJv9ofLQeubw0mWEpP392B91Gr
    hl1W7OfPxNKd4UGCSyzA5dliNuQUbCdGtmOb1hgOKJ1n4OG3SbfIP6dm5LE9JRXY
    75TCO3yvmZMO6wqyLFWprCGoNNwSTatkr9NjwNIHnm0L9mryjanpNLF+5VGgfoS5
    fTaG4PzIFiaf3BV6Vso0yBd+KZftt+FP4qngjYW+GwMbhk0C0F+iWajJvlvaEyOz
    +7ZHcI75p8G75pnkk5yrtL7oqf4/22648t6DYaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519203490;
    bh=eyxdFVf5rNVuubywXafn+NAHJeleoa31aZGOWP3jmBQ=; b=DCye78OrcuY8
    qrBWOAk5KCh+p1x33G8R+FmF7rjV/CC87Fukw9fPY+gj/7TghJODo8t/llnv4f1Q
    FzvQFriGASU69HaO+YIxKivePYlbGZZyV/mNA6uUXGbqOxDipHgyzdbnwvTVDB/U
    O3IbwQ9jkMffC2s7vPBQsAmvE6FRI0kobZ0BXfx7VcETAgVoPgK9DGIf40Zt7QpD
    892vH+/N8j4EBb1jMhxibfwJzrrEzAnfbK9eDA//lc+VmpV1L3FXJYpq1brmSdjI
    5vOQNGH9D17InsntIgLmJXvjN7p7R/u51stgvykzUAac5SK0oMoMxQ0gR+3wjXml
    bQC3jiZ0SQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=GKulmxV9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=GKulmxV9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752630AbeBUI4L (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 03:56:11 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54292 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751535AbeBUI4I (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 21 Feb 2018 03:56:08 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180221085605euoutp011789a2c904db1cd1f82ec81e42f73f99~VS2mJjzt82475124751euoutp01E
X-AuditID: cbfec7f5-b45ff700000028a9-dd-5a8d3424c60b
From: Andrzej Hajda <a.hajda@samsung.com>
To: devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Cc: Andrzej Hajda <a.hajda@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v4 1/6] dt-bindings: add bindings for USB physical connector
Date: Wed, 21 Feb 2018 09:55:36 +0100
Message-id: <20180221085541.14556-2-a.hajda@samsung.com>
X-Mailer: git-send-email 2.16.1
In-reply-to: <20180221085541.14556-1-a.hajda@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0iTURjHPXsvex2tTlPypN0YShqmpn44ZZZG4PtBwqBPg9SVL2pe27y0
        6KKS4pwTMyE1qbSlMbR0XjG1mMOFipc2EwVdJGEMncTUELs5X/32O//n95zn4XAYQrJKejOp
        mTmcIlOeLqVFZPfw5vhp33CtLKTQHIHn3o5TuKh0hcLtNe8oPLO2ROEXpu3Mur5K4ypbJYkn
        JtqEWP1YJ8SGxS8UtvTV07hmYlCAG5uKCdxqmhfi1zNTAlw8YBJGQbbleQtgLRVaAfustJZi
        DXo1zdo0ZgHboXvIVnTqAes0HItjZKLzSVx6ah6nCL6QKErpsqwJsouO3lmtGKMKgNarDLgz
        CIaj744tysUS+AagVUcCz06Aqgti9xx7WzsoA6LtvAmgr80bJH/4B1CJxk64LBoGoD8ds7SL
        PeF15PjcR7gkAk6SaHLULnQVPGAsah1b3maGIaEf6mq95IrFEKOPZR8oftpxNLRctMPu8Cza
        GqjauQdBG40KPzUKeekyWthYJHj2QHZz525+BFmeaEi+QQPQyKB6t7saoAm7RcBbEWjIPLUz
        goD7UVX3U8K1EYJiVFoi4RUWOSaraZ6jUccrA82/SzlAujpVJfB+Cdz0wIvLVWYkc8qwTC4/
        SCnPUOZmJgfdzMowgO1vMPrXvN4LBn/fMALIAOk+MQ4sl0koeZ5SlWEEiCGknmKVRCuTiJPk
        qrucIitBkZvOKY3AhyGlXuJ4/wcyCUyW53BpHJfNKfaqAsbduwAIghui3+v9ZyLTOE3FySAH
        d3EFmaQ+PfW1/dHWlNooan45JHBK5Swz2txi8ptDe9Oh24HA6brpxJz4GMX9tJ5b+f0R2SPw
        cIT6ClnjTJipG/55EJhmrQa974/ConthVuK2bs4vMq5hYemX99KjE42hm6Kuc9esAdqr33SH
        +qWkMkV+5hShUMr/AxsEiicCAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrELMWRmVeSWpSXmKPExsVy+t/xa7oqJr1RBpf/yVrcWneO1aKp4y2r
        xcYZ61ktrn95zmox/whQ7MrX92wWk+5PYLE4f34Du0XnxCXsFpseX2O1uLxrDpvFjPP7mCwW
        LWtltlh75C67xdLrF5ksWvceYXcQ8Fgzbw2jx+W+XiaP2R0zWT02repk87jffZzJY/OSeo++
        LasYPT5vkgvgiOKySUnNySxLLdK3S+DK2Hr5C1NBk2zF+74zrA2MveJdjJwcEgImEq82bGTs
        YuTiEBJYwigxY8liNginkUli/eyLzCBVbAKaEn8332QDsUUEYiXenvrMDFLELHCBReL3xJns
        IAlhAR+JtWfeANkcHCwCqhJb1zqBhHkFLCQOdO1nhdgmL3H4TROYzSlgKfF77ySw+UJANR/O
        fWWfwMizgJFhFaNIamlxbnpusZFecWJucWleul5yfu4mRmDIbjv2c8sOxq53wYcYBTgYlXh4
        LXR6ooRYE8uKK3MPMUpwMCuJ8FYK9UYJ8aYkVlalFuXHF5XmpBYfYpTmYFES5z1vUBklJJCe
        WJKanZpakFoEk2Xi4JRqYGTL+ylsH/5UYKbq+zPyrozX3bx4F+gru/XEhawUOXLEaad1uai7
        /K2U7cE3bXnd0pyO2Ac3OsyvZL9opHKPRevGrBuNt2+vfcnTzr1Jy+fBSlWJ/Qms+/bdul71
        9uXq+44H8tjPKtsz1f9ccOOtSd/31ENLXh3bLfdN+8HptC//VcTn+i2fE6nEUpyRaKjFXFSc
        CADeIyH3VQIAAA==
X-CMS-MailID: 20180221085604eucas1p11aa066a1e106d9f9850731a5171dce8b
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180221085604eucas1p11aa066a1e106d9f9850731a5171dce8b
X-RootMTR: 20180221085604eucas1p11aa066a1e106d9f9850731a5171dce8b
References: <20180221085541.14556-1-a.hajda@samsung.com>
        <CGME20180221085604eucas1p11aa066a1e106d9f9850731a5171dce8b@eucas1p1.samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

These bindings allow to describe most known standard USB connectors
and it should be possible to extend it if necessary.
USB connectors, beside USB can be used to route other protocols,
for example UART, Audio, MHL. In such case every device passing data
through the connector should have appropriate graph bindings.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
v4:
- improved 'type' description (Rob),
- improved description of 2nd example (Rob).
v3:
- removed MHL port (samsung connector will have separate bindings),
- added 2nd example for USB-C,
- improved formatting.
v2:
- moved connector type(A,B,C) to compatible string (Rob),
- renamed size property to type (Rob),
- changed type description to be less confusing (Laurent),
- removed vendor specific compatibles (implied by graph port number),
- added requirement of connector being a child of IC (Rob),
- removed max-mode (subtly suggested by Rob, it should be detected anyway
  by USB Controller in runtime, downside is that device is not able to
  report its real capabilities, maybe better would be to make it optional(?)),
- assigned port numbers to data buses (Rob).

Regards
Andrzej
---
 .../bindings/connector/usb-connector.txt           | 75 ++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/connector/usb-connector.txt

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
new file mode 100644
index 000000000000..e1463f14af38
--- /dev/null
+++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
@@ -0,0 +1,75 @@
+USB Connector
+=============
+
+USB connector node represents physical USB connector. It should be
+a child of USB interface controller.
+
+Required properties:
+- compatible: describes type of the connector, must be one of:
+    "usb-a-connector",
+    "usb-b-connector",
+    "usb-c-connector".
+
+Optional properties:
+- label: symbolic name for the connector,
+- type: size of the connector, should be specified in case of USB-A, USB-B
+  non-fullsize connectors: "mini", "micro".
+
+Required nodes:
+- any data bus to the connector should be modeled using the OF graph bindings
+  specified in bindings/graph.txt, unless the bus is between parent node and
+  the connector. Since single connector can have multpile data buses every bus
+  has assigned OF graph port number as follows:
+    0: High Speed (HS), present in all connectors,
+    1: Super Speed (SS), present in SS capable connectors,
+    2: Sideband use (SBU), present in USB-C.
+
+Examples
+--------
+
+1. Micro-USB connector with HS lines routed via controller (MUIC):
+
+muic-max77843@66 {
+	...
+	usb_con: connector {
+		compatible = "usb-b-connector";
+		label = "micro-USB";
+		type = "micro";
+	};
+};
+
+2. USB-C connector attached to CC controller (s2mm005), HS lines routed
+to companion PMIC (max77865), SS lines to USB3 PHY and SBU to DisplayPort.
+DisplayPort video lines are routed to the connector via SS mux in USB3 PHY.
+
+ccic: s2mm005@33 {
+	...
+	usb_con: connector {
+		compatible = "usb-c-connector";
+		label = "USB-C";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				usb_con_hs: endpoint {
+					remote-endpoint = <&max77865_usbc_hs>;
+				};
+			};
+			port@1 {
+				reg = <1>;
+				usb_con_ss: endpoint {
+					remote-endpoint = <&usbdrd_phy_ss>;
+				};
+			};
+			port@2 {
+				reg = <2>;
+				usb_con_sbu: endpoint {
+					remote-endpoint = <&dp_aux>;
+				};
+			};
+		};
+	};
+};
-- 
2.16.1

