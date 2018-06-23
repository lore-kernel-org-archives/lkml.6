Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EC6C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 05:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6DE24B2B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 05:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y5hqdAMv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E6DE24B2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751479AbeFWFAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 01:00:23 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34551 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751449AbeFWFAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 01:00:21 -0400
Received: by mail-pg0-f68.google.com with SMTP id q4-v6so3818883pgr.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 22:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=iR+qEr2tiyoznVaO+gtZ5lYofHvz5XR9jfVKhHvFVcY=;
        b=Y5hqdAMvM5PH9B16IAOhqZPqDzkfMoUvagsra/WHxgIjSxi+XrkkFkSjWO7k8QrKgN
         ievP+8N9EEV6kA4hx1Ia2QjiI5Ts5sM9ujIp8w9cX48LZ4YMd0BmDlFGrAZr++IOnUgr
         Iapfx3r3cI6fFDxVPunQUTanAAQUiKktBbd6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iR+qEr2tiyoznVaO+gtZ5lYofHvz5XR9jfVKhHvFVcY=;
        b=WX1UOhMsjMg/NFhfmANJtkkQJTsTjBLW/+fxVbUlkt68QeMav8aaLn+gNEKmzPlX5F
         zVekgH47y+QpEpdCY/V+xGl1/8qSCkdkCPMIUrnlPUZMRBruErv3F8T52JiGyNOgMliW
         4asxoZLgcqrDqD3aBOXrgIq9s3OVOso99Y8TwUojOIZ5SpiI+9LmOgcqMyncOr9xbPZm
         YEWt8Tw6j6P63on79hpQGoXvfhtekHklMvQRQDr5R1ceOyJ/Ah7wQAPPr+e/eek22/KF
         4mRbWtwuW6hIoWVDYAd1dezJODT1MSjKuZEJfRcdELg7AWfNmL21NfCfwG2OwVccpGrU
         IweA==
X-Gm-Message-State: APt69E2XsawL12EashJi4wxX/oOpHfSqZATLrt73WfAcxTgJX3TvXFwp
        DRHGk7yaqsQZ5LPRohHjuzAV
X-Google-Smtp-Source: ADUXVKLWTjN1DhPPmbMk3UdvAKe0nJZCmXri1iER4cVOgmIwQ0yFvVlLrKIkKKz25bKVlC9oFNDJjw==
X-Received: by 2002:a65:5086:: with SMTP id r6-v6mr3613841pgp.375.1529730020818;
        Fri, 22 Jun 2018 22:00:20 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:70c3:aca:6549:5166:32c7:2dab])
        by smtp.gmail.com with ESMTPSA id y14-v6sm10787603pgv.37.2018.06.22.22.00.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 22:00:20 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     linus.walleij@linaro.org, robh+dt@kernel.org, afaerber@suse.de
Cc:     liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/3] Add gpio interrupt support for Actions Semi S900 SoC
Date:   Sat, 23 Jun 2018 10:29:51 +0530
Message-Id: <20180623045954.6729-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds interrupt support for Actions Semi S900 GPIO's. Each
port has individual register sets for configuring the below interrupt
types:

1. Rising Edge Interrupt
2. Falling Edge Interrupt
3. Software Emulation of both Edges
4. High Level Interrupt
5. Low Level Interrupt

Thanks,
Mani

Changes in v2:

* Removed custom IRQ domain implementation and used GPIO_IRQCHIP with
  multi parents based on gpio-tegra186.c
* Added support for emulating interrupt on both edges
* Added parentheses to the expression as spotted by Linus
* Added Rob's Reviewed-by tag for bindings patch

Manivannan Sadhasivam (3):
  dt-bindings: pinctrl: Add gpio interrupt bindings for Actions S900 SoC
  arm64: dts: actions: Add interrupt properties to pinctrl node for S900
  pinctrl: actions: Add interrupt support for OWL S900 SoC

 .../bindings/pinctrl/actions,s900-pinctrl.txt |  10 +
 arch/arm64/boot/dts/actions/s900.dtsi         |   8 +
 drivers/pinctrl/actions/Kconfig               |   1 +
 drivers/pinctrl/actions/pinctrl-owl.c         | 271 +++++++++++++++++-
 drivers/pinctrl/actions/pinctrl-owl.h         |  22 +-
 drivers/pinctrl/actions/pinctrl-s900.c        |  31 +-
 6 files changed, 325 insertions(+), 18 deletions(-)

-- 
2.17.1

