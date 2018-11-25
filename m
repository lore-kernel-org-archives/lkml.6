Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27117C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECBA42082F
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECBA42082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbeKZIMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 03:12:33 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35262 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbeKZIMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 03:12:33 -0500
Received: by mail-qt1-f193.google.com with SMTP id v11so15478350qtc.2;
        Sun, 25 Nov 2018 13:20:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=ZDypF2pq0BfQj2VKHtaavUm6fErKIQMxhSKq0uDr+7A=;
        b=iwGJj17gciNNPbDpCU2j32z3KVjyNw8p+9C6q38pm1ugkgSoFcuFEC7RDtLMN8KZeb
         gzF0WiLKGmdjtk50WaT/L0x4d3kbO5UE8DaXg7cb4pRFuT/YRI4YzQ+9R1M4ZEXThIeJ
         KFGEsMRxwL5vrybhCP19ICEqlO4QFCQYRtgaRvi1jxmiWqbbVM5De0Qw/lv8VBrY8L0v
         4MmtrWjTK6Anor0KpJWkzIr+jI0dz2+sVb77LRn5dbV+CWpXE0+vVzfl11VzrlbJOpWf
         /CBjKnLg5fQNTJ0CjDDEY12HvT5VemIvyBrpudnOI/eKUPRmGwtIrbC4hrluBxXO+04Z
         S73w==
X-Gm-Message-State: AA+aEWbTJms5s7wifG1C/pU75mi+nZ3usrmjzVGEVwRfXXaHVK4clS/1
        vi+WR4yZT9st88lN+nKvmesgz6ts
X-Google-Smtp-Source: AFSGD/UKNT/31P8C5rOjcI3MCsK8x9lu99rEGVQmp3O6diEAHNafuE+AeofeOL18zPZDBruObHguXg==
X-Received: by 2002:a0c:c2ce:: with SMTP id c14mr23989867qvi.7.1543180833092;
        Sun, 25 Nov 2018 13:20:33 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id o48sm37912198qtb.87.2018.11.25.13.20.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 13:20:32 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Sun, 25 Nov 2018 19:20:27 -0200
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     Otavio Salvador <otavio@ossystems.com.br>,
        devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 12/13] ARM: dts: rv1108: Pass the 'arm,cpu-registers-not-fw-configured' property
Date:   Sun, 25 Nov 2018 19:19:06 -0200
Message-Id: <20181125211907.9895-12-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181125211907.9895-1-otavio@ossystems.com.br>
References: <20181125211907.9895-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since firmware does not initialize  any of the generic timer CPU
registers pass the 'arm,cpu-registers-not-fw-configured' property as
suggested in Documentation/devicetree/bindings/timer/arm,arch_timer.txt.

This also aligns with other Rockchip SoC dtsi files.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 arch/arm/boot/dts/rv1108.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 42566adadc83..d96c58728b28 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -71,6 +71,7 @@
 
 	timer {
 		compatible = "arm,armv7-timer";
+		arm,cpu-registers-not-fw-configured;
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
 			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		clock-frequency = <24000000>;
-- 
2.19.1

