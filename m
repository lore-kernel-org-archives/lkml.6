Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5B9C04EBA
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 19:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333DB20664
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 19:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="WF3sxssQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 333DB20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633193AbeKXGjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 01:39:10 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38223 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730127AbeKXGjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 01:39:10 -0500
Received: by mail-wm1-f68.google.com with SMTP id k198so12987632wmd.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 11:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M61cDCLQgQA9sNaBzxtJV4zAi7xq2DD5D1gWlGJ8y7Q=;
        b=WF3sxssQSCYAnuy6c55yz7y0QR84Us0Tl1uC09Ii4PgQxTdGrS3/VqOYFPBvZ0mc21
         PfTAOFgwskn2x6Ua3bJOmymPPJy2ZDLTDOh9Mrd70JItG0q+FDx6YQmWEMw9GgZX0ySf
         EMmH7z4JL3hV2w60YupkN/JC2MDT3RaBVSv9vXuXhiahyWLpdU58FsIZMMS/gou0yCv/
         /rHDGrpXKmmtNTnkFlRwz7E3y6DBgoqdW/ZRxRUFxw8Ud2thQANtwfE7Z96SA5uzTSDh
         aSPk6Xp4w12SYmH8l+42EU5Ajwjf4Wif2W4Ts9TwaujAtfyxQyWsLaclovND6Hfemg+3
         UDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M61cDCLQgQA9sNaBzxtJV4zAi7xq2DD5D1gWlGJ8y7Q=;
        b=Uj14FqTS47Isoapx1UPOWGBCVXNcc5MRkk/YM0UtPX7rYfCNRVFG54lUnBOgSJ4CIg
         o95tOjxfPVSubWEYd3bzA3oz5DG/dzG5Jfg+fstTkxaqLKZO5saFLJKdyOvxteGKGtnh
         pKw/3gIlW97KMQFU0WtZ8EoSElzgegmQH4xUVwDs3UF9QyqxpWPw24rTyJB5618E3Vrh
         QXWpJaKCepZlW2myOm7iJ3etKuQ9Yfz5bPFiG5CBghKvhKKu8nPVPCD5jMWOrptsMIdN
         Kew56RjEq5HBCeDRLxCpZaZMm6ttS4www3xOjI5mTAA7KTr9ruHsomSOMJ43zsU9xvng
         tlXQ==
X-Gm-Message-State: AGRZ1gIOngj3RLW4fddYJgSlG5Iuxzx4HIsMrK8dr3vBrehJpVwokdOy
        9T4w3U10zPkEJwn2IcnQ/wg=
X-Google-Smtp-Source: AJdET5eVOW+nRFP4Nitw9c3pyyJV/5bFIqiget0Vkz147/tONK3RusfFunjDix6qGT/EHcoLi0pJMA==
X-Received: by 2002:a1c:730b:: with SMTP id d11mr13726144wmb.29.1543002807667;
        Fri, 23 Nov 2018 11:53:27 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD732F500597D16A631573221.dip0.t-ipconnect.de. [2003:dc:d732:f500:597d:16a6:3157:3221])
        by smtp.googlemail.com with ESMTPSA id g198sm11495337wmd.23.2018.11.23.11.53.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 11:53:26 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     carlo@caione.org, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 3/6] ARM: dts: meson8: add the ARM TWD timer
Date:   Fri, 23 Nov 2018 20:53:08 +0100
Message-Id: <20181123195311.4578-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181123195311.4578-1-martin.blumenstingl@googlemail.com>
References: <20181123195311.4578-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Meson8 and Meson8m2 SoC are using four ARM Cortex-A9 cores which
come with a "TWD" (Timer-Watchdog) based timer. This adds support for
the ARM TWD Timer on these two SoCs.

Suggested-by: Carlo Caione <carlo@endlessm.com>
[ rebased patch from Carlo, use IRQ_TYPE_EDGE_RISING instead of
  IRQ_TYPE_LEVEL_LOW to prevent "GIC: PPI13 is secure or misconfigured"
  message during boot, use pre-processor macros to specify the IRQ,
  added the correct clock, dropped TWD watchdog node since there's no
  driver for it anymore ]
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index 28b9f6779993..2b0b3edbd896 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -362,6 +362,13 @@
 		compatible = "arm,cortex-a9-scu";
 		reg = <0x0 0x100>;
 	};
+
+	timer@600 {
+		compatible = "arm,cortex-a9-twd-timer";
+		reg = <0x600 0x20>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
+		clocks = <&clkc CLKID_PERIPH>;
+	};
 };
 
 &pwm_ab {
-- 
2.19.2

