Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4875CC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F198921737
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YM41f1XE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YM41f1XE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F198921737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbeHHNGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 09:06:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37730 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbeHHNGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 09:06:38 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 93723607C6; Wed,  8 Aug 2018 10:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533725250;
        bh=qA8I/YymdMl1QB9x+9lTpJgdRQSW7CkKTDyPTInXeJ8=;
        h=From:To:Cc:Subject:Date:From;
        b=YM41f1XELkK5Y3KcSd1KEXIXpBaFt3c0GH7CTD1Tutu+6lIIPA7FHRKJZhAxkZ/XM
         Ik0dxLhdbl2CUmejdjq/soUfrHnNjlIQ8Sp8QH+tYyhS1G4jyRV4FzuaBTSIXtj4JE
         nvBIUcQsl0FRSj6XjfW0FCIk2LfCPV77YnN1OtK8=
Received: from anischal-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: anischal@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B079860AFF;
        Wed,  8 Aug 2018 10:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533725250;
        bh=qA8I/YymdMl1QB9x+9lTpJgdRQSW7CkKTDyPTInXeJ8=;
        h=From:To:Cc:Subject:Date:From;
        b=YM41f1XELkK5Y3KcSd1KEXIXpBaFt3c0GH7CTD1Tutu+6lIIPA7FHRKJZhAxkZ/XM
         Ik0dxLhdbl2CUmejdjq/soUfrHnNjlIQ8Sp8QH+tYyhS1G4jyRV4FzuaBTSIXtj4JE
         nvBIUcQsl0FRSj6XjfW0FCIk2LfCPV77YnN1OtK8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B079860AFF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=anischal@codeaurora.org
From:   Amit Nischal <anischal@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Nischal <anischal@codeaurora.org>
Subject: [PATCH v3] Add QCOM camera clock controller driver
Date:   Wed,  8 Aug 2018 16:17:18 +0530
Message-Id: <1533725239-14214-1-git-send-email-anischal@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v3:
1. Mentioned the name of the non-fixed PLL in the comment text.

Changes in v2:
Addressed below review comments - https://lkml.org/lkml/2018/7/23/377
1. Add comment to use clk_rcg2_shared_ops and CLK_SET_RATE_PARENT flag.
2. Replace commas with semicolon for PLL configuration in probe function.

Changes in v1:
This patch series adds a driver and device tree documentation binding
for the camera clock controller on some Qualcomm Technologies, Inc, SoCs
such as SDM845. This would allow camera drivers to probe and control
their clocks.

[v1] : https://lore.kernel.org/patchwork/project/lkml/list/?series=360354
[v2] : https://lore.kernel.org/patchwork/project/lkml/list/?series=361196

Amit Nischal (1):
  clk: qcom: Add camera clock controller driver for SDM845

 drivers/clk/qcom/Kconfig        |    8 +
 drivers/clk/qcom/Makefile       |    1 +
 drivers/clk/qcom/camcc-sdm845.c | 1745 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 1754 insertions(+)
 create mode 100644 drivers/clk/qcom/camcc-sdm845.c

--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

