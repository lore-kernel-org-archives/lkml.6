Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF4DC282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 22:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C9221929
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 22:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uP96R7Ct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfBIWRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 17:17:00 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38496 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbfBIWQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 17:16:58 -0500
Received: by mail-wm1-f66.google.com with SMTP id v26so9771814wmh.3;
        Sat, 09 Feb 2019 14:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2utNHRXXdYBz7wpSqOWL44lfRR4t6gPz0JJNDUjHOyU=;
        b=uP96R7CtLRA7K8XooBJVzcDFNe02f2eIfrWO7H3fQl2RLKnycsz0X1hvKSHFlSjmZ6
         47b74+vCjzvCX/WCgL82LIDm8wKtuAYd1mGAkcR60MrunNW1tGoOP9ez8I/ExH4AS08Q
         O1fObJjcPlEjGXWgvEmmXO3DACDGOT349DGH3VjYKDkZX+/AY9CMOioSz6Hu71YoBJy3
         MWecQQFDQcAbcSXl6fpxstjfEAZpT2fkl2u/mAVtvV7bTRSMxeZqEGwunOKPyf9AZ1ki
         ftJzLNtV9hVo6F+7k4dkbqQhncfhBGjOgzlX/cVOCLaVJFX+FDfWx2Cl9XmdecSbbmcE
         TtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2utNHRXXdYBz7wpSqOWL44lfRR4t6gPz0JJNDUjHOyU=;
        b=YBPC8NEQUAQqFSeV+9eF3D6d28Gw9VZO/lTh9oqebOFRlJ54l26CnPoeCmGyfKouLo
         E1bmKXVV4X4Nbpf4qZa+S6kX4VYeVAT8V3DE/ZMQgmSGDzAG+mC5SwEy5TS4jLBqr2a+
         9oeLzTZNQzFyJfuNx9hdheOrKUGGkCOVXWwToG6bA/vZ+SCS6fCK633zfBN+LZPUy4FT
         5P5ueR4Q+vCzgYJKKWxSn3K0slay9YBnnlnZFBHqP7LR/AayZZDW30RNqmytGDTKb7fg
         DWQQcLKVWvc6duUo61gOnv8oK8fMYsCmeDhRpL+bAfGiltprNKJotpXjtLpC8HKSDo3b
         AS/g==
X-Gm-Message-State: AHQUAuZcDbfan4Ve63g3e63EtE+UN7c636ZTFGRkyzN/LU5rdnMJv1Pe
        Tf+dcoU2Y6vFHMMVOfxSsfyF6NQg
X-Google-Smtp-Source: AHgI3IbvHjiIyylY50oCF+ZrGiL3MreVHpuKGsuZ0InNH0R1cyJmpKgfCq5zZag9SnyVZBS3O3FZaA==
X-Received: by 2002:adf:9168:: with SMTP id j95mr21420682wrj.217.1549750616084;
        Sat, 09 Feb 2019 14:16:56 -0800 (PST)
Received: from localhost.localdomain ([46.216.193.21])
        by smtp.gmail.com with ESMTPSA id a4sm3214142wrt.37.2019.02.09.14.16.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Feb 2019 14:16:55 -0800 (PST)
Received: from jek by localhost.localdomain with local (Exim 4.92-RC4)
        (envelope-from <jekhor@gmail.com>)
        id 1gsave-0006S4-1y; Sun, 10 Feb 2019 01:16:54 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH 2/2] mfd: Add leds MFD cell for intel_soc_pmic_chtwc
Date:   Sun, 10 Feb 2019 01:12:14 +0300
Message-Id: <20190209221213.24052-3-jekhor@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190209221213.24052-1-jekhor@gmail.com>
References: <20190209221213.24052-1-jekhor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MFD cell for LEDs driver to the Intel Cherry Trail Whiskey Cove PMIC
mfd device driver.

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
---
 drivers/mfd/intel_soc_pmic_chtwc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/intel_soc_pmic_chtwc.c b/drivers/mfd/intel_soc_pmic_chtwc.c
index 64a3aece9c5e..68b54173edd8 100644
--- a/drivers/mfd/intel_soc_pmic_chtwc.c
+++ b/drivers/mfd/intel_soc_pmic_chtwc.c
@@ -60,6 +60,8 @@ static struct mfd_cell cht_wc_dev[] = {
 		.resources = cht_wc_ext_charger_resources,
 	},
 	{	.name = "cht_wcove_region", },
+
+	{	.name = "cht_wcove_leds", },
 };
 
 /*
-- 
2.20.1

