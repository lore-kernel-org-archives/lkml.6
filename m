Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7932AECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37012214DD
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CIoaKfN2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37012214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbeIRADD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 20:03:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34061 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728382AbeIRADD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 20:03:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id k19-v6so7972559pfi.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 11:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ltLNIPFLQyeoJzz76sivioQ9yctXRHCKZQ+WN0q2SaM=;
        b=CIoaKfN2eySOLQs0TGAuKs75AahlejX/lyY3GO2XfIkfbPpz+exypfcOSnjJSLm3W+
         n92b4ZTqsgyx5wO8XvdNLTdlm1K1q4OFWcoZ1+6XzAgpk+VNPMyiwpTpQ+h89u0dXrMC
         D5wYQfJ/hLhY+f1YcwDLLryTSTY618RFzlTJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ltLNIPFLQyeoJzz76sivioQ9yctXRHCKZQ+WN0q2SaM=;
        b=m9suF17bRN9KzxCeHzNZBLjMUDJ1+1NkFO4LyZTqDHIq9GdKh8Ap5M9BeyB/7RfYvy
         VZDKi283VBfsPoAT2H6HVEFgjrvbhEmtgP/2BIRaVkFSlCsDswWVDCKmJJycLWXgA9hk
         DHKSfeGFomvyRCjYfDahwoTi/jyXUPig67RkMbKRQwN3S0kMWQ+H7m+XmTEPAuHCsU7N
         Mclr7pGVYUYc6GbZfWiERPXIkQW6q8GVKMiRlaiJMfVHu7f7Ar1te0cxRZ9D1tbHSH+q
         beSY6PzPnIogpoRer3/7ic5lvG/oD76XQYXYT/5GO+O4HwSFpHvGjh1Y7WUoKMI5Wejd
         OXcA==
X-Gm-Message-State: APzg51CzAL5KNt9Yok0CMk9ZhlkJ9LrxC7hg5yoE8i4Qw9ZyftlvvvT5
        9JKvg6T37lWljc/91w6JJK9Fgg==
X-Google-Smtp-Source: ANB0VdanX4GnIIcQd+mQ1MyrRqafNBZ5WbLaKiJZjd6R0L8qJSNGuTwaZboLyS7DzOrIP85BHirEag==
X-Received: by 2002:a65:5581:: with SMTP id j1-v6mr24167193pgs.203.1537209269843;
        Mon, 17 Sep 2018 11:34:29 -0700 (PDT)
Received: from ubuntu.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id i7-v6sm17544137pgs.17.2018.09.17.11.34.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Sep 2018 11:34:29 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        broonie@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] serial: sprd: Remove unnecessary resource validation
Date:   Mon, 17 Sep 2018 11:33:42 -0700
Message-Id: <8aa7a92468beb45348bf113696deb263c3f27792.1537208449.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <96e34fdadaf3f354f5d8e0d2895508e7c7918839.1537208449.git.baolin.wang@linaro.org>
References: <96e34fdadaf3f354f5d8e0d2895508e7c7918839.1537208449.git.baolin.wang@linaro.org>
In-Reply-To: <96e34fdadaf3f354f5d8e0d2895508e7c7918839.1537208449.git.baolin.wang@linaro.org>
References: <96e34fdadaf3f354f5d8e0d2895508e7c7918839.1537208449.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_ioremap_resource() will valid the resources, thus remove the
unnecessary resource validation in the driver.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Acked-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
Changes from v1:
 - Add acked tag from Chunyan.
---
 drivers/tty/serial/sprd_serial.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index e18d8af..03b0cd4 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -710,15 +710,12 @@ static int sprd_probe(struct platform_device *pdev)
 		up->uartclk = clk_get_rate(clk);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "not provide mem resource\n");
-		return -ENODEV;
-	}
-	up->mapbase = res->start;
 	up->membase = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(up->membase))
 		return PTR_ERR(up->membase);
 
+	up->mapbase = res->start;
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "not provide irq resource: %d\n", irq);
-- 
1.9.1

