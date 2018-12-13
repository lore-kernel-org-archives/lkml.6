Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE4DC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC96A20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=elementarea-net.20150623.gappssmtp.com header.i=@elementarea-net.20150623.gappssmtp.com header.b="i7jNemsK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC96A20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=elementarea.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbeLMOo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:44:27 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38131 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729034AbeLMOoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 09:44:25 -0500
Received: by mail-ed1-f65.google.com with SMTP id h50so2233689ede.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 06:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=elementarea-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=sk7VSPsVfgFjKWt+SwLUYCsEgXBvRweH1J/0uUlmL+g=;
        b=i7jNemsKibDCPkzcm1wYCpQOuvYbN6U7EaeERh0gqlZQOJZlotvNV4ey7Bd9lQ3u1m
         QyxSvLcnkKCuVtaDy75JjC67h1uoEU4qtHsjozNOwM08LpzCaEGNw3hapF8H5B/u36WB
         KnkK3c1N7g2VSTf4lDEmh0Tukco4Qjc9VSbOyl65MZDL1w73iqSSM/sgvQirpBCzx4gL
         sIjy1lLtjsGUg9CeSejLXaIVo0lULeJ0yWa6i6U0dW/roqgk+T4VYn5z8a9P7kaqKbpP
         J3khK/1l/NfrE+8xtKaIW36swNLHznCwdK4eAx1kLe7uqgnG3y7vevBT+1Ph+A0VBROk
         n+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sk7VSPsVfgFjKWt+SwLUYCsEgXBvRweH1J/0uUlmL+g=;
        b=T4BdQLu40IVNhVTuWdnMWAZFFdHA/ip0wZTeANFrVIUP6b9qoIKEG52N6vmHG3odTB
         gMtGiBUeGbeCTvrTn4O3AIFQsKDOpttsAI4ea6C1+LdUvr5WI0H/LHBZ6MWCePn1ylrh
         vRM8eu7YN/uEtA4nTNWLXwuf8IWgMvhhT9MU/fr4XNFGH/gJy/NP0YlgNaBb3VrHm38f
         WDAqYg0esnTZ5qXtoCKXAJL8mFRS1Q7LoGetluKOYvkijOyagF/kaMSfDHr5U4CNKfTE
         /VDtnQ3Dbnh5IPgTLbi0SLu5y6cBvIusps7lbcxl79CxGVMp6Noa0qdzY5wmpxkeMk5p
         OtVg==
X-Gm-Message-State: AA+aEWaA+PgIcVDXUJrPeNNobDNcTaH0gQy2jMrKwOibQBAKrLTR7/pi
        9KexqD4d0+TSadlE1Gn4YGA0AQ==
X-Google-Smtp-Source: AFSGD/UBorbcbCXzDdCylHLZJJQEYPVz0+FXfIFnK0a+34sYScFFvoz+a8t6Jbd92fV0GwipvDqEIQ==
X-Received: by 2002:a50:d797:: with SMTP id w23mr23531264edi.19.1544712263833;
        Thu, 13 Dec 2018 06:44:23 -0800 (PST)
Received: from ch-sta-l-li0012.sensirion.lokal ([209.206.26.1])
        by smtp.gmail.com with ESMTPSA id p36sm674842edc.78.2018.12.13.06.44.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 06:44:23 -0800 (PST)
From:   Andreas Brauchli <a.brauchli@elementarea.net>
X-Google-Original-From: Andreas Brauchli <andreas.brauchli@sensirion.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andreas Brauchli <andreas.brauchli@sensirion.com>
Subject: [PATCH v3 3/3] iio: chemical: sgp30: add device tree support
Date:   Thu, 13 Dec 2018 15:44:18 +0100
Message-Id: <20181213144418.24965-1-andreas.brauchli@sensirion.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree support for Sensirion SGP30/SGPC3 gas sensors.

Signed-off-by: Andreas Brauchli <andreas.brauchli@sensirion.com>
---
 .../bindings/iio/chemical/sensirion,sgp30.txt     | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,sgp30.txt

diff --git a/Documentation/devicetree/bindings/iio/chemical/sensirion,sgp30.txt b/Documentation/devicetree/bindings/iio/chemical/sensirion,sgp30.txt
new file mode 100644
index 000000000000..5844ed58173c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/chemical/sensirion,sgp30.txt
@@ -0,0 +1,15 @@
+* Sensirion SGP30/SGPC3 multi-pixel Gas Sensor
+
+Required properties:
+
+  - compatible: must be one of
+    "sensirion,sgp30"
+    "sensirion,sgpc3"
+  - reg: the I2C address of the sensor
+
+Example:
+
+gas@58 {
+	compatible = "sensirion,sgp30";
+	reg = <0x58>;
+};
-- 
2.17.1

