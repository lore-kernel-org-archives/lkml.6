Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B22BC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A748F21508
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fCLnTTMW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fCLnTTMW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A748F21508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbeIRXmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 19:42:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60350 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729946AbeIRXmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 19:42:07 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 98C16605FD; Tue, 18 Sep 2018 18:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537294101;
        bh=l+RA9kwHYjoi+BAL2dyxSubxkZgqYpRRd31aW+SRfW0=;
        h=From:To:Cc:Subject:Date:From;
        b=fCLnTTMWQS3X3TEzOdb3NkHO9eLpiW34FtY+fEJFnLOwnbSuCfI7f/p41rCvDk0Y6
         lqQ0Q7xoR4RNPLcbi1bg8w1WF7sHCXPHBv8E5WQ3d3LhiM5uzDL669jWlnJq0RkSz4
         wL5v7UpAd9HOnbUXAM12Mj6WF3ePzX4RtzziM1pU=
Received: from dkota-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dkota@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4B61160721;
        Tue, 18 Sep 2018 18:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537294101;
        bh=l+RA9kwHYjoi+BAL2dyxSubxkZgqYpRRd31aW+SRfW0=;
        h=From:To:Cc:Subject:Date:From;
        b=fCLnTTMWQS3X3TEzOdb3NkHO9eLpiW34FtY+fEJFnLOwnbSuCfI7f/p41rCvDk0Y6
         lqQ0Q7xoR4RNPLcbi1bg8w1WF7sHCXPHBv8E5WQ3d3LhiM5uzDL669jWlnJq0RkSz4
         wL5v7UpAd9HOnbUXAM12Mj6WF3ePzX4RtzziM1pU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4B61160721
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=dkota@codeaurora.org
From:   Dilip Kota <dkota@codeaurora.org>
To:     swboyd@chromium.org, dianders@chromium.org, broonie@kernel.org,
        mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, Dilip Kota <dkota@codeaurora.org>
Subject: [PATCH V4 0/4] spi-geni-qcom: QUP SPI GENI driver and SPI device tree bindings
Date:   Tue, 18 Sep 2018 23:37:22 +0530
Message-Id: <1537294047-12093-1-git-send-email-dkota@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this V4 series, submitted changes to remove SPI controller
max-frquency device tree binding as it is controller
specific property.

Move the GENI SE SPI controller device tree bindings
documentation to devicetree/bindings/spi/qcom,spi-geni-qcom.txt.

Address the reviewer comments to spi-geni-qcom.c in patch-V3.

Adds changes in spi-geni-qcom.c to plugin set_cs API to SPI framework.

Dilip Kota (3):
  dt-bindings: soc: qcom: Remove SPI controller maximum frequency entry
  dt-bindings: soc: qcom: GENI SE SPI controller device tree binding
  spi: spi-geni-qcom: Plugin API to assert and de-assert Chipselect

Girish Mahadevan (1):
  spi: spi-geni-qcom: Add SPI driver support for GENI based QUP

 .../devicetree/bindings/soc/qcom/qcom,geni-se.txt  |  29 +-
 .../devicetree/bindings/spi/qcom,spi-geni-qcom.txt |  39 ++
 drivers/spi/Kconfig                                |  12 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-geni-qcom.c                        | 680 +++++++++++++++++++++
 include/linux/spi/spi-geni-qcom.h                  |  14 +
 6 files changed, 748 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.txt
 create mode 100644 drivers/spi/spi-geni-qcom.c
 create mode 100644 include/linux/spi/spi-geni-qcom.h

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

