Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4624AC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F312820874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFzBz39M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F312820874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388512AbeGXRuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:50:23 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41574 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388415AbeGXRuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:50:23 -0400
Received: by mail-pl0-f65.google.com with SMTP id w8-v6so2009574ply.8;
        Tue, 24 Jul 2018 09:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9w9JS9k45Mkm5m6z6QbcilGriIHYUaz9xF/Kh7/wMsg=;
        b=nFzBz39Mc7bv7RWDsnUL8xqFcLdPcQWI+0KJ581+47dp06Awn9GGFqp440AM8tIvVh
         HNMwT3/Jd11J+WaKnZXNglOHaMYS0M+B9l6jDb2QlmE5s4anvD4K4at6AI2fBB36Ao1M
         KBbR2iJFxEdfYVKqATeLpT0cWU4a1KFWAVxHx6rTGo9geNj60brjhWXdQdo5R0j+zwGN
         gdlNNfhyNa01cZzWmH05skV3HN1dxj9xBEQJ63AhTwcrkXaGB4UBwJq0LLR5pHha6J05
         saOKPg/HVmGiiEqzv2GnTZyHk5oLMJGKSsMt/FXCeqhy8G9xNbQRAyqw86sYHxETJUOe
         7ORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9w9JS9k45Mkm5m6z6QbcilGriIHYUaz9xF/Kh7/wMsg=;
        b=f5b/50Sv14OXCJdc0f/f01q+PN1o7Zne9qUmfjqD8ydQpV8NTm+hitBr+VaBkhYq6f
         q55izlSqOY4I2fWwvfdaBEQhCsZ6QZSYejOrRW7kJ+Ts4kcm9dKsbI5mQOCMzenBN6sN
         HBfGfxUzYzWyzN1t49RTgBAHhv1vUIiI/tl22gQsbvlRTcX9fTj9FSnFe8g2LrClCGSw
         SUmzSzo49Zsjh2Nvsmf5zxzgMaYQ3AOpEv27zITUHOD30nY1Dof6CMTjc2hWmzKyjtk5
         eM43LQbH0HnGlFFOAYbvu0XtH/sVMjR4qgxnlhQCUZdWiC0ZFDXULWOVMhjbDqBmLuF/
         j7zg==
X-Gm-Message-State: AOUpUlGppPhviVPf3dnzTzYKCmAJl/oU3RZBt5lQcnMXawDlpOghagCt
        Czvi9iEmUho2P0/OcKN+VWQeJtaN
X-Google-Smtp-Source: AAOMgpcW0zikbPwe8m/8vn7EBSGbCXIDMVUY+Ra+/ve2BGFmnSC0c7Yhkw7pYjY2v6+NOYCibnMG0w==
X-Received: by 2002:a17:902:b48c:: with SMTP id y12-v6mr17461770plr.97.1532450583413;
        Tue, 24 Jul 2018 09:43:03 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id j1-v6sm39410536pfk.125.2018.07.24.09.42.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 09:43:02 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/8] dt: bindings: tegra20-emc: Document interrupt property
Date:   Tue, 24 Jul 2018 19:42:14 +0300
Message-Id: <20180724164221.3307-2-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724164221.3307-1-digetx@gmail.com>
References: <20180724164221.3307-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EMC has a dedicated interrupt that is used to notify about completion of
HW operations. Document the interrupt property.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 .../devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt
index 4c33b29dc660..a6fe401d0d48 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt
@@ -10,6 +10,7 @@ Properties:
   and chosen using the ramcode board selector. If omitted, only one
   set of tables can be present and said tables will be used
   irrespective of ram-code configuration.
+- interrupts : Should contain EMC General interrupt.
 
 Child device nodes describe the memory settings for different configurations and clock rates.
 
@@ -20,6 +21,7 @@ Example:
 		#size-cells = < 0 >;
 		compatible = "nvidia,tegra20-emc";
 		reg = <0x7000f4000 0x200>;
+		interrupts = <0 78 0x04>;
 	}
 
 
-- 
2.18.0

