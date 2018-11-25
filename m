Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A318EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C742084E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:20:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71C742084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbeKZIMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 03:12:01 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39144 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbeKZIMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 03:12:00 -0500
Received: by mail-qt1-f195.google.com with SMTP id n21so15474267qtl.6;
        Sun, 25 Nov 2018 13:20:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=7SWfJkSURyZ6Qaf7kGWrWHvU0n7LYaHMjpAyucEttEY=;
        b=H7Ne1AmsVwo5B6DESs6XFI4oCfWEmkDcFaq0iX7GqQxLcJn401M7e+BMr77DiLb0C5
         mkRHwtd4+Tjo8yx//qOY4s3D0r7ZWhgD2PPJJ3Smfton7yly5X+6nOiq3dqsqWWJ8FXy
         ND45aK8qjHWjd5A/8xYa9oFyf2kVW8HoNBkkosTGROPKXAsqGItPgbvTaB6cuoYcX+TY
         R4TlYtj2p67/AvNSEywonnjDPjxpeLZ+P3awoWJZ8l0QzAijDGOmQc+I50b3e/9EPF+W
         bRS6LX4Ruj2oDspqov3uJZ55XAHHczVTLVCz8MoKqKooZywmivjfm1UNjg1nwYckoxXS
         9+Fw==
X-Gm-Message-State: AGRZ1gJkH7o+owiePzAEbQAR+OwX78wmQqD1JzVxPuqOksVXZeiuBU6K
        CKVjjfLlEUlkhVo7I26rlPdM+JrN
X-Google-Smtp-Source: AJdET5cSIJ4Rr5ULc8a6HD1/Tv3Nbc6oouMVL8Zsnm2IUNCoYlnpmE0pZ4SlKZ6t5Kz9NcCt42SsIQ==
X-Received: by 2002:ac8:3971:: with SMTP id t46mr22858418qtb.331.1543180800034;
        Sun, 25 Nov 2018 13:20:00 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id n71sm28469278qkh.59.2018.11.25.13.19.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 13:19:59 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Sun, 25 Nov 2018 19:19:53 -0200
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     Otavio Salvador <otavio@ossystems.com.br>,
        Fabio Berton <fabio.berton@ossystems.com.br>,
        devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 07/13] ARM: dts: rv1108: Fix the timer mask
Date:   Sun, 25 Nov 2018 19:19:01 -0200
Message-Id: <20181125211907.9895-7-otavio@ossystems.com.br>
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

As done in the Rockchip vendor tree and also on other
"arm,armv7-timer" instances, the correct GIC_CPU_MASK_SIMPLE mask
is 4 instead of 1.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
Signed-off-by: Fabio Berton <fabio.berton@ossystems.com.br>
---

 arch/arm/boot/dts/rv1108.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index c7a26f82655b..7b331766120d 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -71,8 +71,8 @@
 
 	timer {
 		compatible = "arm,armv7-timer";
-		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>,
-			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		clock-frequency = <24000000>;
 	};
 
-- 
2.19.1

