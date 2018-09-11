Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68071C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E088C2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DN/ZOUPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E088C2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbeILEek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 00:34:40 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39582 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbeILEek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 00:34:40 -0400
Received: by mail-pl1-f196.google.com with SMTP id w14-v6so24918plp.6;
        Tue, 11 Sep 2018 16:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aPEzi/n+I+NAyw/CrtLwb3cb0Gi7zUQHMoGoDJ2O1Rc=;
        b=DN/ZOUPFIHtxm8dn3fCBPZYvIqlOP4DcWjCBpIZpPWDACd2bQdDTJ9Yi1OQ9VLmTFt
         kYOi0rV8WR5CSm+09gpcqe6hLKmbV0V1sLMzqd32w2vJHnSn2sIj5Fy6Qbmy9yFgbQvL
         ikRYz+xG6J3oghfdMUi9Uw6ZfREV0d5zgiOaYVGheTChAzqpzg7qBaeRrTysXUdImwtb
         lV+pDhV+XPkCMMUm7ThrlIlNLXJeNwzc/8FjOIpy4vZSyD/K0FdgUT5mNvjynp9+uDCz
         iaKJr8DwX65FQV2xRxVww78aaNfUEgI+I77lw+PHax1yRsE+hkTyEIY5uNSi+3hEwjLx
         r/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=aPEzi/n+I+NAyw/CrtLwb3cb0Gi7zUQHMoGoDJ2O1Rc=;
        b=IwHVe0TpT26TyNHmU1cQ5q9ut5KE+XG/KTRteAp5CsFdw5M5ClheBahNBMu3gTEYZW
         MD6vffav4HpvjxPejcwYE5Gqf1ePnLB7iUyqr00j+McFYnkrkjkVe04mk2dgkwm3INiz
         MlHsUMgssWkwKbeUWJhe2JugxUUDvaAU9bif+nC/6imbXl+PGyRxCnvWFKo/y8Me2l15
         XuH4paD7w8UZJ2y2r1VsX+zPvOHy2lokNu7zgarBZ5EuE19ot+YmEGQhI9teaelIWn7z
         w9T2mRRNDoGj7FeL1s2Vl9ir8e8xzLu8+UtvF4XUWTxtzyPeubhF65Gm18M8lsDQpqrN
         JbTg==
X-Gm-Message-State: APzg51D0WIUH9GcbUNiyfbbRqK8/tcZiULe5XTJoZET9KnQNbAUCpBRp
        awGz8fguE+QjaEoqW8lvmTY=
X-Google-Smtp-Source: ANB0VdbKNZ8awRMLn7KUxGnYocZMLedc18X3GXSk9Yyt7deRKYgdciNvLLTelP/nBSv7ophAmqJ5dw==
X-Received: by 2002:a17:902:c6b:: with SMTP id 98-v6mr29792109pls.233.1536708785677;
        Tue, 11 Sep 2018 16:33:05 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id w5-v6sm24216064pfn.44.2018.09.11.16.33.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 16:33:04 -0700 (PDT)
Date:   Tue, 11 Sep 2018 16:33:02 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
        linux-aspeed@lists.ozlabs.org,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jarkko.nikula@linux.intel.com,
        James Feist <james.feist@linux.intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH i2c-next v6] i2c: aspeed: Handle master/slave combined
 irq events properly
Message-ID: <20180911233302.GA18799@roeck-us.net>
References: <20180823225731.19063-1-jae.hyun.yoo@linux.intel.com>
 <20180911183734.GA21976@roeck-us.net>
 <1f34fe8c-69ef-5f2d-25dc-d5f6037cc558@linux.intel.com>
 <20180911204107.GA26017@roeck-us.net>
 <e5135af4-9105-214f-5de2-65cc03804222@linux.intel.com>
 <CACPK8Xdv3aP_zOHAL0WMgwvkpBHAUesU7OdhW==jgvXjRmt-Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8Xdv3aP_zOHAL0WMgwvkpBHAUesU7OdhW==jgvXjRmt-Zw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 08:23:29AM +0930, Joel Stanley wrote:
> On Wed, 12 Sep 2018 at 07:48, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
> >
> > On 9/11/2018 1:41 PM, Guenter Roeck wrote:
> > > On Tue, Sep 11, 2018 at 01:30:41PM -0700, Jae Hyun Yoo wrote:
> 
> > >> I checked this patch again but it doesn't have any change that could
> > >> affect to the probing flow. I'll debug the issue on qemu 3.0 environment
> > >> and will share if I find something.
> > >>
> > > The problem may be that qemu and the new code disagree how interrupts
> > > should be generated and handled, and the new code does not handle the
> > > interrupts it receives from the simulated hardware. This will result
> > > in i2c device probe failure, which in turn can cause all kinds of
> > > problems.
> > >
> >
> > Yes, that makes sense. Looks like it should be reverted until the issue
> > is fixed. Will submit a patch to revert it.
> 
> Let's not rush. The qemu model was written in order to allow us to
> test the kernel code, and was validated by the kernel driver we have.
> We've had situations in the past (with the i2c driver in fact) where a
> change in the driver required an update of the model to be more
> accurate.
> 
> I suggest we wait until Cedric has a chance to look at the issue
> before reverting the patch.
> 

Looking into the patch, clearing the interrupt status at the end of an
interrupt handler is always suspicious and tends to result in race
conditions (because additional interrupts may have arrived while handling
the existing interrupts, or because interrupt handling itself may trigger
another interrupt). With that in mind, the following patch fixes the
problem for me.

Guenter

---

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index c258c4d9a4c0..c488e6950b7c 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -552,6 +552,8 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
 
 	spin_lock(&bus->lock);
 	irq_received = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
+	/* Ack all interrupt bits. */
+	writel(irq_received, bus->base + ASPEED_I2C_INTR_STS_REG);
 	irq_remaining = irq_received;
 
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
@@ -584,8 +586,6 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
 			"irq handled != irq. expected 0x%08x, but was 0x%08x\n",
 			irq_received, irq_handled);
 
-	/* Ack all interrupt bits. */
-	writel(irq_received, bus->base + ASPEED_I2C_INTR_STS_REG);
 	spin_unlock(&bus->lock);
 	return irq_remaining ? IRQ_NONE : IRQ_HANDLED;
 }

