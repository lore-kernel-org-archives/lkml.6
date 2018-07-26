Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEDAC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B58BD20857
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="R0dQA9JV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B58BD20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731846AbeGZRD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 13:03:59 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46589 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730610AbeGZRD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 13:03:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id u24-v6so712389pfn.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 08:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=H0FMPDJxbqp+6InHYCFXACtjdipd7+E3GEKG4gdHw2U=;
        b=R0dQA9JVWREDw9uIH1SaIdJBBsp2ddn8N5d8tz60A7JoS+Lp5t4v94y9US9rXq1ORD
         jNfj9bWdnuIrolblfPgQqHnV5vyoT2pkx6qmHVI5ecPmkOSCCxN7N5oZ7xZe7p8tOGa7
         36ayU4904ZN5JlwqvzRb4Qm/Z8TTtq3XmNhnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H0FMPDJxbqp+6InHYCFXACtjdipd7+E3GEKG4gdHw2U=;
        b=hmDHQVNxiHqSyJ9yC4cn/KuWMd2iBgUgIPm6y0uvWJu+oFRUvBnnQUEoi0PvozEjJ0
         UwFMtc7Gg7qiOAHTkAmag1gdZKMPt3MNmNGcBodUMOnEu5zNd9umXUZSVs086BF3dR6Q
         0uHd7zwP9YKpaPJ9KxHoria1IyCSa38ZIKk4qmtrZFHX6dLk2m6wrX4vafS8gkWL0DQv
         j4N3eYk58UaVRuOhYvrSJLDsdRB1NeFq2OhxOvnDDmWWnIqKXBYeAQZ3MRLSU+ew7tPh
         C+81LJDoxRBsmY2pvM+dujcNO4e9wOYysAmLOgKf/A+tdwcjXGUFkDUMg16RIZklZ/Ex
         M/Hw==
X-Gm-Message-State: AOUpUlH3Do8WAgywf7ZaWclpn9VtyD1IfVaUVYRnlOCaBonOEMJ4ZSDj
        Pb1lz8tN3M4nkow5sPxPxW0j
X-Google-Smtp-Source: AAOMgpc8oMpwwLtr1jr2Z8pdgC+M2Q4jKN9qKNxgACYvgc6mPaixvJseE8Wl/fP0UwVrPLnATViTcQ==
X-Received: by 2002:a65:6104:: with SMTP id z4-v6mr2420450pgu.361.1532619993598;
        Thu, 26 Jul 2018 08:46:33 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:628e:aef6:6d51:3501:dada:e06d])
        by smtp.gmail.com with ESMTPSA id z11-v6sm3755322pff.162.2018.07.26.08.46.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 08:46:33 -0700 (PDT)
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
Subject: [PATCH v7 0/6] Add Actions Semiconductor Owl S900 I2C support
Date:   Thu, 26 Jul 2018 21:15:57 +0530
Message-Id: <20180726154603.5089-1-manivannan.sadhasivam@linaro.org>
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

Changes in v7:

* Fixed a multi line misalignment spotted by Peter

Changes in v6:

As per Peter's review:

* Added missing newlines for error and debug outputs
* Fixed further multi-line misalignments

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

