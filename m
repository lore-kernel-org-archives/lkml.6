Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7754CC10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44299218A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUF0VKIL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbfBRAT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 19:19:59 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39691 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbfBRAT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 19:19:58 -0500
Received: by mail-pg1-f196.google.com with SMTP id r11so7514188pgp.6;
        Sun, 17 Feb 2019 16:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EoaCOkUk5gTo3YGBlv0mXfCaFcXwFz99tNXwoGoos+Q=;
        b=CUF0VKILEd6e5TC6U/Lk5nkkqDiX0VIWU9IgUFZ0ZfyXaueXbEzZeuCCaXO9tpa9Q4
         I8kHcc7SmVIrzdHiDayDq8QvKu4uxVe9gQVPuQuaIJ9+1vJ14bGcim8gMUvVX0MHGNzl
         GtjM/DGj27oZ3U5QVJwyXdYxdq21B3yo7Jdj12x56ffl5eboITDSRjrbLmhBFPPvmbDH
         3hZ4WkqE5nUdKUAKT3Uwbh/x6KYP4V9rGz68rnKD5ZmOWu1V+DvcFbhyuW62pIBXShrc
         NaCyWyTXM9e+6isJJTm8aq6aFiz5nHepCVopinJSUqgk6M5DOoszn5LXdumiimzXUq1A
         5jOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EoaCOkUk5gTo3YGBlv0mXfCaFcXwFz99tNXwoGoos+Q=;
        b=YROjAioKgH00C3L+B4SBys9O6rMi4gxrbH1ThZnzxAa7G3L0oWshxvfIlE5iJlfSOQ
         11LEBDeODmHy8Mi1E+bbRR523E2laIt5yFPDGwvMqplPirH6jXWv7k0VehanohVPrxhc
         WQaLqGf52oh0/Hxc6U+vioWypktjTvkxpgQUXHqA0uL2IQ2oV4ikFytTKQkqfTDbtLCx
         iQYpU8H1uIqYW45skB2D9C4NH1rBWN8guqOD8STeZsHGoVrfhT6vakPztPMOaGoDO9Mb
         ojPr4FCP56927EgSTSTD5+S26AFrKWstzOdFGhFJypF5D7naCnOcHWhbkMAiBQQOhxsF
         CH4g==
X-Gm-Message-State: AHQUAuYStGk3BXX7m37y0ilKmLoJkUXyQcmMzUTysBB9i8xRbEYAeqBV
        5rcEmlvITjpmfojylvGcJ3s=
X-Google-Smtp-Source: AHgI3IY26M/PoAW6QKgiAoUGCwB26eIUUKSsASUJvxvJcrOiGbH+GGYwoscq7O/Hmqh5WqIKoSHuVQ==
X-Received: by 2002:a63:2312:: with SMTP id j18mr16365991pgj.344.1550449197904;
        Sun, 17 Feb 2019 16:19:57 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id s73sm31518071pfi.124.2019.02.17.16.19.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 16:19:57 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/8] ARM: tegra: Always boot CPU in ARM-mode
Date:   Mon, 18 Feb 2019 03:17:24 +0300
Message-Id: <20190218001726.16785-7-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218001726.16785-1-digetx@gmail.com>
References: <20190218001726.16785-1-digetx@gmail.com>
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
 arch/arm/mach-tegra/reset-handler.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index a9f13230da2f..c827b185d281 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -112,7 +112,7 @@ ENTRY(__tegra_cpu_reset_handler_start)
  * NOTE: This code is copied to IRAM. All code and data accesses
  *       must be position-independent.
  */
-
+	.arm
 	.align L1_CACHE_SHIFT
 ENTRY(__tegra_cpu_reset_handler)
 
-- 
2.20.1

