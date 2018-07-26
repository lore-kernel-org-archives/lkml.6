Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE7CC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1301F20893
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1301F20893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbeGZIYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:24:32 -0400
Received: from mx.socionext.com ([202.248.49.38]:12150 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727742AbeGZIYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:24:32 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 26 Jul 2018 16:09:05 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 237CE1800A9;
        Thu, 26 Jul 2018 16:09:06 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 26 Jul 2018 16:09:06 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id B9C3A1A01BB;
        Thu, 26 Jul 2018 16:09:05 +0900 (JST)
From:   Keiji Hayashibara <hayashibara.keiji@socionext.com>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        yamada.masahiro@socionext.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org,
        linux-kernel@vger.kernel.org, hayashibara.keiji@socionext.com
Subject: [PATCH v2 0/2] add SPI controller driver for UniPhier SoCs
Date:   Thu, 26 Jul 2018 16:09:01 +0900
Message-Id: <1532588943-19481-1-git-send-email-hayashibara.keiji@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for SPI controller driver implemented on UniPhier SoCs.

Changes since v1:
- modify not to config SPI in master->setup method.
- fix internal bug of uniphier_spi_fill_tx_fifo().
- replace macro of BYTES_PER_WORD to inline function.
- use IRQ_NONE in irq handler.
- modify the handling of word size in uniphier_spi_send() and uniphier_spi_recv().
- modify help in Kconfig.
- other trivial change.


Keiji Hayashibara (1):
  spi: add SPI controller driver for UniPhier SoC

Kunihiko Hayashi (1):
  dt-bindings: spi: add DT bindings for UniPhier SPI controller

 .../devicetree/bindings/spi/spi-uniphier.txt       |  22 +
 drivers/spi/Kconfig                                |  13 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-uniphier.c                         | 539 +++++++++++++++++++++
 4 files changed, 575 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-uniphier.txt
 create mode 100644 drivers/spi/spi-uniphier.c

-- 
2.7.4

