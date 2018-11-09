Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DC0C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 01:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2C620855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 01:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C2C620855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbeKILUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 06:20:36 -0500
Received: from mx.socionext.com ([202.248.49.38]:41458 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727196AbeKILUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 06:20:36 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 09 Nov 2018 10:42:16 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 6E256180D4F;
        Fri,  9 Nov 2018 10:42:16 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 9 Nov 2018 10:42:16 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id CABDC1A03A2;
        Fri,  9 Nov 2018 10:42:15 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 0/4] reset: uniphier: Rename from USB3 reset to glue reset and add AHCI reset support
Date:   Fri,  9 Nov 2018 10:42:03 +0900
Message-Id: <1541727727-10821-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series renames the reset control of core reset included in USB3 glue
layer with in the glue layer for generic peripherals to allow other devices
to use it.

And this series adds support for the core reset included in AHCI glue layer.

Kunihiko Hayashi (4):
  dt-bindings: reset: uniphier: Replace the expression of USB3 with
    generic peripherals
  reset: uniphier-usb3: Rename to reset-uniphier-glue
  dt-bindings: reset: uniphier: Add AHCI core reset description
  reset: uniphier-glue: Add AHCI reset control support in glue layer

 .../devicetree/bindings/reset/uniphier-reset.txt   |  25 +--
 drivers/reset/Kconfig                              |  10 +-
 drivers/reset/Makefile                             |   2 +-
 drivers/reset/reset-uniphier-glue.c                | 183 +++++++++++++++++++++
 drivers/reset/reset-uniphier-usb3.c                | 171 -------------------
 5 files changed, 203 insertions(+), 188 deletions(-)
 create mode 100644 drivers/reset/reset-uniphier-glue.c
 delete mode 100644 drivers/reset/reset-uniphier-usb3.c

-- 
2.7.4

