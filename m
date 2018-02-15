Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1146594-1518691259-2-14362586574067926024
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518691258; b=sg/+Duf9UsBgq+7PwfPNFCwKCeW1wLllhoQQZvGKwiHGW/z
    0Yw5DZqMGgu8c8e+tQ2DEYK/F0Q+yfLAmBisZCxi2zZTHrrnk37yjK+/dkML9XmU
    VcFaakPdFujOgaVsG/451AYgnl9rZIPiJd6Q9Pm/70ey9Wh3Fic6TSLDyNNNXLE9
    bRS4FHJA1URPhKoCJ/CqtVCtovTObuLjlU+gKs9O2w+aXMqYL9nK4jYFt5jSWfRa
    jcbEqzBOa8KJ+jJFJNBKDwX+mcvCCxbbvIDTdPnQ3jWQzt6NfwqMLI8I4v4xsvnl
    ulCY8w1bdELLBK0K4e+xCwkW7ERE0ezytM958/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1518691258;
    bh=UO8e6kkkBhzXbWbxV/mXveJ4kr3JJHvfEFLpKSmOm88=; b=ODZCawAi6zrW
    tJWxoeaM1zHc/dIFeKQu+hOQV8+15EYipBuhqI8ZxfBn72fi7kldZsj6QwQA9exa
    GCma0nhw+SQ2kjpp/x3KouMWKBTORIVUDco4Psq3co733bVPhjwboEtpHzqxqS3n
    2Z/d1gpq3zTfaAWKImEGipLFZKRwiQBHsm5TQhFc1RQRTtyzS8/aNTvc5KO8oAPj
    ohOKKo/TDoz7ZHPjntCPCp0dmljNABOvicg0opPpXBVFHkhSXGfL5+jWdaxK/MhJ
    TS7l3HaTCgQRjYnMxZKRyad5gs+2+nuJGwfzwBtWx/bhHvDku3MI/DnVo6611azi
    w+iT0oSU0w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=pGZACbs1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=pGZACbs1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755382AbeBOKjf (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 05:39:35 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50922 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755304AbeBOKjc (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 15 Feb 2018 05:39:32 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180215103930euoutp02712a9523f25d21046946ea2f317a104f~TeZKob9H81269412694euoutp02c
X-AuditID: cbfec7f5-b45ff700000028a9-ea-5a85635fcf7f
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
Subject: [RFC PATCH v2 1/6] dt-bindings: add bindings for USB physical
 connector
Date: Thu, 15 Feb 2018 11:39:15 +0100
Message-id: <20180215103920.32017-2-a.hajda@samsung.com>
X-Mailer: git-send-email 2.16.1
In-reply-to: <20180215103920.32017-1-a.hajda@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsWy7djP87rxya1RBh9ns1ncWneO1aKp4y2r
        xcYZ61ktrn95zmox/whQ7MrX92wWk+5PYLE4f34Du0XnxCXsFpseX2O1uLxrDpvFjPP7mCwW
        LWtltlh75C67xdLrF5ksWvceYXcQ8Fgzbw2jx+W+XiaP2R0zWT02repk87jffZzJY/OSeo++
        LasYPT5vkgvgiOKySUnNySxLLdK3S+DK+LT6L0vBDZmKCZ8/szYwvhPrYuTgkBAwkdg4QbeL
        kYtDSGAFo8Sf5cfZIJzPjBLrliwDcjjBin4/aGOFSCxjlPjw8AY7hPOfUeLklyfsIFVsApoS
        fzffBOsQEYiVeHdpFzNIEbPABRaJC6dfgRUJCwRJTDrdxQyym0VAVWJLcyhImFfAQmLZ61+s
        ENvkJQ6/aWIFKeEUsJSYMt8CZIyEwH02ie5115ghalwk/l3ZzQRhC0u8Or6FHcKWkejsOMgE
        0dDNKHFqXyczhDOFUeL8q8tQHdYSh49fBNvGLMAnMWnbdGZIYPBKdLQJQZR4SMyaMAGq3FHi
        YPdRaLj0AA1dtoNxAqPUAkaGVYziqaXFuempxcZ5qeV6xYm5xaV56XrJ+bmbGIHp4PS/4193
        MO77k3SIUYCDUYmH18CmJUqINbGsuDL3EKMEB7OSCO/HqNYoId6UxMqq1KL8+KLSnNTiQ4zS
        HCxK4rxxGnVRQgLpiSWp2ampBalFMFkmDk6pBsaa/3Njvs9fvrCAQVVV0qzRflf5rN7jnt7V
        G8P1djF0ctTvSb06iSkxX9flzPdfd9Je62koPOKJWnT/RaRU3ScRxciqZTOvKesK6Tbt33ao
        +Xa5YYEr7zmjVU42zLIzUrPbhYU+3qqO0VzWcutt4LXPG6J/TFmnyjsrtG9nIGd78v7Fb4Vm
        2SqxFGckGmoxFxUnAgBPQKaAAwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrILMWRmVeSWpSXmKPExsVy+t/xq7qxya1RBu9ua1rcWneO1aKp4y2r
        xcYZ61ktrn95zmox/whQ7MrX92wWk+5PYLE4f34Du0XnxCXsFpseX2O1uLxrDpvFjPP7mCwW
        LWtltlh75C67xdLrF5ksWvceYXcQ8Fgzbw2jx+W+XiaP2R0zWT02repk87jffZzJY/OSeo++
        LasYPT5vkgvgiOKySUnNySxLLdK3S+DK+LT6L0vBDZmKCZ8/szYwvhPrYuTkkBAwkfj9oI21
        i5GLQ0hgCaPE59eNTBBOI5PEi0UdzCBVbAKaEn8332QDsUUEYiXenvrMDFLELHCBReL3xJns
        IAlhgQCJDTO2ASU4OFgEVCW2NIeChHkFLCSWvf7FCrFNXuLwmyZWkBJOAUuJKfMtQMJCQCUb
        J89jncDIs4CRYRWjSGppcW56brGhXnFibnFpXrpecn7uJkZgwG479nPzDsZLG4MPMQpwMCrx
        8BrYtEQJsSaWFVfmHmKU4GBWEuH9GNUaJcSbklhZlVqUH19UmpNafIhRmoNFSZz3vEFllJBA
        emJJanZqakFqEUyWiYNTqoExV8smOfjlydaNeZ+mhkvs+/8999QUy90lj8qr3ymszl23crOB
        ZMJP5vDT+7usZ7U1753hoH2oNra37tujSbsY5WwO8t599vvolFW+TxPnO+XUelUZ7HFvDEze
        0r0muiXoMp+E70yGH+8zmudt+3rk0KKPWjyMs/bc6H9ad/bM400Xik/eFHUOU2Ipzkg01GIu
        Kk4EAOCyx3lUAgAA
X-CMS-MailID: 20180215103925eucas1p1d82fd73ac6ea77c8b66de4ed26101a71
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180215103925eucas1p1d82fd73ac6ea77c8b66de4ed26101a71
X-RootMTR: 20180215103925eucas1p1d82fd73ac6ea77c8b66de4ed26101a71
References: <20180215103920.32017-1-a.hajda@samsung.com>
        <CGME20180215103925eucas1p1d82fd73ac6ea77c8b66de4ed26101a71@eucas1p1.samsung.com>
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
v3:
- removed MHL port (samsung connector will have separate bindings),
- added 2nd example for USB-C,
- improved formatting
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

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>

dt-bindings: add bindings for USB physical connector v3
---
 .../bindings/connector/usb-connector.txt           | 74 ++++++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/connector/usb-connector.txt

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
new file mode 100644
index 000000000000..1efda92639da
--- /dev/null
+++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
@@ -0,0 +1,74 @@
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
+  non-standard (large) connector sizes: "mini", "micro".
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
+to companion PMIC (max77865), SS lines to USB3 PHY and SBU to DisplayPort:
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

