Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7B6C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E3D2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cjTCXaOf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E3D2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbeJIC1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:27:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34468 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbeJIC1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:27:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id k19-v6so8819766pfi.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 12:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=D1Fso1WTOfCgA486lBMa6IWQvrNF27QUPQhpIjOG/4o=;
        b=cjTCXaOf9jei7LtBWh+OH2svB+9ryaJE9mxYHVWdNcgigI2+ePywLfUeE8Q7XHmSwN
         oYar70YtC+1XyKkcLEZPKtl+h2O3ebyUyYMsjub53sEObpa2niBn2RuYB7xk0HCSJBce
         4ycFKbdvJyM23V/sf0BTm0O+RDWouO5GinXYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=D1Fso1WTOfCgA486lBMa6IWQvrNF27QUPQhpIjOG/4o=;
        b=lTFDi7RS9ozgVXgARwlywTFd72vknO4D0msfBTWkq7sZu3vB0icwpKCg3/N4UC2agD
         08FKK1QX5Zs3IoyW8UQ4ABLKdj9HbaZ/ojY2pqlpMaPhajTqlX1ZWb2ErbhunYchRhaL
         j0mWWmDXzx/ki01wb8y+8Fny+N5sFA2na5lse8e2kI0ZVdCIL3gR0whlWoBnol5afbFw
         y7qwfrnYB3SNS+6njCND9GUAsObF/VZeuMYVSyRzLUE7cCPAX7/SRkvEnudvVyPsyW14
         JjIsVxmR0iQW96tsm5NKXDLb4RbsnzC78IgoPyj3otlXfJsCPFQcTAPyLSFvNQ51jTdC
         LSjg==
X-Gm-Message-State: ABuFfoiQqxTYF0keHgxseKAyiw1FBWlcC1tPbLyeRGQ8xSOqgWPpYpOJ
        jitCwItY57ojPStz3iK3inwrvHYP+A==
X-Google-Smtp-Source: ACcGV61V6t0E46F4XOY9/IjLf01giqGrnZVxMQZG0S762fNp9dsaD2zVgA9i3S7lMJpS4N6KD73SCg==
X-Received: by 2002:a62:1dca:: with SMTP id d193-v6mr7136962pfd.157.1539026069754;
        Mon, 08 Oct 2018 12:14:29 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:73c6:20ea:9fd:1785:d893:1e98])
        by smtp.gmail.com with ESMTPSA id a15-v6sm15648035pff.8.2018.10.08.12.14.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 12:14:28 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sean.wang@mediatek.com, linus.walleij@linaro.org,
        matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, amit.kucheria@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/5] Add initial pinctrl support for MT6797 SoC
Date:   Tue,  9 Oct 2018 00:44:06 +0530
Message-Id: <20181008191411.32555-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds initial pinctrl support for Mediatek MT6797 SoC.
The pinctrl driver is based on the vendor binding as like MT6765 and
implements only GPIO and pinmux functionalities.

The devicetree binding doc is not added because it does not exist for
MT6765 and I'm not sure about the structure of it.

This patchset has been tested on 96Boards MediatekX20 development board.

Thanks,
Mani

Manivannan Sadhasivam (5):
  dt-bindings: pinctrl: Add devicetree constants for MT6797 SoC
  arm64: dts: mediatek: mt6797: Add pinctrl support
  arm64: dts: mediatek: x20: Add pinmux support for UART1
  pinctrl: mediatek: pinctrl-mtk-common-v2: Make eint_m u16
  pinctrl: mediatek: Add initial pinctrl driver for MT6797 SoC

 .../boot/dts/mediatek/mt6797-x20-dev.dts      |    2 +
 arch/arm64/boot/dts/mediatek/mt6797.dtsi      |   21 +
 drivers/pinctrl/mediatek/Kconfig              |    7 +
 drivers/pinctrl/mediatek/Makefile             |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt6797.c     |   82 +
 .../pinctrl/mediatek/pinctrl-mtk-common-v2.h  |    2 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-mt6797.h | 2430 +++++++++++++++++
 include/dt-bindings/pinctrl/mt6797-pinfunc.h  | 1368 ++++++++++
 8 files changed, 3912 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt6797.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt6797.h
 create mode 100644 include/dt-bindings/pinctrl/mt6797-pinfunc.h

-- 
2.17.1

