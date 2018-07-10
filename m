Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8210C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 01:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF2E20882
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 01:14:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DF2E20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754629AbeGJBO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 21:14:26 -0400
Received: from mx.socionext.com ([202.248.49.38]:55903 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754565AbeGJBOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 21:14:23 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 10 Jul 2018 10:14:22 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 882AF180B88;
        Tue, 10 Jul 2018 10:14:22 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 10 Jul 2018 10:14:22 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 11F111A11BB;
        Tue, 10 Jul 2018 10:14:22 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 0/2]  reset: uniphier: add USB3 core reset support
Date:   Tue, 10 Jul 2018 10:14:15 +0900
Message-Id: <1531185257-16444-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add new USB3 core reset control support for UniPhier SoCs.
This reset line belongs to USB3 glue layer.

Changes since v1:
- dt-bindings: fix a typo, not "clock-names" but "reset-names"
- dt-bindings: add description of glue layer
- reuse soc_data for pxs2, ld20 and pxs3
- put reset_simple_data into uniphier_usb3_reset_priv
- replace clk operations with clk_bulk
- move nclks and nrsts to soc_data
- rewrite a header with C++ comment style
- change the subject 'USB3 controller reset' to 'USB3 core reset'

Kunihiko Hayashi (2):
  dt-bindings: reset: uniphier: add USB3 core reset support
  reset: uniphier: add USB3 core reset control

 .../devicetree/bindings/reset/uniphier-reset.txt   |  56 +++++++
 drivers/reset/Kconfig                              |  10 ++
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-uniphier-usb3.c                | 171 +++++++++++++++++++++
 4 files changed, 238 insertions(+)
 create mode 100644 drivers/reset/reset-uniphier-usb3.c

-- 
2.7.4

