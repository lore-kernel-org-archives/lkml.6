Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D15FC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 094BB206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXhv4+xD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 094BB206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390330AbeIUQOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:14:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32832 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeIUQOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 12:14:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id n11-v6so1103526wro.0;
        Fri, 21 Sep 2018 03:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8k9rGRkBKmUalmlPNgE7G1YhIeZTdJ1E2ctaQaUHbgc=;
        b=nXhv4+xD/X/n+fvJs0sWff46ScJgJ89XXcrbAovHCNb1Kzrruu2mkPNSlxVwZ1ileD
         a2QlbrW/apwu3ma4CxxxgREe4c6jpbEhNa+ABX+3/IUzwO/g1m3CEyTcsaMBtlCCog0S
         hhFyMm1sES0dVyhSnIUADk9IWIpnMKG7cHbhHRo6CoK+BsYNGRLVlMUG+cjmhyHTxoqI
         2003niKvo741sm9OR/XzW1UuKJ6pzYOgx0KU7sDvJ+EBRvNFGWZ0FvWtYnsdBfNS572v
         GCslxLp/ThByyfo7pNMfhptfr/t7Tg16J6MuUVZ67kbIyFOpHZ/GcaNmSSHuNP0Ouf0S
         IMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8k9rGRkBKmUalmlPNgE7G1YhIeZTdJ1E2ctaQaUHbgc=;
        b=MIGX/5WslqxRVK/LSqj07rYQg6SGuCVYcXZM533Pw0KtEQuZN9dw41FomfebxDEqmP
         7xg8vlr/BN46Io3dI0uANLcqGHgNFC+5K0tE6RJFEsOKp4GsDitECq4EjbG2uB/+6+Mj
         dt2QdEOeBiShtnCpGdn16KwJEwG5InQxc9uAOtkaBO+2qdBWZ/oSsbwCFCpLWovGd/f/
         4JDcZAVk7Z2Hj1KXQYd2MM5Wq9WMsQ5iDhWDY3Yrz/Yw48U9HAjALsZyYx9lHAJ6BhJ0
         bbVZIQdFFjtnxTS8yvUSWJgzR4ctEDdjXice2eTVFUwZWoST5p2tDqEgO7xxxBVFiGrP
         KumQ==
X-Gm-Message-State: APzg51B/X9PlTRwVzHJZCzyzkNQUDP2GQ067VuClVNDz8hqxj2eXOcd7
        rHu/YAgu2lUitXonBSNVqqQ=
X-Google-Smtp-Source: ANB0VdaOq2WIq+IdaE2+H/Cvh/r7sVHdHZMaRDqmgc2HxT+Ysw8pB36NsCdTsBbbtoMdiwqDVyqEug==
X-Received: by 2002:a5d:61c1:: with SMTP id q1-v6mr39099483wrv.33.1537525548490;
        Fri, 21 Sep 2018 03:25:48 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id 14-v6sm11455622wmp.32.2018.09.21.03.25.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 03:25:48 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] Implement wake event support on Tegra186 and later
Date:   Fri, 21 Sep 2018 12:25:37 +0200
Message-Id: <20180921102546.12745-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Hi,

The following is a set of patches that allow certain interrupts to be
used as wakeup sources on Tegra186 and later. To implement this, each
of the GPIO controllers' IRQ domain needs to become hierarchical, and
parented to the PMC domain. The PMC domain in turn implements a new
IRQ domain that is a child to the GIC IRQ domain.

The above ensures that the interrupt chip implementation of the PMC is
called at the correct time. The ->irq_set_type() and ->irq_set_wake()
implementations program the PMC wake registers in a way to enable the
given interrupts as wakeup sources.

This is based on a suggestion from Thomas Gleixner that resulted from
the following thread:

	https://lkml.org/lkml/2018/9/13/1042

Linus, I'm sending this as one series, but both the GPIO and PMC patches
should be applicable separately. There are no build-time dependencies in
the series. So once this has been duly reviewed, I think patches 1-5 can
go through the Tegra tree, while patches 6-9 should go through the GPIO
tree.

Thierry

Thierry Reding (9):
  dt-bindings: tegra186-pmc: Add interrupt controller properties
  soc/tegra: pmc: Add Tegra194 support
  soc/tegra: pmc: Add wake event support
  soc/tegra: pmc: Add initial Tegra186 wake events
  soc/tegra: pmc: Add initial Tegra194 wake events
  gpio: Add support for hierarchical IRQ domains
  dt-bindings: tegra186-gpio: Add wakeup parent support
  gpio: tegra186: Rename flow variable to type
  gpio: tegra186: Implement wake event support

 .../arm/tegra/nvidia,tegra186-pmc.txt         |   3 +
 .../bindings/gpio/nvidia,tegra186-gpio.txt    |   7 +
 drivers/gpio/gpio-tegra186.c                  | 109 +++++-
 drivers/gpio/gpiolib.c                        |  15 +-
 drivers/soc/tegra/pmc.c                       | 312 +++++++++++++++++-
 include/linux/gpio/driver.h                   |   6 +
 include/soc/tegra/pmc.h                       |  21 ++
 7 files changed, 451 insertions(+), 22 deletions(-)

-- 
2.19.0

