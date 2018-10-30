Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0649C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B7C20848
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+6hx2ek"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B7C20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbeJ3TER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 15:04:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:42552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbeJ3TEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 15:04:16 -0400
Received: from localhost.localdomain (unknown [171.61.91.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8B4A20827;
        Tue, 30 Oct 2018 10:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540894287;
        bh=IEUQpmhXY/XzCngzQxGb1pXlJHlTCbukx7XRT8NZu08=;
        h=From:To:Cc:Subject:Date:From;
        b=u+6hx2ekkDI4AA+1TqWzZnyr9Hpj9v3DqJgXvTkDwgFhKqoCsI33kqaw6VGdNewqh
         CEmFLdZg7/sLY5y13aERhiG+j5sX5Ep0WsOWl8lJFCfnMQYhYsSdBsrOYibAGbXdB1
         PH7hLfzASBHZ71UGSPW9hNA7RIki7u69eZaW9MCs=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 00/17] arm64: dts: qcom: qcs404: Add Device tree nodes
Date:   Tue, 30 Oct 2018 15:40:51 +0530
Message-Id: <20181030101108.11041-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for various nodes for QCS404-EVB.

Based on next-20181030

Bjorn Andersson (7):
  arm64: dts: qcom: qcs404: Add reserved-memory regions
  arm64: dts: qcom: qcs404: Add RPM GLINK related nodes
  arm64: dts: qcom: qcs404: Add PMS405 RPM regulators
  arm64: dts: qcom: qcs404: Add TLMM pinctrl node
  arm64: dts: qcom: qcs404: Add sdcc1 node
  arm64: dts: qcom: qcs404: Add scm firmware node
  arm64: dts: qcom: qcs404: Add remoteproc nodes

Vinod Koul (10):
  arm64: dts: qcom: qcs404: add base dts files
  arm64: dts: qcom: qcs404: add smp2p nodes
  arm64: dts: qcom: pms405: add spmi node
  arm64: dts: qcom: qcs404: add spmi node
  arm64: dts: qcom: pms405: add rtc node
  arm64: dts: qcom: pms405: add gpios
  arm64: dts: qcom: qcs404: add prng-ee node
  arm64: dts: qcom: qcs404: Add BAM DMA node
  arm64: dts: qcom: qcs404: Use BAM DMA for serial uart2
  arm64: dts: qcom: pms405: Add pon and pwrkey nodes

 arch/arm64/boot/dts/qcom/Makefile       |   1 +
 arch/arm64/boot/dts/qcom/pms405.dtsi    |  53 ++++
 arch/arm64/boot/dts/qcom/qcs404-evb.dts | 183 ++++++++++++
 arch/arm64/boot/dts/qcom/qcs404.dtsi    | 485 ++++++++++++++++++++++++++++++++
 4 files changed, 722 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pms405.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/qcs404-evb.dts
 create mode 100644 arch/arm64/boot/dts/qcom/qcs404.dtsi

-- 
2.14.4

