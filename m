Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22066C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E020F21019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKCScfIN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfAVSIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:08:18 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53720 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfAVSHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 13:07:54 -0500
Received: by mail-wm1-f67.google.com with SMTP id d15so15126496wmb.3;
        Tue, 22 Jan 2019 10:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VqnCZBPi9Tl8tc5DJHEj6tCVcy/LFCMWRjEYRKuhKQA=;
        b=RKCScfINRS5zdWC9dzaLGIlaYuflMHnkxts7r1Jd9IOZs9eIxjiQZBYIiyf+XqaPHV
         6NcW1VOOdK7UdJAyrjUpC3zG36paPLccCwaowKeFUsBdkbSz4bivDEtWb1x8J5+gOtc6
         9RX0s5hE+QYn59ykiamAEHtoIXKo+T8MX3m8PjHhTlyYlMwxTg6PDugMQC3QJi4dxGsQ
         yQtQsID8bS959qdwgdmQqV6LJOLSLd7ozKWvy865fLBc4atTSry1DkTcvJRJ3bUMPPxQ
         /yfu4XpZoJyWC/fNMbYoIfrstpzRjl1ZZT1tn4Q8SnfNEYHZeKWWlFkBh4SpTTMnYE0q
         f27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=VqnCZBPi9Tl8tc5DJHEj6tCVcy/LFCMWRjEYRKuhKQA=;
        b=iZz7+XenY1DWS0T653BB1kQfSLos4S4VWd8RVxQR4nlWnKIlQzNrCkhGJA03b9Fdpq
         9VJXS7MjqTXMfQgBZAfYykmzvKOQt9BntEohpxUEi8BC5xVEKHmUMWzvG3ped8B1gOAu
         sAPeMvEYyTaV0TXO8S9yYE2YV9sdkT2+Emwyy4GlUwPOcmxHk9M/5TlGAjwNd5srS5rD
         XWGzJQNp1KQVM0vV2qQ0tkWnMsT5srMEMzhiZb5tBOZX/yozRqMjCp95XXRjJRcRurvu
         NDFhAooOjWao0OBWABJ8graU+DKtwGaWxyGgi50liWu9hSfTIguWIoad/PFBPtvONA+O
         R3nA==
X-Gm-Message-State: AJcUukdBi7X867t0N6uAGlA+TP3js+phKG5y1bsuLRChKwvsZqPLp8JY
        kRN7JpAnnaKX707+I6JD1xg=
X-Google-Smtp-Source: ALg8bN4GEZ9VAjtno9nWFCTvGGLURMsDl9hyTK/K+mmWiFJtpiWWCsoRsaKDloWeDCC/q9whtAktEQ==
X-Received: by 2002:a1c:5656:: with SMTP id k83mr4784099wmb.125.1548180472103;
        Tue, 22 Jan 2019 10:07:52 -0800 (PST)
Received: from Sarah.lan (229.98.125.91.dyn.plus.net. [91.125.98.229])
        by smtp.gmail.com with ESMTPSA id 129sm93804220wmd.18.2019.01.22.10.07.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 10:07:51 -0800 (PST)
From:   Ben Whitten <ben.whitten@gmail.com>
X-Google-Original-From: Ben Whitten <ben.whitten@lairdtech.com>
To:     afaerber@suse.de
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        linux-lpwan@lists.infradead.org, robh@kernel.org,
        Ben Whitten <ben.whitten@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 lora-next 2/4] dt-bindings: lora: sx125x: add basic documentation
Date:   Tue, 22 Jan 2019 18:07:27 +0000
Message-Id: <20190122180729.1834-3-ben.whitten@lairdtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190122180729.1834-1-ben.whitten@lairdtech.com>
References: <20190122180729.1834-1-ben.whitten@lairdtech.com>
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
index 000000000000..4a51a251d97f
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
+      radio0: lora@0 {
+        compatible = "semtech,sx1257";
+        reg = <0>;
+      };
+    };
-- 
2.17.1

