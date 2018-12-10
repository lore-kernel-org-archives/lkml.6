Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FD5C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3D820672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="c3EZTtYw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA3D820672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729555AbeLJTqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:46:07 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40703 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728391AbeLJTqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:46:05 -0500
Received: by mail-wm1-f67.google.com with SMTP id q26so12522038wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 11:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9sGcynHRDayWT0bdEoEQXYHjCHQPwGXVBs+kG3yXWuo=;
        b=c3EZTtYwtBQxZl3VbklgD5HZtnwUEAu48aEHItHudHijdbLgQU8FI9pEeU/2dIBweD
         IZ3uuuO/9lEGUDf6E2JmOak1Fsx+PUueRb935pwOmUQGioGVivxfrFe+Crm4u2ePGTs0
         y98nlbMKroMUgjufy3gO7pr4Sv9T9vN/Xhp/KvMOb8bJSwMR5bffW3w2Kw1OZKmFcRet
         5Nn1khAX0QNzORkEcBIEqWXlEFgVrAiPK8aH4SfJnNIHKu8ZEsAAewhdfr+zkQ5wknHH
         YV9xA9MavholJKPcMGu5F/y7jsB6Ld1CRaL24Avnd79YijP3YWRKO09gxfeRYo94F2pq
         75mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9sGcynHRDayWT0bdEoEQXYHjCHQPwGXVBs+kG3yXWuo=;
        b=hYRRoklruDCbDUL1z8KtYvKC+QSqAYFZ+8efmCfU4A1wIGFxTnJHAFG5rWvFhZRDpf
         Eopreh70qaXLHUriSos+6MKKYR28o0bMp0DbHgHuxEh2CwpIwLWZrmvcqzvVggvhg3D1
         wHpL2smIm4O/TB9e0L8nstVh8jIJwDg2H3VdQVSPVwR8EzAHTyUfzBdF7HgGqc2BMtln
         PpoeM3dspam/BD2RAOZZAuse8J74RMCXx7CBWhHUdak0oHzkwbDV7koAkgQIz970MDb4
         4zSNgZKZkDO6zI3yy4BxI9BN+Ny90T7Rw/JHTAbKjsAuuxjknGWgCg5dY2HbPIS2fIUH
         pPXQ==
X-Gm-Message-State: AA+aEWY+24FETDaxoRAlVESZ5TajKVZzIgo40/Og7cREadOdPM9p1IBF
        nqu8oXUS1W1X3R4mzUOo1sXADmbmJWA=
X-Google-Smtp-Source: AFSGD/UE6w6dfOa14BeLOL+C4y6fua+sIoB1LWLFufJpEFjPhTpsYXKmfws3QvIzIT5kYgHHSz3jdQ==
X-Received: by 2002:a1c:e484:: with SMTP id b126mr11281831wmh.119.1544471163666;
        Mon, 10 Dec 2018 11:46:03 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id 202sm18808915wmt.8.2018.12.10.11.46.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 11:46:03 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 2/2] soc: amlogic: meson-clk-measure: Add missing REGMAP_MMIO dependency
Date:   Mon, 10 Dec 2018 19:45:55 +0000
Message-Id: <1544471155-26661-2-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544471155-26661-1-git-send-email-clabbe@baylibre.com>
References: <1544471155-26661-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchs adds a missing dependency on REGMAP_MMIO.
This cause the following build failure on SPARC:
drivers/soc/amlogic/meson-clk-measure.o: In function `meson_msr_probe':
meson-clk-measure.c:(.text+0xc4): undefined reference to `__devm_regmap_init_mmio_clk'

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/soc/amlogic/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/amlogic/Kconfig b/drivers/soc/amlogic/Kconfig
index 36633bb..5501ad5 100644
--- a/drivers/soc/amlogic/Kconfig
+++ b/drivers/soc/amlogic/Kconfig
@@ -11,6 +11,7 @@ config MESON_CLK_MEASURE
 	bool "Amlogic Meson SoC Clock Measure driver"
 	depends on ARCH_MESON || COMPILE_TEST
 	default ARCH_MESON
+	select REGMAP_MMIO
 	help
 	  Say yes to support of Measuring a set of internal SoC clocks
 	  from the debugfs interface.
-- 
2.7.4

