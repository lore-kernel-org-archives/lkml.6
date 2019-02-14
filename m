Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD448C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC64222DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Vrn+mOfH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439460AbfBNOwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:52:45 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34542 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439447AbfBNOwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:52:44 -0500
Received: by mail-wr1-f66.google.com with SMTP id f14so6830455wrg.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ko20qH5VmzzpKbO5X1zzZZEhTfTUa95eJTu4HyvS+F8=;
        b=Vrn+mOfHygpz64Ntn+hDUMCf+ggClSA0JuCXlM6Y2XJ0b3j4A8sJDPZJHCV8i0tzdk
         +wHpiq6HW1FoPFuCoqRDcmMjI11bi77CdYIKaQq9EgNHqTApylUUHDCRtbPBkOB3mxlx
         fuY4MR6K2SoKb22nx5onljvScWxS7iZIlp0/01PxOvjckYyKlpQIpS5gxUuSQKopXkjq
         FNr0pR9jmNFgGhddo4bZk/1+ZHHBxyo3qRDQIDr92NZxDCVnVDCkgO4XTyAqBV7LlBje
         9G7x5uwOjdarqd7cYOs6FGuGrLUTgDAkb5UafZZMD8AvQrgWbiLJvIbkHcTPVC5FOaRG
         NI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ko20qH5VmzzpKbO5X1zzZZEhTfTUa95eJTu4HyvS+F8=;
        b=SsYbMPZlrEPqHysHpciJ4lm0RuoSOM9j5xhmmTdmaWEYw3JTg518PHvAZyHPERc0Bw
         bmOoK/NBCG8ZB84v5NGN3nHW1lffWyZJ+qKFs4Mm/LYVcz1uB8RvVkSoxkeYo5JzoYGt
         tRxYBSctifju1O5yFo3pKyo05EUcZruRn1Bd3YfaEpWhXhQJgWLBH4GoWJmFD8B3BR8z
         tdbsAUFSK0VAFxM/oKrH8geLc6r4NP+it2uQgWTN1v0CM0KUS5igRd9zS1TFOMqwb/Nq
         R01ysIMWkpEqxtgRprBhj1BpCm3RjXOgDtViGq/cRahLuYBz1ld/9tSTIB7OtJ4hDOvu
         6Ffw==
X-Gm-Message-State: AHQUAuYO0gTEAUWlu+ibMq2jgNmIHHCD7O/Mmy+jBlWsLo4jzYDGPYFG
        zPgsMsoAgXT8SyY3OANn+Eh1Cw==
X-Google-Smtp-Source: AHgI3IZpuZOE7Wb4I9LFdmI6pdHZp8xd2iDykim9YIYTPf8qjlb4qFXsJcx7B5+RWtTlHrgk0Qw+Xg==
X-Received: by 2002:adf:c543:: with SMTP id s3mr284705wrf.192.1550155963366;
        Thu, 14 Feb 2019 06:52:43 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.52.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:52:42 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 01/37] input: davinci_keyscan: remove unnecessary includes
Date:   Thu, 14 Feb 2019 15:51:55 +0100
Message-Id: <20190214145231.8750-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214145231.8750-1-brgl@bgdev.pl>
References: <20190214145231.8750-1-brgl@bgdev.pl>
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

