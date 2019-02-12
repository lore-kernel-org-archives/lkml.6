Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE19CC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE6120449
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="zMMMKSHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbfBLKkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:40:49 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42239 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729045AbfBLKjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:39:22 -0500
Received: by mail-wr1-f68.google.com with SMTP id q18so2067962wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 02:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aM1xrGIBo2FFuSsmFTHMz/H1xNta7gzJkLnZYdQJhl0=;
        b=zMMMKSHFQibmHtmVol+4g5z++egugz+ma4x0V9e+S98FunxVu4sxjhnGYnGIZ5bIXw
         wIfhXxTbF6Tlrn7UbjvEJazD3Tdr5uwa22tYg3bVGL68GIKSRNAq2h6tV1t98wSUhg1X
         bc4jjGgWpyCUi0awNeRiAI6AQnnL9g1j9f3yLHZhbaFzZJFenWaFvLQ4DzY+iHJZfobD
         3T/+3BKim7DOpK4pXDbcFqRY9HnirCXCkb1IpvaDgY8qM2B60rmki9nN0/9tPGNI0TAn
         DU+fs92YqQ0uUnBzwOVPtniaDgKqXl3YoWEeEBZKC7+cOF9vRqZfdNBKCF8VehW5tMo8
         T6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aM1xrGIBo2FFuSsmFTHMz/H1xNta7gzJkLnZYdQJhl0=;
        b=uX3389X1q9VSfrM4K/YJcVFhw7F72arR+FxqlUyVMB/eHKYgOs4Kbx/A+r240yY36o
         WQjKCinh7XhVNbaUSiC6QNBJEwhySL4exZ8NT9OWAdMIbGgq7xy2ZSI8M+cSgyvYEcvV
         ww3DzNQoXYxiNDRew8rcQ57Dh6F+WeEOLRYmgyUWbY3nrtEu7Af3nNON0WQycrHf/g84
         2ZQAYg5k2YY84oWQVpVtrN9LM0Xcd+NM+TPmVT7Hf7k27OOEzS21AWHbElx6RQs8ABTr
         0JQnzb4MXlHAHHmh5PWBNFRBNAfvnLiwRiwo4bZTY1HyTWGL1qmkdLdSLQz2lXWDtKMQ
         KVhQ==
X-Gm-Message-State: AHQUAubzPkICSlHknwbsAOUuoInVPcyOl3IFQuy6SO7Uaur7G7xuFVf0
        rSSDcrhevJYx479WCa7e8Zjl4w==
X-Google-Smtp-Source: AHgI3IaR8g4CNnlhzVYgQRzBLI1JVXA/2dvwrTWuQaYyILi/hBazVBrmalD7bNSIDHb/BRkJ5U+sNA==
X-Received: by 2002:adf:9f54:: with SMTP id f20mr2423842wrg.88.1549967961439;
        Tue, 12 Feb 2019 02:39:21 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
        by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 02:39:20 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 21/37] ARM: davinci: aintc: remove unnecessary includes
Date:   Tue, 12 Feb 2019 11:38:19 +0100
Message-Id: <20190212103835.7768-22-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212103835.7768-1-brgl@bgdev.pl>
References: <20190212103835.7768-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

These includes are no longer required. Remove them.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/irq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 92b6e653d8cb..810ccc4fe476 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -12,10 +12,6 @@
 #include <linux/io.h>
 #include <linux/irqdomain.h>
 
-#include <mach/hardware.h>
-#include <mach/cputype.h>
-#include <mach/common.h>
-#include <asm/mach/irq.h>
 #include <asm/exception.h>
 
 #define DAVINCI_AINTC_FIQ_REG0		0x00
-- 
2.20.1

