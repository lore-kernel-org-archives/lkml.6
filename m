Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66818C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E25E20843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtRlRJgq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E25E20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbeICOVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 10:21:33 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51207 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbeICOVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 10:21:33 -0400
Received: by mail-wm0-f66.google.com with SMTP id y2-v6so557149wma.1;
        Mon, 03 Sep 2018 03:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qipwbSNbIVGXyNEah+LaRkOfqYRnkS7mgM/kvMpA4og=;
        b=YtRlRJgqsfxwivkA9BvyG8G3eHeIHiWIxCjvboHiEXRCLjsQwPhb7QcSSWQlufKBA1
         RbN94+8af6bSc5slyXSRlSSDY4Ddeq4jIpz1Di5g9oArbLbBBlJejBzzgd3a1Mdog2Bt
         BbubrIao6dn7av7jrImIxZ8pGjp9Yz8kTvyjTRDaBWfbC1T/siLbMVb9BUKpN4pUNjI5
         2K7AJUjROyI5T69hKIyb6534YoeJi66ExH3P53/bWJI5v+iAtUQXLfnO/Vm+p0vp1cse
         E95+0Do09Vlorhnq3/TClYdm1LPMelQWygi4PXH51YuFnkPl5tryqc6t+hF9t2i6Oj0b
         51oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qipwbSNbIVGXyNEah+LaRkOfqYRnkS7mgM/kvMpA4og=;
        b=PWyfrGqBVDthdcVyHQVhJx7i2N6F647KBM6+1jzvw08zu7YhqxSYsIQZ5Aspv1gd6T
         ZoyVHjVsoPG6KnZdeIqJkiC4prTQLoQzbkVeibwAnuYqVDJMAArIZEqXccb0AFX7E+/p
         bg0VOPWGQLSv7IrP1mSYp0DPJBspC5f0x0E7vj0ORV0wa1DIfkx0oxx9jSPN5fM6UQb1
         31gzoKxQcbQf8yqbtOUyHji1VR1Drq+3D85DIauthyN+5/0RlRvebO4DrH8RIYv3t12y
         2tDu4nfkYNYlTmoIhc+dk9i6s5PU14unxEcxQGeyND6lCspORKNnhaqFAjXO8qOFRLWO
         5VVQ==
X-Gm-Message-State: APzg51CzVIPdBF/+RmTrAAb8IWbdnvsMuM6Uvg2U0SgSG0GfweBNq0p5
        59gNaCNhEBx9IUuzWgJlr0g=
X-Google-Smtp-Source: ANB0VdbBtKTckMzHzcyD8aoftTeKqOST7+gggPLpp4NmiYtWE+Wg0ux7jCRWxQPDV/NxyfFdeos+9g==
X-Received: by 2002:a1c:8dc6:: with SMTP id p189-v6mr5117950wmd.3.1535968926207;
        Mon, 03 Sep 2018 03:02:06 -0700 (PDT)
Received: from Red.localdomain ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id k34-v6sm31773936wre.18.2018.09.03.03.02.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 03:02:05 -0700 (PDT)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     axboe@kernel.dk, hdegoede@redhat.com, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, robh+dt@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH v5 0/9] ata: ahci_platform: support allwinner R40 AHCI
Date:   Mon,  3 Sep 2018 12:01:52 +0200
Message-Id: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset add support for allwinner R40 AHCI controller.

The whole patchset is tested on sun8i-r40-bananapi-m2-ultra and
on sun7i-a20-cubieboard2 which doesnt have any of the ressources added
by this serie, so no regression should come with it.

Patchs 1-7 should go via the ata tree
Patchs 8,9 should go via the sunxi tree

Changes since v4:
- dropped PHY dedicated driver
- added the optionnal phy-supply

Changes since v3:
- Moved PHY code to a new sun4i-a10-phy-sata driver
- Removed reset code since ahci_platform support now reset controller.

Changes since V2
- Moved all ressources management to ahci_platform

Corentin Labbe (9):
  dt-bindings: ata: ahci-platform: fix indentation of target-supply
  ata: ahci_platform: add support for AHCI controller regulator
  dt-bindings: ata: ahci-platform: document ahci-supply
  ata: ahci_platform: add support for PHY controller regulator
  dt-bindings: ata: ahci-platform: document phy-supply
  ata: ahci_sunxi: add support for r40
  dt-bindings: ata: update ahci_sunxi bindings
  ARM: dts: sun8i: r40: add sata node
  ARM: dts: sun8i: sun8i-r40-bananapi-m2-ultra: enable AHCI

 .../devicetree/bindings/ata/ahci-platform.txt      |  6 ++-
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts  | 18 +++++++++
 arch/arm/boot/dts/sun8i-r40.dtsi                   | 13 ++++++
 drivers/ata/ahci.h                                 |  2 +
 drivers/ata/ahci_sunxi.c                           |  3 +-
 drivers/ata/libahci_platform.c                     | 46 +++++++++++++++++++++-
 6 files changed, 84 insertions(+), 4 deletions(-)

-- 
2.16.4

