Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313ACECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE8D20843
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="JPNp+r7Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFE8D20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbeGMLR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 07:17:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34100 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729617AbeGMLRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 07:17:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id c13-v6so24664198wrt.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 04:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Qk6hnKwUWLm/H05hoCAYAeoi5TcRpEM5YmryPa+Opgk=;
        b=JPNp+r7QNkJuK/Vmb9tpXBdnnFsV1dZagccIFdpbM5Z43VbNVVIImhfjWCZWIWsTx2
         IJZTJ4iEajeDajbWMOSPQ6z2LtvtkPvOv8UBt/UuLqzlrEaF0hfKTpRVZ6XQrsQC1d/S
         /YWQmutlL4AX5AhuApf8mOsE6CNolHKIiwj12TgJk0xKUM/zDjJCX2YC+MQwkHQ4hJr3
         qZ70jRHWPuU1T/RXM5+FoJ82NvaGp4boZklc8a1ykJ8/+Q1shzXASJoASPhFG+JpB178
         v7X7g7LcLA6UgHG74O8tiCVgeAwxb+pVb1Ru85uCUY+QKiSSMLMN/O2zz+kxLfv9Oat3
         Bvjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Qk6hnKwUWLm/H05hoCAYAeoi5TcRpEM5YmryPa+Opgk=;
        b=Y+0haP223G29I2zNjyxa41qwOOz3oyeG8p5U1PJRp/MmhatuQ0EyJ6l5H9iSNqCNR5
         6hUkGMFFm8n76+9cvZCDX51ypkP0po6gTvvdtWipdRY/WQLPtu57hPgX6ilkJI33K2eq
         IiHtbtOlGqi6Rc2g42vPSNRLm3nK7GsX13H66Xo1Euhsbwj2o6F8hmvT0xSuosvdPO9G
         X/LgjaaUPXoIXDIUBt0VM76+GDeSsrlxbZUhRjgtrX+8a+kCUVJqfFj1PQ3tOAMR3LJG
         fJZEkR0qdHwxiDhwxxEe+Ze62Bd8Sh9fUa9r7RD/2kEY/7sUny6yEr3pSAt6RGY8EA1K
         cyXw==
X-Gm-Message-State: AOUpUlEwg3hd0nvtDqHYw88aCf+faZHsCVwT4Kq1/CdjPTqh/bpYh6b5
        uVQNsLLxDEuycOJdE3QEny0K1A==
X-Google-Smtp-Source: AAOMgpfXlM7pLO9syZL28CDh/gnDBp7wcx+AU17+XXl8vLHkoOhcgZzzRr5i4piDpCKy4IhzRewZ4w==
X-Received: by 2002:a5d:6401:: with SMTP id z1-v6mr4471676wru.64.1531479793990;
        Fri, 13 Jul 2018 04:03:13 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id y14-v6sm4598045wrq.45.2018.07.13.04.03.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Jul 2018 04:03:13 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     hdegoede@redhat.com, linux@armlinux.org.uk, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, robh+dt@kernel.org,
        tj@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, thierry.reding@gmail.com,
        icenowy@aosc.io, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 0/9] ata: ahci_platform: support allwinner R40 AHCI
Date:   Fri, 13 Jul 2018 11:02:57 +0000
Message-Id: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

This patchset add support for allwinner R40 AHCI controller.

This controller need two regulator and one reset which is unsupported
for the moment on ahci_platform.

So this patchset add support for reset and regulator for AHCI
controller.
It add also support for non-target regulator per SATA port.

The whole patchset is tested on sun8i-r40-bananapi-m2-ultra and
on sun7i-a20-cubieboard2 which doesnt have any of the ressources added
by this serie, so no regression should come with it.

Since just before sending this patchset, I discovered the revert of
f0f56716fc3e ("ata: ahci-platform: add reset control support")
I have also tested this serie on a tegra124-jetson-tk1.

Changes since V2
- Moved all ressources management to ahci_platform

Corentin Labbe (9):
  ata: ahci_platform: add support for AHCI controller regulator
  dt-bindings: ata: ahci-platform: document ahci-supply
  ata: ahci_platform: add support for AHCI controller reset
  dt-bindings: ata: ahci-platform: document AHCI reset
  dt-bindings: ata: ahci-platform: fix indentation of target-supply
  ata: ahci_platform: add support for port regulator
  dt-bindings: ata: ahci-platform: document port-supply
  ARM: dts: sun8i: r40: add sata node
  ARM: dts: sun8i: sun8i-r40-bananapi-m2-ultra: enable AHCI

 .../devicetree/bindings/ata/ahci-platform.txt      |   7 +-
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts  |  21 +++++
 arch/arm/boot/dts/sun8i-r40.dtsi                   |  16 ++++
 drivers/ata/ahci.h                                 |   4 +
 drivers/ata/libahci_platform.c                     | 102 ++++++++++++++++++---
 5 files changed, 138 insertions(+), 12 deletions(-)

-- 
2.16.4

