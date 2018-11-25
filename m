Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010F8C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C322A20855
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:20:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C322A20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbeKZIM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 03:12:27 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34533 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbeKZIM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 03:12:26 -0500
Received: by mail-qk1-f196.google.com with SMTP id a132so11207082qkg.1;
        Sun, 25 Nov 2018 13:20:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=bup91yDRXOC8SzCQPUHpgYvuVu+1L3rRb7v7DMoPavc=;
        b=gaR1kwvfKcd5vU7YZj0X/YG8keOGUtVm3F0e8LIfNF9xvpJy77/d4TwKowDgteGr/K
         TWGxsSN+STx4KUzXN4MY6TS/0u1B7SteJPZM5+DtQ0f9EX/xZu4ma2/WTf8Uz1JoQF2L
         j7pDDi8kHBhtesx4Y2jRKLDYHv/m/cWWxiTlR33WVlbFOR1S+X/FnjRJ1FFGR7r7yibY
         AporVfVuYukkact8HbP8Tyd+U7RVGFi3DeTIPKW41YY4ZYEKs64TZBMCETHwjKTQaA5Y
         7U8n8hmjao4pvLL+gyC0h0G8Gendz/F5m8/tmT6k8MvWqm0ZK/aw5wKzUZHUq0MSvAKi
         az9Q==
X-Gm-Message-State: AA+aEWZ0a2lqmLf3lUaUZK6Vx7r35dFbZolRCTFmQZQbQ3s02+fTw0ax
        NE10aK0S8mlqS1/jCLFK6LbcJqc9
X-Google-Smtp-Source: AFSGD/WjUeOhJqN7McOiIVsb+gcNYtv/IoEfuxJQgDTfZR9zoty7Yn8gp06HH66azZ6S0sHcXv/N4g==
X-Received: by 2002:a37:688c:: with SMTP id d134mr22696183qkc.57.1543180826716;
        Sun, 25 Nov 2018 13:20:26 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id c49sm21741197qtc.94.2018.11.25.13.20.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 13:20:26 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Sun, 25 Nov 2018 19:20:20 -0200
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     Otavio Salvador <otavio@ossystems.com.br>,
        devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 11/13] ARM: dts: rv1108: Add internal timer support
Date:   Sun, 25 Nov 2018 19:19:05 -0200
Message-Id: <20181125211907.9895-11-otavio@ossystems.com.br>
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

Add support for the internal timer peripheral on RV1108.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 arch/arm/boot/dts/rv1108.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 7ef6d965871c..42566adadc83 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -291,6 +291,14 @@
 		};
 	};
 
+	timer: timer@10350000 {
+		compatible = "rockchip,rv1108-timer", "rockchip,rk3288-timer";
+		reg = <0x10350000 0x20>;
+		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&xin24m>, <&cru PCLK_TIMER>;
+		clock-names = "timer", "pclk";
+	};
+
 	watchdog: wdt@10360000 {
 		compatible = "snps,dw-wdt";
 		reg = <0x10360000 0x100>;
-- 
2.19.1

