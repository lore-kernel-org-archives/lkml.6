Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E0DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 182262070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G05694d0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfBVSEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:04:52 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42672 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbfBVSEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:04:38 -0500
Received: by mail-lf1-f68.google.com with SMTP id p1so2370074lfk.9;
        Fri, 22 Feb 2019 10:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QnRZ3rfzwRbPDDTdc6HzTkn6HQQ4M3T5bbjKD11buGw=;
        b=G05694d0OTJpUsO3QC7S/LYh8TaqBs+SeafD31Jy46AXpJYIScpUzo/4Pmpo7ZTda0
         1GcfZn0Rllt4rax+n63QkZ8u/zjwu49nFqqA7se4+xJIOT3790J1Dxj0KQaEO28OdOwr
         UnMLWe1b/DjJiUwGYXbw5MfghxTzJY0Vsf1exA6hz4Z+/2LPW3k15pZSc6w3KM4TNF9e
         wBAhCjSYPNSwE31e8qMeHHYcCDXawSoHkQzrQk/26kjl9QJTq6hKw7RLBxuBdFmsadgo
         tw4vb1phHUHvhY0P4tADJ08EIiggu5ri1Gbl2ZI/hxVWSOSR3R7zBiw8ixO2NGSfiOyc
         KOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QnRZ3rfzwRbPDDTdc6HzTkn6HQQ4M3T5bbjKD11buGw=;
        b=ZdIE+AZ7mhB/Wm/5WLvGHaWnsvjlSDYb1Y3WZqf7Qpra5xPimMRUuXVft2GClNqg71
         tSZ343HR/0/B1PE4wKZKKcqybytiMR7vcZb9qawg9dtMtI+E/TlFYoyYicWRaH0SHDdi
         UxYJHXHX3vZHxctf2MFI312Zhco8yDXv6UUsmGR0c/nzkH45UQS9btYyXwXMvHbgyWk9
         QchkI/uMQ3iNoV7BE1v+LTBF83tjaAoIsygaLNwO8fyHSeTYgDEJH88DTzg7uEBoa3vR
         T6rz6qAhHhUu8yMZfID1eaFpRpr1VlJEicIeqUKq9kAmjjTzAmF3Tin9S1HeelB8w+vG
         Oekw==
X-Gm-Message-State: AHQUAuYRdsmKXrxHqU1hNy4cpbQv3Qkrj9prPhyKnusQHsRLsLCjZhvA
        c1NxPSByz9EISHZUBDDcxRE=
X-Google-Smtp-Source: AHgI3IasBZa3PuWN1j2x0kUD2ry51mdaHvWnal+iuky2BlV15/ajKA4yAaSOhdkehshKTBaq8BB+0g==
X-Received: by 2002:a19:cf4f:: with SMTP id f76mr3181684lfg.125.1550858676122;
        Fri, 22 Feb 2019 10:04:36 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id j12sm721202lfg.47.2019.02.22.10.04.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 10:04:35 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 6/8] ARM: tegra: Always boot CPU in ARM-mode
Date:   Fri, 22 Feb 2019 20:59:24 +0300
Message-Id: <20190222175926.23366-7-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222175926.23366-1-digetx@gmail.com>
References: <20190222175926.23366-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU always jumps into reset handler in ARM-mode from the Trusted
Foundations firmware, hence let's make CPU to always jump into kernel
in ARM-mode regardless of the firmware presence. This is required to
make Thumb-2 kernel working with the Trusted Foundations firmware on
Tegra30.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/reset-handler.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index 6bea95d165fa..3bf202819534 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -113,6 +113,7 @@ ENTRY(__tegra_cpu_reset_handler_start)
  *       must be position-independent.
  */
 
+	.arm
 	.align L1_CACHE_SHIFT
 ENTRY(__tegra_cpu_reset_handler)
 
-- 
2.20.1

