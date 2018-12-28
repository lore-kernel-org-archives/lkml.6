Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D765EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A951120874
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NonqxYOY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731723AbeL1PTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 10:19:50 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45043 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731588AbeL1PTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 10:19:38 -0500
Received: by mail-lj1-f193.google.com with SMTP id k19-v6so18923890lji.11;
        Fri, 28 Dec 2018 07:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CCV0gd3aGFNtHm5duNx7zwWOLB1bEFb5KSmmwZuypIU=;
        b=NonqxYOY0jKIFzhMoGY7dkjCJmzvDJftKvILDCjPm0bXr/Fuak2U5To/b2r5ahLqDH
         K82R0mrg+GlPc1UYKlzYHnj2LTlfWHPTXIBhSgM1E8iL+t8lw3WbmupnPzlVhmfVNwaU
         v/3XprdkB3DwxUWvPMysjG/MtMUdAnU+zBjjWAmBjOCt7d7CXwUsKUo8N0jIwx+3Kmcp
         YVHlAXRQk/9M9cuPc1hzIChsqjrDQQUI+MX0VuAcGptb45NInJf9VMQpV2V6JSL+7YlI
         AWNogyBuz06EhYppayP1iEd+5xElx90j1Ox2AJRiAAUg8M9OvZvJwrtFDdN4q3JV3dix
         QHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CCV0gd3aGFNtHm5duNx7zwWOLB1bEFb5KSmmwZuypIU=;
        b=h+9YV0y3ry8ptMwgnzfEwcldmY1EW5ejmmUtM7DJLeRaAOVwHzstc6yHp0ABSgfp3M
         hvYIMst4c6TO4jYCANhpyLXEEYCqN/SPPrARMr0Y3kINh5Rmnuu1M8LEdt3AYzNE2MJU
         4Jta4a8+6nV3wCDQx/BPIDXWslTY5fxoNIS3JPCBn+lpVMAfieSFs6EZ1mkVacRrwpwo
         BqAXb7lhR+trTN/EWkazyKyAEVheHtF0KOGq4szo/DiZjR+7RAk6YRSPwskVLY5N/AjU
         iC6qFAos7E9L4G0KBB8JdUK0ZbTJxeEanXHh6o7e0bbqhZZPKwk85lcIUB+OB3qVhNt2
         G8dw==
X-Gm-Message-State: AJcUukfVZVxrwuLm3cZsyJYzaL31jmrX7w5UqrdSMUVSirIc+dMua9kc
        Qhekw2ejFAb6qVVWSrjHgmc=
X-Google-Smtp-Source: ALg8bN4WyJOu3IF4f2GY54hTI2FKFReGAyCTELDRufUayNhspyNowq4R4V7h/GGbDU490RpVuDC42Q==
X-Received: by 2002:a2e:9059:: with SMTP id n25-v6mr9252819ljg.155.1546010376468;
        Fri, 28 Dec 2018 07:19:36 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:7146:fd07:48ff:9665])
        by smtp.googlemail.com with ESMTPSA id s24sm7872704lfc.30.2018.12.28.07.19.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 07:19:35 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     inki.dae@samsung.com, krzk@kernel.org, airlied@linux.ie
Cc:     jy0922.shim@samsung.com, sw0312.kim@samsung.com,
        kyungmin.park@samsung.com, kgene@kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v2 3/3] ARM: dts: s5pv210: Add node for exynos-rotator
Date:   Fri, 28 Dec 2018 16:19:04 +0100
Message-Id: <20181228151904.12079-4-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181228151904.12079-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181228151904.12079-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds node for Exynos Rorator device,
so it can be used on all s5pv210 based devices.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 arch/arm/boot/dts/s5pv210.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
index 75f454a210d6..a5463003c7f6 100644
--- a/arch/arm/boot/dts/s5pv210.dtsi
+++ b/arch/arm/boot/dts/s5pv210.dtsi
@@ -542,6 +542,15 @@
 			#dma-requests = <1>;
 		};
 
+		rotator: rotator@fa300000 {
+			compatible = "samsung,s5pv210-rotator";
+			reg = <0xfa300000 0x1000>;
+			interrupt-parent = <&vic2>;
+			interrupts = <4>;
+			clocks = <&clocks CLK_ROTATOR>;
+			clock-names = "rotator";
+		};
+
 		i2c1: i2c@fab00000 {
 			compatible = "samsung,s3c2440-i2c";
 			reg = <0xfab00000 0x1000>;
-- 
2.17.1

