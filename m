Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAF5ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 19:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E1E2150E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 19:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mooHwLB8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26E1E2150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbeIWByT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 21:54:19 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:35998 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbeIWByT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 21:54:19 -0400
Received: by mail-it1-f196.google.com with SMTP id u13-v6so6033834iti.1;
        Sat, 22 Sep 2018 12:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MBy+RNKnOUmTHb65YAdlTNAluCLYjYibeqs9O8pC2u4=;
        b=mooHwLB8DO2SZF1VOksxSqUyr3DfRTUG8Dq5UN3PVaQVIRawlYV0XVTw4FTIsizMin
         aWMImts1bGMuxzvfSppNwoAp4sFfdKGzgoux4CBom8mCla9CZ/JBQXHXOYF7OktKYP5p
         gmj5Po/4Zi7P3LY1ziwY850QkIHlrSCT1DgwHNqCFYu1hwcMZsRB3iMAojAGujqw3uFd
         4nnY3Lkd5eKiTSh088aibWu0dsbLa5E8w7drd5qK5geuy0f3Vq5sgGFSxX5PrA/YsSpM
         LI1fTNrWxkG1iUareblAWAtilSk5qlEPdebj9tRsFEFSD7UMVA/EB7pc7Jo8aPzrQv/l
         dInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MBy+RNKnOUmTHb65YAdlTNAluCLYjYibeqs9O8pC2u4=;
        b=nrvQ/USkBuxj22pUaPfuvlcOa7+hDpDH4tcyv31TGAQgD60iZRaoYmBbMxWC7k9XD0
         0A6Ms2t7PzpjFJJRGv4arXgaPm0eCaYvIoOglB+Ppgtmuhjg2dpjvWZDg4hJ4PY5DSGy
         k8U8tb7y40B8hmEtiJv3cxF33/JQNaUHU1IImICBf1vJEg7C/8HfGArdeyQ7JEPuA/nm
         F4svA53GxBoP+XkKj4ed7n8AKSUzcZ5G94iFLoE+dHG8ZO0eNGNjGWKossNKaAq7iObr
         fygt9g49iU3V7cQdOr6IijGqS1c2E2fShzYl0NRntdDs80kRb1sA67r1k8Yv9BycXhyq
         weOw==
X-Gm-Message-State: ABuFfojnwSQ++K2dOWxkIkLN445toJwj/Qg9qz9IpP2HFqjmLxpwJcp+
        ypsfJWuDKuedQU8jvcJ1JA==
X-Google-Smtp-Source: ACcGV63Pli+DNEMDN6cpjWf/lDAPN1CcUt5bcQjgKHqGNRkE1bFyJQlEcpS2kpjPKsiDVlCIkNLCvQ==
X-Received: by 2002:a24:1d84:: with SMTP id 126-v6mr2649830itj.63.1537646373473;
        Sat, 22 Sep 2018 12:59:33 -0700 (PDT)
Received: from localhost.localdomain (CPE1cabc0918a93-CM1cabc0918a90.cpe.net.cable.rogers.com. [99.229.26.117])
        by smtp.gmail.com with ESMTPSA id h66-v6sm1095021ita.22.2018.09.22.12.59.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 12:59:32 -0700 (PDT)
From:   ryang <decatf@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ryang <decatf@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: iio: light: bh1750: Add device tree binding documentation
Date:   Sat, 22 Sep 2018 15:59:21 -0400
Message-Id: <20180922195922.24791-1-decatf@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document device tree bindings for ROHM BH1750 ambient light sensor driver.

Signed-off-by: ryang <decatf@gmail.com>
---
 .../devicetree/bindings/iio/light/bh1750.txt   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/bh1750.txt

diff --git a/Documentation/devicetree/bindings/iio/light/bh1750.txt b/Documentation/devicetree/bindings/iio/light/bh1750.txt
new file mode 100644
index 000000000000..468350cc7af6
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/bh1750.txt
@@ -0,0 +1,18 @@
+ROHM BH1750 - ALS, Ambient light sensor
+
+Required properties:
+
+- compatible: Must be one of:
+    "rohm,bh1710"
+    "rohm,bh1715"
+    "rohm,bh1721"
+    "rohm,bh1750"
+    "rohm,bh1751"
+- reg: the I2C address of the sensor
+
+Example:
+
+bh1750@23 {
+	compatible = "rohm,bh1750";
+	reg = <0x23>;
+};
-- 
2.17.1

