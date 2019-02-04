Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0034BC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C27C62176F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="mHzJ9Mt2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbfBDRSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 12:18:13 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46261 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728914AbfBDRSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 12:18:10 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so627279wrt.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 09:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yFpS5DDDhLyl9bQz2zuBoJHX/scehbNVUdh3+QSm0uc=;
        b=mHzJ9Mt23GsbDw0sKI5+ezDtdS4AkNnYBIyoVSB0ETguUWETQgmLTfy8enaI+5E7r+
         jJRPCQ4EZnORxwMSNVMfsW69UEbw6FFL4TUBBfJFXQ2LvCNgTwWidSemMrm+FFKOPUPK
         iraBKtjBU+nvnjlA/OuaUVxM/E76oiJUY5gAjfWm6RZ6rnha8QEdOKdqjFcWezk2YlVQ
         PdPn/HM2lQ+1JtC2qVgYCaP14MN3PkiZdjCb2LqWZQ2opiLfx53kY+kSjvGwWoeNYg7W
         YQ7YREJ3s7q5eZX3L0R343ARndFt+RAX7F6ybyad61hWnDMphSGe0jzvmEiD4R4nhn81
         NZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yFpS5DDDhLyl9bQz2zuBoJHX/scehbNVUdh3+QSm0uc=;
        b=D6Tp/ZJ6+tvI5tlfpMgFtvMsficQQNavDtBKRSzx5mDC3er1XdJIK09NpmRJlpH2P+
         Q419U/kqEiG6dwF7p84F3ncf7o/K42hoRyhya6auCIvcfbLvxC4R1Tl34pfrj/xfmzJ6
         ZRlvYHJB/6r8Y7oH+oTVANLoFpiA5Wi2czJQXN2Pmume+DQ5DdcmJK1bGtSA9dzFkvsF
         3Hdz5b8Gw7hKh40SqchRAi8XUsprK1XCn24qZdbcTnMsqthrVl+5SKM9S6Ye8GWcrYFA
         QrsF1L+RMH+VaJ5j0HZ/uS3GtAiyaJ3Zj8y0u42bTX4o08Ap8bZ+nE3JjesdHSgXEOKj
         J41A==
X-Gm-Message-State: AHQUAua4dq9yQLkdApD5TZmtZM0qzmip6M5hQF46bYXeclvOzRMrSAeL
        7t64MxWEnPJ3KhF5pStc98ygBw==
X-Google-Smtp-Source: AHgI3Ia02xaYGccohww9tvSMAvuI8+c4UZjzMOGlLH+nv0yHbnp5Y9YEamYZ5vI8iJ9yS47e8tEDBg==
X-Received: by 2002:adf:c505:: with SMTP id q5mr348997wrf.84.1549300688052;
        Mon, 04 Feb 2019 09:18:08 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-8-223.w90-86.abo.wanadoo.fr. [90.86.125.223])
        by smtp.gmail.com with ESMTPSA id q9sm11197506wrv.26.2019.02.04.09.18.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 09:18:07 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 01/12] ARM: dts: da850: fix interrupt numbers for clocksource
Date:   Mon,  4 Feb 2019 18:17:46 +0100
Message-Id: <20190204171757.32073-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204171757.32073-1-brgl@bgdev.pl>
References: <20190204171757.32073-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The timer interrupts specified in commit 3652e2741f42 ("ARM: dts:
da850: Add clocks") are wrong but since the current timer code
hard-codes them, the bug was never spotted.

This patch must go into stable since, once we introduce a proper
clocksource driver, devices with buggy device tree will stop booting.

Fixes: 3652e2741f42 ("ARM: dts: da850: Add clocks")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 47aa53ba6b92..559659b399d0 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -476,7 +476,7 @@
 		clocksource: timer@20000 {
 			compatible = "ti,da830-timer";
 			reg = <0x20000 0x1000>;
-			interrupts = <12>, <13>;
+			interrupts = <21>, <22>;
 			interrupt-names = "tint12", "tint34";
 			clocks = <&pll0_auxclk>;
 		};
-- 
2.20.1

