Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C20ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86EE220875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FcGv/4ba";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FcGv/4ba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86EE220875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388013AbeGWM1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 08:27:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54948 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387830AbeGWM1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 08:27:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EB9206085F; Mon, 23 Jul 2018 11:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532345205;
        bh=iw1NRydm/zFaSl7WNZJLvWWhxCBGTdwxKQeeepb0v7s=;
        h=From:To:Cc:Subject:Date:From;
        b=FcGv/4baAEUW6+QVgmaT/KhfwTvREONgmj+Cbl6zGx8w7fqAkjGEUX+WwCUNo42Cr
         7zHbxHUXzOdAVeyipKank+BWq3VCgTerxK4Td/OScmuTRhW/999Bj8x09xl46Jll2+
         0jffDTe1qjJkYry9V+Vs/GyGQWr5IdKm0NJGomE4=
Received: from anischal-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: anischal@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D4D0E602BC;
        Mon, 23 Jul 2018 11:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532345205;
        bh=iw1NRydm/zFaSl7WNZJLvWWhxCBGTdwxKQeeepb0v7s=;
        h=From:To:Cc:Subject:Date:From;
        b=FcGv/4baAEUW6+QVgmaT/KhfwTvREONgmj+Cbl6zGx8w7fqAkjGEUX+WwCUNo42Cr
         7zHbxHUXzOdAVeyipKank+BWq3VCgTerxK4Td/OScmuTRhW/999Bj8x09xl46Jll2+
         0jffDTe1qjJkYry9V+Vs/GyGQWr5IdKm0NJGomE4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D4D0E602BC
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
Subject: [PATCH 0/2] Add QCOM camera clock controller driver
Date:   Mon, 23 Jul 2018 16:56:31 +0530
Message-Id: <1532345193-18108-1-git-send-email-anischal@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a driver and device tree documentation binding
for the camera clock controller on some Qualcomm Technologies, Inc, SoCs
such as SDM845. This would allow camera drivers to probe and control their
clocks.

Amit Nischal (2):
  dt-bindings: clock: Introduce QCOM Camera clock bindings
  clk: qcom: Add camera clock controller driver for SDM845

 .../devicetree/bindings/clock/qcom,camcc.txt       |   18 +
 drivers/clk/qcom/Kconfig                           |    8 +
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/camcc-sdm845.c                    | 1736 ++++++++++++++++++++
 include/dt-bindings/clock/qcom,camcc-sdm845.h      |  116 ++
 5 files changed, 1879 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,camcc.txt
 create mode 100644 drivers/clk/qcom/camcc-sdm845.c
 create mode 100644 include/dt-bindings/clock/qcom,camcc-sdm845.h

--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

