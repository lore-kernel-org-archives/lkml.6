Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FA0ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 21:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D3221476
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 21:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVaOa7q/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51D3221476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbeIWDAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 23:00:49 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:52396 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbeIWDAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 23:00:48 -0400
Received: by mail-it1-f193.google.com with SMTP id h3-v6so6140375ita.2;
        Sat, 22 Sep 2018 14:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MBy+RNKnOUmTHb65YAdlTNAluCLYjYibeqs9O8pC2u4=;
        b=ZVaOa7q/N/A2MAhwArRBNHUalSy/3yq30EhI9SBBL+cOyjsPQOr2FGUlV0Bj+3ZVMk
         bXDzSwyoxY0vbS41UBlW+iNEbp9bqrpHI8YXC48jrcWWJG4B94a4a12MaDHaouhulPE0
         x4CDQixkNc7xRpU+Ike6kqcdu+5suDFbfnl/n4/gLxZnylkEwGtqAbpl7s+9u3tMDNFj
         4M9N6R1DgDqOjxIYTXlD0MAwfHIu/6Q6WTdVit9FtqLZAnN7uAMM6/3GKSH0qwMC3uKI
         fpnP0RDF9bkviNyznveiftF3VBWRIyKCOQytupYoQCQ7cshitnFAMo+Bs/txvGJNCQSa
         5jGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MBy+RNKnOUmTHb65YAdlTNAluCLYjYibeqs9O8pC2u4=;
        b=YS/6FnqNJSR+NhgYxboiTY1Vxb6mDWsfnAcQm80fCt5DfATTtuJz/FcFhJatcJUc8+
         83WhTgElcG1BenIod8gZAudZXU5CMrJbq+utIZuuw5S6npZ9lSqGbQuWtpvyDsadx8EB
         SExqzoyS38S5el89IhyENLVjQ717c7+e9G2JGfkfWEU3H4BYKFrsHde3MrWWDApUa0xa
         VKtReVeKQoiOi6tDbQtQyi2bTpGOBzw/qs1QzlRImLxkYJGSJrf7Oe8yqRaiHWfwaVnV
         TQ5Eh7BoxQQ9yoQo5eI0klBh2eeyyoU/YEpDuqleF6NEiRRGRPgKn/T0YHhsTVOqf6WT
         SqCQ==
X-Gm-Message-State: ABuFfoj27VNAlPdz7OrG3H8XZRbKjRCULEMqqRfWGo9Mi3TMIfiZ9vGy
        jtBTegIeYdKbt/g1St7Dw0YoilA=
X-Google-Smtp-Source: ACcGV62MXd8WMbhWcpNx3Tnc+6rv47WL0nzM2aj05a93tBaHGfSR/Lw1naI/2d8klKVGLwfIqeFmUw==
X-Received: by 2002:a24:8085:: with SMTP id g127-v6mr2747190itd.120.1537650351639;
        Sat, 22 Sep 2018 14:05:51 -0700 (PDT)
Received: from localhost.localdomain (CPE1cabc0918a93-CM1cabc0918a90.cpe.net.cable.rogers.com. [99.229.26.117])
        by smtp.gmail.com with ESMTPSA id t24-v6sm4206532ite.12.2018.09.22.14.05.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 14:05:50 -0700 (PDT)
From:   ryang <decatf@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ryang <decatf@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: iio: light: bh1750: Add device tree binding documentation
Date:   Sat, 22 Sep 2018 17:05:38 -0400
Message-Id: <20180922210539.6670-1-decatf@gmail.com>
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

