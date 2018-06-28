Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7010EC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F993276FF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H7KrG50H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F993276FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967680AbeF1SLx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 14:11:53 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33335 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965800AbeF1SLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 14:11:49 -0400
Received: by mail-pg0-f67.google.com with SMTP id e11-v6so2819737pgq.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 11:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=jEZEu4uN/9qjUIZVkwQD+oQYw+qzJ+MlqViQqIlKRXU=;
        b=H7KrG50HBeNb3I/uCAQpwaylea5i95dibg/aFkHtIfNp36wT9y22qzqe7LzccpO3nj
         3bKh307wRKb7duEvro8ciWS2yyBjwTh5Y+Zry+VInR8dEpHG8zTxEltENYaC+I9SqvY8
         juXDELOqc4EhhEn8LWKYGnii+B0NuM8AYAxyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jEZEu4uN/9qjUIZVkwQD+oQYw+qzJ+MlqViQqIlKRXU=;
        b=azvkeHFpaE+SDlpERjvCSv1qUvmtkCRoQsUkc4FkW7GATiHGtvH6Xjze+fX/7KBHem
         TETElG9s2S8jVIDn3L0A+v4mqa21KJLiyMAZ3If0o3XOZT5z7PF2OzzuRMvPjMksmpe0
         Lqos+L4foHnwo7n0bmtxOouB2KaR3QBTPweL4AiL3QBwKQ/TOAJeW4GAO+Vyag82iPMy
         9LjdqCEy3ucwmYGtKaXI2DUHjBsYAYSMr4vSAn7FNVwu3xGmnbcoehdOr6uM8AjPa7qw
         x+0otlntJTA22eKu4FYQcup5Xq6yapEJAcvc/1Tywv4l2Sv0w7eMVssOKhH9e4b8XomK
         hylQ==
X-Gm-Message-State: APt69E267PYs3rihagOJkuo6VuYKnd1ZKJHPqFovlDptsK0RNSHTFGpf
        2jFpxRO00wR1Di6ePpkhgf17LvsGmg==
X-Google-Smtp-Source: AAOMgpeHl+L2L0nW1UBwOM/+xYP/lAY31u0XOQG6a0al6cymfWX5ZB0cGKrqMUX42GDpr2qDLZOEIA==
X-Received: by 2002:a65:428b:: with SMTP id j11-v6mr1607446pgp.200.1530209509292;
        Thu, 28 Jun 2018 11:11:49 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7141:9f8e:c1c3:7dd1:e694:9dc2])
        by smtp.gmail.com with ESMTPSA id o13-v6sm13293132pgn.93.2018.06.28.11.11.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 11:11:48 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     wsa@the-dreams.de, robh+dt@kernel.org, afaerber@suse.de
Cc:     linus.walleij@linaro.org, linux-i2c@vger.kernel.org,
        liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/6] Add Actions Semi S900 I2C support
Date:   Thu, 28 Jun 2018 23:40:36 +0530
Message-Id: <20180628181042.2239-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds I2C controller support for Actions Semi S900 SoC.
This driver has been structured in a way such that there will be only
one controller driver for the whole OWL family series (S500, S700 and
S900 SoCs).

There are 6 I2C controllers with separate memory mapped register space.
The I2C controller can handle atmost two messages concatenated by a
repeated start via its internal address feature. Hence the driver
uses this feature for messages of length greater than 1. In those cases,
the first message of the combined message should be a `write` with maximum
message length 6 and the second message's maximum length should be 240 bytes.

As far as the bus speed is concerned, this driver only supports
Standard (100KHz) and High speed (400KHz) for now.

The pinctrl definitions are only available for I2C0, I2C1 and I2C2.
With the mux option available only for I2C0.

For Bubblegum-96 board utilizing the S900 SoC, only I2C1 and I2C2 which
are exposed on the Low speed expansion connector are enabled.

Thanks,
Mani

Changes in v2:

As per Andy's review:
* Modified infinite loops to fixed number of retries
* Used i2c_8bit_addr_from_msg for constructing the slave address
* Removed unnecessary parenthesis around defines
* Modified certain dev_warn to dev_dbg
* Modified the error handling to more generic pattern

* Fixed the return value in owl_i2c_master_xfer
* Added MAINTAINERS patch for I2C driver and its binding

Manivannan Sadhasivam (6):
  dt-bindings: i2c: Add binding for Actions Semi OWL I2C controller
  arm64: dts: actions: Add Actions Semi S900 I2C controller nodes
  arm64: dts: actions: Add pinctrl definition for S900 I2C controller
  arm64: dts: actions: Enable I2C1 and I2C2 in Bubblegum-96 board
  i2c: Add Actions Semi OWL family S900 I2C driver
  MAINTAINERS: Add entry for Actions Semi OWL I2C driver

 .../devicetree/bindings/i2c/i2c-owl.txt       |  27 +
 MAINTAINERS                                   |   2 +
 .../dts/actions/s900-bubblegum-96-pins.dtsi   |  29 ++
 .../boot/dts/actions/s900-bubblegum-96.dts    |  11 +
 arch/arm64/boot/dts/actions/s900.dtsi         |  60 +++
 drivers/i2c/busses/Kconfig                    |   7 +
 drivers/i2c/busses/Makefile                   |   1 +
 drivers/i2c/busses/i2c-owl.c                  | 471 ++++++++++++++++++
 8 files changed, 608 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-owl.txt
 create mode 100644 arch/arm64/boot/dts/actions/s900-bubblegum-96-pins.dtsi
 create mode 100644 drivers/i2c/busses/i2c-owl.c

-- 
2.17.1

