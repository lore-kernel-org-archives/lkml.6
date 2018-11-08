Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D636DC46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3422081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEP3cHFC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E3422081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbeKHWZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 17:25:06 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45404 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbeKHWZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 17:25:05 -0500
Received: by mail-wr1-f66.google.com with SMTP id k15-v6so18139268wre.12;
        Thu, 08 Nov 2018 04:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EkoJoXBciY/DLr4VKETRPvsmkQMlKVc0rpvxLdGMh3E=;
        b=XEP3cHFCmYJRs+yIZLWbVbSPr07W7Rkr+y8STcqYqi8zb9hwoepkJYvLgnUCZER89p
         O8KsQCbGiE7QcU0NVl5lIQJ8ue0z+3PY+QHgnhrJbQMkwKKoFZwyPJJG2LEs+Ik5DxSl
         NyRqecr64l6vG1NxbvBxOLl9Qo2S4KkOPsv39LKe/SFtEgBp244VMju8iD5MxpXQ+sjA
         1/0XM8sCTni5HzUNN2yzfwMmhtew0s7+2ICtCWEFz5ZuUbu6Tc571EOVMe0O28E5sCcj
         AWqFwbcUjCn0/nYMC10kBNqWNrf3MqdgYCGylzSYzunr4mrm+EUgAnrDp42DlFE6onEX
         qRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EkoJoXBciY/DLr4VKETRPvsmkQMlKVc0rpvxLdGMh3E=;
        b=OZQ5efIOIpp5khGKwDOaQPPDlTtIm7TA2e5IFzcWlAOcXs0kbL74ddWR5wHXSSUYVN
         bjNfaTzNuVs2BNzhDagF2iIw4b9cdz8Rre7bMXJhcsPZXJRslzcnOhX8/bh6GyqhKsTb
         m27apmrf2l21e2nBXkKw390pAAbvva8A2uF1YTyIDIAiNWOh+kSzl2zjulxDUa4B3bfj
         mYF6RvG1A7nO+8J4TgSlWbj0YMfgUAoMouSa1+kYXjJTlQOFQsCpslPty7ljSPvfoFvo
         D9+GsvnK2HkmahcBkI8sKb2em1v6U13HKMfL8j/a7WB5iGMbgUZ4r3BKdyADgPbMYy9U
         pvkg==
X-Gm-Message-State: AGRZ1gItnTabvmJIH/kMfjNs+xXI5zQ6mVN+Otp6AzaYJPSFnMnfZydq
        GSzj8Bnlz5mvjFzS/QQ7Qh8=
X-Google-Smtp-Source: AJdET5cvS08z8UIDjZdR9i183b03JHJ+4BnPCx4pnFo2V/lAydvRbReWMf5JKLzwPISfOI1K9Aigsw==
X-Received: by 2002:a5d:4907:: with SMTP id x7-v6mr4029494wrq.272.1541681383446;
        Thu, 08 Nov 2018 04:49:43 -0800 (PST)
Received: from cperon-Latitude-7490.devialet.com (static-css-csd-151233.business.bouyguestelecom.com. [176.162.151.233])
        by smtp.gmail.com with ESMTPSA id y4-v6sm4956622wrd.61.2018.11.08.04.49.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 04:49:42 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 2/2] ASoC: dt-bindings: add bindings for AK4118 transceiver
Date:   Thu,  8 Nov 2018 13:49:34 +0100
Message-Id: <20181108124934.32381-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108124934.32381-1-peron.clem@gmail.com>
References: <20181108124934.32381-1-peron.clem@gmail.com>
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

