Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351CDC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A7C2183F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A31b7aW8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbfAHQ4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:56:34 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33652 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727764AbfAHQ4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 11:56:11 -0500
Received: by mail-lj1-f193.google.com with SMTP id v1-v6so4027076ljd.0;
        Tue, 08 Jan 2019 08:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jAEXFJkBZ3UVZneEhxEUAboaTpH0jjDGy7Sznxt2tMw=;
        b=A31b7aW85KjLT5S9fD0JOkn66FArIYgUEAabFdE0BoN9HbQ8YiOMGC94Vr8Y67UX6l
         9DUzAaBI9h+fIB6qQRAe8EuyrBdbBKq27+ul+2Z/oyyzd/MTmbOj8KKleRoswwKwGLp/
         cBO2ys1ru3VcFD9f83yRSvq4ifNMlHxsrkExSK5gnoIPqEStYlnYlqbF1O5SArVHv/33
         WZW1bFFEiIotYNftF1E+bVcya4NvX1thwEpU8fNNpazh8SOp27MRmtvHNGKEdVwxj/kp
         bMsL/fX6w+Eymu5SOXR4nA+URpj//lG1LwONM0XajRMcTV2/OwGotwYZpyYhkYl1q0N1
         qqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jAEXFJkBZ3UVZneEhxEUAboaTpH0jjDGy7Sznxt2tMw=;
        b=JoIarZj8wWGOYpLdnwczyVPtVRsZhS5nV6TwcFr75I2LsNqjx1CpuABnZVI6hE3k8n
         qIvSOhgJFbVW0JaoJc2T1KcBxJtudDpqLPGGGn4EFI1jzSxz2neYhS8+pIpJxKf6Tm6+
         apzk5LaiaTExxSVNubQEN/GelNVaAEK9bFfuUD4wC/RaIJ072CnTr8IwGt8oIXT8KsZG
         fTrH4U8Hx1YXcBUxd9ZkDrsvOSEVEgdi9+cPDslxbfZwLZUUMnyv17mqvzN10NFS/KrP
         ZgIQlBzBhDAU4FJxQhnbVb5dcJ0j/1hh47XASbDxCC9hk3NS6/UPYSoAdsVXxO8wytTm
         L1CA==
X-Gm-Message-State: AJcUukfo/MxoDPDAzZJy07Hpz+QyDXC094YXEWe7JUCQVMvyQndSvA7F
        GuYlBgS0MMTxOmO2FEnaXRU=
X-Google-Smtp-Source: ALg8bN7vWxUp46zVTLsiadiH8y0zquk4m8rzMk8e+zfqwL/X/eTuBX6xuma+zuTHUhLZSUJjIV1rlA==
X-Received: by 2002:a2e:45d:: with SMTP id 90-v6mr1524269lje.110.1546966568574;
        Tue, 08 Jan 2019 08:56:08 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:d033:e708:8ec7:810d])
        by smtp.googlemail.com with ESMTPSA id f8sm14687989lfe.72.2019.01.08.08.56.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 08:56:07 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     krzk@kernel.org
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, pawel.mikolaj.chmiel@gmail.com,
        xc-racer2@live.ca, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] ARM: dts: s5pv210: aries: Add reserved memory for mfc
Date:   Tue,  8 Jan 2019 17:55:58 +0100
Message-Id: <20190108165601.25708-2-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190108165601.25708-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190108165601.25708-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

THis commit adds memory reservation required by MFC to run.
On S5PV210 both regions needs to be on separate memory banks.
Size of both regions is taken from stock sources.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
Changes from v1:
   - Fixed name of nodes to be more generic
---
 arch/arm/boot/dts/s5pv210-aries.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
index 575094ea7024..89525e56cc7c 100644
--- a/arch/arm/boot/dts/s5pv210-aries.dtsi
+++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
@@ -23,6 +23,24 @@
 			0x50000000 0x08000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		mfc_left: region@43000000 {
+			compatible = "shared-dma-pool";
+			no-map;
+			reg = <0x43000000 0x2000000>;
+		};
+
+		mfc_right: region@51000000 {
+			compatible = "shared-dma-pool";
+			no-map;
+			reg = <0x51000000 0x2000000>;
+		};
+	};
+
 	wifi_pwrseq: wifi-pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&gpg1 2 GPIO_ACTIVE_LOW>;
@@ -329,6 +347,10 @@
 	status = "okay";
 };
 
+&mfc {
+	memory-region = <&mfc_left>, <&mfc_right>;
+};
+
 &pinctrl0 {
 	wlan_bt_en: wlan-bt-en {
 		samsung,pins = "gpb-5";
-- 
2.17.1

