Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C48DECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C9721531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJWq5XsU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C9721531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388199AbeIUBCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:02:13 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42110 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387773AbeIUBCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:02:13 -0400
Received: by mail-pg1-f194.google.com with SMTP id y4-v6so4873623pgp.9;
        Thu, 20 Sep 2018 12:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NYKCzosd2yHyg482oEwQQtyC0evqIAxtkiG0dvXHqBo=;
        b=WJWq5XsU3acBwxl9t8IVcQIBiXLrcxGzduRWOepCZKQd5fvg+Fi1ePa/YmwWjYeVyV
         3AdweaEeQ+LiqhVt4I51LjsYxaPDvg+PREgdht3zxwlVFh1VFRnuq0owoPSo/QVElQjY
         NtFw+H2qlQVAabbrCasxm72W4fcgOCVTsyTREWkX6YJ8gAZK7YOkZu9ght4gACf3nnKq
         odUjRmg5cMA1vXLzvmEJj1UmaHfjoBO/Qp/NfdFRkw5mgZVtCkRBV2mDzaV8pdhkwSqW
         7gOS1vNYbOKfyqoIFyQ2dTafIOGlRvgv4C73gMBkH+54TTPjvXd7zZkDsOJU2CbVKeRW
         2/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NYKCzosd2yHyg482oEwQQtyC0evqIAxtkiG0dvXHqBo=;
        b=be+ifr84EYKxe8qyY/v7fGcKBl0/t0EBFM+yXElRkzcbwFyAvDr85khkRfqK1BG0Hv
         LSg1JdOpLsBDGJgQItkzd/y0Fef5/+/MlvnClJxolTvBQh0n6d5k9AFP13HexQV7QNyg
         6AYIo7aJNBNDUFWnvMKjZc8QC1tq1Dw5NfNuzwggEe/SKRmNia1gKNWNlbxoOCQkcA51
         HFVJujiDTw7tMB/Yuibo9sfYhb7f4zm+mrRwSYoXErsX4xkzMSohnzwhLNwrkftAbHYr
         d6EsIktBD83s8FQHM6t2RjeQuVFB25Aa67Ecj264CeaKM7qanO5RFXF97q1rB/PMRzJ9
         ljDg==
X-Gm-Message-State: APzg51Dn5u3bbW3RXsNJ2x1wqcLfKGIsUSgfi3eLvYS6m/ZnNCcpl9et
        YSJt5+znb1yt+PkhCQkcTAKnCmlw
X-Google-Smtp-Source: ANB0VdZSg0z56OKX8esTNibk0c3V6nY/zXJxghDGth/7nypRx8qtWk4A+lTGK9bt+NJJIvSfZBY+JQ==
X-Received: by 2002:a63:e116:: with SMTP id z22-v6mr38006275pgh.89.1537471033865;
        Thu, 20 Sep 2018 12:17:13 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id n9-v6sm40665601pfg.21.2018.09.20.12.17.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 12:17:12 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Al Cooper <alcooperx@gmail.com>,
        Ray Jui <ray.jui@broadcom.com>, Tejun Heo <tj@kernel.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH 0/9] AHCI and SATA PHY support for BCM63138
Date:   Thu, 20 Sep 2018 12:16:34 -0700
Message-Id: <20180920191646.18198-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon, Tejun,

This patch series adds support for the SATA AHCI and PHY found on the
ARM-basd BCM63138 DSL SoCs.

It would probably make sense for patches 1-3 to go through Kishon's
tree, patches 4-7 through Tejun's tree, and I would be merging the last
two patches through the Broadcom ARM-SoC tree.

Let me know if this is not a workable plan, thank you very much!

Florian Fainelli (9):
  dt-bindings: phy: Document BCM63138 compatible string
  phy: brcm-sata: allow PHY_BRCM_SATA driver to be built for DSL SoCs
  phy: brcm-sata: Add BCM63138 (DSL) PHY init sequence
  dt-bindings: ata: Document BCM63138 compatible string
  ata: ahci_brcm: Allow optional reset controller to be used
  ata: ahci_brcm: Match BCM63138 compatible strings
  ata: ahci_brcm: Allow using driver or DSL SoCs
  ARM: dts: BCM63xx: enable SATA PHY and AHCI controller
  ARM: bcm63138: Enable SATA AHCI and PHY

 .../bindings/ata/brcm,sata-brcm.txt           |  1 +
 .../devicetree/bindings/phy/brcm-sata-phy.txt |  1 +
 arch/arm/boot/dts/bcm63138.dtsi               | 30 ++++++++
 arch/arm/boot/dts/bcm963138dvt.dts            |  8 +++
 drivers/ata/Kconfig                           |  3 +-
 drivers/ata/ahci_brcm.c                       | 10 +++
 drivers/phy/broadcom/Kconfig                  |  3 +-
 drivers/phy/broadcom/phy-brcm-sata.c          | 70 +++++++++++++++++++
 8 files changed, 124 insertions(+), 2 deletions(-)

-- 
2.17.1

