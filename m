Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE166C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A110A20846
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ZJHJj8ie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A110A20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754545AbeFUHhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 03:37:23 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34308 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754308AbeFUHhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 03:37:17 -0400
Received: by mail-wr0-f194.google.com with SMTP id a12-v6so2048643wro.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 00:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vbMoxrYqiT5PHCCztYs5UuxfSxJ8o6V2VTsEdyjF2EI=;
        b=ZJHJj8ienokrj+iGcpNw5ekkDQct8esF3RmWYxD1XC8uROA3ssQR5CqW2tc1qRvvNW
         O22n4+6ALDQ17JwxPOeW+yFoYavdWSbqX23H/3byG0dTrO4kZTcUdiYY3WAZd659GFZ7
         ckV8vyFOIhRqApRnkV6pvDAiMMQyM1Y6FUPRQ56pkzAyDwD4BVdnwAQheDbRZRTok4WI
         cXePt7L2Ra/iBkLO2WdSVqOcQmO0f//AmwRS872cSBksf6kOQ9EpRmIuA13v/2G6kzVr
         BbmAYzVFVO8jXF5bBwgwbWnN03O4zerlIT8WuaF8eHZc29NBQxHmfiOvtoqxN6iLEgTf
         uMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vbMoxrYqiT5PHCCztYs5UuxfSxJ8o6V2VTsEdyjF2EI=;
        b=myg3IxUSgc80vBkaxVTKUjm6aj8LX423S3KAuzSueH0+3y2RgpPBHZK4PR7Nu/wWz6
         froWCgVsZS/iLqF9DkyYIL8XprZcQRw6F9ZOShXVb7U7QbpCESnBcHF+D4NlWyygRACT
         m0mBNDh8pJ6zAsCa6Mt+i/NH5IQzXjjpcg53Wlzl1kOQVq7lm2YzRdhGCtudUHp3BIpq
         v61IX0S4rWVbsO8ObDIFICDY2ldMfrSKdzbMmcb9ZNDYJvcaublouybyGKNG5LfGu7sr
         sIloZ87mLedgQtvAKs4Dg/NGjfEnTPKL49B1KIe25ZuY8ahjeiK1qqt3MkaLXdY7gEQ0
         tkNw==
X-Gm-Message-State: APt69E1gnUwpiheZ2gtWhr2GkiBp7LqO1fmuWBzxbxwG2blw3cCejReY
        Cf5BfOT/ZyPdc0fPRaktZ4fyYw==
X-Google-Smtp-Source: ADUXVKI7RjD9BmYQ15ZiJmT+Rp5/lizaSEm0VZVTpVEqkmtmIpuyFYavJdW98ayQq+YjyNZ0NOS4pQ==
X-Received: by 2002:adf:8b01:: with SMTP id n1-v6mr21306563wra.282.1529566636323;
        Thu, 21 Jun 2018 00:37:16 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id l7-v6sm767635wmh.1.2018.06.21.00.37.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 00:37:15 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v7 3/4] ARM: davinci: dts: make psc0 a reset provider
Date:   Thu, 21 Jun 2018 09:37:05 +0200
Message-Id: <20180621073706.22812-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180621073706.22812-1-brgl@bgdev.pl>
References: <20180621073706.22812-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The psc driver registers with the reset framework as a provider. Add
the #reset-cells property to the psc0 node.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/boot/dts/da850.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 3fc8b8fd816e..1bc0e4bc0697 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -132,6 +132,7 @@
 			compatible = "ti,da850-psc0";
 			reg = <0x10000 0x1000>;
 			#clock-cells = <1>;
+			#reset-cells = <1>;
 			#power-domain-cells = <1>;
 			clocks = <&pll0_sysclk 1>, <&pll0_sysclk 2>,
 				 <&pll0_sysclk 4>, <&pll0_sysclk 6>,
-- 
2.17.1

