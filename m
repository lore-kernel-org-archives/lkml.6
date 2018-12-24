Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFB1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9A12173C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KLFweUxZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbeLXIjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 03:39:47 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34120 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbeLXIjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 03:39:45 -0500
Received: by mail-pg1-f196.google.com with SMTP id j10so5369357pga.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 00:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ilSlR+CLtzMBfDdXJ3oXdMqstsLzRCty6BU1tKZ3IUs=;
        b=KLFweUxZqt1MAELm2KAl41xoiN166xLO8cYNoZMYTA4/Sakz/QO3KJRcpbIwAmIZQA
         QJfBmOXEuQKgvqR7qONOyaBzHU4Vb8UeT6xTqLDs4oInIXS14he6pGy4G0cS0P+tjhAg
         S7/KUYmQ0KOzkjXbTOfh3OyFq82kWmOBardF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ilSlR+CLtzMBfDdXJ3oXdMqstsLzRCty6BU1tKZ3IUs=;
        b=Ym2lPV14RSrT3+XAZaAIfh7N/BH6iS4w12wWh/ZkNb8imMs+DWHNIvOrpn753PcCC3
         9RnE/MjBLJ40STynb508wfQREmz0r9lAhinURx+P4CC9tPew8sL3RgJASg8FeDtq5gQk
         2No/LCtyoAkYFs7cr/pkeyvQQ34CPpgjGYc7nTx2OO/wqsUzA1LkGDrao3WMl/rgquSu
         hLMK/HS8uDpEtSssP6Aryr9OrucY4rnpc2Pi6ZNesMjy3Nypb+CftF6wUV3IauYOWICv
         mx6tOmsIhZZ09PGSyY8fwFw8jBT0u95Q+SazP1brOLSMZD3o9VVUbbI/vpXaJGfP/meY
         iX5g==
X-Gm-Message-State: AA+aEWbO3+AlfiWrhjL1dhCIPs8cUrjJybJlhcexS3/3EK/DosbGEaRS
        DDmblQ+CYhlG7ETEGMvIV3V5G9P6DsI=
X-Google-Smtp-Source: AFSGD/VMgXLenR9XsVHoEFKNu/dbWlWMEnWnB7SiXuc4T15BvDP2GVXtsw3zAibKjfFdhyG3LDKGfg==
X-Received: by 2002:a62:1043:: with SMTP id y64mr12552993pfi.78.1545640784859;
        Mon, 24 Dec 2018 00:39:44 -0800 (PST)
Received: from cychiang-z840.tpe.corp.google.com ([2401:fa00:1:b:e688:dfd2:a1a7:2956])
        by smtp.gmail.com with ESMTPSA id r130sm59078720pfr.48.2018.12.24.00.39.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Dec 2018 00:39:44 -0800 (PST)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        Rohit kumar <rohitkr@codeaurora.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH v2 2/3] ASoC: Documentation: Add google,cros-ec-codec
Date:   Mon, 24 Dec 2018 16:37:24 +0800
Message-Id: <20181224083724.75618-2-cychiang@chromium.org>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
In-Reply-To: <20181224083724.75618-1-cychiang@chromium.org>
References: <20181224083724.75618-1-cychiang@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for Chrome EC codec driver.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 Change in v2: Fixed name of driver in MAINTAINERS.

 .../bindings/sound/google,cros-ec-codec.txt   | 24 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++++
 2 files changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt

diff --git a/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
new file mode 100644
index 0000000000000..57718382b3a36
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
@@ -0,0 +1,24 @@
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
+	};
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index 5b9c6af98283b..05e1922624e58 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3636,6 +3636,11 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform.git
 F:	drivers/platform/chrome/
 
+CHROMEOS EC CODEC DRIVER
+M:	Cheng-Yi Chiang <cychiang@chromium.org>
+S:	Maintained
+F:	Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
+
 CIRRUS LOGIC AUDIO CODEC DRIVERS
 M:	Brian Austin <brian.austin@cirrus.com>
 M:	Paul Handrigan <Paul.Handrigan@cirrus.com>
-- 
2.20.1.415.g653613c723-goog

