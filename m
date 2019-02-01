Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B31AC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 21:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 303982082C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 21:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxNPcOXZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfBAV6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 16:58:51 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33715 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfBAV6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 16:58:39 -0500
Received: by mail-lj1-f195.google.com with SMTP id v1-v6so7118541ljd.0;
        Fri, 01 Feb 2019 13:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n3lyGEA96Cx0tDawBx8Bnt96fulhEcOs/o2QgNWNbzI=;
        b=KxNPcOXZ/geYhy05PBFlx5ddK9Sah3VjUtVdYlIfpF1fiVWfY3SEMYavtpTW1yh3Hp
         LbW6Ek0lFpeycqB1N8Ms57Z5ypGiVUYzI/Oo6KDENOYGu0OjKuj9NnjaLOgv1nb0WR+o
         1dbY98Por36hCUBM3xtA4phXbOBszsteo6dOjRmU2+tWD3Vr1mnazOMd2CpRgVp1s6Yl
         tC6Mo09jJOU+761shwDINHBJmHxbS0viOsQJOQL8CqKdlxtQbqUp4pssfUrK72n2r7Xk
         PYgG4Q9JZKmxzeyBHXaNJAJrxolHiVQmOt4Kjsi8zyIctA65Xob/ws87Qb8mPrqcO814
         5ylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n3lyGEA96Cx0tDawBx8Bnt96fulhEcOs/o2QgNWNbzI=;
        b=SSj6GjSmN/XkZhNPL1K0AZ/DvvIDtRjrFvOBPe2YxfK5S9Z6RNDjH7R6qQ5dtyGJ35
         VYfBacohoMHo9imZcueGTkeYKtwqtRIqY2ms1xQoTIuhbMKgLdSA/NtFNkfPXRTN2e87
         ZrDS1dD3KdorEry9n6qmctV+gh3ADcaZ17Gc1gJP2Z9+8qA/cvFQ5btCpbNd0VH/loDg
         5yABoJSRuY25bJMd5EzGSQ2mem6A70aQ2qgKqGFWslwVQ168GLt9cSCyMdAqMkYK6zw7
         b8pM8BedLiPxfkvDJl6AoOFTFaSagp8xRDxX9/5Nvd2TSku3/V/8+L7ImfzxsKD3cLkN
         /izg==
X-Gm-Message-State: AJcUuke2OxoslBHvLp0eCNCiOC/jCOKu7Vp8JVVabb7xIMF9bNITQGut
        2Nsx/wNNvoAtP5GzWM7i0jYjouPTDpU=
X-Google-Smtp-Source: ALg8bN4cJjJ1hR2xaO6FAJ3RG6ySgxGqP34rYVEXlAchKBnERLMXINlvlWQO6InRjutxDbzbbayWsQ==
X-Received: by 2002:a2e:4601:: with SMTP id t1-v6mr33006103lja.111.1549058316717;
        Fri, 01 Feb 2019 13:58:36 -0800 (PST)
Received: from arch.domain.name (89-70-37-207.dynamic.chello.pl. [89.70.37.207])
        by smtp.gmail.com with ESMTPSA id s20sm1567630lfb.51.2019.02.01.13.58.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 13:58:36 -0800 (PST)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, jic23@jic23.retrosnub.co.uk, pmeerw@pmeerw.net,
        johan@kernel.org, Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH v3 3/3] dt-bindings: iio: chemical: pms7003: add device tree support
Date:   Fri,  1 Feb 2019 22:57:59 +0100
Message-Id: <20190201215759.14569-4-tduszyns@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190201215759.14569-1-tduszyns@gmail.com>
References: <20190201215759.14569-1-tduszyns@gmail.com>
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
index 000000000000..cbad95480e04
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
+- set-gpios: phandle to the GPIO connected to the SET line
+- reset-gpios: phandle to the GPIO connected to the RESET line
+
+Refer to serial/slave-device.txt for generic serial attached device bindings.
+
+Example:
+
+&uart0 {
+	air-pollution-sensor {
+		vcc-supply = <&reg_vcc5v0>;
+		compatible = "plantower,pms7003";
+	};
+};
-- 
2.20.1

