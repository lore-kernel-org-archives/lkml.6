Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F069C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6640D20893
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6640D20893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbeGZIZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:25:47 -0400
Received: from mx.socionext.com ([202.248.49.38]:12186 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728984AbeGZIZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:25:47 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 26 Jul 2018 16:10:20 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 4C16760034;
        Thu, 26 Jul 2018 16:10:20 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 26 Jul 2018 16:10:20 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 890C21A01BB;
        Thu, 26 Jul 2018 16:10:19 +0900 (JST)
From:   Keiji Hayashibara <hayashibara.keiji@socionext.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com,
        yamada.masahiro@socionext.com, catalin.marinas@arm.com,
        will.deacon@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org,
        linux-kernel@vger.kernel.org, hayashibara.keiji@socionext.com
Subject: [PATCH v2 0/3] Add SPI dts node for UniPhier SoCs
Date:   Thu, 26 Jul 2018 16:09:57 +0900
Message-Id: <1532589000-19602-1-git-send-email-hayashibara.keiji@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds SPI pin-mux node and SPI node for UniPhier SoCs.

Changes since v1:
- remove the node for MCSSI which support multiple channels.
  Since the current driver doesn't support MCSSI, it deletes this node.

Kunihiko Hayashi (3):
  ARM: dts: uniphier: add SPI pin-mux node
  ARM: dts: uniphier: add SPI node for UniPhier 32bit SoCs
  arm64: dts: uniphier: add SPI node for LD20, LD11 and PXs3

 arch/arm/boot/dts/uniphier-ld4.dtsi              | 11 ++++++
 arch/arm/boot/dts/uniphier-pinctrl.dtsi          | 20 +++++++++++
 arch/arm/boot/dts/uniphier-pro4.dtsi             | 11 ++++++
 arch/arm/boot/dts/uniphier-pro5.dtsi             | 22 ++++++++++++
 arch/arm/boot/dts/uniphier-pxs2.dtsi             | 22 ++++++++++++
 arch/arm/boot/dts/uniphier-sld8.dtsi             | 11 ++++++
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 22 ++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 44 ++++++++++++++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi | 22 ++++++++++++
 9 files changed, 185 insertions(+)

-- 
2.7.4

