Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339FEC5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC86A20836
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hcqm6L7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC86A20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965048AbeFRUyB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 16:54:01 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36049 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935708AbeFRUw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 16:52:59 -0400
Received: by mail-pl0-f68.google.com with SMTP id a7-v6so9676020plp.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 13:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=96USV6C54uRHxC6nrrC3LgcFLVwryPmux7y3++LNzZQ=;
        b=hcqm6L7eMzPEfJj0AmnEv7mAl5K0RywLLwodQdy3ef1AzGT5ufSLa+xjGXzPZlmnl5
         L1CpRJSMrUl62zEv3Z+hninpfm+tv+6FW7gCFwRQECOdw4DTMIarqNj9t7KuyJDqT21n
         m9uHzXgmGYRllvBsoD7VH+pp5/zopelMwXeOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=96USV6C54uRHxC6nrrC3LgcFLVwryPmux7y3++LNzZQ=;
        b=JCb7pT71F3iV+iZLSILGVScgLYxZpQtNJIkjKLn9Gf37xxe8gGFg0Zfu8jX1Khqr5G
         5x5n4zrdBtEOu/TacYxEoVMVA8EKUC6r3elpCFGU5w6y3dNfRClu/aHKP+QDxLmhnhkC
         MALeJLeLGNR9oACh7psi22mre19GRHqbWUNfwudndCv1+hL8aS8MCJIvd0sX/dGmCmRK
         Q+NAMQe1oJzqDNSUtKG3ftOk5GdjCTWHLkWN2hvF+TB8moIVu3ifuhpSF8r3jaKPrtht
         AkG74aUgBecP1rxeVQbqKpO9j/qHddEyTPLwF6qI4xktJZWOrHBEPyA/ogq+4KDqaQh1
         Npuw==
X-Gm-Message-State: APt69E1E6h2VGRmxfsHU7uZGb+FI9dPgH0O1MqH5QRaMROCEnTnZuFe2
        xc5PtMpDnCDRdcXvXOtJfjZTkA==
X-Google-Smtp-Source: ADUXVKLoAE+Pv+Rkr4gEcmcvM5KCOABytlIVRcJkdojt6rMrNyX+m0erjzU0IqQ9D6YjBuYtofBniA==
X-Received: by 2002:a17:902:64cf:: with SMTP id y15-v6mr15743339pli.53.1529355179005;
        Mon, 18 Jun 2018 13:52:59 -0700 (PDT)
Received: from swboyd.mtv.corp.google.com ([2620:0:1000:1511:d30e:62c6:f82c:ff40])
        by smtp.gmail.com with ESMTPSA id a27-v6sm27052196pfc.18.2018.06.18.13.52.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 13:52:58 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Subject: [PATCH 1/3] pinctrl: msm: Really mask level interrupts to prevent latching
Date:   Mon, 18 Jun 2018 13:52:53 -0700
Message-Id: <20180618205255.246104-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
In-Reply-To: <20180618205255.246104-1-swboyd@chromium.org>
References: <20180618205255.246104-1-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupt controller hardware in this pin controller has two status
enable bits. The first "normal" status enable bit enables or disables
the summary interrupt line being raised when a gpio interrupt triggers
and the "raw" status enable bit allows or prevents the hardware from
latching an interrupt into the status register for a gpio interrupt.
Currently we just toggle the "normal" status enable bit in the mask and
unmask ops so that the summary irq interrupt going to the CPU's
interrupt controller doesn't trigger for the masked gpio interrupt.

For a level triggered interrupt, the flow would be as follows: the pin
controller sees the interrupt, latches the status into the status
register, raises the summary irq to the CPU, summary irq handler runs
and calls handle_level_irq(), handle_level_irq() masks and acks the gpio
interrupt, the interrupt handler runs, and finally unmask the interrupt.
When the interrupt handler completes, we expect that the interrupt line
level will go back to the deasserted state so the genirq code can unmask
the interrupt without it triggering again.

If we only mask the interrupt by clearing the "normal" status enable bit
then we'll ack the interrupt but it will continue to show up as pending
in the status register because the raw status bit is enabled, the
hardware hasn't deasserted the line, and thus the asserted state latches
into the status register again. When the hardware deasserts the
interrupt the pin controller still thinks there is a pending unserviced
level interrupt because it latched it earlier. This behavior causes
software to see an extra interrupt for level type interrupts each time
the interrupt is handled.

Let's fix this by clearing the raw status enable bit for level type
interrupts so that the hardware stops latching the status of the
interrupt after we ack it. We don't do this for edge type interrupts
because it seems that toggling the raw status enable bit for edge type
interrupts causes spurious edge interrupts.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Doug Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 0e22f52b2a19..3563c4394837 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -626,6 +626,19 @@ static void msm_gpio_irq_mask(struct irq_data *d)
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	val = readl(pctrl->regs + g->intr_cfg_reg);
+	/*
+	 * Leaving the RAW_STATUS_EN bit enabled causes level interrupts that
+	 * are still asserted to re-latch after we ack them. Clear the raw
+	 * status enable bit too so the interrupt can't even latch into the
+	 * hardware while it's masked, but only do this for level interrupts
+	 * because edge interrupts have a problem with the raw status bit
+	 * toggling and causing spurious interrupts.
+	 */
+	if (irqd_get_trigger_type(d) & IRQ_TYPE_LEVEL_MASK) {
+		val &= ~BIT(g->intr_raw_status_bit);
+		writel(val, pctrl->regs + g->intr_cfg_reg);
+	}
+
 	val &= ~BIT(g->intr_enable_bit);
 	writel(val, pctrl->regs + g->intr_cfg_reg);
 
@@ -647,6 +660,10 @@ static void msm_gpio_irq_unmask(struct irq_data *d)
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	val = readl(pctrl->regs + g->intr_cfg_reg);
+	if (irqd_get_trigger_type(d) & IRQ_TYPE_LEVEL_MASK) {
+		val |= BIT(g->intr_raw_status_bit);
+		writel(val, pctrl->regs + g->intr_cfg_reg);
+	}
 	val |= BIT(g->intr_enable_bit);
 	writel(val, pctrl->regs + g->intr_cfg_reg);
 
-- 
Sent by a computer through tubes

