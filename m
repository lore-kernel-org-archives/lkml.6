Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38437ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D732B206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r4q6L4UA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D732B206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390347AbeIUQOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:14:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39545 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389264AbeIUQOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 12:14:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id s14-v6so12312869wrw.6;
        Fri, 21 Sep 2018 03:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TqMEwFyf4ZquG+hsptIWBhDxrXZUsJ1QshY0+jeRlTs=;
        b=r4q6L4UAVTMoK2ERprIkcNWzc4/0KqTOFEZvr+NPV0vKJ5kdPAV92sYMY8K6zwyfaM
         Vu0GgNChLOt9NLrg8xuuzngh3Gt4/XaOIxrCHC7kQ9ctqpgcZuqPja8/PIciYnkh1pBw
         98xWEBXKzwX6jFcSJkjR1X0OwA9f1JXVQzz+DpuguHWYZtatBjC6cyFi6JfvnwTdZTzd
         j5rtxMIy5rBODGNozk0Hy3h8n2OjWQNlnaXmp1ECeYoHjKE9T3rbzWuAriwdX1rniyFe
         qW/LRBercTZ+H7SyE7HcdM2l/1hH4d04hEyB19O3QcFr5ntnuStRqiTrnyNmCwR/cjm2
         lACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TqMEwFyf4ZquG+hsptIWBhDxrXZUsJ1QshY0+jeRlTs=;
        b=Nskbp4KV4DaQPZtGOLD45EN/WIHYuwuyuyyWtqL6pc55xt2sSZzOYJFwiDgRyli3tu
         SfzDp0JT2XwPavBxDsDOuUo+fUwlIMYfWqM2MFD/OYAPCWDsrkSVy/FQsO0r4uMtYoke
         iUv888SBT4VEbHcbmIvJ8ss+WgAhiYrwNllCSBc45hr2T4fYcEMKxjDJ37mZqYrmTYRH
         izuqVNfbwM1tvE4gDHSUapd7t2Om01kjnrVkszT0tQVEFX0FPgaz4RanybW8aHFcZVY0
         Ro4v1HmMoQgLwBbUuZRf073DR1P0cPcjVoqpZKjBYNqNzWrdATrQHlIxvCJWfXQ+2TIJ
         ckog==
X-Gm-Message-State: APzg51AEvun/x3BqM0JBhZCsD1tGVU55KcXZdMyl/CtmzyftM2M/hB+H
        R0paejCYIZ+ihEqfZp2cigE=
X-Google-Smtp-Source: ANB0VdYesVJtYnC4uh/aFTCTBIGLrHzLUjWJ7LVm8+nC4THhGRtNJ4nEjovV0fzupudGiy2+XTEB7Q==
X-Received: by 2002:adf:ea92:: with SMTP id s18-v6mr36031329wrm.284.1537525550020;
        Fri, 21 Sep 2018 03:25:50 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id d22-v6sm45651320wra.80.2018.09.21.03.25.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 03:25:49 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] dt-bindings: tegra186-pmc: Add interrupt controller properties
Date:   Fri, 21 Sep 2018 12:25:38 +0200
Message-Id: <20180921102546.12745-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180921102546.12745-1-thierry.reding@gmail.com>
References: <20180921102546.12745-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The PMC can be a top-level interrupt controller that provides the top-
level controls for wake events. Add optional properties to mark the PMC
as interrupt controller.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt      | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt
index c9fd6d1de57e..2d89cdc39eb0 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt
@@ -15,6 +15,9 @@ Required properties:
 
 Optional properties:
 - nvidia,invert-interrupt: If present, inverts the PMU interrupt signal.
+- interrupt-controller: Identifies the node as an interrupt controller.
+- #interrupt-cells: Specifies the number of cells needed to encode an
+  interrupt source. The value must be 2.
 
 Example:
 
-- 
2.19.0

