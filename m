Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26667C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC9B32082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnTGvniA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC9B32082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbeH3XFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:05:07 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39480 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeH3XFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:05:06 -0400
Received: by mail-wm0-f67.google.com with SMTP id q8-v6so3067072wmq.4;
        Thu, 30 Aug 2018 12:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xCKx9NEGzJwtaXAXUXUGumz714/0g1o9mExKt4VtueU=;
        b=SnTGvniACGn8C6kPyeufdxpxFhMY2VEw7HBcss31a2xRvrYnQO2yG1L2pKJ7szYoOf
         yBw2PdOnKAqI3nfVaDCqiFvL+cQ3FJ6F4wdvVdYmBeZBnUmMotYfoEH/2/vMnpgEyf4B
         DpMYgZq3PLoFu4vmerbyUwVd4dh2QDf0xRYOC2vD6OR6rhNpJbcbsT2/HCEU0Hgfi0PK
         e8N2H2rsXUHLa/E3I6W37EJg7x1yYjWd5tTfIhDR2BAOvJV7lOnfX9GBtGFoF9nHx5PH
         juSEs3HM1h+Fp6OTuNgTFDDkE6Bt530MnbleuIZ8ozHK69zqby8whZZGf8M613IjoZZj
         Ulyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xCKx9NEGzJwtaXAXUXUGumz714/0g1o9mExKt4VtueU=;
        b=IL7POy7GQkrXDnGpZPvaK5KR8vGN1/aFLOxC9XuVooyeGsmf5OoufPa4DsGsA4Hi1d
         /7tn1xECe8cVVYVJjTk7QgQY0GxUMDPDcH/fC6QoeMGRmadYne1jUNNk95ujaRnuUKcZ
         3KLaxlCwls1P3au/FDSSHDr8m14FQO/QbNDtN/yX3WawxHl6eeadpnHGoTGC+VFkT2PH
         QuhJY0yydphJ3FoumNbLRSdh8tOuJJJwKfAz35Y0nV1ZdeOsPPtpEqKOca7tmUexdhHG
         8+KoYKOW+d1g31lmd1EDOXtd9fBAiePIaG4thgoYIHq5PME+s1qAY7WSx7lWyWmup1ro
         Mh/g==
X-Gm-Message-State: APzg51B2FTdzt6S4Vqy4v5gIiQrzyLVQvLi7QbSiX3012xuzPt3sMMpM
        qMiHAE8K3UmlFwSzWmR/lyA=
X-Google-Smtp-Source: ANB0Vdai2rqaT7J1abPZq/xBuLeSOI7jxtqizkXKLbhigygIbMjWpftzdbsf0oYRSY9S12A8LV86YA==
X-Received: by 2002:a1c:3f08:: with SMTP id m8-v6mr2759411wma.88.1535655688420;
        Thu, 30 Aug 2018 12:01:28 -0700 (PDT)
Received: from Red.localdomain ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id w17-v6sm2937095wmc.43.2018.08.30.12.01.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 12:01:27 -0700 (PDT)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     axboe@kernel.dk, hdegoede@redhat.com, kishon@ti.com,
        mark.rutland@arm.com, maxime.ripard@bootlin.com,
        robh+dt@kernel.org, wens@csie.org, clabbe.montjoie@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v4 00/13] ata: ahci_platform: support allwinner R40 AHCI
Date:   Thu, 30 Aug 2018 21:01:07 +0200
Message-Id: <20180830190120.722-1-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

This patchset add support for allwinner R40 AHCI controller.

The whole patchset is tested on sun8i-r40-bananapi-m2-ultra and
on sun7i-a20-cubieboard2 which doesnt have any of the ressources added
by this serie, so no regression should come with it.

The last patch(ata: ahci_sunxi: remove PHY code) should not be merged,
but will be resent for inclustion when all patchs will have hit linus
tree.

Changes since v3:
- Moved PHY code to a new sun4i-a10-phy-sata driver
- Removed reset code since ahci_platform support now reset controller.

Changes since V2
- Moved all ressources management to ahci_platform

Corentin Labbe (13):
  dt-bindings: ata: ahci-platform: fix indentation of target-supply
  ata: ahci_platform: add support for AHCI controller regulator
  dt-bindings: ata: ahci-platform: document ahci-supply
  phy: Add sun4i-a10-phy-sata driver
  dt-bindings: phy: document sun4i-a10-sata-phy
  dt-bindings: ata: update ahci_sunxi bindings
  ata: ahci_sunxi: Bypass PHY init when using the new binding
  ata: ahci_sunxi: add support for r40
  ARM: dts: sun8i: r40: add sata node
  ARM: dts: sun8i: sun8i-r40-bananapi-m2-ultra: enable AHCI
  ARM: dts: sun7i: a20: add sata-port/sata-phy nodes
  ARM: dts: sun4i: a10: add sata-port/sata-phy nodes
  ata: ahci_sunxi: remove PHY code

 .../devicetree/bindings/ata/ahci-platform.txt      |  11 +-
 .../devicetree/bindings/phy/sun4i-sata-phy.txt     |  20 ++
 arch/arm/boot/dts/sun4i-a10.dtsi                   |  13 ++
 arch/arm/boot/dts/sun7i-a20.dtsi                   |  13 ++
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts  |  21 +++
 arch/arm/boot/dts/sun8i-r40.dtsi                   |  23 +++
 drivers/ata/ahci.h                                 |   1 +
 drivers/ata/ahci_sunxi.c                           |  87 +--------
 drivers/ata/libahci_platform.c                     |  26 ++-
 drivers/phy/allwinner/Kconfig                      |   7 +
 drivers/phy/allwinner/Makefile                     |   1 +
 drivers/phy/allwinner/phy-sun4i-sata.c             | 208 +++++++++++++++++++++
 12 files changed, 343 insertions(+), 88 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/sun4i-sata-phy.txt
 create mode 100644 drivers/phy/allwinner/phy-sun4i-sata.c

-- 
2.16.4

