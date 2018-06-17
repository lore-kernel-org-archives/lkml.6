Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B81C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 15:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17FE208A6
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 15:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0sPVsvU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17FE208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936785AbeFQPB1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 11:01:27 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37176 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933681AbeFQO7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 10:59:45 -0400
Received: by mail-lf0-f67.google.com with SMTP id g21-v6so21003911lfb.4;
        Sun, 17 Jun 2018 07:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ISyf22lzoXxmW4di2CCMwh5mM1JZdh5BeMsDH+Ye8Fc=;
        b=C0sPVsvU7Bt0kX/2y/LzZm5WmzBaFpVaWGbg9BErEit8nV+zEsZiTqBTq74q3RvDis
         3G1R1LhUweVLpW38L4EZADu5rFc4TRoyNw0jVMxna/AxCABJ5IgtF7MDWNP3oYm6TU6g
         66W9JPdRGMX/UoNre6hNwv9iT8tBlOERuhOCfWmN4Oo9LIa6pKs8Xu02Gw9BI8cxzTee
         /itgBVgND/jpXEnmmpTjX1Kii8Bl/lHqUy5sOttmg8wOTLF932n23YBUJJ8nwLMHenEk
         lTqj/ZlZydI/P8rjnBrYLpFfqULNmKpwc/W8QAgxuSUZVVGSApoNGsnMKsvjMRIxWiCm
         IaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ISyf22lzoXxmW4di2CCMwh5mM1JZdh5BeMsDH+Ye8Fc=;
        b=uRb2xUMLHhr0C9vCfvUCIypw5qzuQblSIc0A3e610+j5SDvHY4PtKzcVA0igBAgx+J
         +Npr3xwJgMOXQtE8/UgZGin56C/rGpJAHdcuk8SnbFa3DcocDnpXw6XE730TrVjX1Ev8
         B34mNe4ohkPz+77vbh4+yAY0P5oCrP0gGuggVfyusL0umXd7U7pkQHhPsxmiIR1RqEnw
         LtJM1KXeJzT/7ytTFeKC0mZ+zL/ilsykhIsOMu+ZWL7TjAnpFmP62lkwIppmVpau8CuW
         Z2wDMOLF0GYkRcCmMJ7gxBHwOkOPfdhvzGeEeBAmbUzPwxRagtjOaP/JzQ85OsvkL3HI
         rwGg==
X-Gm-Message-State: APt69E11CXODH8Gmu7uFZzxTFdKTZD5mc+4xr6ba9yocXrlVQ41TmqYK
        +qyC3GCYi+8DQzFdBYTEyrA=
X-Google-Smtp-Source: ADUXVKLweckDa1xSkYyTPCZ4twL+8BMBfgowxBz09Szsr3rFjxI1lfvEVyYAAFEIBEjsTO8t0k2FIQ==
X-Received: by 2002:a19:1ccc:: with SMTP id c195-v6mr5169527lfc.92.1529247583384;
        Sun, 17 Jun 2018 07:59:43 -0700 (PDT)
Received: from localhost.localdomain ([109.252.55.139])
        by smtp.gmail.com with ESMTPSA id r21-v6sm2296173lja.92.2018.06.17.07.59.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jun 2018 07:59:42 -0700 (PDT)
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
Subject: [PATCH v3 5/8] ARM: dts: tegra20: Add clock entry to External Memory Controller
Date:   Sun, 17 Jun 2018 17:55:36 +0300
Message-Id: <20180617145539.4758-6-digetx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180617145539.4758-1-digetx@gmail.com>
References: <20180617145539.4758-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock entry into the EMC DT node.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 3cd3cb28cfd9..877e41fe87cf 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -610,6 +610,7 @@
 		compatible = "nvidia,tegra20-emc";
 		reg = <0x7000f400 0x200>;
 		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA20_CLK_EMC>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
-- 
2.17.1

