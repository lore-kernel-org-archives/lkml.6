Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AB3C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E3320846
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="xEBZc4mz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E3320846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754567AbeFUHhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 03:37:48 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51217 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754485AbeFUHhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 03:37:19 -0400
Received: by mail-wm0-f66.google.com with SMTP id r15-v6so3430879wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 00:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1tQm8IcxQv2/OGZeQfLh3x1BtwKoygdYzD3R6sEBvso=;
        b=xEBZc4mzRvTbtRlENCG6JN1/FfYn+Swb4E24MzriCUkUwfsMDQBSiwy8vOZNm8BUsg
         1IKzhAPzeuAh9PFo+C/B2CqHPG1VLMJVcwFoY0/AxpqBU05/spiCWsXGnTun0tJWSUMk
         lR5jIrMKNlBihuJp1cg6RXy5iicfQu59CYEaXlmRf/QUMguvq8AY5ysCnL479wSjRPvK
         pyq+G+wgujyjD9tRSVQQQVavkTvE9CmKBOSFq558TF8zBr7LsN440DHo10ZwKmtF044l
         C3D7J8xAKB9MxKxblxQ6JCYxz9tnmmU7td6//p7AzpUo90o9eDaOIYlhOfY/oOovStoC
         Vu6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1tQm8IcxQv2/OGZeQfLh3x1BtwKoygdYzD3R6sEBvso=;
        b=JC3bW5WsdyvfBCAz4Z99X8qST55/MELkJJ+xpfbSBOavpeksNrIk+iainbOlg9FOC8
         u95g5nVit2DeKvTV0+eA5jjKlnm2UOniLOuiiqeqxKlCbt5U3q3Zjqf2uaoCv/n9q+1w
         fioTw61VcfDuWUkkm3LRGbMvA5mJ4YWbjW42g2B+GUER5Zbb+tQAAPUfMXD2Fv0/CfYA
         FyumN+icbIjG/I+rQZYwt2jm4Z0acM27Vrgi6c0W8qavnbprkBRs/fqcfeh82RJ5wXgI
         hD82eGsUHAdWfbfYH4TwTc+SVMJKRNctKQsXNQz/S0ga6EsL9AkoqhGslXH1+3rf0ppI
         tzmw==
X-Gm-Message-State: APt69E00zmd5htovq59HFeyFOXqxkka4QOvJvgpGkCaohfjGGGpxauzE
        WGvJEfieNsuuSzqZQxTHO/2W9A==
X-Google-Smtp-Source: ADUXVKKHzITr7Y/SJ09+UFPhB3fb+9ifR29sZsATnhMyt724YoAbZj72kKOpPNeXiaIjwYhjgmgC8g==
X-Received: by 2002:a1c:4adb:: with SMTP id n88-v6mr4185483wmi.121.1529566637619;
        Thu, 21 Jun 2018 00:37:17 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id l7-v6sm767635wmh.1.2018.06.21.00.37.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 00:37:17 -0700 (PDT)
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
Subject: [PATCH v7 4/4] ARM: davinci: dts: add a reset control to the dsp node
Date:   Thu, 21 Jun 2018 09:37:06 +0200
Message-Id: <20180621073706.22812-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180621073706.22812-1-brgl@bgdev.pl>
References: <20180621073706.22812-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The davinci-rproc driver will soon use the reset framework. Add the
resets property to the dsp node in da850.dtsi.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/boot/dts/da850.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 1bc0e4bc0697..225e0cf4b7bc 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -118,6 +118,7 @@
 		interrupt-parent = <&intc>;
 		interrupts = <28>;
 		clocks = <&psc0 15>;
+		resets = <&psc0 15>;
 		status = "disabled";
 	};
 	soc@1c00000 {
-- 
2.17.1

