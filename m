Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BACDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF84F20856
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgFJH9Gq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733276AbeL1QSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 11:18:35 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34746 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbeL1QSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 11:18:34 -0500
Received: by mail-lf1-f67.google.com with SMTP id p6so14891249lfc.1;
        Fri, 28 Dec 2018 08:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=otuHlPExgvwh1mlMZzgUgoZRtdmzR3U/LJ6rxovEI4k=;
        b=AgFJH9GqPOnlCudwvqJ2wWGD5eaKd7XDH+yUqrlr2uPTSI5ttY9oCeU8/p+waF5VFF
         48pLfKJ5pfMIbTDWFR4YiS0+/Fz4wRADQ4mtNExI6fHQVbcTIvqEKft6W4wHcOeQxhLs
         JeSqO18I/EDm+zHSxYv9pqzTTe/oOSBBbC55NEi9T6cUI/t9jiTBpoZ9jh4zuOCvl8b0
         6vb/S0Xl6n9o3a9jjKZJ9JjbOkQurzuINPPfY4GQ7vX1O+lESmH6covdE/hd181lTwPS
         sTA04vNENZe7dsV9PtygE5IJ2f+49jIufCeEjEH+jloYb6EVKoAdVX9JkJnoc2MWl01A
         muzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=otuHlPExgvwh1mlMZzgUgoZRtdmzR3U/LJ6rxovEI4k=;
        b=I+wtT0Us3geU2ThZGhpkQPV0uYn51LThAbnZAV6qVzrtyOTiTUKFS1DKlPuNXWhMAT
         LWxrnHZMZB7MVi2mHjwkq9PR2bhTLT+HbpOwPosPGSgPWjf05W6PbAHbnf8UwwG1JAGM
         KwoiNjMeFiDhUvMUiRmNgG8O98us1dwjQeKP5H36q+y8cs3PS+41NKJ/0ZbkAA8VAdnr
         T9UCYeF5Pt5Ijs8LbjN0JVu13K4Mm9V/LGFz287vE/n+0/ZA/OZ0p4Ip95w48S1Mff6G
         r//b5lTdQP8IALNeFmYgBbvOFSvc+6LQKIygnhidmLCBdE+BuzmwtF4q1Z5rdxYDdai/
         IpHw==
X-Gm-Message-State: AA+aEWYz0dTxh1YcqbUpV+d0eyGFh+4IVXZ6SpNntrhWbBzcd2Ipm5xk
        1YnoOauwKVvjDF4BCWT6V7I=
X-Google-Smtp-Source: AFSGD/VAaDu5yC4knlwspbo7uIKQpQuFB3SeF5DYHpLGiiBQp7pVbb02sHPiA3WtFhV2XKVUM+/4cQ==
X-Received: by 2002:a19:d145:: with SMTP id i66mr15013769lfg.97.1546013912224;
        Fri, 28 Dec 2018 08:18:32 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:7146:fd07:48ff:9665])
        by smtp.googlemail.com with ESMTPSA id r4sm8136502lfe.60.2018.12.28.08.18.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 08:18:31 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     krzk@kernel.org
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, pawel.mikolaj.chmiel@gmail.com,
        xc-racer2@live.ca, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] ARM: dts: s5pv210: Use correct fimd variant
Date:   Fri, 28 Dec 2018 17:18:14 +0100
Message-Id: <20181228161819.18931-2-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181228161819.18931-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181228161819.18931-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we have separate compatible for our SOC,
let's use it rather using one from exynos4210.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 arch/arm/boot/dts/s5pv210.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
index 75f454a210d6..3d6e5ad1ea35 100644
--- a/arch/arm/boot/dts/s5pv210.dtsi
+++ b/arch/arm/boot/dts/s5pv210.dtsi
@@ -511,7 +511,7 @@
 		};
 
 		fimd: fimd@f8000000 {
-			compatible = "samsung,exynos4210-fimd";
+			compatible = "samsung,s5pv210-fimd";
 			interrupt-parent = <&vic2>;
 			reg = <0xf8000000 0x20000>;
 			interrupt-names = "fifo", "vsync", "lcd_sys";
-- 
2.17.1

