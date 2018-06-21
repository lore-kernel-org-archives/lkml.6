Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB4EC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8468920846
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="hNTUnNAY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8468920846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754529AbeFUHhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 03:37:21 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38846 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754434AbeFUHhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 03:37:16 -0400
Received: by mail-wm0-f67.google.com with SMTP id 69-v6so3967918wmf.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 00:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EJfqI7MXPfwK/Lkh5EsCdmacNmrknbn9kBUss39RD7I=;
        b=hNTUnNAYvCVo2R3SFK83NXt3nsETEohIBLc1JYiqEqNMex/YAQqP2mpt9pwgPfidv5
         tO0dqa+5ytH8p/kdyZYWUpV16ow4b0kZXDbKp0YPGEm3HBFWMfAAqUcUctYM6r9YoK2Z
         JmqPw83dpyWsucVz6ciTw+kmJgqrNUjnwP4yD+pHapRQT6SwYyocyPZGHGENY6uPgNVJ
         rJ6Z2er8/DbQz0AlJBnWguARp2ib00ZKtabft7jRPRWN30uS8jTkgnVyWFz7NNU6Jprp
         g+TXsjsKwPABAMmKd9rs9tLDVdCUMnLDmsMbe+IkKZl0OFv8hPwmE2XbLLPrWU+UwBGQ
         ztBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EJfqI7MXPfwK/Lkh5EsCdmacNmrknbn9kBUss39RD7I=;
        b=F2yrvypbDouLiFMM99UmY8uC6nHy+scu9dTuVmDM6OOHP9jZlMuTbddZVvyqu6C23X
         7x0NLsLY0hvJ+NjFwt2xeAPl9lp3i5dLosH2HQd4gEfkzuxD4CJpH34Xw94X0+HLYMZ2
         VmObvXbCsrYfqe/lHdYeZOofBLT4apwkuSBW9FceWXfEG/uUP/5htdlW76ddSpqtEY+4
         EwI1wI9beBCTn255r9xjlL7FRw/Vb12Ktv5E0FffbjpjPot/PR8CbzhLwOpjKLZ/wuhr
         DIRCDK+ZTxGE1OL5WUU9LRYs6uAhM5Zeman+cBeJAeukZGnjH7YgPMZcj28csPP3b4yF
         tCxA==
X-Gm-Message-State: APt69E36NJ+yehg8R2YaygKsABGmaQSb1+ufrce+fk+uuLpcMr9T5JaH
        +2WuhGQPTJeYFMTq2c3TQMO06Q==
X-Google-Smtp-Source: ADUXVKKaZFdBkgmgZAgitWY575R0u7K3jGZFSdHZzn5a2J5I2mnHTY2hApqBdlbHez/Q6rZVZtt/QQ==
X-Received: by 2002:a1c:b80a:: with SMTP id i10-v6mr4354203wmf.123.1529566635100;
        Thu, 21 Jun 2018 00:37:15 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id l7-v6sm767635wmh.1.2018.06.21.00.37.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 00:37:14 -0700 (PDT)
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
Subject: [PATCH v7 2/4] clk: davinci: kill davinci_clk_reset_assert/deassert()
Date:   Thu, 21 Jun 2018 09:37:04 +0200
Message-Id: <20180621073706.22812-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180621073706.22812-1-brgl@bgdev.pl>
References: <20180621073706.22812-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This code is no longer used. Remove it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 arch/arm/mach-davinci/include/mach/clock.h | 21 ---------------------
 drivers/clk/davinci/psc.c                  | 18 ------------------
 2 files changed, 39 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/include/mach/clock.h

diff --git a/arch/arm/mach-davinci/include/mach/clock.h b/arch/arm/mach-davinci/include/mach/clock.h
deleted file mode 100644
index 42ed4f2f5ce4..000000000000
--- a/arch/arm/mach-davinci/include/mach/clock.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * arch/arm/mach-davinci/include/mach/clock.h
- *
- * Clock control driver for DaVinci - header file
- *
- * Authors: Vladimir Barinov <source@mvista.com>
- *
- * 2007 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-#ifndef __ASM_ARCH_DAVINCI_CLOCK_H
-#define __ASM_ARCH_DAVINCI_CLOCK_H
-
-struct clk;
-
-int davinci_clk_reset_assert(struct clk *c);
-int davinci_clk_reset_deassert(struct clk *c);
-
-#endif
diff --git a/drivers/clk/davinci/psc.c b/drivers/clk/davinci/psc.c
index fffbed5e263b..5b69e24a224f 100644
--- a/drivers/clk/davinci/psc.c
+++ b/drivers/clk/davinci/psc.c
@@ -303,24 +303,6 @@ static int davinci_lpsc_clk_reset(struct clk *clk, bool reset)
 	return 0;
 }
 
-/*
- * REVISIT: These exported functions can be removed after a non-DT lookup is
- * added to the reset controller framework and the davinci-rproc driver is
- * updated to use the generic reset controller framework.
- */
-
-int davinci_clk_reset_assert(struct clk *clk)
-{
-	return davinci_lpsc_clk_reset(clk, true);
-}
-EXPORT_SYMBOL(davinci_clk_reset_assert);
-
-int davinci_clk_reset_deassert(struct clk *clk)
-{
-	return davinci_lpsc_clk_reset(clk, false);
-}
-EXPORT_SYMBOL(davinci_clk_reset_deassert);
-
 static int davinci_psc_reset_assert(struct reset_controller_dev *rcdev,
 				    unsigned long id)
 {
-- 
2.17.1

