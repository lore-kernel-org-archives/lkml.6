Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D828C5CFC2
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 15:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F6A208E1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 15:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5zombEM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F6A208E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934152AbeFQPAB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 11:00:01 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35816 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933588AbeFQO7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 10:59:44 -0400
Received: by mail-lf0-f68.google.com with SMTP id i15-v6so20993908lfc.2;
        Sun, 17 Jun 2018 07:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a2Q7a41jwpKNsScnwoDwsLFmklM5mt6scOHyG2tEFVU=;
        b=N5zombEMrEy7sSvLv4jfAx9jAuZUN+CR9tTJos7bRDWh0hdYUdUHzH8MHidIgyHy7p
         5yulE3IZc9rbIXgGNu69xmINenVQ7PCLRNOaYahVvg3qCHnbNql9LrFHQDdDHTqFXHou
         0eu7VyKG5e/CItTLq/RGCTqxEeTwq0MtHtj3dIhMSbAce/GSr2t4tJVaqCBofEL0KD2g
         owmnq+mH4dzVFP7GucF8vilyKGbwsG7xz8mANz0dhMEz6SN1YKOH+bxIdqpLo31wckRn
         0+EaG0vRMf/WJLuxLqH07RHIJ2DA8x4y/tUPZiTnhEcWlZcu3Dmb0esisHFxX0Q5hPsW
         m8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a2Q7a41jwpKNsScnwoDwsLFmklM5mt6scOHyG2tEFVU=;
        b=a0824ZMymNXIS0Wp6/9to4fwbUCH/9iwFBKwIIUIVbmkpbCVtwgiR+hQEy5VvmCY9A
         y0e3LXXLfMQaER0ic1a8vpdn6UG5EQ3qLLprqQj8rSAqk0Ek2oUNsKgTHh8AO/kRLlFi
         vJtUgI/kL1YOglygyNMr5VvcEXdMYgFbEg7teNmnmmw5Bu2BLXRMMzXVcxcZJ3IPNDUy
         8Z11avrFxnZAWfhFQd+84e32qo9OKg1QuaFoAodfAHxN+qWI1CO+eX2390sAfD7mdFO2
         V6RGbClMGI0arkCypeoMMBwxC6ely540Zkdw1PMTO5k4R5wNFiLKp9LGRl6/Hiv4DKNp
         beWQ==
X-Gm-Message-State: APt69E2ZE4ZLDkunZWNXhX1x1qnDk07WXtnWdSrKdgJhc0HfWiACQ4XF
        bh9IPgXWVQnz6pwHv7ZxuUQ=
X-Google-Smtp-Source: ADUXVKJd1naCAarpW0vImMlEpdparS1gP5RhwFy6WeOLF5LqUWBNSfO3MsV7hIyZ/zAgmj2TNGQPpw==
X-Received: by 2002:a19:d046:: with SMTP id h67-v6mr5152518lfg.52.1529247582346;
        Sun, 17 Jun 2018 07:59:42 -0700 (PDT)
Received: from localhost.localdomain ([109.252.55.139])
        by smtp.gmail.com with ESMTPSA id r21-v6sm2296173lja.92.2018.06.17.07.59.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jun 2018 07:59:41 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/8] ARM: dts: tegra20: Add interrupt entry to External Memory Controller
Date:   Sun, 17 Jun 2018 17:55:35 +0300
Message-Id: <20180617145539.4758-5-digetx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180617145539.4758-1-digetx@gmail.com>
References: <20180617145539.4758-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interrupt entry into the EMC DT node.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 arch/arm/boot/dts/tegra20.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 983dd5c14794..3cd3cb28cfd9 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -609,6 +609,7 @@
 	memory-controller@7000f400 {
 		compatible = "nvidia,tegra20-emc";
 		reg = <0x7000f400 0x200>;
+		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
-- 
2.17.1

