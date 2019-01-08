Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE92AC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A92C2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+2dUHhE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbfAHImX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 03:42:23 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38146 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbfAHImW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 03:42:22 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so1551352plb.5;
        Tue, 08 Jan 2019 00:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KxcYoPKhPakJz2BJLRFHaSM8hqbnJhclkIWiFsvi1VI=;
        b=l+2dUHhEq+Q4MC+zH2KdpWjMZdQ21TFN6tue9X9sRI9bHwKvuXfLMCssLl5A7X+hyk
         ge50fOULWFLA4IIEqRc0HHrQjnQrFAwUSeqrZDIjxnWSw+gMNG3r2DG+XxAO+a8zwKZF
         rFg5UeO7DGaSVmZagunjl+87ybS5HNzovP0VoITQ0d2ayf/U/qLsM/UUsuJylSuM5XMw
         gprEBLJnBXvUBbvYEu5IdjgEQPgSLduruvKuHtzm+JknvZ7SuYG9fDgrLDSRsHoIhVo7
         yt92l7xRHQjER6S7C3WW/cR5KP6F4p5I5niIwcgiivFRknkD4eUOXPZUIKAWwrV+sQrC
         oRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=KxcYoPKhPakJz2BJLRFHaSM8hqbnJhclkIWiFsvi1VI=;
        b=azSh5xYcsdwU9XyiuAaLs5VQwwd2CY+fn6JSqxffrOBGzEWySTtQgbZxH1Xnp29bkM
         PxOI6vGtGtgLf/MXqfo1rvb+aIxIUFuevodm0joWpUM4Ef5WnRzZc/wlX8ABWLvIgXyc
         m4L80H352hSarzrY3Hkh3SD8Vb9cVUvDwHwwAzoVeFwJFimO6uZmVRGL02oB7kid6XRA
         B8IoD+u3/deP4kLxiZPm4l+LNkMH1n8IsROPbv5synET3mV2CxOZu7o/mUP2DzJuFng7
         NYcPb6BXEo1I9CwuHfwgZ8QxhFBEY/+sIgN0l8+1P0LwXafQnPBpA82yQubq3sER2WWe
         Kn9A==
X-Gm-Message-State: AJcUukdwZPdgsq1GTdEuPlflC0JGC84FdWR8yMgebXJOQ0/TuoAuTmTB
        xPTgn23GOgTDvrzWtuOhk34=
X-Google-Smtp-Source: ALg8bN6rXetocnBLKFzwq67DfykBN6x0L9AwLJqDDn+K30GmQx9vKNZ09hIpi4k1UZyRm31oW9dvOg==
X-Received: by 2002:a17:902:9047:: with SMTP id w7mr877703plz.270.1546936941332;
        Tue, 08 Jan 2019 00:42:21 -0800 (PST)
Received: from localhost.localdomain (i121-116-192-145.s41.a020.ap.plala.or.jp. [121.116.192.145])
        by smtp.gmail.com with ESMTPSA id l64sm86277445pge.73.2019.01.08.00.42.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 00:42:20 -0800 (PST)
From:   Ben Whitten <ben.whitten@gmail.com>
To:     linux-lpwan@lists.infradead.org, afaerber@suse.de
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Ben Whitten <ben.whitten@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH lora-next 2/4] dt-bindings: lora: sx125x: add basic documentation
Date:   Tue,  8 Jan 2019 17:41:30 +0900
Message-Id: <20190108084132.10214-2-ben.whitten@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190108084132.10214-1-ben.whitten@gmail.com>
References: <20190108084132.10214-1-ben.whitten@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sx125x family are IQ radio transceivers from Semtech configured over
SPI, they are typically connected to an sx130x series concentrator however
may be connected to a host directly.

Required properties include the radio number of the host or concentrator
bus.

Signed-off-by: Ben Whitten <ben.whitten@gmail.com>
---
 .../bindings/lora/semtech,sx125x.yaml         | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/lora/semtech,sx125x.yaml

diff --git a/Documentation/devicetree/bindings/lora/semtech,sx125x.yaml b/Documentation/devicetree/bindings/lora/semtech,sx125x.yaml
new file mode 100644
index 000000000000..5eadec860b70
--- /dev/null
+++ b/Documentation/devicetree/bindings/lora/semtech,sx125x.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/lora/semtech,sx125x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Semtech IQ modulator/de-modulator transeiver
+
+maintainers:
+  - Andreas Färber <afaerber@suse.de>
+  - Ben Whitten <ben.whitten@gmail.com>
+
+description: |
+  The sx125x family are highly integrated RF front-end to digital I and Q
+  modulator/demodulator Multi-PHY mode transceiver capable of supporting
+  multiple constant and non-constant envelope modulation schemes.
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
+    description: The chip select on the SPI bus or radio number in concentrator.
+
+  spi-max-frequency:
+    maximum: 10000000
+    default: 8000000
+    description: The frequency of the SPI communication to the radio,
+      in Hz. Maximum SPI frequency is 10MHz.
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    radio0: lora@0 {
+      compatible = "semtech,sx1257";
+      reg = <0>;
+    };
-- 
2.17.1

