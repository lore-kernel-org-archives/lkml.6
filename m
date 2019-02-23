Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936B1C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6120F20675
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OKS/iPp4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfBWNIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 08:08:25 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36738 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727648AbfBWNIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 08:08:23 -0500
Received: by mail-wm1-f65.google.com with SMTP id j125so4276055wmj.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 05:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vUftDpL4i18Pw6X49JOGif3RmHhi91QSNFqo0duvcr4=;
        b=OKS/iPp4AxRs4b/HBAjDGPW5CkyMSIDgkO6haLo2yc73iTtkJibQPOyNdvEEvCbRLG
         28SETm8AqtAOPjUnBEimaxKAnHIwTDtRJC8L2PLpewuMlvDOkHeT86dNgom/PAeM8naG
         0fgzXhzrQOfNY4dcaXj1bR5tXbfGqjPVnH97l3xqybTpb3o7AfU6v2S8c97x4iQorJEu
         Unh6xKzQOyYqKKNXfq2RTnKJECQW5L05u2HRsKfSJ5mTz7e3sVK2WENbylkeCJ9UPskT
         FqQvwEYGTxGF7atIj1UGVSeaXsghsCZ+3BU1nqrmax5Z6u5RTbomGBMpu8dAFo7LKX8h
         ZizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vUftDpL4i18Pw6X49JOGif3RmHhi91QSNFqo0duvcr4=;
        b=Pj00lmgc96EVmxlU36BSdK+aFrj/6OSXw7ywUR4MzJN8ppnzSU+bmYadN+Pfg6otBN
         qUK8lqzM3Ob3ZIFg1zaXs7S4KXXIvAetBqbsrtHS7Qob/MZN0bfafs0+s5/ISGbyVpGE
         kXxvpG63HjTp7LzLuMvxCi579Xqwow7eL2Lmvn3kD/KHGSgepUb4GmVWH1CLF7OIesUU
         +zXZmZoue5Uj15cRckQqYqbgsAog6jOpDLYE4NXUL7TKIwbvb+BfIREIcDSBbsqhuiDF
         UV6nYd0g8lZ3J9+LVVJEgfsSqiWOnT4Lna33VV5Wx4rCNKadv0yyPX9Q+m0kWODkOXhV
         v4wg==
X-Gm-Message-State: AHQUAuZ8VuSnLkMXUJPcWxDkE7Jw+ipWv4RRiscG8wE4JbgJX4dciKJ7
        s05qcWlXfiM485ZyoKJdDsRSDyZiLjk=
X-Google-Smtp-Source: AHgI3Iax22T3B6VwZGT5IoA2SxAUbmxy2E1ugtuZeImruQDX3vluDBxDyATNz93gUfqaW3Dzszygtw==
X-Received: by 2002:a05:600c:219a:: with SMTP id e26mr5676630wme.93.1550927300979;
        Sat, 23 Feb 2019 05:08:20 -0800 (PST)
Received: from clegane.local (189.126.130.77.rev.sfr.net. [77.130.126.189])
        by smtp.gmail.com with ESMTPSA id i12sm7830746wrq.21.2019.02.23.05.08.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 05:08:20 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 15/18] clocksource/drivers/timer-cs5535: Rename the file for consistency
Date:   Sat, 23 Feb 2019 14:07:03 +0100
Message-Id: <20190223130707.16704-15-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190223130707.16704-1-daniel.lezcano@linaro.org>
References: <b5d75b05-b78c-535c-2b35-9a1f5a3a853f@linaro.org>
 <20190223130707.16704-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the sake of consistency, let's rename the file to a name similar
to other file names in this directory.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Makefile                              | 2 +-
 drivers/clocksource/{cs5535-clockevt.c => timer-cs5535.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/clocksource/{cs5535-clockevt.c => timer-cs5535.c} (100%)

diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index a9e7c642ecce..c4a8e9ef932a 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -6,7 +6,7 @@ obj-$(CONFIG_ATMEL_ST)		+= timer-atmel-st.o
 obj-$(CONFIG_ATMEL_TCB_CLKSRC)	+= tcb_clksrc.o
 obj-$(CONFIG_X86_PM_TIMER)	+= acpi_pm.o
 obj-$(CONFIG_SCx200HR_TIMER)	+= scx200_hrt.o
-obj-$(CONFIG_CS5535_CLOCK_EVENT_SRC)	+= cs5535-clockevt.o
+obj-$(CONFIG_CS5535_CLOCK_EVENT_SRC)	+= timer-cs5535.o
 obj-$(CONFIG_CLKSRC_JCORE_PIT)		+= jcore-pit.o
 obj-$(CONFIG_SH_TIMER_CMT)	+= sh_cmt.o
 obj-$(CONFIG_SH_TIMER_MTU2)	+= sh_mtu2.o
diff --git a/drivers/clocksource/cs5535-clockevt.c b/drivers/clocksource/timer-cs5535.c
similarity index 100%
rename from drivers/clocksource/cs5535-clockevt.c
rename to drivers/clocksource/timer-cs5535.c
-- 
2.17.1

