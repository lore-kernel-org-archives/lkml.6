Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C58DC04AB8
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 03:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2423920671
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 03:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwNzTMSR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2423920671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbeINImm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 04:42:42 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36788 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbeINIml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 04:42:41 -0400
Received: by mail-pl1-f196.google.com with SMTP id p5-v6so3526760plk.3;
        Thu, 13 Sep 2018 20:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=CE7CisDtOe1qc1Y/eLDbkwNL86Hd/5IDA1nzcGb+Rck=;
        b=KwNzTMSRXNLaW9ANNkIs6Yq+m7zeuGN4/ewCCT5Nj6iFCmSg2fh+MkGIApx/xYhgjX
         nwyV1SjVNBeZ2POvDawi1PNqwU6hHJBiC8sLmhrcg75Z/XjhjV/1iaPgMRHcUe6Y22b/
         JMZvrHmkTiyeQ8ObVMNjW5vZALiYAFIySNHPwmF+LXIarcIVZ2+o0qnnoalsbjQxyaro
         IlzNEUsk5DpmYpCl0/TjXABm3yLdBlFPRP6+nXDlUdcIPq1XATCsCp3kSKFVp0N7bBkl
         JqSE1Q1fzvYRLz6a56fzDO6tKFK1ddzYXwOUDRaxjAkIVewKpGb8yl5VEklI8JV1YCdI
         Vaeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=CE7CisDtOe1qc1Y/eLDbkwNL86Hd/5IDA1nzcGb+Rck=;
        b=RzgRlNosUrUizJAfkvzkbTsPMOspcueuy6eZOkX4wtmtZ69YkLuYeGnzKU5mupwokX
         CEAjV8V5FHkQHmbb1CA+UrEd03fXJdw6DItlF90R93Tnlm56KIWm/nSdnPfx6+fKIMt8
         QSJSAM4aAbEAcTH4x+t54H+8et1Jn6xWqOOuUG7CORQW762baxbcZM0WC/Egi9hKwETT
         EYv0iuqxCnJydDZKC786CIgMWoiTWBkbrVFlec14372q12iqnMmuMSu1BnkOpzaZbAjT
         9oME1qcyVAI2Xr8we6hjwXPrmhFyutZn9FS3aKNqd+xviuM1cPw+EjPUN9RSG3rygEOl
         wCsg==
X-Gm-Message-State: APzg51BAcp4bCP0W78EH1hcMDOhLLZfimXI5SCzvz+UveRnowNDTZy1U
        fTqG1IgSRkW1DnXqcmdS88o=
X-Google-Smtp-Source: ANB0VdY0P35yn4UBN0WXK1MqxgjjrwVhBKujPYiXYzCz900G4grpBDQ2TSO01QC/r4U8tXmAjH1VBA==
X-Received: by 2002:a17:902:714f:: with SMTP id u15-v6mr10168834plm.154.1536895813994;
        Thu, 13 Sep 2018 20:30:13 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id h4-v6sm7881511pfe.49.2018.09.13.20.30.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 20:30:12 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: [PATCH] i2c: aspeed: Acknowledge most interrupts early in interrupt handler
Date:   Thu, 13 Sep 2018 20:30:10 -0700
Message-Id: <1536895810-28903-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3e9efc3299dd ("i2c: aspeed: Handle master/slave combined irq events
properly") moved interrupt acknowledgment to the end of the interrupt
handler. In part this was done because the AST2500 datasheet says:

 I2CD10 Interrupt Status Register
   bit 2 Receive Done Interrupt status
         S/W needs to clear this status bit to allow next data receiving.

Acknowledging Receive Done before receive data was handled resulted in
receive errors on high speed I2C busses.

However, interrupt acknowledgment was not only moved to the end of the
interrupt handler for Receive Done Interrupt status, but for all interrupt
status bits. This could result in race conditions if a second interrupt was
received during interrupt handling and not handled but still acknowledged
at the end of the interrupt handler.

Acknowledge only "Receive Done Interrupt status" late in the interrupt
handler to solve the problem.

Fixes: 3e9efc3299dd ("i2c: aspeed: Handle master/slave combined irq events properly")
Cc: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc: Joel Stanley <joel@jms.id.au>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/i2c/busses/i2c-aspeed.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index c258c4d9a4c0..3d518e09369f 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -552,6 +552,9 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
 
 	spin_lock(&bus->lock);
 	irq_received = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
+	/* Ack all interrupts except for Rx done */
+	writel(irq_received & ~ASPEED_I2CD_INTR_RX_DONE,
+	       bus->base + ASPEED_I2C_INTR_STS_REG);
 	irq_remaining = irq_received;
 
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
@@ -584,8 +587,10 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
 			"irq handled != irq. expected 0x%08x, but was 0x%08x\n",
 			irq_received, irq_handled);
 
-	/* Ack all interrupt bits. */
-	writel(irq_received, bus->base + ASPEED_I2C_INTR_STS_REG);
+	/* Ack Rx done */
+	if (irq_received & ASPEED_I2CD_INTR_RX_DONE)
+		writel(ASPEED_I2CD_INTR_RX_DONE,
+		       bus->base + ASPEED_I2C_INTR_STS_REG);
 	spin_unlock(&bus->lock);
 	return irq_remaining ? IRQ_NONE : IRQ_HANDLED;
 }
-- 
2.7.4

