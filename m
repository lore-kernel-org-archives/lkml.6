Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465F1ECDE4C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12AF720684
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0ckswFhK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12AF720684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbeKIERm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 23:17:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:59408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbeKIERl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 23:17:41 -0500
Received: from localhost.localdomain (unknown [171.76.98.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA96C20857;
        Thu,  8 Nov 2018 18:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541702454;
        bh=+3SVLMpE5P/EqTYdxpXRD+l06OH/4A9X7HFijiM+bII=;
        h=From:To:Cc:Subject:Date:From;
        b=0ckswFhKln5TAnpok0xtnmL//MH6697xmT6WMoMH7sCmTP9liKVc2VTXRqaqEbjtn
         nANM9+VtlFSsS91fNinKA8T0Bv4mINkPpx1zUrENy+MiIZEgPYtYCu/i1+/u68nl4M
         JPksau9Z6WieykG+DF9ZFKKXXYh6ssKbHonUks0I=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v4 00/18] arm64: dts: qcom: qcs404: Add Device tree nodes
Date:   Fri,  9 Nov 2018 00:09:51 +0530
Message-Id: <20181108184009.18430-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for various nodes for QCS404-EVB.

Based on v4.20-rc1

Changes in v4:
 - correct the v3 post (sent wrong branch)

Changes in v3:
 - Make the DTS files sorted alphabetcially and by node addresses
 - Add reviewed by from Bjorn
 - Split out the DTS files for EVB 1000 and EVB 4000 boards and add common
   evb dts files for common part

Changes in v2:
 Fix cpu binding

Bjorn Andersson (7):
  arm64: dts: qcom: qcs404: Add reserved-memory regions
  arm64: dts: qcom: qcs404: Add RPM GLINK related nodes
  arm64: dts: qcom: qcs404: Add PMS405 RPM regulators
  arm64: dts: qcom: qcs404: Add TLMM pinctrl node
  arm64: dts: qcom: qcs404: Add sdcc1 node
  arm64: dts: qcom: qcs404: Add scm firmware node
  arm64: dts: qcom: qcs404: Add remoteproc nodes

Vinod Koul (11):
  arm64: dts: qcom: qcs404: add base dts files
  arm64: dts: qcom: qcs404-evb: add dts files for EVBs
  arm64: dts: qcom: qcs404: add smp2p nodes
  arm64: dts: qcom: pms405: add spmi node
  arm64: dts: qcom: qcs404: add spmi node
  arm64: dts: qcom: pms405: add rtc node
  arm64: dts: qcom: pms405: add gpios
  arm64: dts: qcom: qcs404: add prng-ee node
  arm64: dts: qcom: qcs404: Add BAM DMA node
  arm64: dts: qcom: qcs404: Use BAM DMA for serial uart2
  arm64: dts: qcom: pms405: Add pon and pwrkey nodes

 arch/arm64/boot/dts/qcom/Makefile            |   2 +
 arch/arm64/boot/dts/qcom/pms405.dtsi         |  55 +++
 arch/arm64/boot/dts/qcom/qcs404-evb-1000.dts |  11 +
 arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts |  11 +
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi     | 188 ++++++++++
 arch/arm64/boot/dts/qcom/qcs404.dtsi         | 490 +++++++++++++++++++++++++++
 6 files changed, 757 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pms405.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/qcs404-evb-1000.dts
 create mode 100644 arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts
 create mode 100644 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/qcs404.dtsi

-- 
2.14.4

