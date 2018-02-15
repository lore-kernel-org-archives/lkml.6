Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1146594-1518691196-2-4175315796913771916
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
    t=1518691195; b=GlW0U6ZpOLMDX0zcAQkmndbWmYqlCIwJiftDW6qdlesIbqo
    loJFmRm9HoTQ87xdmHtfhAMbg7jNX7JvTph141/8KfGAlwTVU1omuNqHlefBF2zM
    bWd51F0ITVEe26joDlsz5ry+s13N2B/7Xb2QVLUdYxxElkc5tVu49j+l/dV9IiKV
    Zp+i/8EYt6o7zf4oj7Q3oWl/rMkLH9trIiibhROUBL13mDgQEragoNw0AcfMs2Ym
    VELbW8RVo6/sOvrThtGbpq6XqXyfhQHi+Zxt7YYQh/o5FOcF1D05H7gxECeZYiLP
    9dJTkjyll/urIr2jG4mo5MmBe5swsmAB2u5WIuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1518691195;
    bh=U+TU3hWTmOdK2q/WAGc0v7sC9xzTBqO6DDYf61q6mOQ=; b=qfDn2D29336C
    p1zwNREeQa5shY5OzAEQJCk8Keit2BeAlRyn2Clc3AlVrD/wO5kcAZHuXjJjwc+m
    Tj+OsiuonVhr/nByxJCErN2br5NMzaAOmKh6eMyRB5PO+MV914ctil81WjJT7hpb
    LZ2m8YCrYsoM8TQ0XgtZsaZIdQ0gu+3tEvizbzdQ+GL0UtCQcgn9wZ8Gf1lTrDXh
    4Nnd/3kMZI11Q0qS/5GDDrbrC9YySf+1kyG/2uMa7B3EVxKsLnI94apqkpgpM05M
    i+hcMFo5g1M4zMeCJfNx/Oz5gRgU4kDvX9XW3uyGltpuSGWctk8w3GYUxFjMyBfh
    s8eUSMlmNg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=QzMvbFHh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=QzMvbFHh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755481AbeBOKjl (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 05:39:41 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47541 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755357AbeBOKjd (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 15 Feb 2018 05:39:33 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180215103930euoutp01c28de1014fa7da7db0891caaf23f72e3~TeZLO1ITr1265312653euoutp01R
X-AuditID: cbfec7f5-f95739c0000028a9-ec-5a85635f2bb7
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
Subject: [RFC PATCH v2 2/6] dt-bindings: add bindings for Samsung micro-USB
 11-pin connector
Date: Thu, 15 Feb 2018 11:39:16 +0100
Message-id: <20180215103920.32017-3-a.hajda@samsung.com>
X-Mailer: git-send-email 2.16.1
In-reply-to: <20180215103920.32017-1-a.hajda@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTYRjG+3auWrPTlPxaYjSVLuAlivgiiZKoQxEFBuYobephSk5tx3tU
        y7S2ecEbpGhqoiN0malZzVLS0SzBuVZaQUlJmdKsMENnZs5j/z3v+/ye9/1e+GhM8gOX0glJ
        qZw6SZEoI93xzmdzg4HRsXnykM6eQPSuZZBAOVoHge5V3CXQyK9xAtWal3qvZr6TqHS0GEdW
        ayuFdCUNFGobGyaQ3VRNogprtwjVG/IwdMf8nkKNIzYRyntipvYzrLHGCFh7UaGIrdJWEmxb
        k45kR/MtIra94TJb1NEE2Ok23xO03D00jktMSOfUwfvOusc/tWioFNO6zMWZTlwDTB564EZD
        ZhcccxhJPXCnJcxtAEvsLaTLkDDTALZqsvWAXoZKrgcJjAFAfZmTEIpFAIsK54ErQDLb4EL7
        2+WwF3MGTr00YS4IY4ZwODQwSbkMTyYK2joMuEvjTACsq64nXFrMIDivn6KEJ22Cfd9yCNdm
        N2YPLK9FrjmQGSXhrccFQGAOwo/9paSgPeGkpWMl6wPtZfm4EMgH8EW3DhOKcgCtk3aRQO2F
        fRbb8maM8YClnTcw4U4x1F6TCAgL5yrur+AHYEVx98rJBQCWvrlJFQNpHVjVBLy5NF6l5Pid
        SVxGEK9Q8WlJyqDYZFUbWPoHA38tMw9B95+YXsDQQLZGHBKaK5cQinQ+S9ULII3JvMQ/5Xly
        iThOkZXNqZOj1WmJHN8LNtK4zFsctfWSXMIoFancOY5L4dT/XRHtJtWA4aLVmY1rB3sWrhoi
        s3wymlntgyr/10ciL8Q7jzsGrixMhNXIwo/OnoyYDMDDLvo+/9LQk2sMNuuq+pzOMBR76vMW
        POfY7/P9GXMfVIdlmV8j5jcoReHr0XxjskY6Ut/j1+uYOB3Q5W/qAn7NfJ1h9yGruuDT7Pj0
        ZrzS9ijGKMP5eMWO7ZiaV/wDiVxJ+gMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrILMWRmVeSWpSXmKPExsVy+t/xq7pxya1RBhvnClvcWneO1aKp4y2r
        xcYZ61ktrn95zmox/whQ7MrX92wWk+5PYLE4f34Du0XnxCXsFpseX2O1uLxrDpvFjPP7mCwW
        LWtltlh75C67xdLrF5ksWvceYXcQ8Fgzbw2jx+W+XiaP2R0zWT02repk87jffZzJY/OSeo++
        LasYPT5vkgvgiOKySUnNySxLLdK3S+DKOHi8gb1gl2DF/6/bWBoYd/F1MXJwSAiYSExs1+ti
        5OIQEljCKLG39wQzhNPIJLHo4EUgh5ODTUBT4u/mm2wgtohArMTbU5/BipgFLrBI/J44kx0k
        ISwQJ3FxyzIWEJtFQFViwZxFrCA2r4CFxO+ud2A1EgLyEoffNLGCbOYUsJSYMt8CJCwEVLJx
        8jzWCYw8CxgZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgQG7LZjP7fsYOx6F3yIUYCDUYmH
        18CmJUqINbGsuDL3EKMEB7OSCO/HqNYoId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rznDSqjhATS
        E0tSs1NTC1KLYLJMHJxSDYwr2k9P+v73/8OXDpkrEybzPnUy5s9Rz5S6+zDUcqHtDfXEqq/P
        +TmMFj8xzd+i8C6W+5aSdM1N9W1rNHalXIrpyZQtuNp9MVG82VOB/YuWgZdT3s+SJ4vTbk70
        +cS1TPJazxtu7T3Bcw4m+q0UMP9rflkzZseEe7cUuiZwh6/WnHOOs0ORq12JpTgj0VCLuag4
        EQAcNpCUVAIAAA==
X-CMS-MailID: 20180215103926eucas1p2f13dcf5aa4e102e7f0145c976a60bc72
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180215103926eucas1p2f13dcf5aa4e102e7f0145c976a60bc72
X-RootMTR: 20180215103926eucas1p2f13dcf5aa4e102e7f0145c976a60bc72
References: <20180215103920.32017-1-a.hajda@samsung.com>
        <CGME20180215103926eucas1p2f13dcf5aa4e102e7f0145c976a60bc72@eucas1p2.samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Samsung micro-USB 11-pin connector beside standard micro-USB pins,
has pins dedicated to route MHL traffic.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 .../connector/samsung,usb-connector-11pin.txt      | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/connector/samsung,usb-connector-11pin.txt

diff --git a/Documentation/devicetree/bindings/connector/samsung,usb-connector-11pin.txt b/Documentation/devicetree/bindings/connector/samsung,usb-connector-11pin.txt
new file mode 100644
index 000000000000..c8ef1ad6732f
--- /dev/null
+++ b/Documentation/devicetree/bindings/connector/samsung,usb-connector-11pin.txt
@@ -0,0 +1,51 @@
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
+Optional properties:
+- label: symbolic name for the connector.
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
+Micro-USB connector with HS lines routed via controller (MUIC) and :
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

