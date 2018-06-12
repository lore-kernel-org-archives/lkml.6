Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D1B5DC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D27208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qsbCJrCV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86D27208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932303AbeFLEkM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 00:40:12 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36652 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752832AbeFLEkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 00:40:10 -0400
Received: by mail-pg0-f66.google.com with SMTP id m5-v6so10835116pgd.3;
        Mon, 11 Jun 2018 21:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Z1iLPIjXQ1iHjvXHIgAyPo8ttxIjrkZ7hYNxVfhx+Rg=;
        b=qsbCJrCVuWwYxcKgLDLIO+fcbTLlw4PjEY1Cn9bgn3wm0PorEJ8l6P32piDIPykLsM
         XEuAxaVizMNkFZqFJhdvRqYQIhMCSeWAPsodv92SQQiY5VZdH0dG90GSLLjWo646yxQU
         vsSBtKDI2mbCr0VCazkItHgodHsNwjaEmXe0uVBRq+TEsHsyYdkQ6Txvk1kCOulumlUM
         gHFXdjkFGh+Ic5TZYDFMjTyh5ZxIwZbgF6L6LoxSbu9avXZgRBWLdsCJUNtiaoZ8hH5h
         Cu6/LBmcTfLt+2Trr/e5c4Ow3RCXMa3QYA3XMR9mAeygWlQvaGB/IU9sCqQE01t+m8kE
         6SQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Z1iLPIjXQ1iHjvXHIgAyPo8ttxIjrkZ7hYNxVfhx+Rg=;
        b=IaLWxtUXWyb7dKxKyakQihHow7nZMYRaAi4yiv4oSi3JHZmREQAz80iVlpX1LoF9w1
         rN+S6L9vbH5yJbvAHJYLMWONcYac+VYqEIms4PRZ4mVaStCMJQ/d9rvhkYnDYLJ39Lqk
         amHjWt4AJM8Susn5BgBmBxT/O3eTHrVoNwdlwv2Czr3YvgVJfSMgcHfMRJO7pMlsHh3+
         quRVMt74uhnzAakNznV9mpIGffvx6Jyey/hgT6Vg3UoXoU2bw4OcST0ne6hLw3C7hlsK
         E1oy85zX2JVP5paAqYWALNUOSi8ANbQ40hVb0vatAQNuoBfQD/C6Ciir9iLsXKJnZwKd
         3S0Q==
X-Gm-Message-State: APt69E0D6mlKOup2SnNotvKleUmnHABMofIpREvSoDL6KSa0GhyKdhCm
        OZZvUHGyT7Ft3hmzyAmclgw=
X-Google-Smtp-Source: ADUXVKK7qP2zSZ/WUAqNcoIIyPDnd3Z9CSzljcu7pQbKgKunRpsuw4RxHSsc5qG9Rej9aQsH4XecxA==
X-Received: by 2002:a62:8910:: with SMTP id v16-v6mr2086649pfd.13.1528778409921;
        Mon, 11 Jun 2018 21:40:09 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id b4-v6sm10755426pgq.51.2018.06.11.21.40.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 21:40:09 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: rtc-bq4802: add error handling for devm_ioremap
Date:   Tue, 12 Jun 2018 12:40:03 +0800
Message-Id: <1528778404-41456-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When devm_ioremap fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling devm_ioremap.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 drivers/rtc/rtc-bq4802.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/rtc/rtc-bq4802.c b/drivers/rtc/rtc-bq4802.c
index bd170cb..5747a54 100644
--- a/drivers/rtc/rtc-bq4802.c
+++ b/drivers/rtc/rtc-bq4802.c
@@ -164,6 +164,10 @@ static int bq4802_probe(struct platform_device *pdev)
 	} else if (p->r->flags & IORESOURCE_MEM) {
 		p->regs = devm_ioremap(&pdev->dev, p->r->start,
 					resource_size(p->r));
+		if (!p->regs){
+			err = -ENOMEM;
+			goto out;
+		}
 		p->read = bq4802_read_mem;
 		p->write = bq4802_write_mem;
 	} else {
-- 
2.7.4

