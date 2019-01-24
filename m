Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242EFC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D33218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVgEbL4H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfAXOyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 09:54:25 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38253 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728167AbfAXOx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 09:53:59 -0500
Received: by mail-wm1-f68.google.com with SMTP id m22so3372881wml.3;
        Thu, 24 Jan 2019 06:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WwWzOwpYDI3JAoktqCzhSVWsOiE+dgnPjG4gSEHDnlM=;
        b=AVgEbL4HudSrvLd8w7B0feN9vYMKLT3WVfmL9Qs15wTL8tnDFhWEUq7YMvwtgInSQz
         rSCmvE6uk+yqnBY4AOcAs5M0TYZPb1CcHXYaU/P6z0BLq2r8dBzAvCplGRMtcDqpUQU5
         ecvftpyLzds/DO4JIRUFOc3KJ2VJErZOzUBoAJgIsymelT5rqhv9qetSj+abu67qloEV
         0CShl9GwnJ2aSpVXzs6OpdXXLjCQPwn5/XV52C3jH6L4DuwBDkZTphqbCErg68HBxf46
         RO+wB3ZOdnTrje6wIOMW7bLv1ytKLxrKi945MqM2n1J3dz0xyqpaW7PIGXxFgBfqmRXd
         Onfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=WwWzOwpYDI3JAoktqCzhSVWsOiE+dgnPjG4gSEHDnlM=;
        b=cNaiCq7JXhHwra1IOMBt+Ng1LKsWo5ExK+s4JOIxwqa4MSvFw6Q7gS0JfyPta4GeAV
         xAHC+GBtxVMMA8no5xcx6DyNKpvRRZsdYec2pzimwzEvDTf8ULqMeguEy9SmapCgmbFD
         gBLpbj0Gw0XABcSTVScAqvJfdwGk8w8vZ5pbaLWa5kKMGEFB9BQ5Bm26iRm6Ld76P0mH
         sNKpsDXHvXvdybwuNtmOerjWIHu2buWksid6UKLQmYXTYJOSmnWcGO5w1PIncHDSzahI
         KwRQHFmr79zhQJnzS/H72UUVBAjf/KZ+3Piaqvaej/T5UJeHbD0oWrA7CG39j1UFJzCZ
         BKzg==
X-Gm-Message-State: AJcUukdV/hEV4Fj1v4ABLbkv10KjZDF+aIBlsc3Av7ZXnRHIVj2dB574
        pMj4mWmplAdsbUlace4hYTc=
X-Google-Smtp-Source: ALg8bN5/AW8PIjzqtJwaOqu6D/Ey60Qg+pJNzciSXwJGZT5lFz9yDoCXKUkviL2FeaQxKlNpuAe6OQ==
X-Received: by 2002:a7b:c76b:: with SMTP id x11mr2931572wmk.37.1548341637372;
        Thu, 24 Jan 2019 06:53:57 -0800 (PST)
Received: from Sarah.corp.lairdtech.com ([109.174.151.67])
        by smtp.gmail.com with ESMTPSA id t63sm53611538wmt.8.2019.01.24.06.53.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 06:53:56 -0800 (PST)
From:   Ben Whitten <ben.whitten@gmail.com>
X-Google-Original-From: Ben Whitten <ben.whitten@lairdtech.com>
To:     afaerber@suse.de
Cc:     davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Whitten <ben.whitten@gmail.com>
Subject: [PATCH v3 lora-next 2/4] dt-bindings: lora: sx125x: add basic documentation
Date:   Thu, 24 Jan 2019 14:53:07 +0000
Message-Id: <20190124145309.21698-3-ben.whitten@lairdtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190124145309.21698-1-ben.whitten@lairdtech.com>
References: <20190124145309.21698-1-ben.whitten@lairdtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Whitten <ben.whitten@gmail.com>

The SX125x family are IQ radio transceivers from Semtech configured over
SPI, they are typically connected to an SX130x series concentrator however
may be connected to a host directly.

Required properties include the radio number of the host or concentrator
bus.

Signed-off-by: Ben Whitten <ben.whitten@gmail.com>
---
v2 -> v3:
* Renamed example node name to be consistent with concentrator
v1 -> v2:
* Dropped spi-max-frequency binding
* Wording changes to commit and descriptions
* Added spi wrapper suggested by Rob H
* Dual licence
---
 .../bindings/net/lora/semtech,sx125x.yaml     | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/lora/semtech,sx125x.yaml

diff --git a/Documentation/devicetree/bindings/net/lora/semtech,sx125x.yaml b/Documentation/devicetree/bindings/net/lora/semtech,sx125x.yaml
new file mode 100644
index 000000000000..fe2d2a23c28b
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/lora/semtech,sx125x.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/lora/semtech,sx125x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Semtech IQ modulator/de-modulator transeiver
+
+maintainers:
+  - Andreas Färber <afaerber@suse.de>
+  - Ben Whitten <ben.whitten@gmail.com>
+
+description: |
+  The SX125x family are transceivers capable of supporting multiple constant
+  and non-constant envelope modulation schemes.
+
+properties:
+  compatible:
+    items:
+      - enum:
+        - semtech,sx1255
+        - semtech,sx1257
+        - semtech,sx1258
+
+  reg:
+    maxItems: 1
+    description: The chip select on the SPI bus or radio number in concentrator
+      , with radio A = 0 and radio B = 1.
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      radio0: radio@0 {
+        compatible = "semtech,sx1257";
+        reg = <0>;
+      };
+    };
-- 
2.17.1

