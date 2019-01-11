Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5C6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407DD2177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="uhGHaxmE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389312AbfAKRXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:23:19 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53759 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388717AbfAKRV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:21:57 -0500
Received: by mail-wm1-f67.google.com with SMTP id d15so3128815wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 09:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wdNPi9yYX+VeO7yfYl4QzOTwh2emyQNtF85luiFVb28=;
        b=uhGHaxmEJviZuGQmGmBjpOazE6+kQBgDedrWgSS8iT8szm3RUCgxV07K6lR7YqFae3
         PykG/z5syFNlaT0+zHQfvyI2gkXAReMEmNrn2vCHXPDqsNo65KJmLCovjM8Z+1bXkfFG
         z2JMyiKbOao1JqKiKt9p7zki09GkScxag2UHps2pmRFUxSPPInK2G7K3na7jojaC9Vkl
         AH5eNZjcBrzOey0U0nCYzg2RNB7n+h9oALKQ8t8DVXcaf7T2yckvEf2nG/VeIZbG9Fwa
         kKk0L9UBPWeL9LneejzIo6byknAzktb8WVukq7YOBFTextXqJGbHPRkuZnx2lpgGS6s8
         GPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wdNPi9yYX+VeO7yfYl4QzOTwh2emyQNtF85luiFVb28=;
        b=HXw4uBziiToLxqbkLSn8CNYrH0aLiu66w7RecSGrsfn01fWrDYSx1gBPrICGedpD0u
         rRfPfSx2whbFzpeiDnheyvzF0bVODM1/gMputQzz2EiVV+ZpQmmqjqs2VLjbBP0EmcG+
         h/t5Pi9oFnEwIJ9xbwJuPLUIqzygIABEsESEVNO25iO+SwQBhSnsW6YJomuw4UZaZWyp
         zYpcoDt3Ep7BuXAc1eHqkwB10eQdORogNUIEpkSyri2pLLo3xJih/wqz4DfsIRiezn4p
         U7z6PTf4VC80WaJWarxtCHiP7Z3tbOfZlbqSJ3J5KclUFL+OsXHtdRSIqWariEMBI6AY
         rZ1Q==
X-Gm-Message-State: AJcUukc41MDAQvJ7SfAvTN9F6kv4Fh/4fl5VB/GA/EkxsnhERZrr4ckO
        QP6xUiCv2DDkKoJI/oe2YyCiVA==
X-Google-Smtp-Source: ALg8bN51ES/LVNgyvdfRMCzv55KUPPAPMkaAEcAbJT82yMZmq+JTtiU37mTzcH08PmBePII1Rao3XA==
X-Received: by 2002:a1c:6e01:: with SMTP id j1mr3015616wmc.103.1547227315042;
        Fri, 11 Jan 2019 09:21:55 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id o16sm78534408wrn.11.2019.01.11.09.21.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 09:21:54 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 04/17] ARM: davinci: da850: WARN() if clk_get() fails
Date:   Fri, 11 Jan 2019 18:21:21 +0100
Message-Id: <20190111172134.30147-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190111172134.30147-1-brgl@bgdev.pl>
References: <20190111172134.30147-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Currently the timer code checks if the clock pointer passed to it is
good (!IS_ERR(clk)). The new clocksource driver expects the clock to
be functional and doesn't perform any checks so emit a warning if
clk_get() fails.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/da850.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index e7b78df2bfef..9ff377f26c4b 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -774,6 +774,7 @@ void __init da850_init_time(void)
 	da850_pll0_init(NULL, pll0, cfgchip);
 
 	clk = clk_get(NULL, "timer0");
+	WARN(IS_ERR(clk), "Unable to get the timer clock\n");
 
 	davinci_timer_init(clk);
 }
-- 
2.19.1

