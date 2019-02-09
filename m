Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE55DC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5FC20823
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFTYrDun"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfBIRgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 12:36:50 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35610 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbfBIRgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 12:36:45 -0500
Received: by mail-lj1-f196.google.com with SMTP id j13-v6so5607994ljc.2;
        Sat, 09 Feb 2019 09:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pWUDt6MxnVmk+/hRCdmQbHGfGO1VjvxQfobMdJrFKoE=;
        b=AFTYrDunE7JhyCP6nUpAaRSmBF1X1V5Oyd/vUAF5sBRob6jGf9XdfHMK1P0kHoaUFn
         yA6+pWfHmIxEkjfy8rMP/IAW6nf60VYByMzm7mdCk+uXUjC2a3kHt36F5CXybh61Zo3p
         tQQDczAjSBkt3AUOEMEpChe7bOqHjGwc1rWgKJK8vxO+JxSfX/siqY0i+p+Qf8YwLVUi
         lNhR5VX1HoHC8dm/ijpdfms50KonqBa6irYRWuT1cipKtkRBCUq4NFaJbD349wz3+t82
         fcRO89PGmD6WB/8AT/F2auwPHLfMlaUL4btjiAKBc/jbrVJ50pe2LdMbLDKVuaoOkpoG
         jLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pWUDt6MxnVmk+/hRCdmQbHGfGO1VjvxQfobMdJrFKoE=;
        b=YkrYsnXaowJ8Lpm2PyIYVVfuI8/FIyJIJPmtwIwYRu+9nWFJR0qcCwU7+9/P+U7L5c
         flSmXXMHa5ZlZW6aALPp7FzJOtKgMeCinR7Z+VSOFoCuSN6fxepmLVbPFnlJ1yOhnmF+
         74hkUy92BBEdqOMBknz3KZCBZTA2akNOSd48SJMiD9uU+ZdwhGBdLIMEnkIQnWi9qtqK
         +5EVKj+3GxBXYdJBYet+wVu8U7cZv2YRdmOKvPHDr3zmII+MvTvrNEtGZK5APxFlUwRl
         i2/yA5snD0vlGKdxvIsMRii1104//PFU9V3TPY059EkdqA/cB29WvQzfWqxuR3z178bg
         L0xA==
X-Gm-Message-State: AHQUAuYByOiR3KMIzeoPEzI7QmWI4Foz2nTgbPkuUxQuN9oLHIskzzeU
        A9eLZJk9r69rNwEjmhQHiEZM+G8RtBk=
X-Google-Smtp-Source: AHgI3IbzxviCccsBUh+BWmrdV1SBQKop/d+ppjXGVsPSAKgUO45lQTae7xEXrSTH8iV8lsr4OtHgPg==
X-Received: by 2002:a05:651c:101:: with SMTP id a1mr8362206ljb.59.1549733802283;
        Sat, 09 Feb 2019 09:36:42 -0800 (PST)
Received: from arch.domain.name (89-70-37-207.dynamic.chello.pl. [89.70.37.207])
        by smtp.gmail.com with ESMTPSA id n12-v6sm1080508ljj.32.2019.02.09.09.36.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 09:36:41 -0800 (PST)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, jic23@jic23.retrosnub.co.uk, pmeerw@pmeerw.net,
        johan@kernel.org, Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH v4 3/3] dt-bindings: iio: chemical: pms7003: add device tree support
Date:   Sat,  9 Feb 2019 18:36:09 +0100
Message-Id: <20190209173609.13220-4-tduszyns@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190209173609.13220-1-tduszyns@gmail.com>
References: <20190209173609.13220-1-tduszyns@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree support for Plantower PMS7003 particulate matter sensor.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 .../iio/chemical/plantower,pms7003.txt        | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt

diff --git a/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt b/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
new file mode 100644
index 000000000000..7b5f06f324c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
@@ -0,0 +1,20 @@
+* Plantower PMS7003 particulate matter sensor
+
+Required properties:
+- compatible: must be "plantower,pms7003"
+- vcc-supply: phandle to the regulator that provides power to the sensor
+
+Optional properties:
+- plantower,set-gpios: phandle to the GPIO connected to the SET line
+- reset-gpios: phandle to the GPIO connected to the RESET line
+
+Refer to serial/slave-device.txt for generic serial attached device bindings.
+
+Example:
+
+&uart0 {
+	air-pollution-sensor {
+		compatible = "plantower,pms7003";
+		vcc-supply = <&reg_vcc5v0>;
+	};
+};
-- 
2.20.1

