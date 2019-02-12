Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3CDC282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B72C20449
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ab0ASbTj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbfBLKjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:39:05 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42205 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbfBLKjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:39:00 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so2066569wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 02:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FQpTYNOFF/xBKJ0FliQbJ6ZdH9bqB2OMp9FtFZp2/A0=;
        b=ab0ASbTjE/ckR7IVCA4YfKj+IeTTiW229Kuce+qyg+52Erhivx+/2FhNz6L5q6IAHJ
         CZ6dpFUHV/8t5UAmzAZY6MPvKSIcBuPKrVfgYSyRmvv54xnEG2eRqd081L0RZxMsbf0a
         vMueLD0AQYWLryjUGqhGTZ3wSRKOCroqtuBDS0vjgvN4tfLZo87ZQHtTapRZYUesrDdg
         uLAFbUCE/PDrD8JnWoTBLbyJwWa25J3mFfA5AtZCmNFWC4AekZGnUEcGCy873PbFIMX0
         qaRS6Ff1kBOtcn+37uv/FqrO48TKTDXPcVB7PkLjPW1PouhtQ8GhRj0IQ6NUlVD1rDKg
         MyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FQpTYNOFF/xBKJ0FliQbJ6ZdH9bqB2OMp9FtFZp2/A0=;
        b=MWAaKM0vKjsAYxhb0cfIggBAljbuhJSICTn3CEnwnjfzHO39pgxzqD3B+tS1Ty3ygl
         48dz0WtycT5kAVSDrbjvaHWHUNG4CMbLR8M9JvqAxHV7ZSDyTg6gz1y36PEAILOcE1R2
         P3flIKFuQahjFRAgr7lMhVAwC3H79Lel6xve/d84lfPEqMpnLG+o6Shs6U2ZTIwZnaFs
         8iBzT369pMmhSMiTcTYLWXjioplvVaPrNDd7IbVX9DMoOu/GJXxJ843jXtaoY9gtKEAp
         h84xc1ylt2301iW6ObZDwpGCZqQfESX3H+y3QGvLkwf5GbW6g7yx6LOoRbwduTzcyxWt
         mgbw==
X-Gm-Message-State: AHQUAuZZeS/vXjDy6ye2AC/N1MDfHyomGHModwieDI25ZpjcIOn8s/ud
        vZ7Yu3C9TwlW8H/DGDovQHS0aQ==
X-Google-Smtp-Source: AHgI3Iak1wszZsWxYCmn7blit4/Cv0jSY38pVugKKoO/9rIYq3iJcLekYIiTe+Cthps43ITmUiygjg==
X-Received: by 2002:adf:dbc4:: with SMTP id e4mr2508066wrj.320.1549967938534;
        Tue, 12 Feb 2019 02:38:58 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
        by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.38.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 02:38:57 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 02/37] ARM: davinci: remove intc_host_map from davinci_soc_info struct
Date:   Tue, 12 Feb 2019 11:38:00 +0100
Message-Id: <20190212103835.7768-3-brgl@bgdev.pl>
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

The intc_host_map field in struct davinci_soc_info is not used by any
board. Remove it as part of the interrupt support cleanup.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/cp_intc.c             | 5 -----
 arch/arm/mach-davinci/include/mach/common.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 94085d21018e..67805ca74ff8 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -117,7 +117,6 @@ int __init cp_intc_of_init(struct device_node *node, struct device_node *parent)
 {
 	u32 num_irq		= davinci_soc_info.intc_irq_num;
 	u8 *irq_prio		= davinci_soc_info.intc_irq_prios;
-	u32 *host_map		= davinci_soc_info.intc_host_map;
 	unsigned num_reg	= BITS_TO_LONGS(num_irq);
 	int i, irq_base;
 
@@ -182,10 +181,6 @@ int __init cp_intc_of_init(struct device_node *node, struct device_node *parent)
 			cp_intc_write(0x0f0f0f0f, CP_INTC_CHAN_MAP(i));
 	}
 
-	if (host_map)
-		for (i = 0; host_map[i] != -1; i++)
-			cp_intc_write(host_map[i], CP_INTC_HOST_MAP(i));
-
 	irq_base = irq_alloc_descs(-1, 0, num_irq, 0);
 	if (irq_base < 0) {
 		pr_warn("Couldn't allocate IRQ numbers\n");
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index b577e13a9c23..944afd57ee38 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -61,7 +61,6 @@ struct davinci_soc_info {
 	int				intc_type;
 	u8				*intc_irq_prios;
 	unsigned long			intc_irq_num;
-	u32				*intc_host_map;
 	struct davinci_timer_info	*timer_info;
 	int				gpio_type;
 	u32				gpio_base;
-- 
2.20.1

