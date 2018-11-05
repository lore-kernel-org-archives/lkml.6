Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D914C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 259DB20866
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wk/9rq74"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 259DB20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbeKEXfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 18:35:25 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37844 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbeKEXfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 18:35:25 -0500
Received: by mail-wr1-f68.google.com with SMTP id o15-v6so6060320wrv.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 06:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pKoF4gPx9B0hHhbAB2Ch8ktDsv0ythRuT+2AvvIEQMI=;
        b=Wk/9rq74GD3KQbHd6whopkrWhMnzN0W2Bmr5tOsey/ZtmG9ID2KL79rTrXAWtrJvEz
         dAhl10zay2Rc3Bj1XRKPns0o5rNMAxwGD/B36VED/QJt5zSQGMcyAWcewIaLPg5UTGJY
         TCHi/dKYNpLyOe4a0S5V35KZQdnMoxaSCJU90E5znY7cYxPQbxCHcdU5xPIi6MrlBzPf
         uYrI7J7zlH89MBWrEkz6vVqO3ri3S/EJ8w46XmpBThirQLbwM/krisyOtmB4w6p0e1js
         VR29nq5/G8b6fFZ6USJjMfLgEnAtcBga7LAM3yXmkGX79heqS3/QDuF3FhxgQpuwvOFw
         EqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pKoF4gPx9B0hHhbAB2Ch8ktDsv0ythRuT+2AvvIEQMI=;
        b=lendWY30Xxzg4QkKGSwqPpnNUJVhU4yy1ewX4aEjhRKh14j1gPZPM8IzpN7b5hA9N4
         9mFJjlUC+1F4CAveHrgAlqNb9p1xe44r2L8p1qGfuftNtGMqxfAiuA6uEyvuhreL9xnP
         nIKacdK4zfPbBJ2ock7wEUarPMrMeKMwk/GznJhO9c6o62M99LyfEpIqettlfEToaz48
         UBMUpF2cPvu1Y0dUc7rqV618Kzj39oXOdVHpnlUZwOUXhduGq+EbPmA9eOqtcQxpLXSc
         avRwBVUm2AeVq0eu++K88XvIPJEtDj6pkLqiIE56FtgjZp+jN1X8gjAeqPwS1C9uYVZn
         i/kg==
X-Gm-Message-State: AGRZ1gInQtMmySQSXtjUEhhwWnC9yW4jyIoYVSS2nueSFLReKXaK6a7L
        Gs8qczPuNZ9J3KSWWwypYf3EG30HwpPddg==
X-Google-Smtp-Source: AJdET5dnKpMYvinEdgPnYEhcava063LWXTrt7G7cc/M4x7b/biyLdKl7VZrT4Y5I6J9W9RypAU05xQ==
X-Received: by 2002:adf:ca03:: with SMTP id o3-v6mr19257898wrh.148.1541427328197;
        Mon, 05 Nov 2018 06:15:28 -0800 (PST)
Received: from localhost.localdomain (static-css-cqn-141161.business.bouyguestelecom.com. [176.149.141.161])
        by smtp.gmail.com with ESMTPSA id v2-v6sm13585081wru.20.2018.11.05.06.15.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 06:15:27 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     NXP Linux Team <linux-imx@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH] clocksource: imx-gpt: remove unnecessary irq protection
Date:   Mon,  5 Nov 2018 15:15:11 +0100
Message-Id: <20181105141511.30657-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

shutdown and oneshot are already protected against irq interruptions

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/clocksource/timer-imx-gpt.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/clocksource/timer-imx-gpt.c b/drivers/clocksource/timer-imx-gpt.c
index 165fbbb1c9a0..48e025e8dc82 100644
--- a/drivers/clocksource/timer-imx-gpt.c
+++ b/drivers/clocksource/timer-imx-gpt.c
@@ -198,15 +198,8 @@ static int v2_set_next_event(unsigned long evt,
 static int mxc_shutdown(struct clock_event_device *ced)
 {
 	struct imx_timer *imxtm = to_imx_timer(ced);
-	unsigned long flags;
 	u32 tcn;
 
-	/*
-	 * The timer interrupt generation is disabled at least
-	 * for enough time to call mxc_set_next_event()
-	 */
-	local_irq_save(flags);
-
 	/* Disable interrupt in GPT module */
 	imxtm->gpt->gpt_irq_disable(imxtm);
 
@@ -221,21 +214,12 @@ static int mxc_shutdown(struct clock_event_device *ced)
 	printk(KERN_INFO "%s: changing mode\n", __func__);
 #endif /* DEBUG */
 
-	local_irq_restore(flags);
-
 	return 0;
 }
 
 static int mxc_set_oneshot(struct clock_event_device *ced)
 {
 	struct imx_timer *imxtm = to_imx_timer(ced);
-	unsigned long flags;
-
-	/*
-	 * The timer interrupt generation is disabled at least
-	 * for enough time to call mxc_set_next_event()
-	 */
-	local_irq_save(flags);
 
 	/* Disable interrupt in GPT module */
 	imxtm->gpt->gpt_irq_disable(imxtm);
@@ -260,7 +244,6 @@ static int mxc_set_oneshot(struct clock_event_device *ced)
 	 * mode switching
 	 */
 	imxtm->gpt->gpt_irq_enable(imxtm);
-	local_irq_restore(flags);
 
 	return 0;
 }
-- 
2.19.1

