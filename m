Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B328C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 07:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D63492081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 07:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3mLeIuf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D63492081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbeKBQsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 12:48:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33265 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeKBQsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 12:48:51 -0400
Received: by mail-pf1-f195.google.com with SMTP id i62-v6so643200pfi.0;
        Fri, 02 Nov 2018 00:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=udHYAOJoq7dBu2TG+Rke+TL45YsKhdHuhHDaVlLoj3Y=;
        b=L3mLeIuf7uUKk9oYWuTYKNZaG7ABDqYeTmWNXzsGegF5wlLn1zVqfHL6KiCbPytV1D
         Gxirfv9SUV/KntqfA8LVsGw8u6W2j4yiikQCiworOp+xsxA1HmMn2Uwvv0ZNbPzum5Av
         fvWzYE9faciKQ/q4hJX0wrIeVA/Y2kPv34P5pvkQBA6XrbbJSmvj6Ix4hLlk0QjhGC4f
         jHSWm9i4Ak9PQVBjOlomzQRnLi4V7BrDC88cH0u9yI+JZFBajpgmTB+Ovz0V4NvxxKa+
         z8qOYzxDbDWl82cWdYLx+C0VQcsdVDIhei3pAHNY1R2HV8uQ+oTpckeJx2WPRCxSBevB
         kWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=udHYAOJoq7dBu2TG+Rke+TL45YsKhdHuhHDaVlLoj3Y=;
        b=OlisQa7RVjgRwnRnS4hS7DK2KdEcxiUmtSjq+W3NXolbAXgYhRqO/uoB6w+ZckeDWe
         B8EI9KQcgV2+LalI3thn2xpNAZ2Dh7+1ZL8VnKZxKHyb3atNDsxWDVO8l7LAWgO7GQHn
         JZQk6aFSldc21046u1cZjnkLR6xJvqpw+JfSyj3kCLeOQUrt+PVNXhPL4JQjtBN+mHrI
         wTRk3st1v7XaCrCZ5kB/DS7+rOUbjkARS+/q9MbaRzGpcm1kvrzXrOrcf5n+LmHYEFSR
         mK2HTuCg0l+PVuFJSXgE4Ky5T6N4Z5QU7AwRYTSn3E/0rqbwu7ZZxWe+YcT+BRJUKTPJ
         kzrg==
X-Gm-Message-State: AGRZ1gKhpnybj6Na6kHqhxpJpDb0Su7deFCQsAlOEitfbUmDT44IxaHL
        7LBQ7oYye8gX1XI1aTha2Dg=
X-Google-Smtp-Source: AJdET5doR2cMqsk6JOqzW64pM+eGH1yD81YrKQ2p7t6j4N4s50JnNy4debk4Dgzz+KhPDyb2A1YrMg==
X-Received: by 2002:a65:664e:: with SMTP id z14-v6mr9708682pgv.347.1541144557777;
        Fri, 02 Nov 2018 00:42:37 -0700 (PDT)
Received: from localhost (97.64.17.87.16clouds.com. [97.64.17.87])
        by smtp.gmail.com with ESMTPSA id y88-v6sm25349038pfd.104.2018.11.02.00.42.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 00:42:36 -0700 (PDT)
From:   Song Qiang <songqiang1304521@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        preid@electromag.com.au, himanshujha199640@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Song Qiang <songqiang1304521@gmail.com>
Subject: [PATCH v5 2/3] iio: magnetometer: Add DT support for PNI RM3100
Date:   Fri,  2 Nov 2018 15:42:08 +0800
Message-Id: <20181102074209.12620-3-songqiang1304521@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181102074209.12620-1-songqiang1304521@gmail.com>
References: <20181102074209.12620-1-songqiang1304521@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>

---
 .../bindings/iio/magnetometer/pni,rm3100.txt  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt b/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
new file mode 100644
index 000000000000..497c932e9e39
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
@@ -0,0 +1,20 @@
+* PNI RM3100 3-axis magnetometer sensor
+
+Required properties:
+
+- compatible : should be "pni,rm3100"
+- reg : the I2C address or SPI chip select number of the sensor.
+
+Optional properties:
+
+- interrupts: data ready (DRDY) from the chip.
+  The interrupts can be triggered on level high.
+
+Example:
+
+rm3100: rm3100@20 {
+	compatible = "pni,rm3100";
+	reg = <0x20>;
+	interrupt-parent = <&gpio0>;
+	interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
+};
-- 
2.17.1

