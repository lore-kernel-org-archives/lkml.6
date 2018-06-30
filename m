Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2CEC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 13:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F3025429
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 13:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PmDfJd8b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F3025429
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752111AbeF3Ndw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 09:33:52 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:41202 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751060AbeF3Nds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 09:33:48 -0400
Received: by mail-pg0-f66.google.com with SMTP id l65-v6so5174514pgl.8
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 06:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TKTeKRQWXYCQBWxq4jBLmm9sNoG9zgycBxcujch58L0=;
        b=PmDfJd8bYzm4G2S5FJLHXSnnDrDh4wCQD5EcFsBXQJ7/3214PZcKYHPVjfg531yihe
         w7k7+T7FU/CGkTVQMftvtbUUBpyib8BGi3QXcprvj0dpaN7a4pZ/rXk7QsmKLwqNzd9H
         IwAcHadn2q33WVH048uxLfSs6bEiLM1Zk/sxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TKTeKRQWXYCQBWxq4jBLmm9sNoG9zgycBxcujch58L0=;
        b=bROuXntEwalKxG7y0jQmrl9UGAIOT6fZhbsrewU9PIOTMtTgsyI6zNUCyBLbnQBzcJ
         MfXFnM5zyOibHJGdOfCc20vtmH1ohPlkkl+hCnwJZReK3GvvfyMJo56495LjmDr5+nf2
         KZZvLXT+odI3uphcjvT5gHLs0giAa+RSuz3hK2nmT7gcG1o3/sf3nHLhC2w32X232IVp
         pvB/fqVUVKm9IXt4y6wjbFhWon/GqsvFrcVsxB3eZ+KMr/XIxOYbtQVZ43fUto+DQaJB
         mZSQOqAcovEH3LTxMkE5P7x+ajM0fnKRY9Zzu9RVZ0l7ySdzoEXezdLavbfFKEh018Fb
         xvbQ==
X-Gm-Message-State: APt69E3ek3TQYp4I9faR7eULc+mmpSGPTEY7jb1IJ7cEdJVvIZsTkoFo
        S/tIRaYtY3WOH6rCzQsAWKMk
X-Google-Smtp-Source: ADUXVKIv1T/ARd93VPMKb1JI3Stjwgj0Nd4SetDYRLjAZ4Nvo/Gv2PhI516LFqNu6zsID45TNihysA==
X-Received: by 2002:a65:4b0f:: with SMTP id r15-v6mr16136916pgq.103.1530365627991;
        Sat, 30 Jun 2018 06:33:47 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:73ca:b257:2c06:3367:1893:796])
        by smtp.gmail.com with ESMTPSA id m10-v6sm18738778pgq.89.2018.06.30.06.33.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 06:33:47 -0700 (PDT)
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
Subject: [PATCH v3 0/6] Add Actions Semiconductor Owl S900 I2C support
Date:   Sat, 30 Jun 2018 19:03:24 +0530
Message-Id: <20180630133330.23858-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds I2C controller support for Actions Semiconductor S900 SoC.
This driver has been structured in a way such that there will be only
one controller driver for the whole Owl family series (S500, S700 and
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

This series depends on the pinctrl patch [1] is still not merged by the
platform maintainer Andreas but it has been reviewed by the pinctrl maintainer
Linus Walleij. For the reference, I have queued up all reviewed dts patches
in my tree [2] from which Andreas is picking them for 4.19.

For this series, since the dts patches will go through the ARM SoC tree,
Andreas will pick it up once it is reviewed.

Thanks,
Mani

[1] https://patchwork.kernel.org/patch/10322937/
[2] https://git.linaro.org/people/manivannan.sadhasivam/linux.git/log/?h=s900-for-next

Changes in v3:

As per Peter, Andy and Andreas review:

* Removed owl_i2c_reset function from interrupt handler since is
  involves the use of delays.
* Fixed the return path in owl_i2c_master_xfer and added a note
* Changed "base" parameter to "reg" in owl_i2c_update_reg for better
  understandability
* Ordered the includes in alphabetical order
* Small changes to defines and added comma at the end of struct members
* Removed rendundant 0 assignment in owl_i2c_master_xfer
* Changed all OWL naming convention to Owl and also changed Actions Semi
  Actions Semiconductor

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
  dt-bindings: i2c: Add binding for Actions Semiconductor Owl I2C
    controller
  arm64: dts: actions: Add Actions Semiconductor S900 I2C controller
    nodes
  arm64: dts: actions: Add pinctrl definition for S900 I2C controller
  arm64: dts: actions: Enable I2C1 and I2C2 in Bubblegum-96 board
  i2c: Add Actions Semiconductor Owl family S900 I2C driver
  MAINTAINERS: Add entry for Actions Semiconductor Owl I2C driver

 .../devicetree/bindings/i2c/i2c-owl.txt       |  27 +
 MAINTAINERS                                   |   2 +
 .../dts/actions/s900-bubblegum-96-pins.dtsi   |  29 ++
 .../boot/dts/actions/s900-bubblegum-96.dts    |  11 +
 arch/arm64/boot/dts/actions/s900.dtsi         |  60 +++
 drivers/i2c/busses/Kconfig                    |   7 +
 drivers/i2c/busses/Makefile                   |   1 +
 drivers/i2c/busses/i2c-owl.c                  | 477 ++++++++++++++++++
 8 files changed, 614 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-owl.txt
 create mode 100644 arch/arm64/boot/dts/actions/s900-bubblegum-96-pins.dtsi
 create mode 100644 drivers/i2c/busses/i2c-owl.c

-- 
2.17.1

