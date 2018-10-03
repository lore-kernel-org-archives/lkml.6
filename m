Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0008C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B932089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="o4LMlpld";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aVAZjRQ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B932089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbeJCUdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 16:33:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56888 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbeJCUdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 16:33:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 28AF96081B; Wed,  3 Oct 2018 13:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538574288;
        bh=oL5Bn05QJ/In7PFMO1/7O2PGjfonPh51GEnljNiruKc=;
        h=From:To:Cc:Subject:Date:From;
        b=o4LMlpldf5aDI9xWH6tZGT442pKG5MImUh65sA5XGMJNiiPBiNn/GkT5YkK9ujNuw
         CpWH8N30swh35lPPWchMwtZKW0lwgAatFPj+RFBtTqvAcFH3hz+g8B1VmJg8RjxJRp
         FQpo49K19mXzih231SDvmgGt6YgHhw0s3JWsahFM=
Received: from alokc-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokc@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3F06F601D4;
        Wed,  3 Oct 2018 13:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538574287;
        bh=oL5Bn05QJ/In7PFMO1/7O2PGjfonPh51GEnljNiruKc=;
        h=From:To:Cc:Subject:Date:From;
        b=aVAZjRQ+BbOGNXkgNpE1Z/sDq27DS4JIKeWabTy2jvzC/FoSNXADy8jUzxSQR9b16
         toCdlAxQcRrQGY1K6/3QNJlRMlJbviMYqZluDelUnTkf6mor5zBZKsQHCqzfVGVPwP
         8SGNn8wQzBmD9wi7gDTn5yrNRAbONEhKRvxvWqfs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3F06F601D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=alokc@codeaurora.org
From:   Alok Chauhan <alokc@codeaurora.org>
To:     swboyd@chromium.org, dianders@chromium.org, broonie@kernel.org,
        mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, Alok Chauhan <alokc@codeaurora.org>
Subject: [PATCH V5 0/3] spi-geni-qcom: QUP SPI GENI driver and SPI device tree bindings
Date:   Wed,  3 Oct 2018 19:14:22 +0530
Message-Id: <1538574265-30235-1-git-send-email-alokc@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds the driver for GENI based Qualcomm Universal
Peripheral (QUP) Serial Peripheral Interface (SPI) and SPI device tree
bindings.

An overview of the GENI SE SPI controller device tree components are in
patch 2 and 1. Patch 3 adds the SPI driver for GENI QUP HW.

changes from v4:
- Patch 1/3 and 2/3 are unchanged
- squashed patch 4/4 into 3/4 as suggested
- Patch 3/3 changes are follows:
        * Add SPI M_COMMAND OPCODE to handle different geni command
	  handling
        * Remove forward declaration of ISR
        * Remove unused variable rx_fifo_depth in spi_master structure
        * Declare cur_speed_hz as unsigned long to match clock framework
        * Declare cur_xfer as const pointer
        * Newline in error print
        * Correct consecutive spelling
        * Rename trans_len to len and restructure the lines in
	  setup_fifo_xfer()
        * Rename timeout to time_left and restructure the
	  handle_fifo_timeout()
        * Add check for '0' bytes transfer as part of
	  spi_geni_transfer_one()
        * Correct if-else check in geni_byte_per_fifo_word()
        * Remove NULL current transfer check in
	  geni_spi_handle_tx()/geni_spi_handle_rx() and make these
	  functions as void.
        * Hoist rx_last_byte_valid variable into function scope
        * Remove RT check in ISR and add cur_mcmd handling
        * Correct the error prints in ISR
        * In spi_alloc_master() pass 2nd arg as sizeof(*mas) for code
	  clarity
        * Use ret = PTR_ERR(se->base) for devm_ioremap_resource() err
	  return
        * Move request irq code to probe() and used request_irq() in place
	  of devm_request_irq()
        * Rewrite suspend/resume function
        * Add MODULE_DEVICE_TABLE(of, spi_geni_dt_match);
        * Remove include/linux/spi/spi-geni-qcom.h file
	

Dilip Kota (2):
  dt-bindings: soc: qcom: Remove SPI controller maximum frequency
    binding
  dt-bindings: soc: qcom: GENI SE SPI controller device tree binding

Girish Mahadevan (1):
  spi: spi-geni-qcom: Add SPI driver support for GENI based QUP

 .../devicetree/bindings/soc/qcom/qcom,geni-se.txt  |  29 +-
 .../devicetree/bindings/spi/qcom,spi-geni-qcom.txt |  39 ++
 drivers/spi/Kconfig                                |  12 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-geni-qcom.c                        | 703 +++++++++++++++++++++
 5 files changed, 757 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.txt
 create mode 100644 drivers/spi/spi-geni-qcom.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

