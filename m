Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5860DC070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 23:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050632146E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 23:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9jASYqC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 050632146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbeIMEhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 00:37:25 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37354 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbeIMEhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 00:37:24 -0400
Received: by mail-pl1-f193.google.com with SMTP id f1-v6so1705863plt.4;
        Wed, 12 Sep 2018 16:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bBB+ZsvSWSmi4xNtTNLtWwDQGBmvBwol/TKax8NUdH8=;
        b=h9jASYqCgn517RsAMEsBGVhsin5hoUSefaE752j7ASwzAKyGgDTEkv2lGjybJptfqQ
         hAlXp6GlqP2YfPnsaHMQtLOerfg6EH85X7YI5Q5Bn7ailm6/xgcJ0v6tHvMfeft/zXvP
         noLsBmf+29vtqnIPnFt9zVSyBVWDiMzxfKEGR0pCS5sRfnLNIIjLziAG44G1clhQPgu/
         FWy1IUJc2Vp49syfccu7VARoCyJTie731sbYjmraG8QFbm3LgOy7+R7jnx26idcGGgme
         m29yRWF6hqgJb7ZtUeqs93oaCtoTi8zy9KlMxQF4tP4qtg/g7j5kCbKvCdbU/+9SF3P8
         k9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=bBB+ZsvSWSmi4xNtTNLtWwDQGBmvBwol/TKax8NUdH8=;
        b=qtEIxCH5FZ0mc8tNXdeK8mL9XB5Xf3pFggtKSWaQ9WmeVbwRXlF5m83w3TaDM9u97V
         aC7EXA2Ba9z0rN0tTVCHTOWMCqjapGH/9WARybl75L7PfDT5MzC+IOVK0V3g0YdOpBqt
         EgyZQdDu/zrHYAsZlj94B9Kj6kimBszcJ2WUq45uZpb/C1nQgUuaXZJquijR1DnzlAq0
         OVUItpaa+uOIuPXAAuIbjVndZuLLukqOUhnryZ2dYOSN7RixvcCpJjH4x+CUgGknmei5
         am08ZNvft3tiSltu3oYUzfP7sMKGJko3R93uf5k7NF20hrdct1AuMy5hXHpFDcvdbioP
         PkJw==
X-Gm-Message-State: APzg51CXsGIXzpfb44l2SgzoT3bKWbbC2xQDV9fVMBg1SwKoFMCuB7Ts
        n/AAg45R4Lose47Pgza2eok=
X-Google-Smtp-Source: ANB0VdaHS5H28tH3wg55jecNrpy9hMTZA5DhboZpKHu6+norITaL8RAVXxxLN8bihy3WpC8OswxU+w==
X-Received: by 2002:a17:902:bf0b:: with SMTP id bi11-v6mr4628216plb.76.1536795038227;
        Wed, 12 Sep 2018 16:30:38 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id u17-v6sm4777010pfa.176.2018.09.12.16.30.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 16:30:37 -0700 (PDT)
Date:   Wed, 12 Sep 2018 16:30:35 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-i2c@vger.kernel.org, jarkko.nikula@linux.intel.com,
        =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        James Feist <james.feist@linux.intel.com>
Subject: Re: [PATCH i2c-next v6] i2c: aspeed: Handle master/slave combined
 irq events properly
Message-ID: <20180912233035.GA10713@roeck-us.net>
References: <e5135af4-9105-214f-5de2-65cc03804222@linux.intel.com>
 <CACPK8Xdv3aP_zOHAL0WMgwvkpBHAUesU7OdhW==jgvXjRmt-Zw@mail.gmail.com>
 <20180911233302.GA18799@roeck-us.net>
 <5698ca34-14c9-8d05-c4e6-5acf85ff9d14@linux.intel.com>
 <20180912013449.GA12612@roeck-us.net>
 <7fd98646-fb5a-be4d-ce37-84b74e0fa8b3@linux.intel.com>
 <20180912195844.GA6893@roeck-us.net>
 <da7f4691-7428-3114-32bb-e0171f6c7228@linux.intel.com>
 <20180912203059.GA18201@roeck-us.net>
 <6a99dc09-b06d-88ee-2843-3bd88f883dc2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a99dc09-b06d-88ee-2843-3bd88f883dc2@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 03:31:06PM -0700, Jae Hyun Yoo wrote:
> >
> >I played with the code on both sides. I had to make changes in both
> >the linux kernel and in qemu to get the code to work again.
> >See attached.
> >
> >Guenter
> >
> >---
> >Linux:
> >
> >diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> >index c258c4d9a4c0..3d518e09369f 100644
> >--- a/drivers/i2c/busses/i2c-aspeed.c
> >+++ b/drivers/i2c/busses/i2c-aspeed.c
> >@@ -552,6 +552,9 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
> >  	spin_lock(&bus->lock);
> >  	irq_received = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
> >+	/* Ack all interrupts except for Rx done */
> >+	writel(irq_received & ~ASPEED_I2CD_INTR_RX_DONE,
> >+	       bus->base + ASPEED_I2C_INTR_STS_REG);
> >  	irq_remaining = irq_received;
> >  #if IS_ENABLED(CONFIG_I2C_SLAVE)
> >@@ -584,8 +587,10 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
> >  			"irq handled != irq. expected 0x%08x, but was 0x%08x\n",
> >  			irq_received, irq_handled);
> >-	/* Ack all interrupt bits. */
> >-	writel(irq_received, bus->base + ASPEED_I2C_INTR_STS_REG);
> >+	/* Ack Rx done */
> >+	if (irq_received & ASPEED_I2CD_INTR_RX_DONE)
> >+		writel(ASPEED_I2CD_INTR_RX_DONE,
> >+		       bus->base + ASPEED_I2C_INTR_STS_REG);
> >  	spin_unlock(&bus->lock);
> >  	return irq_remaining ? IRQ_NONE : IRQ_HANDLED;
> >  }
> >
> >---
> >qemu:
> >
> >diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
> >index c762c73..0d4aa08 100644
> >--- a/hw/i2c/aspeed_i2c.c
> >+++ b/hw/i2c/aspeed_i2c.c
> >@@ -180,6 +180,33 @@ static uint8_t aspeed_i2c_get_state(AspeedI2CBus *bus)
> >      return (bus->cmd >> I2CD_TX_STATE_SHIFT) & I2CD_TX_STATE_MASK;
> >  }
> >+static void aspeed_i2c_handle_rx_cmd(AspeedI2CBus *bus)
> >+{
> >+    int ret;
> >+
> >+    if (!(bus->cmd & (I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LAST))) {
> >+        return;
> >+    }
> >+    if (bus->intr_status & I2CD_INTR_RX_DONE) {
> >+        return;
> >+    }
> >+
> >+    aspeed_i2c_set_state(bus, I2CD_MRXD);
> >+    ret = i2c_recv(bus->bus);
> >+    if (ret < 0) {
> >+        qemu_log_mask(LOG_GUEST_ERROR, "%s: read failed\n", __func__);
> >+        ret = 0xff;
> >+    } else {
> >+        bus->intr_status |= I2CD_INTR_RX_DONE;
> >+    }
> >+    bus->buf = (ret & I2CD_BYTE_BUF_RX_MASK) << I2CD_BYTE_BUF_RX_SHIFT;
> >+    if (bus->cmd & I2CD_M_S_RX_CMD_LAST) {
> >+        i2c_nack(bus->bus);
> >+    }
> >+    bus->cmd &= ~(I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LAST);
> >+    aspeed_i2c_set_state(bus, I2CD_MACTIVE);
> >+}
> >+
> >  /*
> >   * The state machine needs some refinement. It is only used to track
> >   * invalid STOP commands for the moment.
> >@@ -188,7 +215,7 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
> >  {
> >      bus->cmd &= ~0xFFFF;
> >      bus->cmd |= value & 0xFFFF;
> >-    bus->intr_status = 0;
> >+    bus->intr_status &= I2CD_INTR_RX_DONE;
> >      if (bus->cmd & I2CD_M_START_CMD) {
> >          uint8_t state = aspeed_i2c_get_state(bus) & I2CD_MACTIVE ?
> >@@ -227,22 +254,7 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
> >      }
> >      if (bus->cmd & (I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LAST)) {
> >-        int ret;
> >-
> >-        aspeed_i2c_set_state(bus, I2CD_MRXD);
> >-        ret = i2c_recv(bus->bus);
> >-        if (ret < 0) {
> >-            qemu_log_mask(LOG_GUEST_ERROR, "%s: read failed\n", __func__);
> >-            ret = 0xff;
> >-        } else {
> >-            bus->intr_status |= I2CD_INTR_RX_DONE;
> >-        }
> >-        bus->buf = (ret & I2CD_BYTE_BUF_RX_MASK) << I2CD_BYTE_BUF_RX_SHIFT;
> >-        if (bus->cmd & I2CD_M_S_RX_CMD_LAST) {
> >-            i2c_nack(bus->bus);
> >-        }
> >-        bus->cmd &= ~(I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LAST);
> >-        aspeed_i2c_set_state(bus, I2CD_MACTIVE);
> >+        aspeed_i2c_handle_rx_cmd(bus);
> >      }
> >      if (bus->cmd & I2CD_M_STOP_CMD) {
> >@@ -263,6 +275,7 @@ static void aspeed_i2c_bus_write(void *opaque, hwaddr offset,
> >                                   uint64_t value, unsigned size)
> >  {
> >      AspeedI2CBus *bus = opaque;
> >+    int status;
> >      switch (offset) {
> >      case I2CD_FUN_CTRL_REG:
> >@@ -283,9 +296,16 @@ static void aspeed_i2c_bus_write(void *opaque, hwaddr offset,
> >          bus->intr_ctrl = value & 0x7FFF;
> >          break;
> >      case I2CD_INTR_STS_REG:
> >+        status = bus->intr_status;
> >          bus->intr_status &= ~(value & 0x7FFF);
> >-        bus->controller->intr_status &= ~(1 << bus->id);
> >-        qemu_irq_lower(bus->controller->irq);
> >+        if (!bus->intr_status) {
> >+            bus->controller->intr_status &= ~(1 << bus->id);
> >+            qemu_irq_lower(bus->controller->irq);
> >+        }
> >+        if ((status & I2CD_INTR_RX_DONE) && !(bus->intr_status & I2CD_INTR_RX_DONE)) {
> >+            aspeed_i2c_handle_rx_cmd(bus);
> >+            aspeed_i2c_bus_raise_interrupt(bus);
> >+        }
> >          break;
> >      case I2CD_DEV_ADDR_REG:
> >          qemu_log_mask(LOG_UNIMP, "%s: slave mode not implemented\n",
> >
> 
> Nice fix! LGTM. I've tested the new patch and checked that it works well
> on both low and high bus speed environments. Thanks a lot!
> 
> Can you please submit this patch?
> 
Assuming you mean both patches, sure, can do. I'll need to clean up
the qemu patch a bit, though; it looks too messy for my liking.

Guenter
