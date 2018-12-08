Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA7CC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B44205C9
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ABvWjMa4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B44205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbeLHQul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 11:50:41 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34875 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbeLHQuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 11:50:37 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so6570510wrb.2;
        Sat, 08 Dec 2018 08:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=siu7JVjNR7VuNknPREHMc13jDIkP5BqqtLPXYh2aEDU=;
        b=ABvWjMa4L/STK1+471aoftFNaFxTyri/bNFiULWcsMv44G+dgtpeYcoXaaw03A1pHl
         7OUtSDref+J9JCuxcKhJDoYU7YsOQ9XbAae7b22/90nmTihAAa5q+kkNhHhRwNmkOt1J
         jtXChq/lNzJF0K6+WJQMu57/PQWDHFcmmP7fnMgDFF7Ratdoi3FnpE1v2C+B/GbEXCuK
         I4QwuRCmBBNSyNgk4CXWHd9wK5tTNh0SHcjjThMpvjLwH+022q2VdIg0XgYQfF8BvO17
         5FkwpMcRlZVQO7i+iLIuRxb+XpiXE1QvZV4i6nmQjDlcXbzHaBOo+kRQ+bQ0xD6rEVbj
         C4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=siu7JVjNR7VuNknPREHMc13jDIkP5BqqtLPXYh2aEDU=;
        b=mApsokr8wlF2nEwONr5hX+utNvuiaxKJMzihF3PLyHmIhcRy238nE5NAGlJ2XUafzx
         ftXbuiHeB5So5lItH3MIRKhbBEoiQT4Jt/iFtejvq8xAesfHY855Y1p05lPngInQ1os0
         hkH8Y38zLrZR+AB6vOkphWNotsRyizehppd8YITpXwZ/4C3RoZIDqz9jzN1sTQQ6khfV
         jwzZn2byQWrUS2GB2shCBRvvNXnQx6m0BmgJD++Ybs2imla/BR/jy00eT/IxSa7a8n0f
         3Gr+t/wqx+WiMjBjpTsNYlH9IVHtJ4VKNpJAZAGMw/K3xMIZRkYGRoe0ysuzNN5juFw4
         8b3w==
X-Gm-Message-State: AA+aEWY2G/EgH33l5wy5R0HmDBb4eWpimK6xUVKQGYzpkQcZMZX9EnD0
        +n74Da7hkcEMzKaDxQ6P+20=
X-Google-Smtp-Source: AFSGD/UVGb22p66k7r3cvPgVxIA4qdIfuXkrU/jXpVHCSNohCs3spE7Thw8ZQuIeX53ulP6RanwCLQ==
X-Received: by 2002:adf:db51:: with SMTP id f17mr4701253wrj.90.1544287834989;
        Sat, 08 Dec 2018 08:50:34 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id n15sm11395651wrt.21.2018.12.08.08.50.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Dec 2018 08:50:34 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 3/3] ARM: dts: meson8b: add the APB bus
Date:   Sat,  8 Dec 2018 17:50:25 +0100
Message-Id: <20181208165025.27689-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181208165025.27689-1-martin.blumenstingl@googlemail.com>
References: <20181208165025.27689-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various peripherals (Mali GPU, NAND controller, VPU; etc.) are located
in the APB bus. Describe this bus so we can add devices to it.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 22d775460767..5d036842c355 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -178,6 +178,14 @@
 			no-map;
 		};
 	};
+
+	apb: bus@d0000000 {
+		compatible = "simple-bus";
+		reg = <0xd0000000 0x200000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0xd0000000 0x200000>;
+	};
 }; /* end of / */
 
 &aobus {
-- 
2.19.2

