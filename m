Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-757978-1519715552-2-18051982809370913142
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
    t=1519715551; b=AYUsZhg4YjW5KM72/Adz09fo/yJJ4gdQB0mL/k3MVrbHpA6
    Hbz0y7D0LeEg41vZNdV5fFbltR4JBny01EYaRSscffeeYOPRCuxw1pz8gPiANPWN
    j8zMXw+2ZZNvblvbpR+jIVQpYuU7bCt4iAZiFXOvuRF6ws+iV4rfFpWTrOa56gOO
    01BOUGLAgkSVF42eo5Vv/10t6ubeC4Eqm1ZvEsI2iPRrcngFsX5neQUh1Bt38PjI
    nV1pcx7kELgSIuWPH8ABX+oyw+WP/SM2KTXbL6AqizxEJyhlZM7y2hyVwptBfo0r
    VCHJilDUaw7IC1WugeTIZm/g0pl8C0bTcaE8Opg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519715551;
    bh=HYTFpnnrxMgBZr13U4GqwMNeDo25NiytmEMSwtL/aq8=; b=SLe5U7WIOjg6
    zXcH9skM2es+F5J/NG/2hEGs0prDsxiGyv4yAKZs07GNzeXprgiwr7R1i9IBFWr4
    qnVI7bxr1gjK2AUrJ+FDTcJMqN/SCvWuZpFeD6to7amf1TMkhL11B3Y5CpDFyHb/
    i/p8vArAe9TAYwnDUTf6wN4SCYKtI+tE04ba/kVpwDzuK5Q7VEnAJEimSWyjn5qK
    UlsiZ00+49kx7mWlREtTMfYlFyaiygXovjhgANemn/8JYDBHw1vXEpWzjR7zFcgr
    Lt1wbu3PREQAPDrYWLvt4qbtZm2fFj0TEkQBsaHiokm/2W7BTJCek2ZBWCwT2qy2
    kYTcvXRlpA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=rVbLmePd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=rVbLmePd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752193AbeB0HLt (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 02:11:49 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47729 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752107AbeB0HLn (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 27 Feb 2018 02:11:43 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180227071140euoutp01e0f71a589e1ed776ce441ef3d6075269~XHTI9iYIA2121721217euoutp015
X-AuditID: cbfec7f4-713ff700000043e4-7c-5a9504abf5ee
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
Subject: [PATCH v5 2/6] dt-bindings: add bindings for Samsung micro-USB
 11-pin connector
Date: Tue, 27 Feb 2018 08:11:30 +0100
Message-id: <20180227071134.28063-3-a.hajda@samsung.com>
X-Mailer: git-send-email 2.16.2
In-reply-to: <20180227071134.28063-1-a.hajda@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfyyUcRzHfZ9f95Crp4fNd6i2s35oS2rZnkYls/XMX22l1jPJlWdHuWP3
        IGz50cack/lxStMPOVTnSh3TYRHJtcTRVRJmE2PXuIpalpLz8N/7/Xm/Pj/++JAo/R3zJuNV
        ybxaJU+QEW5Yc8+idU89Vs4F6vuCmM+P+3Hmav4szjytaMCZoYVpnLnbvVJ7/9NBMKXjxRhj
        tT6RMJqSGglj+vIRZ2yttwimwtqOMNV1uSjzqHtMwtQODSJM7vNuSSjFGu8YAWsruoawlfk3
        cdZk0BDsuNaCsI01WWxRkwGw86atx0nOLSSWT4hP5dV7D8e4xQ0XTmNJnXSauV+DZ4OGTQXA
        lYTUATj1tQMUADeSph4AWNY7s2bmATRrx8A6VTKlI8SgDsCZnGpcNMsAPiufQ50UQfnDv43D
        hFN7Umfh3LtW1Amh1AAGB3rtEmfgQXFwtK0WKQAkiVHb4egnzFmWUgx8rZ9ExW3b4L2+D6va
        lToIO66/Xd0MqXEC1rVXIiIUDgf+TGGi9oB2S5NE1L7QVqbFxAYtgG/aNahodABa7ba17mD4
        0jKIOzVKbYSlzTdQ50WQksL8PFpEWOgY/rY29Ch8NftiFaepQgBLjZnFwLsKuBiAF58iKBW8
        sF/FXw4Q5EohRaUIuJCoNIGVR+j9Z1kwg9al812AIoHMXRrqq+NoXJ4qpCu7ACRRmaf0ob6M
        o6Wx8vQMXp14Tp2SwAtdwIfEZF7S6F2ZHE0p5Mn8JZ5P4tXrKUK6emeDZL8TxmJTT15GyMUY
        wWXzMd1gu+JKlFUZlDnh+HUq0sVsaJ3tzJj9YdH+7jtir69ZPjTisxg2HjbZwtnb5v0twWmp
        EaCwaix0S9pJQ5Yn14OMRDRVmkqrIndEB4bXuuuXohw56G1JefNOP1VCzMIZusojeMPEfb3u
        tCYuoLJFhglx8n27UbUg/w+XQ6H9BAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrELMWRmVeSWpSXmKPExsVy+t/xy7qrWaZGGXQ8ELC4te4cq0VTx1tW
        i40z1rNaXP/ynNVi/hGg2JWv79ksJt2fwGJx/vwGdovOiUvYLTY9vsZqcXnXHDaLGef3MVks
        WtbKbLH2yF12i6XXLzJZtO49wu4g4LFm3hpGj8t9vUwesztmsnpsWtXJ5nG/+ziTx+Yl9R59
        W1YxenzeJBfAEcVlk5Kak1mWWqRvl8CVcbPnOUvBQaGKHec6WRsY1/N3MXJySAiYSEx8OoWt
        i5GLQ0hgCaPEtI5PUE4jk8SkE9uZQarYBDQl/m6+yQZiiwjESrw99ZkZpIhZ4AKLxO+JM9lB
        EsICURIHnixh6WLk4GARUJW4c4MFJMwrYCFxYvETZoht8hILz14FszkFLCX2TzsDNlMIqOZ+
        5zHWCYw8CxgZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgSG7LZjP7fsYOx6F3yIUYCDUYmH
        d4bclCgh1sSy4srcQ4wSHMxKIrwrF0+OEuJNSaysSi3Kjy8qzUktPsQozcGiJM573qAySkgg
        PbEkNTs1tSC1CCbLxMEp1cCot0G8MGDrj2ufY4r9ig5mv5QuuD/dzkTpZGKip3PJmqT3KwPn
        HuxgnStXd3JD1vHfq4tf2yt6HY3+274lJ8RXxnbNR51TruFbDfM/tq5W+f/qiN5lkU/d7c03
        uS6ebb+cvlLDy9+18cd9Xwf1RV0z7bLWPLJefjlpnlW6av+rL9uUty8+9POrEktxRqKhFnNR
        cSIAOCf0+lUCAAA=
X-CMS-MailID: 20180227071139eucas1p125ee35ada221fbed1dc85b7fc250f9ca
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180227071139eucas1p125ee35ada221fbed1dc85b7fc250f9ca
X-RootMTR: 20180227071139eucas1p125ee35ada221fbed1dc85b7fc250f9ca
References: <20180227071134.28063-1-a.hajda@samsung.com>
        <CGME20180227071139eucas1p125ee35ada221fbed1dc85b7fc250f9ca@eucas1p1.samsung.com>
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
2.16.2

