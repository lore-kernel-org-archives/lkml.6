Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764FDC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 07:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32BB52171F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 07:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZyBcGx2k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbeLZHID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 02:08:03 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39974 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbeLZHIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 02:08:02 -0500
Received: by mail-pf1-f193.google.com with SMTP id i12so7530399pfo.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 23:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zcoSEGjxuSEIrQl28ukO3J49sznU0Pd5P50+ubK9Lzg=;
        b=ZyBcGx2kmDyK/0rg9iq+w+JRwojWCpeKv8hvtUW0JDNJoKbD8j4Ag3DdPm9CdA/KRF
         zpHQo3b13c/pPR5gcYg5K/1RnsTIy5Vin11XXAr4F0VOEuLP8KoASpfJlIuiclEGqLwC
         tsDk/6kS8Vxqldo6KBlOm8F8crYdvnPlsrJMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zcoSEGjxuSEIrQl28ukO3J49sznU0Pd5P50+ubK9Lzg=;
        b=QJ+KBsr80+BADuAW3//N49vKpYyvkdlXGQc1sdQc2wDcKTucVyQ166rC/Q6oIe4BiF
         ZSzhD3+WCTyKN7AagxbRpldbUeIMvW5wHL5KhGJzHFCU1vTchfLJ6NviYYImlpOVh4Yx
         ZJ1sBhnprDysurkSBtyk83vS/zSlqPP9r/o6tPPVGeU0SuIDrK77erf1zmXR2HA1vkMB
         yDuMJR4pMWS5AcLwjks0vhhO9bVOEVmuZv+Kcb8EWRFXvlN98AayO9s/KIdjH/5l/L8n
         YkzntK1mSlGu/yXClim5CbDgxZ+5S0TXpehnTHpF8lukyLP/6gTiCv4un5Pp9tiC93IU
         4t4A==
X-Gm-Message-State: AJcUukdbbPidev6+zl9BooU6kdwKCF1fi4+H0MOA9oGK4XeEbsz47yxq
        u1+XFuv06SK4KcqQBSL0yUoY7gP+qEY=
X-Google-Smtp-Source: ALg8bN7043geOiN9UCs/Tc40EIah7I3ZphDJS7YfCTd667VtM+RqSog4xgc/D5mvK6aN0a/Wq8zqzg==
X-Received: by 2002:a63:8b41:: with SMTP id j62mr18191130pge.182.1545808081564;
        Tue, 25 Dec 2018 23:08:01 -0800 (PST)
Received: from cychiang-z840.tpe.corp.google.com ([2401:fa00:1:b:e688:dfd2:a1a7:2956])
        by smtp.gmail.com with ESMTPSA id n68sm52966030pfb.62.2018.12.25.23.07.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Dec 2018 23:08:00 -0800 (PST)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        Rohit kumar <rohitkr@codeaurora.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH v3 2/3] ASoC: Documentation: Add google,cros-ec-codec
Date:   Wed, 26 Dec 2018 15:03:17 +0800
Message-Id: <20181226070317.72022-2-cychiang@chromium.org>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
In-Reply-To: <20181226070317.72022-1-cychiang@chromium.org>
References: <20181226070317.72022-1-cychiang@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for Chrome EC codec driver.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 +Rob Herring for reviewing this patch.

 Hi Rob,
   Could you please take a look ?
 Thanks!

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

