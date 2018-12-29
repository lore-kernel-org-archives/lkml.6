Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E641BC43444
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 13:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACDFC20828
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 13:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyPASDp6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbeL2Ndz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 08:33:55 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37823 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeL2Ndn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 08:33:43 -0500
Received: by mail-ed1-f66.google.com with SMTP id h15so19467997edb.4;
        Sat, 29 Dec 2018 05:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1wglHSkxyGTBpW71D3d8wcxzMqGZqy9iDQdsYiDzonE=;
        b=CyPASDp6H+wFEkaEphC6t5MubhljNf1tI9HGfb+FEe+ajudGKBUipMWDr2FVNdnM2k
         kZegCxlOc1PlDILEIGd5YzcrBZm5+Cc2ix+J3xMTEqBkptzzcrv1u0qEWKmnPZE7/l1Q
         Dqj+8lS80rbzD4KPTfPDSxYDIkvG+3/SSMi0hmVtn/BIx9Ll5TyMBLXNO+wu0nlpQQtt
         vM4IPfiqTGeWxZ7wHwomYW/+LVTAzOeyjATN9lZAuWlkGSLOLUan6Fn0439Y7mkkW3gt
         lkPyj8Qn+x2lGBt5GkH8P0nMeIJCOlQ1wxw77h01KzNfaWE5ULQiJ/0E9I9Xgf+8PCYX
         vmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1wglHSkxyGTBpW71D3d8wcxzMqGZqy9iDQdsYiDzonE=;
        b=jR00jcLBqtLmy3p5QEkXa7ycDqU/P3gPt75UCG+SVSpBj8BZIpYWQre/iXNxDHB9wA
         5io2gLnyoXvwut9EDW1xAiy8AWlvDjLyNZfUG6+3OUugmGKIROEH/IuAY1YnUu/BTABH
         cHqVNfZVmaRXLyJDwzyxEvt8rajUMqW64ma8/JOEiPzewnWHOn9slRpWQ/D1XNstHm6M
         gQxU5VoToh5Ct6Xew9cdSdtM9IEHv0yA8F3RyTT0qjdyybF2U49j0g9Q9WQQ3zyF2Ici
         KSs71fgaCn/8E3lMGG3S65orfADBOGcTtxN1Agi/EvyFwl6zyNrjp/lPYvkkyf08Pjj4
         4i4g==
X-Gm-Message-State: AA+aEWbP9p2zTAbhycxcDdPWuBOc0B5yPxWK4wCyFoJ6bOcBqRf89nmn
        prrN3O8jpA185I1kXPofhMQ=
X-Google-Smtp-Source: AFSGD/VnaoatO3KAsK2Iay7QYMtSvZSGSJskN89P8E+VTGmuBmweU4vlYmtyd9hhXuFucTLu/GVJJQ==
X-Received: by 2002:a17:906:6c97:: with SMTP id s23-v6mr21486841ejr.79.1546090421193;
        Sat, 29 Dec 2018 05:33:41 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id d7-v6sm8023063ejx.68.2018.12.29.05.33.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Dec 2018 05:33:40 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, robh+dt@kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v2 7/7] ARM: dts: rockchip: rk3066a-mk808: enable vop0 and hdmi nodes
Date:   Sat, 29 Dec 2018 14:33:18 +0100
Message-Id: <20181229133318.18128-8-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181229133318.18128-1-jbx6244@gmail.com>
References: <20181229133318.18128-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables the vop0 and hdmi nodes
for a MK808 with rk3066 processor.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a-mk808.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a-mk808.dts b/arch/arm/boot/dts/rk3066a-mk808.dts
index b6a8a82d2..14a560598 100644
--- a/arch/arm/boot/dts/rk3066a-mk808.dts
+++ b/arch/arm/boot/dts/rk3066a-mk808.dts
@@ -91,6 +91,14 @@
 	};
 };
 
+&hdmi {
+	status = "okay";
+};
+
+&hdmi_in_vop1 {
+	status = "disabled";
+};
+
 &mmc0 {
 	bus-width = <4>;
 	cap-mmc-highspeed;
@@ -151,6 +159,10 @@
 	status = "okay";
 };
 
+&vop0 {
+	status = "okay";
+};
+
 &wdt {
 	status = "okay";
 };
-- 
2.11.0

