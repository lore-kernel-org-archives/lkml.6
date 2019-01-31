Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5587BC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238342085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="zjPDnWnr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387957AbfAaNlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:41:01 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54336 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387829AbfAaNkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:40:16 -0500
Received: by mail-wm1-f66.google.com with SMTP id a62so2532713wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 05:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=suo+S/p01f0fXm68K0wOuLuMu8DfXRVmkAo382MDz8Y=;
        b=zjPDnWnrJ0x0vcVq1AmXMJevGmQre2lZ664/pYI8oeykVs+FDnxvnDoADtP9ZGikC6
         6jwJHE+mfl478Mqoz7HRGNaxTGDXBZ3y7Ob+hX1/NNQEPlsySViLj6y0ZlldKb3tqRSC
         rr4aO5yG7Ip8KM6uwYwW0ic/W5Ax+GkpzN0el+pKvntLUAnUEYDHkW1RHlYMQTqsDvXr
         WwF3L79lFQ0lk9QeWk0uup+lIsAP5WifAjT+0z6GQAdNWfEvQKuK2UdHuU6H4z01ufQn
         azqkhV4kLHCiDTcg9bTk7H+HcgRi2duP+usNovrJJcexc2M87aKNqUrKejMXfrl87jeW
         eTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=suo+S/p01f0fXm68K0wOuLuMu8DfXRVmkAo382MDz8Y=;
        b=aSZVxCwL+IvgMQo3xAYHvj18xZg/dHjdRVHquNO0wx8Q+Y9BPOlGOEUx4uYbImtHGN
         f4ICDtZSRv8WmpoWSC4oIZc6zBt5TX3Cr1SXMJzBoSmexCh8m+lZh4nh/jQZWPm6+C30
         i1efC6jk/0qHMKnRUvzqYdXAERCDMp8o1p0tRsmh0czK1o0qbZ5c84fgJm0hevgE8q3e
         Q0EWX1BA98S1pKV/P+0lGRn91F2ym28qvuq0bG4V57/3BuxBEt31B/7mbomjl2SSd5lx
         Qe00ROoRCq6nQ8bCYBCyQzqePySuxaikPiXLdU4E9iHHTiclMIPIBWFII3YqbkFX8Amj
         uuAg==
X-Gm-Message-State: AJcUukcwmIbUPGlas6JXkp8WEuB+ibJJ36k1QyftguLb0SIz4xlJEykt
        2k5M5okc/OapbFKozjhwBFHCXQ==
X-Google-Smtp-Source: ALg8bN5ibLPcQXfxZ3bmH/xGPIH5HpgxF7ioO9Rlv/z5DLFwKXEH5IROXVDMEZIWbH7yAbnQP/qJOQ==
X-Received: by 2002:a7b:c7c7:: with SMTP id z7mr31531297wmk.74.1548942014638;
        Thu, 31 Jan 2019 05:40:14 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.40.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 05:40:14 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 28/35] ARM: davinci: cp-intc: remove unneeded include
Date:   Thu, 31 Jan 2019 14:39:21 +0100
Message-Id: <20190131133928.17985-29-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131133928.17985-1-brgl@bgdev.pl>
References: <20190131133928.17985-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This header is no longer needed. Remove it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/cp_intc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 8d751318682d..812e49fcaa8b 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -21,7 +21,6 @@
 #include <linux/of_irq.h>
 
 #include <asm/exception.h>
-#include <mach/common.h>
 
 #define DAVINCI_CP_INTC_CTRL			0x04
 #define DAVINCI_CP_INTC_HOST_CTRL		0x0c
-- 
2.20.1

