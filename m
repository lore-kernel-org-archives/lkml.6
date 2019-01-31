Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37165C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC672085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="hmdqpeYc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387836AbfAaNkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:40:16 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37713 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387752AbfAaNkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:40:12 -0500
Received: by mail-wr1-f68.google.com with SMTP id s12so3342501wrt.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 05:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tQ080XSy9CragrnXr938L/pI+v5aJ06V54Jlzfpdd30=;
        b=hmdqpeYcpj+SLDsDzt/8vR5qdul/8gSSFcb/1wzDH9OetGMQltUKBb9OV8Qiz8OJwK
         6s8/AXuYShhh4K6bAtU8JQ4+LSOP70jsLF805U7aNpE88RQAuDRYVpRs1EkOHL98In1d
         vTwq/yf0tCLrgpC3NvRMe0HfU17YC1ExyTueq7V8y/nOor940hP0zAA37YgcwNo0G39E
         qe9U+Q66olaL3XVYe16/Dr7pfo1DbeDilXPJ9g+I7p76NCJBdfBeevweRbTcnR6DAHVL
         cXdPd4hd3SSO1foATQYlfeYt88lVR1CKi0egxob6TF69DtTJ1en+VEXb0Fhf1+jLO7Vp
         +9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tQ080XSy9CragrnXr938L/pI+v5aJ06V54Jlzfpdd30=;
        b=AexkPLoakPghEgLFgC42YROHbmlmuOCJWY/d6wRwtu3dNZNyTKK1HTJHMLNAkA3c2f
         BGevhIdHkRamRrF1ceYGA7Kd8zHzgsQjzYLS++c2th1/GOFcJBNvpWyyqHbzJo9uOjta
         dgp5HRSMzTGVvXh43mVoqpKNTUeBtdEPBowAm5BdefkqSUpDIoY5D6XLC1TzWU1BYeH2
         HMrSFvoPR05LKqDG3NRAXvm+RCxSjnc1B8yAhrhJMSBX45wrsFo8h2FPnR8GV2fzSWjG
         nKd47glgDG8ClsAqLoZ6XMh7EJpxfpDgjlDdVZVCBIHyAtt2oJ4JQMBjJI+ur79RHjol
         96mg==
X-Gm-Message-State: AJcUukc0IdXqjQ5f2KwywFPVt4N8K2WpxPG2oRdJ7TObJbHW9+SQGPNa
        A1qCTzajo7CrPoKK5wD+zqlEEQ==
X-Google-Smtp-Source: ALg8bN4qJy8KXPn1XXnN39DTI3SKbStCMBYqfVP9ZHSUPOBZXWwqKyeDtXVo9Y+MOG1/Ita1e5xTmg==
X-Received: by 2002:a5d:6105:: with SMTP id v5mr33635986wrt.63.1548942010166;
        Thu, 31 Jan 2019 05:40:10 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.40.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 05:40:09 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 24/35] ARM: davinci: cp-intc: convert all hex numbers to lowercase
Date:   Thu, 31 Jan 2019 14:39:17 +0100
Message-Id: <20190131133928.17985-25-brgl@bgdev.pl>
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

Use lowercase letters in hexadecimal numbers as is done in most of the
kernel code base.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/cp_intc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 3a99a3146d8e..1f55d68672db 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -23,19 +23,19 @@
 #include <mach/common.h>
 
 #define DAVINCI_CP_INTC_CTRL			0x04
-#define DAVINCI_CP_INTC_HOST_CTRL		0x0C
+#define DAVINCI_CP_INTC_HOST_CTRL		0x0c
 #define DAVINCI_CP_INTC_GLOBAL_ENABLE		0x10
 #define DAVINCI_CP_INTC_SYS_STAT_IDX_CLR	0x24
 #define DAVINCI_CP_INTC_SYS_ENABLE_IDX_SET	0x28
-#define DAVINCI_CP_INTC_SYS_ENABLE_IDX_CLR	0x2C
+#define DAVINCI_CP_INTC_SYS_ENABLE_IDX_CLR	0x2c
 #define DAVINCI_CP_INTC_HOST_ENABLE_IDX_SET	0x34
 #define DAVINCI_CP_INTC_HOST_ENABLE_IDX_CLR	0x38
 #define DAVINCI_CP_INTC_PRIO_IDX		0x80
 #define DAVINCI_CP_INTC_SYS_STAT_CLR(n)		(0x0280 + (n << 2))
 #define DAVINCI_CP_INTC_SYS_ENABLE_CLR(n)	(0x0380 + (n << 2))
 #define DAVINCI_CP_INTC_CHAN_MAP(n)		(0x0400 + (n << 2))
-#define DAVINCI_CP_INTC_SYS_POLARITY(n)		(0x0D00 + (n << 2))
-#define DAVINCI_CP_INTC_SYS_TYPE(n)		(0x0D80 + (n << 2))
+#define DAVINCI_CP_INTC_SYS_POLARITY(n)		(0x0d00 + (n << 2))
+#define DAVINCI_CP_INTC_SYS_TYPE(n)		(0x0d80 + (n << 2))
 #define DAVINCI_CP_INTC_HOST_ENABLE(n)		(0x1500 + (n << 2))
 
 static void __iomem *davinci_cp_intc_base;
-- 
2.20.1

