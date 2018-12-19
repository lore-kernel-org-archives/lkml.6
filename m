Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0269AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48E6217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YE3UVjaL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbeLSQEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:04:39 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37008 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729376AbeLSQEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 11:04:32 -0500
Received: by mail-lj1-f194.google.com with SMTP id t18-v6so5857130ljd.4;
        Wed, 19 Dec 2018 08:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CCV0gd3aGFNtHm5duNx7zwWOLB1bEFb5KSmmwZuypIU=;
        b=YE3UVjaLtXB4jlrdgiTLlTN3GOZmzbTqdaPHe0KTUgMWc2v5IffHsVZc29O2biLpIX
         WZvLuyaZutOkgYxZb9L3E1LCjdAiVjPYC7UhFeEM33Ke5wB/c7WYziASOnkKPN2UybNj
         +JI/RUEWlK1MfFWCnn1LnRNSVbzICqzdxvBCDs0JvDTL3tdDRqYGNExeX6gGKAa2fk8S
         GVvPQ8LAtCmY/nTLTot2EoV9Bae6stzHbdpOuP5b0B6KAklQ1QsJua7pOaWt3U8HIcpu
         wJnQ+J0FGETZUSg09xmZjqIaQ0ORgjsBM705ToS3hULwCDZgNByBYAVC5NYvztGF9ydl
         XWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CCV0gd3aGFNtHm5duNx7zwWOLB1bEFb5KSmmwZuypIU=;
        b=j7MlBCp4M9MA1Y02YvXRYrNNtOZ6GS3YjCbvvZI9hsxvVOwyYLHY9hBDXEzIJ8HXIt
         LlnB51M39A3zroiyiEqjzCWn9XOiPdWgLJMtk3PB8d0fFSr6Eim6bnZbruPykKGTlPqD
         tTuGySI8kp6z0FXvfMtd03PBySasolGCyWDjiLZB2GqoAOwrttGOcn585SUSiH6Z26kc
         BTtyZhPrkG3jbCx2GpU7ScqqiK8K5DOYpcUUscM92b0RZOQy00HnY4iiYaAO8jbYtzjo
         AckUkmYN55tr5pK3qYrqVwbfLqxx+CAxitOE5V4xL+u2jpUzU06sTOEkf+8IeG3fP6Sj
         Eu/A==
X-Gm-Message-State: AA+aEWY5Bsa+5XIEeojfVPfV5XSbdkqZwlxmpqW5HW2322aZ9lxtj7In
        ljRb4AjYY0DVLmW3zWt1MFA=
X-Google-Smtp-Source: AFSGD/X1pPhIvldWPsmxYIMED/sUdTu62KEYCaOUA2sly555DBs0sX0MnEaVUuSAFj2LEI3aFQmFbg==
X-Received: by 2002:a2e:9dcb:: with SMTP id x11-v6mr5082837ljj.158.1545235470038;
        Wed, 19 Dec 2018 08:04:30 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:253f:4197:555d:bfba])
        by smtp.googlemail.com with ESMTPSA id i75sm3943979lfb.58.2018.12.19.08.04.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 08:04:29 -0800 (PST)
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
Subject: [PATCH 3/3] ARM: dts: s5pv210: Add node for exynos-rotator
Date:   Wed, 19 Dec 2018 16:57:04 +0100
Message-Id: <20181219155704.15264-4-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181219155704.15264-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181219155704.15264-1-pawel.mikolaj.chmiel@gmail.com>
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

