Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A03EC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 22:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B93214DA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 22:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mathembedded-com.20150623.gappssmtp.com header.i=@mathembedded-com.20150623.gappssmtp.com header.b="GGLs5eMp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfBJWvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 17:51:20 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36292 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfBJWvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 17:51:19 -0500
Received: by mail-wm1-f66.google.com with SMTP id p6so13380873wmc.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 14:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mathembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=Pi51Mueiz01jqmURtbglad6f6KeDug2dSwxXoF3nC+o=;
        b=GGLs5eMpymB8AgB2Gbk2l763hDFn+qpOAaeQC35PF76pG1YUs3lXj4SYM/7R8pR+YI
         pcP2Ve4OgpjAhK5ADJ9wUqTsRopHf8yAvO4/LLesq1Vmb+hfO/1rRKR0AXaEH0o8dwKJ
         sdjIwDOTHsd9cNA4tSWVUo7AiKWj+9iCjPPgziyZIgz550QZ1QpXQkZ6TPaxSIHnVfeR
         7pPzHgBbcRLGTFnURNpp3meu7CKM8bR3J2KM6dZKd1r44K0AH5z78tIF7sP/604Baea8
         jjNuYeTYIthO2WmKSj3PqYnkN+iRpt7IipOrlXnTp4NJe5sqv21I2BanrjZ7yyGfFexk
         TKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=Pi51Mueiz01jqmURtbglad6f6KeDug2dSwxXoF3nC+o=;
        b=LPw06rqpHNHFlE3ajsa7JAeMLJPJ9/DYSulP4n+5fdbKE8KEGVWXfnPewRfzXknzDY
         zoFlZzTwYA3aXugo8+VQ/mwk9Tvo3mpTR4vUGps+DQi6gbTY02DNgVHBpJeKY5K72t7o
         ZlNTD0++a1e1e0TT6PnEjmh7kQxhNJJVQEoBX3vEZLPDK1RWYq39/+M+FMAZSbKKucsU
         32MdwPCTorplgHv99ndMvHdUSTvkhH0DAooqaEbRg5qWrRAgCAeCobo8iCy0E6nGh9G5
         I7/Hwbbh2p94b0plVfqQVdn2Dy//s7xLeBej3vs9eq8x4lCA0R+QsEPsllWGy9rF9SJ6
         ST6w==
X-Gm-Message-State: AHQUAuYOxoY+mZZorfwd+Hk/sWuDPoWAAMGl3SnsHjcSE62OBsmZ/5pX
        j0G51m2PJoRBm/O84jrFkyKtQg==
X-Google-Smtp-Source: AHgI3IZMAXENriRqCnD09knJAHnUr2hVcIg8TPURsETLX9fU46ieXCFiVyIKMeaZwlCxnXJjyjuxFA==
X-Received: by 2002:a05:6000:10cf:: with SMTP id b15mr24877948wrx.301.1549839077853;
        Sun, 10 Feb 2019 14:51:17 -0800 (PST)
Received: from localhost.localdomain (host86-176-243-198.range86-176.btcentralplus.com. [86.176.243.198])
        by smtp.gmail.com with ESMTPSA id c139sm3904325wmd.13.2019.02.10.14.51.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Feb 2019 14:51:17 -0800 (PST)
From:   Stuart Menefy <stuart.menefy@mathembedded.com>
To:     linux-samsung-soc@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] Subject: [PATCH 0/2] clocksource: exynos_mct: Clear timer interrupt when shutting down
Date:   Sun, 10 Feb 2019 22:51:12 +0000
Message-Id: <20190210225114.20110-1-stuart.menefy@mathembedded.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When debugging suspend problems on Exynos 5260, I had a large number
of debugging prints going to the serial port after interrupts
had been disabled but before the timer interrupt was shutdown. This
was long enough for a timer tick to occur, but as interrupts were
disabled the ISR didn't run, and so the interrupt wasn't cleared.
Later when the timer was shutdown the interrupt was left asserted and
so the wfi at the heart of the suspend code didn't wait, causing
the suspend to fail.

Currently the code which stops the timer when it is on one-shot mode
and the interrupt occurs is in exynos4_mct_tick_clear(), meaning if we
called this from the shutdown code exynos4_mct_tick_stop() could be
called twice. So first restructure the existing code, so the check for
one-shot mode and stopping the timer is moved to the ISR, leaving
exynos4_mct_tick_clear() just clearing the interrupt flag.

Once this has been done simply call exynos4_mct_tick_clear() from
set_state_shutdown().

Stuart Menefy (2):
  clocksource: exynos_mct: Move one-shot check from tick clear to ISR
  clocksource: exynos_mct: Clear timer interrupt when shutdown

 drivers/clocksource/exynos_mct.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

-- 
2.13.6

