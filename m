Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A647C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C533820879
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="nq6B7Xb4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C533820879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=essensium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbeLKPs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:48:56 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37731 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728410AbeLKPst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:48:49 -0500
Received: by mail-ed1-f66.google.com with SMTP id h15so12931077edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 07:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=FOi0pvFwTKOHTkINiTQH+JjJ0kbelvTenkp9OkIJ+tA=;
        b=nq6B7Xb4csPokr9L2KQxHXOnGkeEGDeXzBuO2A3r78X3VOPe2FnlMeMXpkgGdtmf8Z
         wnxiMA0V1L1iFjGABe7dZN827IS9cNlSiss6/t+pUUXuIvXFxG5QhW+qpFM+/PYMAngC
         xGYdgv392KQw++BvrqsnHI0r+cLMtBvSNjQf7tVW25qjjBuDznwe9gijwNCcxk1XQZd0
         /9iWzOglsuK9t9jpgtRp87lRD34P8/SUU2UOKkbE+iIDqFLgNcuyoAPjje3xYyguZVhI
         PKhFwASjfp9r7e8LPf2QIYRQJOLs0xxGPYFC+p9L0L4rDGawEOPBETjWH6igyYEXPBjU
         ezpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FOi0pvFwTKOHTkINiTQH+JjJ0kbelvTenkp9OkIJ+tA=;
        b=e7+hNJL5PYKYB/DXRsg0+AYR/9y0SepO9jb7cpPe3DVTZy7+hIWzPGWyEe4E5yjyl6
         U50fDJc7I3DmI8wkbKyUrzxTO+Rgqh3GsvgmAd+4HQyIw7bL/AhVin56FEk2JUzQF8j4
         YtwiWkkSSixeQNAj5hQkq8bJJV0f0/72zmIqKNd04r1mfCkCNa5/CydUKrJyD1i2651f
         BJ6xaAUpRvhm+Iq7CQlg7K2tAF41Ndu8VuYsZFaDMWQlSqbW0RvtjEbEnZEzl/rVE4zp
         gsfWndXfetHZKZw27JjvytgjSqeDMr+1b7+4d4l7piYO32cbfUE/g6BUetNXDWvXuwm3
         gkRg==
X-Gm-Message-State: AA+aEWYFdd9yr3URe997P67V1ndJB5Bl/PJ79w9b3Zh0EV3jJUfG52hE
        LUjZ5xKeDFfYYbPSfO00Itun7g==
X-Google-Smtp-Source: AFSGD/U26UrBPGK9B7KkVsfJOdOD99WXfsHOsGKx6Tg4gr3GXrBMU4ls1jl369WYO329l1Q31nlp8A==
X-Received: by 2002:a50:ac81:: with SMTP id x1mr15906450edc.71.1544543326940;
        Tue, 11 Dec 2018 07:48:46 -0800 (PST)
Received: from ph-ThinkPad-E560.local.ess-mail.com (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
        by smtp.gmail.com with ESMTPSA id l51sm4264547edb.36.2018.12.11.07.48.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 07:48:46 -0800 (PST)
From:   Patrick Havelange <patrick.havelange@essensium.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org
Cc:     arnout.vandecappelle@essensium.com,
        patrick.havelange@essensium.com, matthew.weber@rockwellcollins.com
Subject: [PATCH] ARM: dts: ls1021a: Add memory controller
Date:   Tue, 11 Dec 2018 16:48:34 +0100
Message-Id: <20181211154834.4489-1-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LS1021A has a memory controller that supports EDAC. This commit
adds an entry for it.

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index bdd6e66a79ad..a877c32bff20 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -125,6 +125,13 @@
 		interrupt-parent = <&gic>;
 		ranges;
 
+		ddr: memory-controller@1080000 {
+			compatible = "fsl,qoriq-memory-controller";
+			reg = <0x0 0x1080000 0x0 0x1000>;
+			interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
+			big-endian;
+		};
+
 		gic: interrupt-controller@1400000 {
 			compatible = "arm,gic-400", "arm,cortex-a7-gic";
 			#interrupt-cells = <3>;
-- 
2.17.1

