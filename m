Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27FBECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11A920684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EGR15/ye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A11A920684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732130AbeGSS3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:29:55 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35706 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732029AbeGSS3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:29:55 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6-v6so4420979pgv.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 10:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=P9msEeOWuKRHaJD5110IIrRLgke2uQu5PlVzkB4rMxI=;
        b=EGR15/ye3dYJFy6dUMboerhNK2pdlEXgWoUEcEqD0AyyJeOAHHOkz2Eqllj/lkJwRn
         oNqdhUmllCcwHjVikPvUTC73UHlHpAyM1bE5PPWhjoNldvuPoKfFkl6SY+y93bgi5998
         iuBEJZKvfDw64X1mVHuBAQSCf3OBZAcgsWEvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P9msEeOWuKRHaJD5110IIrRLgke2uQu5PlVzkB4rMxI=;
        b=Rhserj4vxefTu2x4+sC7zEf5VftGkHexN0kgvVSU6l2UEjXWIvffmTR7axKnqdTlq4
         f7ac/FXCD+SSvhEVPKT0La555PthcErZG+K6z4WVCHxwofoOVZBHYiOqS5AdfjNt5RzP
         +Mcntyh1i0/VHpU1hK3KKlZXsQBDjliRQtyTYfuZk/xuMluho0l8ByOYC7Jm42/79P9T
         y38Bk9M4Jm43p9kA20QRxfaBvw0nyhKiKGxGGq02RazCK7XIomnJ0HZcikFvCwbypSMj
         eX0yF5KjKYIsDvVpWJoOMUisoSyq0q1/XZAUmrAwSQ7aIKHkOAxWS6ytUqrQTSvsrRta
         +10A==
X-Gm-Message-State: AOUpUlHT9BdDrJ1lcr8osZpHN5mAnIOuii/2mUSkprICv0ISp9lTKLwi
        RH+QDP+bMEW3ClhxkLJsDx6d
X-Google-Smtp-Source: AAOMgpeFKvZ09pxiRgKnQZ8n9Y4V03KcGJxBW5P69FurvZ8SKzCuc6svp2Aj42iTi7kiQWRYzOwUdQ==
X-Received: by 2002:a63:4d47:: with SMTP id n7-v6mr10899741pgl.270.1532022342694;
        Thu, 19 Jul 2018 10:45:42 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6081:b056:55fa:fd42:61de:739])
        by smtp.gmail.com with ESMTPSA id h2-v6sm10114639pgc.90.2018.07.19.10.45.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 10:45:25 -0700 (PDT)
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
Subject: [PATCH v5 0/6] Add Actions Semiconductor Owl S900 I2C support
Date:   Thu, 19 Jul 2018 23:13:59 +0530
Message-Id: <20180719174405.7210-1-manivannan.sadhasivam@linaro.org>
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

Changes in v5:

* Cleaned up the multi-line codes and reordered the error paths
  as per Peter's review
* Added Acked-by tag from Peter for driver patch
* Added Reviewed-by tag from Rob for bindings patch

Changes in v4:

As per Andy and Peter review:

* Used spinlock for accessing most of the register access (only parts
  involved sleep/long-busy-wait has been excluded)
* Removed returning 0 and added -ENXIO if the msg_ptr not equals to
  message length
* Added DIV_ROUND_UP for setting clock frequency
* Changed one non-atomic mdelay instance to usleep_range
* Moved pinctrl definition patch before dts patch
* Fixed the driver to support only 100KHz and 400KHz frequencies

Changes in v3:

As per Peter, Andy and Andreas review:

* Removed owl_i2c_reset function from interrupt handler since it
  involves the use of delays.
* Fixed the return path in owl_i2c_master_xfer and added a note
* Changed "base" parameter to "reg" in owl_i2c_update_reg for better
  understandability
* Ordered the includes in alphabetical order
* Small changes to defines and added comma at the end of struct members
* Removed rendundant 0 assignment in owl_i2c_master_xfer
* Changed all OWL naming convention to Owl and also changed Actions Semi
  naming to Actions Semiconductor

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
  arm64: dts: actions: Add pinctrl definition for S900 I2C controller
  arm64: dts: actions: Add Actions Semiconductor S900 I2C controller
    nodes
  arm64: dts: actions: Enable I2C1 and I2C2 in Bubblegum-96 board
  i2c: Add Actions Semiconductor Owl family S900 I2C driver
  MAINTAINERS: Add entry for Actions Semiconductor Owl I2C driver

 .../devicetree/bindings/i2c/i2c-owl.txt       |  27 +
 MAINTAINERS                                   |   2 +
 .../dts/actions/s900-bubblegum-96-pins.dtsi   |  29 +
 .../boot/dts/actions/s900-bubblegum-96.dts    |  11 +
 arch/arm64/boot/dts/actions/s900.dtsi         |  60 +++
 drivers/i2c/busses/Kconfig                    |   7 +
 drivers/i2c/busses/Makefile                   |   1 +
 drivers/i2c/busses/i2c-owl.c                  | 495 ++++++++++++++++++
 8 files changed, 632 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-owl.txt
 create mode 100644 arch/arm64/boot/dts/actions/s900-bubblegum-96-pins.dtsi
 create mode 100644 drivers/i2c/busses/i2c-owl.c

-- 
2.17.1

