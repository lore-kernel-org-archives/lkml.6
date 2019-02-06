Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6165C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A67B2080D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XMrhC9zG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbfBFPVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:21:36 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36114 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbfBFPVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 10:21:35 -0500
Received: by mail-lj1-f194.google.com with SMTP id g11-v6so6411242ljk.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 07:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VXEfSUVHDZBtxIDehDg39kf3Kcy+B5w82asK2nt7zH8=;
        b=XMrhC9zGmUxM214BZIL0u94LgkyF+AjOlO57MLvc7b8+kQlx9XrImvTmVE/nySajTP
         Dg6dIvJnno8LCHPKVHDfuS9V+H471IL6NkA3bhumPN/x0siDntWxQa1e+PRZQP4vTQVM
         qtgijq8H9jdrG2empG9FieIZ64dTSQB7f/eH+LPgVuBNo01yF9dvIz9mvRqhyw+p6/yG
         UYLLnnf0HEBnWuZPayf3vaRXkzPfxmJnlAuAztPH/poGMM7uK/sqcVPuQ7uLOnTgxzbP
         NQtdcjxoveV2xNWhngcX+AkbJOWLflJo338tEAUtRy64mbj7vEwHmM8tN1ALEbx8aYBL
         vwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VXEfSUVHDZBtxIDehDg39kf3Kcy+B5w82asK2nt7zH8=;
        b=fw7MD8SzgvwGA04DNaetLfSg5OC08VupXCJVijL80hXdB41JlnQLrZH0x1y3s2U3yN
         Xa5+k3eZ2rpn9A5fJYT9O+KwXxdtiCVUgYYEsnRt2hhlMxAJkfbT4cug9YmBohkOpFcw
         O2eOaSSFFr3H5fcM2iEXWUqY5gFJ1smGd9UcuRolb1pmFbsjZQq8dRh+2Vz9GIOSUd29
         j3b3vAshcN18aYEl7VBc3HjxZSXd+7/h9k8ooSNHwYpiElw3p/6Yl/LXP8XVOaV8T978
         cOq6+V7gAgIibvPJsdBhgq5Q2aIE5P9kqt9v8kZVZ+OZrj/l7YqNATR87es5SFU7yEEj
         ZyYA==
X-Gm-Message-State: AHQUAuY+/q3NRcAUzHuvs2/xJwDjKRs/9qD56YG3psqizFdA7VTq8pbx
        hk6QNXyzYXtFNhgVBr5burWziZvmdKmkKJmcnA2H1g==
X-Google-Smtp-Source: AHgI3IaV/mUQVG8+qatCQxUQCjG0Ou3kP5PbQFFNURa46DYs39K3KEKJ91PGIqFEEzRAvb6TlQnwHyzi+rl7nUQh0uw=
X-Received: by 2002:a2e:9356:: with SMTP id m22-v6mr6796198ljh.135.1549466492799;
 Wed, 06 Feb 2019 07:21:32 -0800 (PST)
MIME-Version: 1.0
References: <20190125162302.14036-1-masneyb@onstation.org>
In-Reply-To: <20190125162302.14036-1-masneyb@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 6 Feb 2019 16:21:20 +0100
Message-ID: <CACRpkdbKGfupo6uWukYQ-+zsfyS8rbU4v96HBxCgbJi5OhA83g@mail.gmail.com>
Subject: Re: [PATCH 0/9] qcom: ssbi-gpio: add support for hierarchical IRQ chip
To:     Brian Masney <masneyb@onstation.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 5:23 PM Brian Masney <masneyb@onstation.org> wrote:

> This patch series adds hierarchical IRQ chip support to ssbi-gpio so
> that device tree consumers can request an IRQ directly from the GPIO
> block rather than having to request an IRQ from the underlying PMIC.

I had to apply the patch I just sent out:
"genirq: introduce irq_chip_mask_ack_parent()"
and then the following diff to make things work. But after that:
Tested-by: Linus Walleij <linus.walleij@linaro.org>
It works like a charm on the APQ8060 DragonBoard!

I would recommend you just fold the below into your series
and add the extra patch for genirq to your patch stack.

From 14569f7901cfe84221ed775ba63b09b32277de62 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 6 Feb 2019 16:19:32 +0100
Subject: [PATCH] qcom hierarchy: fixup hacks

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mfd/qcom-pm8xxx.c                | 19 ++++---------------
 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c |  8 ++++----
 2 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/mfd/qcom-pm8xxx.c b/drivers/mfd/qcom-pm8xxx.c
index a976890c4019..2ee3b075cd0e 100644
--- a/drivers/mfd/qcom-pm8xxx.c
+++ b/drivers/mfd/qcom-pm8xxx.c
@@ -82,8 +82,9 @@ struct pm_irq_chip {
  struct irq_domain *irqdomain;
  unsigned int num_blocks;
  unsigned int num_masters;
- u8 config[0];
  const struct pm_irq_data *pm_irq_data;
+ /* MUST BE AT THE END OF THIS STRUCT */
+ u8 config[0];
 };

 static int pm8xxx_read_block_irq(struct pm_irq_chip *chip, unsigned int bp,
@@ -303,7 +304,6 @@ static int pm8xxx_irq_set_type(struct irq_data *d,
unsigned int flow_type)
 {
  struct pm_irq_chip *chip = irq_data_get_irq_chip_data(d);
  unsigned int pmirq = irqd_to_hwirq(d);
- irq_flow_handler_t flow_handler;
  int irq_bit;
  u8 block, config;

@@ -317,8 +317,6 @@ static int pm8xxx_irq_set_type(struct irq_data *d,
unsigned int flow_type)
  chip->config[pmirq] &= ~PM_IRQF_MASK_RE;
  if (flow_type & IRQF_TRIGGER_FALLING)
  chip->config[pmirq] &= ~PM_IRQF_MASK_FE;
-
- flow_handler = handle_edge_irq;
  } else {
  chip->config[pmirq] |= PM_IRQF_LVL_SEL;

@@ -326,11 +324,9 @@ static int pm8xxx_irq_set_type(struct irq_data
*d, unsigned int flow_type)
  chip->config[pmirq] &= ~PM_IRQF_MASK_RE;
  else
  chip->config[pmirq] &= ~PM_IRQF_MASK_FE;
-
- flow_handler = handle_level_irq;
  }

- irq_set_handler_locked(d, flow_handler);
+ irq_set_handler_locked(d, handle_level_irq);

  config = chip->config[pmirq] | PM_IRQF_CLR;
  return pm8xxx_config_irq(chip, block, config);
@@ -386,15 +382,8 @@ static void pm8xxx_irq_domain_map(struct pm_irq_chip *chip,
    struct irq_domain *domain, unsigned int irq,
    irq_hw_number_t hwirq, unsigned int type)
 {
- irq_flow_handler_t handler;
-
- if (type & IRQ_TYPE_EDGE_BOTH)
- handler = handle_edge_irq;
- else
- handler = handle_level_irq;
-
  irq_domain_set_info(domain, irq, hwirq, chip->pm_irq_data->irq_chip,
-     chip, handler, NULL, NULL);
+     chip, handle_level_irq, NULL, NULL);
  irq_set_noprobe(irq);
 }

diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
index d4847f42f52f..e2509f26be4c 100644
--- a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
@@ -696,8 +696,7 @@ static int pm8xxx_pin_populate(struct pm8xxx_gpio *pctrl,

 static struct irq_chip pm8xxx_irq_chip = {
  .name = "ssbi-gpio",
- .irq_mask = irq_chip_mask_parent,
- .irq_ack = irq_chip_ack_parent,
+ .irq_mask_ack = irq_chip_mask_ack_parent,
  .irq_unmask = irq_chip_unmask_parent,
  .irq_set_type = irq_chip_set_type_parent,
  .flags = IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_SKIP_SET_WAKE,
@@ -781,13 +780,14 @@ static int pm8xxx_gpio_probe(struct platform_device *pdev)
  struct pinctrl_pin_desc *pins;
  struct pm8xxx_gpio *pctrl;
  int ret;
- int i, npins;
+ int i;

  pctrl = devm_kzalloc(&pdev->dev, sizeof(*pctrl), GFP_KERNEL);
  if (!pctrl)
  return -ENOMEM;

- npins = (uintptr_t) device_get_match_data(&pdev->dev);
+ pctrl->dev = &pdev->dev;
+ pctrl->npins = (uintptr_t) device_get_match_data(&pdev->dev);

  pctrl->regmap = dev_get_regmap(pdev->dev.parent, NULL);
  if (!pctrl->regmap) {
-- 
2.20.1


Yours,
Linus Walleij
