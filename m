Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950B0C5CFEB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 01:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3512086E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 01:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F3512086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754691AbeGJB1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 21:27:23 -0400
Received: from mx.socionext.com ([202.248.49.38]:56089 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754581AbeGJB1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 21:27:21 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 10 Jul 2018 10:27:20 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 5172260034;
        Tue, 10 Jul 2018 10:27:20 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 10 Jul 2018 10:27:20 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id A99C81A11BB;
        Tue, 10 Jul 2018 10:27:19 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 0/2] regulator: add new UniPhier regulator support
Date:   Tue, 10 Jul 2018 10:27:15 +0900
Message-Id: <1531186037-16630-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add new regulator controller support for UniPhier SoCs.
Currently this supports USB3 VBUS controller only. This USB3 VBUS belongs to
USB3 glue layer.

Changes since v1:
- dt-bindings: add description of glue layer
- replace read/write accesses with regmap_mmio
- rewrite a header with C++ comment style
- reuse soc_data for pxs2, ld20 and pxs3
- replace clk operations with clk_bulk
- move nclks and nrsts to soc_data

Kunihiko Hayashi (2):
  dt-bindings: regulator: add DT bindings for UniPhier regulator
  regulator: uniphier: add regulator driver for UniPhier SoC

 .../bindings/regulator/uniphier-regulator.txt      |  57 +++++
 drivers/regulator/Kconfig                          |   8 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/uniphier-regulator.c             | 247 +++++++++++++++++++++
 4 files changed, 313 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/uniphier-regulator.txt
 create mode 100644 drivers/regulator/uniphier-regulator.c

-- 
2.7.4

