Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A595C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC13F20842
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="oBSwqCPW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbfBLKjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:39:00 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55474 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728845AbfBLKi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:38:58 -0500
Received: by mail-wm1-f65.google.com with SMTP id r17so2323745wmh.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 02:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ko20qH5VmzzpKbO5X1zzZZEhTfTUa95eJTu4HyvS+F8=;
        b=oBSwqCPWAfiPofGOLL/ZuadJvT6OUVeR2+SjwNRw2pKwDzieCPnADy/EHvVd4s94Za
         xiJfQqQd2P0wl2VSCJFggCqmxCF1hIrMwYAqSV2J/oFjrwodVM8YSacrCUGgsavHlMww
         Mvn/KNzy9rF7R0GMWYFphbexkLmGAXeXOwDO2baUz9tmW2H05uciBX43KiBeRlZZpSKG
         yQAYHsTiMi8bHl4kPgMskQwauFdlc8GNWJ5S8GfJ3bLS40TG3eGieVIbOL6EPl+0X3pF
         Yby0ZC4QD0axAt4ZEKek4byCwGYc/csQ5tj39zbL6d2FRDZznF3ZluGME2kjDD3j/xjp
         b57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ko20qH5VmzzpKbO5X1zzZZEhTfTUa95eJTu4HyvS+F8=;
        b=TjAoKH/f+LeeZoU8mmfmYZv+MVeh4ZyZAONK0H7QoNJd9NhM0SgYSihBsnbS2GtJuI
         FYCD2AmCPZ9FBTDezwVXUjGubMCeie+XLEa2foDZ93SGc4bi9P+a7BfE72qtAWl8FNpF
         A28jHEV86ngmts5w+2MzGlc3t7KieBzjRdLZn8wisCtdlyEAdv+Zgo6hquz5xHtQy/6c
         yB5+iJjv8SJdUoRQ884kH0G2mbAWzOA3IRxqlNQkqDFmBKVVkRTUmrQL7dNSL3TBHC/W
         rirsMWg1grlS/I7iGA+Em9tD2UnCWahQPl/XTKkckZh3fknqklalTwwnmBrRPPR62INa
         V/TQ==
X-Gm-Message-State: AHQUAuZi9Ish9T1MBDsi4ywnu+qWi/VsdQgAIbIqDoMRJJjsgx5ywT1d
        CQwzj4WXac6uRWAyzMtnsxoklw==
X-Google-Smtp-Source: AHgI3IYCAQHXXKZnml8pj9M+v/cEgYSnKTP396aUo18geS0yV3VrW45Hk3dfRdxZ5bc0NTchXWHR7A==
X-Received: by 2002:a1c:342:: with SMTP id 63mr2263104wmd.34.1549967937058;
        Tue, 12 Feb 2019 02:38:57 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
        by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.38.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 02:38:56 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 01/37] input: davinci_keyscan: remove unnecessary includes
Date:   Tue, 12 Feb 2019 11:37:59 +0100
Message-Id: <20190212103835.7768-2-brgl@bgdev.pl>
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

The mach/ and asm/ includes are not needed in davinci_keyscan, but they
will cause build problems once we make mach/irqs.h a private header for
mach-davinci.

Remove all unused header includes.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/input/keyboard/davinci_keyscan.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/input/keyboard/davinci_keyscan.c b/drivers/input/keyboard/davinci_keyscan.c
index b20a5d044caa..b4db72f833ca 100644
--- a/drivers/input/keyboard/davinci_keyscan.c
+++ b/drivers/input/keyboard/davinci_keyscan.c
@@ -32,10 +32,6 @@
 #include <linux/errno.h>
 #include <linux/slab.h>
 
-#include <asm/irq.h>
-
-#include <mach/hardware.h>
-#include <mach/irqs.h>
 #include <linux/platform_data/keyscan-davinci.h>
 
 /* Key scan registers */
-- 
2.20.1

