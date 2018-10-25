Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4795EECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195C4205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 195C4205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeJYPzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 11:55:32 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:64946 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbeJYPzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 11:55:31 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gFZzo-0002Do-5y from Jiada_Wang@mentor.com ; Thu, 25 Oct 2018 00:23:56 -0700
Received: from jiwang-OptiPlex-980.tokyo.mentorg.com (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Thu, 25 Oct 2018 00:23:52 -0700
From:   <jiada_wang@mentor.com>
To:     <geert+renesas@glider.be>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <horms@verge.net.au>, <magnus.damm@gmail.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <jiada_wang@mentor.com>
Subject: [PATCH linux-next v1 0/4] Add AVB Counter Clock
Date:   Thu, 25 Oct 2018 16:23:45 +0900
Message-ID: <20181025072349.15173-1-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiada Wang <jiada_wang@mentor.com>

on R-Car SoCs there are AVB Counter Clocks, each clock has 12bits integral
and 8 bits fractional dividers which operates with S0D1ϕ clock.

This patch set adds avb clock provider, which registers all 8 AVB
Counter Clocks, and provide them via clock provider.

AVB Clock node are added to R-Car ULCB and Salvator boards,
so that like Audio Clock Generator (ADG) can use avb counter clocks
via common clock framework.


Jiada Wang (4):
  clk: renesas: clk-avb: add AVB Clock driver
  clk: renesas: Add binding document for AVB Counter Clock
  arm64: ulcb: Add avb counter clock
  arm64: salvator-common: Add avb counter clock

 .../bindings/clock/renesas,avb-clk.txt        |  19 ++
 .../boot/dts/renesas/salvator-common.dtsi     |   6 +
 arch/arm64/boot/dts/renesas/ulcb.dtsi         |   6 +
 drivers/clk/renesas/Kconfig                   |   6 +
 drivers/clk/renesas/Makefile                  |   1 +
 drivers/clk/renesas/clk-avb.c                 | 257 ++++++++++++++++++
 6 files changed, 295 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,avb-clk.txt
 create mode 100644 drivers/clk/renesas/clk-avb.c

-- 
2.17.0

