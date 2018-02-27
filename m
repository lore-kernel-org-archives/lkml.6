Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-757978-1519715634-2-16401621644961458388
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
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
    t=1519715633; b=rMGGMZkgIbV5ppEcF/svcHegfn+lgfPiIdjHllBzRTKAEwM
    hKu3yfIxDV1I4zmUwCDb0u17Wxim9ewNL/Xxk2eT/scosiZjHeAn13zYKD2QsGRT
    U04ovhEWwj5XLOQIhiDwRyKI0xDV0By2hLJ/pQuKp96TmDXz9RqbIC49HRT0F2H5
    aAAsbZlkNpbZk5++qULyOcaEFvLCNOOaH6gx+hM7F4ZDlHEjHlZbJojKP2GkCq5s
    WQPktgSA4DC5XTsZ0EkwAle8KkrdV/SVLh7zjQhc3S0PuC0COI2AXYRScw9+5V6u
    7f2lN3+KUu4eZnEImj3fMMR3jatj5J+mkUMDb3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519715633;
    bh=5qsZQc0SYybPM6MtEJSNIW1Af2AK4oEOFaPMrjFqEAM=; b=s/KAdlCkL/uH
    VmARzWDxIk1K+KyONxq5NEeklronC32x6x3OXDtpgwwNav87tRQrB/TZx1tRC20p
    MXbtGXEIrDlwIpN86VSO2Upx7rQjTEfvFnYY4pt9UzfxgOedNN63XPZT7IfQgoqv
    ERTDy46wj8VfPI+YOEX0muSw1ujni9ofx86/ytca5M80LuJ9WGcroky1Tmzd5K3f
    FH3qpHoGdr2OmdYcmpe/f1kYsBGd7D5+Xriyt4zFbtYC8j8TtuDjMzrqYOC5O5Yr
    GPnan/+XJE1TbUuNWTCSYsy4sZv9nv5j7vXyZqqjjM2qEHJFh4RL3BEeg2ltqnCI
    umObuN9zVQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=jrnSo/xY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=jrnSo/xY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752160AbeB0HLp (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 02:11:45 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50094 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752042AbeB0HLm (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 27 Feb 2018 02:11:42 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180227071140euoutp02a1cc559a1720ce2aa2a758dba0ee81db~XHTIqJeUi2532325323euoutp02H
X-AuditID: cbfec7f5-b45ff700000028a9-ae-5a9504ab6a8f
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
Subject: [PATCH v5 1/6] dt-bindings: add bindings for USB physical connector
Date: Tue, 27 Feb 2018 08:11:29 +0100
Message-id: <20180227071134.28063-2-a.hajda@samsung.com>
X-Mailer: git-send-email 2.16.2
In-reply-to: <20180227071134.28063-1-a.hajda@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTURzHO7uP3a0Wl830YJowCjLKSgWPJGUhcYmgiIJYlN3yoqJT2Xyk
        ZMlw4pv5SA2f+Ri1VuocIzQVbDhQc7NpoiYaEolZUdNQ0cx513+/7/l+fuf3/R0OhUl/4b5U
        fFIqp0piE+WkGLcMro+eeIk/UZxaa5Sh6dejBNLkfydQZ007gSZXvhKo0bpzNr76k0Tlczoc
        2e0dQlRQ1ipEpoWPBHJ215Goxt4nQM16LYZeWWeFqG1yTIC0vVZhJM0YG4yAcZaWCJja/KcE
        YzIUkMxckU3AdLU+ZkrNBsC4TIeuUgpxRAyXGJ/OqU6evSuO67cbsBSN/4Om5nqQA0p8CgFF
        QToU5pUfKARiSko/B9D5px7nhQvAnt48QSEQ7UKbrg2PoQfwk3aM4MU2gMudy7sUSQfCra4p
        0l170bfhjw/dmBvCaAcOHcNLQrchoy/D2m/TmLvG6SOwtGwWc+eQ0AjmTHvz0wLgs/cTu4iI
        Dof9VSOk+x5Iz5BQk6fBeCgKfq5Y8cSTwSWbWcjXftBZUYTzDUUADvUVYLyoBNC+5PR0nIHv
        bO4dRDvx9sNySzXGv4YE5udJeYSB89sbHvw8rB0r9KxcDGDL2xahDvg2gT0G4MOlqZWxnDok
        icsIUrNKdVpSbND9ZKUJ7HyE4b+21Tegb/PeAKApIN8nifSrVEgJNl2dqRwAkMLkXpIXLRUK
        qSSGzcziVMnRqrRETj0ADlK43Edy5+gjhZSOZVO5BI5L4VT/XQEl8s0BxozfcyNW3Yx38eKF
        kmv+ocr29RbXfF1Yw6pDYc4el2HGvQE9FolWlyG+NLgeBarPWesirGvRRp3Irh/QTMxkO7QX
        b+QeX2gjw1yJs0NXQiy3TKaH4VWj1Vi9nn4WfDiyjFhtS+iYMucGBw7f/KJkQXTW9c3tjdjt
        rcX0MDmujmNPH8NUavYfIMBbgQQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrILMWRmVeSWpSXmKPExsVy+t/xy7qrWKZGGcybrGZxa905Voumjres
        FhtnrGe1uP7lOavF/CNAsStf37NZTLo/gcXi/PkN7BadE5ewW2x6fI3V4vKuOWwWM87vY7JY
        tKyV2WLtkbvsFkuvX2SyaN17hN1BwGPNvDWMHpf7epk8ZnfMZPXYtKqTzeN+93Emj81L6j36
        tqxi9Pi8SS6AI4rLJiU1J7MstUjfLoErY//5VcwFTbIVCxbNZWxg7BXvYuTkkBAwkfjz+RcL
        iC0ksIRR4sss9y5GLiC7kUnixruD7CAJNgFNib+bb7KB2CICsRJvT31mBiliFrjAIvF74kyw
        ImEBH4nZr28xg9gsAqoSfRPvAtkcHLwCFhINt8QglslLLDx7FayEU8BSYv+0M2wQiy0k7nce
        Y53AyLOAkWEVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYMBuO/Zzyw7GrnfBhxgFOBiVeHhn
        yE2JEmJNLCuuzD3EKMHBrCTCu3Lx5Cgh3pTEyqrUovz4otKc1OJDjNIcLErivOcNKqOEBNIT
        S1KzU1MLUotgskwcnFINjH0c8yX3HLoWqHmw3/SHQ5PtDZGpDJlPpY2FXKL3OG89nXLsn6S7
        4qegNDX22HN/j+fPbWTz/7vo+Xu9vYzd+7PNzkocC7mXI8GVOF/Qu/PTnNCotJytPH/ypReG
        O918pBB2le3W1XmVZRecFzxtTg1e+F98Dtv/eqln1QUb3m/6psdaFOO9WImlOCPRUIu5qDgR
        AO9WhdhUAgAA
X-CMS-MailID: 20180227071138eucas1p17e1e16f13f6d3e3b15a57dc93eb8cf3f
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180227071138eucas1p17e1e16f13f6d3e3b15a57dc93eb8cf3f
X-RootMTR: 20180227071138eucas1p17e1e16f13f6d3e3b15a57dc93eb8cf3f
References: <20180227071134.28063-1-a.hajda@samsung.com>
        <CGME20180227071138eucas1p17e1e16f13f6d3e3b15a57dc93eb8cf3f@eucas1p1.samsung.com>
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
2.16.2

