Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5182EC61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 11:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 178A320821
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 11:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gEqfNbFC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbfASLdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 06:33:53 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44329 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbfASLdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 06:33:53 -0500
Received: by mail-pg1-f194.google.com with SMTP id t13so7303214pgr.11
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 03:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0HlCechkAc3ObRUM6hv1W0c8PK1wYLXHG3tM4eJXam0=;
        b=gEqfNbFCKxI4HSNedc9KZpKxsIqAiWdWv3KB/zsNedea31VHpl6SO+jWK6+DnpWh0o
         ppCs18brVnMj6rM+Y0FcYZPHxCQ8HY8NzlIfQOY01aOUlakJ+msKtnosx1EsVVXX84mx
         emIWH6oUvuac42E+d6deVw0Awaw/MvBr6eW4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0HlCechkAc3ObRUM6hv1W0c8PK1wYLXHG3tM4eJXam0=;
        b=jVrQu7VuytMIh0xD2dfDdkkUHfi7kcdxfzRsWRK88SERRqcjdItqETecL6OrJJKx2D
         WKPFuh12NJNHenAlneGECdSQU7CnaZRThqEkVfV7V15wuyOOjQt2CsJnlOh7P7QvYyq4
         UPpwm8qFxRRJPoXWnACtaMFol3nAxskF3mRGnosZy3zdxCOyAxL2+SCMSUHWHqvOWfl2
         ASnndUXk3D+6w+CuK7iUyf3aFZNeZvMdM7o728ATUA4BO27IltSc6FVoYTY1ZiWxlXxN
         3e+9ZAnRaTpCB77l0m4ROpLOiaD4BvXf8ZcNKgURim434P6DYNRldmSaM2jNMijZdtvt
         al+g==
X-Gm-Message-State: AJcUukcey3hFq8NFF/R8sRq6PU48hbXkKLCg+YibCdfvW6t+QvBxwRiX
        5dX6GOMpnmTZ3b3e+HjZuHTNS3Kjf4A=
X-Google-Smtp-Source: ALg8bN7iurSaISS8DttQAlGR0TQZcc1SrpNwA2pHtMXyUcUF9veMrOVvtRcjzvrJX9wpYZUmsQZBag==
X-Received: by 2002:a62:184e:: with SMTP id 75mr22624476pfy.28.1547897631666;
        Sat, 19 Jan 2019 03:33:51 -0800 (PST)
Received: from cychiang-z840.tpe.corp.google.com ([2401:fa00:1:b:d3e3:8b64:9238:2823])
        by smtp.gmail.com with ESMTPSA id d18sm10477098pfj.47.2019.01.19.03.33.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 03:33:50 -0800 (PST)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        Rohit kumar <rohitkr@codeaurora.org>,
        Guenter Roeck <groeck@chromium.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH v4 1/2] ASoC: Documentation: Add google,cros-ec-codec
Date:   Sat, 19 Jan 2019 19:33:31 +0800
Message-Id: <20190119113332.249720-1-cychiang@chromium.org>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for Chrome EC codec driver.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 Change in v4:
 - Add a property max-dmic-gain so we can configure maximum gain on dmic.
 - Add Guenter to the reviewer list.

 .../bindings/sound/google,cros-ec-codec.txt   | 26 +++++++++++++++++++
 MAINTAINERS                                   |  7 +++++
 2 files changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt

diff --git a/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
new file mode 100644
index 000000000000..1084f7f22eea
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
@@ -0,0 +1,26 @@
+* Audio codec controlled by ChromeOS EC
+
+Google's ChromeOS EC codec is a digital mic codec provided by the
+Embedded Controller (EC) and is controlled via a host-command interface.
+
+An EC codec node should only be found as a sub-node of the EC node (see
+Documentation/devicetree/bindings/mfd/cros-ec.txt).
+
+Required properties:
+- compatible: Must contain "google,cros-ec-codec"
+- #sound-dai-cells: Should be 1. The cell specifies number of DAIs.
+- max-dmic-gain: A number for maximum gain in dB on digital microphone.
+
+Example:
+
+cros-ec@0 {
+	compatible = "google,cros-ec-spi";
+
+	...
+
+	cros_ec_codec: ec-codec {
+		compatible = "google,cros-ec-codec";
+		#sound-dai-cells = <1>;
+		max-dmic-gain = <43>;
+	};
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index 4d04cebb4a71..a5678e4041e9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3688,6 +3688,13 @@ N:	cros_ec
 N:	cros-ec
 F:	drivers/power/supply/cros_usbpd-charger.c
 
+CHROMEOS EC CODEC DRIVER
+M:	Cheng-Yi Chiang <cychiang@chromium.org>
+S:	Maintained
+R:	Enric Balletbo i Serra <enric.balletbo@collabora.com>
+R:	Guenter Roeck <groeck@chromium.org>
+F:	Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
+
 CIRRUS LOGIC AUDIO CODEC DRIVERS
 M:	Brian Austin <brian.austin@cirrus.com>
 M:	Paul Handrigan <Paul.Handrigan@cirrus.com>
-- 
2.20.1.321.g9e740568ce-goog

