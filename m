Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1047503-1519203424-2-2129847337442613254
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
    t=1519203423; b=G1IE+iYnu1jnWO80MV4zeGw2FANsReYaXrDidqj8raDqA7r
    zrcj6x9MrtBhMAY7ufp+u7tnKaLkEsQFf4tQEEcdRmwA3jBpApfL3gR+nmKM1HPS
    VAWQLg9AiFoKewsbZj8+HlOPC2Jr8qGoWflYSSAU5xIWrJaHcIaNScJbGZHXuCM/
    9ViXy1D+ydQ9rMEhMyr10UhrtnRZwLfQWRwRcjJViJSimjQ50OPZ5Sexbop3jv4o
    rsB45FVzZCW4bKndtrOZq7vXXRRyTZX0qieqcaAWytEUCikxAUZ9Jxxy9UOf/8pE
    3ouUGNM7wRhYxkHKSBj8/GLH4NaBOGja29Gt1Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519203423;
    bh=Mctx2PRPvkqpweEFzPe4EEQukXIiLc5hqA4B2KmT95M=; b=lRe1FRBHWbZC
    f2D6HjXYhYqnZ3jhUh+cp6aCXjrTCL8wBTaKRb5Kn6jXtLJ9+s976zlmJVfW6Vy9
    mb23HsrkbJzijOpvzO3YAr+zyUp4o+4X8ALOV1AZVz0Wh/Py/X//VLXGG+GZdqLJ
    vG1EpOd8cYV/CyW6jltrKic4PaPRf9MwKvkIdkxEo/jP/cA5rn6dnMGnrOaJx1n5
    DI9ER1Qy+Z5gCNS5W2FLbPKplkO1/d/qBzIeq0YCx73dw3Te/8XrfF9WDg0lyGUu
    1h0Zf/xQSOISP43vRgEhQTBYYrx2qnlZG7N0jvGJlmIce+M1qrFOgAyFrjtJ7A4+
    tXqyompIxg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=k1G3FsBJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=k1G3FsBJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752667AbeBUI4Q (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 03:56:16 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54300 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751537AbeBUI4I (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 21 Feb 2018 03:56:08 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180221085606euoutp0194f020b80ca2423f86e8d5170400b0ba~VS2mxJ3Qd2444524445euoutp01S
X-AuditID: cbfec7f4-713ff700000043e4-d4-5a8d342541b8
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
Subject: [PATCH v4 2/6] dt-bindings: add bindings for Samsung micro-USB
 11-pin connector
Date: Wed, 21 Feb 2018 09:55:37 +0100
Message-id: <20180221085541.14556-3-a.hajda@samsung.com>
X-Mailer: git-send-email 2.16.1
In-reply-to: <20180221085541.14556-1-a.hajda@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsWy7djPc7qqJr1RBk++qVncWneO1aKp4y2r
        xcYZ61ktrn95zmox/whQ7MrX92wWk+5PYLE4f34Du0XnxCXsFpseX2O1uLxrDpvFjPP7mCwW
        LWtltlh75C67xdLrF5ksWvceYXcQ8Fgzbw2jx+W+XiaP2R0zWT02repk87jffZzJY/OSeo++
        LasYPT5vkgvgiOKySUnNySxLLdK3S+DKeHKkquCgUMWE8/NZGxjX83cxcnJICJhIXDvVzQRi
        CwmsYJT48Fm/i5ELyP7MKDHrxRb2LkYOsKIdvzgh4ssYJV6ffcIK0fCfUeL4VB0Qm01AU+Lv
        5ptsILaIQKzEu0u7mEEamAUusEhcOP2KHSQhLBAlMfn9JGYQm0VAVeJg11xGEJtXwEJi3aEp
        jBAXyUscftMEtoBTwFLi995JYIMkBG6zSVyetRGqyEVi4tT1bBC2sMSr41vYIWwZic6Og0wQ
        Dd2MEqf2dUJ1T2GUOP/qMhNElbXE4eMXwVYwC/BJTNo2nRniT16JjjYhiBIPiRPHrkMtc5S4
        +ukKM8T/PYwSq89tYpzAKLWAkWEVo3hqaXFuemqxUV5quV5xYm5xaV66XnJ+7iZGYDI4/e/4
        lx2Mu/4kHWIU4GBU4uF9YdATJcSaWFZcmXuIUYKDWUmEt1KoN0qINyWxsiq1KD++qDQntfgQ
        ozQHi5I4b5xGXZSQQHpiSWp2ampBahFMlomDU6qBcZWKuUH5BMV825LdVy+uuZ9/3FAuXFx4
        nvuh75N3vdsvqcl1aY6p66dzyVti9HRn7quSnsKUHyJgUiD532bDwa3fzva1+PVLZup0vXP8
        mC6txVCV38/O2cvc1sVl8Wain8HBKU5Np0TWGV2OtJkqeWnSxPb7HU0Rkr+CfqtVfA79oWUU
        zfpWiaU4I9FQi7moOBEAjUCvigIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsVy+t/xa7qqJr1RBruW8ljcWneO1aKp4y2r
        xcYZ61ktrn95zmox/whQ7MrX92wWk+5PYLE4f34Du0XnxCXsFpseX2O1uLxrDpvFjPP7mCwW
        LWtltlh75C67xdLrF5ksWvceYXcQ8Fgzbw2jx+W+XiaP2R0zWT02repk87jffZzJY/OSeo++
        LasYPT5vkgvgiOKySUnNySxLLdK3S+DKeHKkquCgUMWE8/NZGxjX83cxcnBICJhI7PjF2cXI
        xSEksIRR4tPiE4xdjJxATiOTxJKZHiA2m4CmxN/NN9lAbBGBWIm3pz4zgzQwC1xgkfg9cSY7
        SEJYIEpi8qqLrCA2i4CqxMGuuWCDeAUsJNYdmgJmSwjISxx+0wRWwylgKfF77yRmiGUWEh/O
        fWWfwMizgJFhFaNIamlxbnpusaFecWJucWleul5yfu4mRmC4bjv2c/MOxksbgw8xCnAwKvHw
        Wuj0RAmxJpYVV+YeYpTgYFYS4a0U6o0S4k1JrKxKLcqPLyrNSS0+xCjNwaIkznveoDJKSCA9
        sSQ1OzW1ILUIJsvEwSnVwOjp80mWc9HczQv/9B9dG2Uo5VOr09f3rPvqnfX7rWd6RCY3+HvP
        /7u2V1TJQKt43v/1KhLLOn47LjrSuUa14uzSk1kezc/jHomUsFZ1rnGx269Qu9ZfxnkPg9iD
        4/6/jfuXXfrRf/BvsZ/3yvsbHVW9zNofH/LhfbWpvutw6IKrtSH9Rlcc45VYijMSDbWYi4oT
        AZkUPktTAgAA
X-CMS-MailID: 20180221085605eucas1p164d6a334353cf34c4c6f203bf7dec6ae
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180221085605eucas1p164d6a334353cf34c4c6f203bf7dec6ae
X-RootMTR: 20180221085605eucas1p164d6a334353cf34c4c6f203bf7dec6ae
References: <20180221085541.14556-1-a.hajda@samsung.com>
        <CGME20180221085605eucas1p164d6a334353cf34c4c6f203bf7dec6ae@eucas1p1.samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Samsung micro-USB 11-pin connector beside standard micro-USB pins,
has pins dedicated to route MHL traffic.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v4:
- removed description of property inherited from usb-connector (Rob),
- fixed example description.
---
 .../connector/samsung,usb-connector-11pin.txt      | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/connector/samsung,usb-connector-11pin.txt

diff --git a/Documentation/devicetree/bindings/connector/samsung,usb-connector-11pin.txt b/Documentation/devicetree/bindings/connector/samsung,usb-connector-11pin.txt
new file mode 100644
index 000000000000..22256e295a7a
--- /dev/null
+++ b/Documentation/devicetree/bindings/connector/samsung,usb-connector-11pin.txt
@@ -0,0 +1,49 @@
+Samsung micro-USB 11-pin connector
+==================================
+
+Samsung micro-USB 11-pin connector is an extension of micro-USB connector.
+It is present in multiple Samsung mobile devices.
+It has additional pins to route MHL traffic simultanously with USB.
+
+The bindings are superset of usb-connector bindings for micro-USB connector[1].
+
+Required properties:
+- compatible: must be: "samsung,usb-connector-11pin", "usb-b-connector",
+- type: must be "micro".
+
+Required nodes:
+- any data bus to the connector should be modeled using the OF graph bindings
+  specified in bindings/graph.txt, unless the bus is between parent node and
+  the connector. Since single connector can have multpile data buses every bus
+  has assigned OF graph port number as follows:
+    0: High Speed (HS),
+    3: Mobile High-Definition Link (MHL), specific to 11-pin Samsung micro-USB.
+
+[1]: bindings/connector/usb-connector.txt
+
+Example
+-------
+
+Micro-USB connector with HS lines routed via controller (MUIC) and MHL lines
+connected to HDMI-MHL bridge (sii8620):
+
+muic-max77843@66 {
+	...
+	usb_con: connector {
+		compatible = "samsung,usb-connector-11pin", "usb-b-connector";
+		label = "micro-USB";
+		type = "micro";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@3 {
+				reg = <3>;
+				usb_con_mhl: endpoint {
+					remote-endpoint = <&sii8620_mhl>;
+				};
+			};
+		};
+	};
+};
-- 
2.16.1

