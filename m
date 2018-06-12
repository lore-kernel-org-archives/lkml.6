Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E7804C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BBA3208B2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lniK+jxr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PY7ccB1v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BBA3208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754386AbeFLRJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 13:09:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58776 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753448AbeFLRJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 13:09:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4D5C660850; Tue, 12 Jun 2018 17:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528823361;
        bh=hOYzfGJnJA7ldHU75roW+TH5Mc4VwYRFbaeRZYwMExc=;
        h=From:To:Cc:Subject:Date:From;
        b=lniK+jxrchzzKONydYpjmJsrLkVo/uoNPfpcaVVO2nFtC25LoTCouzXVnx3xuxekY
         YMba3KO+YboEeN/vE8zHOTMJfGsnVvE9flXMUJP0poQNq1rfvZ8JlRxgrTlwxoFhia
         IxbaqUkGvqET/Zgd7L3RQOB7Qn06EXlnYlTqfpdg=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kramasub@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A320C606DB;
        Tue, 12 Jun 2018 17:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528823360;
        bh=hOYzfGJnJA7ldHU75roW+TH5Mc4VwYRFbaeRZYwMExc=;
        h=From:To:Cc:Subject:Date:From;
        b=PY7ccB1v2xF+HH+wAuJikxNZKqJE2WMNxzTAOwGkzoUCjYWBrxKW1KTCO2sVXpOz5
         c4NqxFdFrFE45cn15H+VuApe2iVVgi1dHtlDWm6+9lhMTglWE6NKMsoMzz3p3YNrvd
         1hGQ5cHjFvJqOLUfLUWUJclcYFxpP5Iygcax7N70=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A320C606DB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kramasub@codeaurora.org
From:   Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, wsa@the-dreams.de, gregkh@linuxfoundation.org
Cc:     Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-i2c@vger.kernel.org,
        evgreen@chromium.org, acourbot@chromium.org, swboyd@chromium.org,
        dianders@chromium.org
Subject: [PATCH v7 0/4] Introduce GENI SE Controller Driver
Date:   Tue, 12 Jun 2018 11:09:04 -0600
Message-Id: <1528823348-30532-1-git-send-email-kramasub@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generic Interface (GENI) firmware based Qualcomm Universal Peripheral (QUP)
Wrapper is a next generation programmable module for supporting a wide
range of serial interfaces like UART, SPI, I2C, I3C, etc. A single QUP
module can provide upto 8 Serial Interfaces using its internal Serial
Engines (SE). The protocol supported by each interface is determined by
the firmware loaded to the Serial Engine.

This patch series introduces GENI SE Driver to manage the GENI based QUP
Wrapper and the common aspects of all SEs inside the QUP Wrapper. This
patch series also introduces the UART and I2C Controller drivers to
drive the SEs that are programmed with the respective protocols.

[v7]
 * Return appropriate error codes as idenitified in i2c fault-codes
 * Add Maintainer details for I2C controller driver
 * Fix an incorrect conditional check in DMA mode
 * Drop the patches in the series that got accepted

[v6]
 * Move the I2C clock-frequency configuration to the SDM845 board file
 * Remove a redundant comment in the I2C driver

[v5]
 * Remove Linux specific property from the device tree binding
 * Clarify I2C SCL time period documentation
 * Remove redundant checks in I2C controller driver during timeout
 * Use 100kHz as the default clock frequency in the I2C controller driver
 * Disable Wrapper controller by default in the SDM845 device tree and
   enable it explicitly for SDM845 MTP
 * Specify I2C clock frequency in the SDM845 device tree
 * Remove bias configuration for I2C pins under sleep state in device tree
 * Drop the serial driver from the patch series since it is merged
 * Specify the UART port options in the SDM845 device tree

[v4]
 * Add SPI controller information in device tree binding
 * Add support for debug UART & I2C controllers in SDM845 device tree
 * Remove any unnecessary parenthesis & casting
 * Identify break character in UART line and pass it to the framework
 * Transmit data from fault handler reliably in debug UART
 * Map the register block when the UART port is requested
 * Move concise exported functions as macros or inlines in public header
 * Move the clock performance table from the wrapper to serial engines
 * Add a lock to synchronize between IRQ & error handling in I2C controller
 * Remove any compiler optimization hints like likely/unlikely
 * Update documentation to clarify tables and hardware blocks

[v3]
 * Update the driver dependencies
 * Use the SPDX License Expression
 * Squash all the controller device tree bindings together
 * Use kernel doc format for documentation
 * Add additional documentation for packing configuration
 * Use clk_bulk_* API for related clocks
 * Remove driver references to pinctrl and their states
 * Replace magic numbers with appropriate macros
 * Update memory barrier usage and associated comments
 * Reduce interlacing of register reads/writes
 * Fix poll_get_char() operation in console UART driver under polling mode
 * Address other comments from Bjorn Andersson to improve code readability

[v2]
 * Updated device tree bindings to describe the hardware
 * Updated SE DT node as child node of QUP Wrapper DT node
 * Moved common AHB clocks to QUP Wrapper DT node
 * Use the standard "clock-frequency" I2C property
 * Update compatible field in UART Controller to reflect hardware manual
 * Addressed other device tree binding specific comments from Rob Herring

Karthikeyan Ramasubramanian (3):
  i2c: i2c-qcom-geni: Add bus driver for the Qualcomm GENI I2C
    controller
  MAINTAINERS: Add Qualcomm Generic Interface I2C driver maintainer
  arm64: dts: sdm845: Add support for an instance of I2C controller

Rajendra Nayak (1):
  arm64: dts: sdm845: Add serial console support

 MAINTAINERS                             |   8 +
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts |  60 +++
 arch/arm64/boot/dts/qcom/sdm845.dtsi    |  67 ++++
 drivers/i2c/busses/Kconfig              |  13 +
 drivers/i2c/busses/Makefile             |   1 +
 drivers/i2c/busses/i2c-qcom-geni.c      | 649 ++++++++++++++++++++++++++++++++
 6 files changed, 798 insertions(+)
 create mode 100644 drivers/i2c/busses/i2c-qcom-geni.c

-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

