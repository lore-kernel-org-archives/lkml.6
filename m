Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E8BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 12:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5FEC214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 12:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKvTLCkm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5FEC214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732704AbeKNWUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 17:20:03 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36430 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbeKNWUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 17:20:02 -0500
Received: by mail-wm1-f65.google.com with SMTP id s11so5211579wmh.1;
        Wed, 14 Nov 2018 04:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EkoJoXBciY/DLr4VKETRPvsmkQMlKVc0rpvxLdGMh3E=;
        b=eKvTLCkmnxXbf9BnTySl1JTzlPd0fEXhjPNu+wIypMDLefJxSaykFhIiNdT/GO0Scf
         uwNPkbAavYyvn273ZtBg25BYGkwNkP4Zz+PX/VJfe0P6etjtGocc9YOaXuXxFPX3/veX
         Ncww6Lv6lYLhPjkoqmLXjbcG2EeIVvC9/74BSsZvCW+YT/hnN9vhiDY4AagYgJufrvzU
         BT6gbJTNjXponzzEkwRaDkdH3/pZ3K9GSswmFjSKlQha5m6X+Y9WoCFdLiaOt8+A1wiw
         leLDgOnLvqlOFU5QcejatHNezoSCcOGHYBKMPvAdfRXFRR4aPiHAUrQZBeI97BezhLi4
         O3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EkoJoXBciY/DLr4VKETRPvsmkQMlKVc0rpvxLdGMh3E=;
        b=QDRiKTkoIRGCyekT2m+t1mhplXoLEKvaCSDTFYsXfDFy9TU9SGkyiv+tyX0cvKtWcS
         V3hTEcPuIgKZlqDQbQTXpB7FSTjFi6ejU3fncXKZcovDWHBUEfWK3+YOfk/1cWFw3/NH
         ceo2s6CE0u9W5OsixM0TXyv47aG7IQcqhaHcOw4Lfai6LSfIvsb+qvSDSNXslq90ICjn
         QNXh8KuID23jYjWbAftjiRtf9oE+1JVySSLNWWPaZ6VMZATlqx4iVWPyO9728qQf1sNQ
         GIbDlkOnAtZJYU6O1nKXSFREC5C+71qgOlq8kWlS57MLSy/Iz1W0wFu7v+bCZqa57Rox
         qGSw==
X-Gm-Message-State: AGRZ1gIcn6jmJXsIhw3jpE+tee9DyeLIvOu+Ebpk3I4rJr6G658osERJ
        aFhu3n+9Ps7Go5QX2vncAgI=
X-Google-Smtp-Source: AJdET5eLUpNw85SMaYcGxx1ItnZXuuK0wl5+uMAUiX3JeY/PUrNXlWzfur6FsWhLn3i2h94h69HjzQ==
X-Received: by 2002:a1c:85d2:: with SMTP id h201mr1126643wmd.151.1542197820103;
        Wed, 14 Nov 2018 04:17:00 -0800 (PST)
Received: from cperon-Latitude-7490.lan (static-css-csd-151233.business.bouyguestelecom.com. [176.162.151.233])
        by smtp.gmail.com with ESMTPSA id a125-v6sm12443623wmf.8.2018.11.14.04.16.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 04:16:59 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 2/2] ASoC: dt-bindings: add bindings for AK4118 transceiver
Date:   Wed, 14 Nov 2018 13:16:42 +0100
Message-Id: <20181114121642.1404-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114121642.1404-1-peron.clem@gmail.com>
References: <20181114121642.1404-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bindings for AK4118 S/PDIF transceiver

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 .../devicetree/bindings/sound/ak4118.txt      | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ak4118.txt

diff --git a/Documentation/devicetree/bindings/sound/ak4118.txt b/Documentation/devicetree/bindings/sound/ak4118.txt
new file mode 100644
index 000000000000..6e11a2f7404c
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ak4118.txt
@@ -0,0 +1,22 @@
+AK4118 S/PDIF transceiver
+
+This device supports I2C mode.
+
+Required properties:
+
+- compatible : "asahi-kasei,ak4118"
+- reg : The I2C address of the device for I2C
+- reset-gpios: A GPIO specifier for the reset pin
+- irq-gpios: A GPIO specifier for the IRQ pin
+
+Example:
+
+&i2c {
+	ak4118: ak4118@13 {
+		#sound-dai-cells = <0>;
+		compatible = "asahi-kasei,ak4118";
+		reg = <0x13>;
+		reset-gpios = <&gpio 0 GPIO_ACTIVE_LOW>
+		irq-gpios = <&gpio 1 GPIO_ACTIVE_HIGH>;
+	};
+};
-- 
2.19.1

