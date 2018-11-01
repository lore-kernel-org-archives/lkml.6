Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A232BC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 06:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 586FA20820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 06:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cf4aHiYD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 586FA20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbeKAPU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 11:20:56 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37150 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbeKAPU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 11:20:56 -0400
Received: by mail-pl1-f193.google.com with SMTP id bh10-v6so8440264plb.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 23:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=moyvFdCAg/Y6GiKMyRNN1D/UT2U6l2UAq61V8B6ZMuA=;
        b=Cf4aHiYDKHHtJWfXJHrAjD3oQARam/fgEIkIIAgoE1jMHvfLerUf5cyE3dZijB1MrD
         2R/11mwQFTDQIz1TZaPl7HeZCEIb445zvSyTTUDNidDanH/J/KyKbb6o+ACfVMdKCkZw
         290kko8Iga43mJSbvIAOVPLBChphBBp/+t/TY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=moyvFdCAg/Y6GiKMyRNN1D/UT2U6l2UAq61V8B6ZMuA=;
        b=fM+YT2Edqau1K4yk3V/qShInd7sUHUfUznEp/nbpTg49IO8f2TUrOGGmqw9HoqrxCv
         L6m6yhjG5wngVeyoBNRfwIXQUITpjijj8pTxGL1gGTy8L5I788YnokEaO9y9NucJARR1
         ZniTlFh7vxUbfy9bqbI/6dGXBC2qX06LGHVt9PQZCTCE3WIB/aP55BZ7E8hrpCEMcxfN
         SzzRI3DD771/EUWv5lWzgAmF7uF3fI8QH56pidWZyh1iya7mJiTo4Q5MhEUwLFPyqm3y
         yr/2fCmDySP/qwoGq0j5MleIr33IEcQncviA2FxqNGDfhXL2KmCS24rKC0jseD6FtM8P
         vBGA==
X-Gm-Message-State: AGRZ1gJ3vDOscQVzzqK2kRnHJZuhmCNSVYVbXUZkgIpfpHeTfGHg1/UD
        2c1OFzXunXTCUxqQKSPHPlz2
X-Google-Smtp-Source: AJdET5eGbhHhZRMC7vTm/nSPxLa1wce7hfCfhtic4y2MSm0AJxRBPSbkuoQclORqeFYnc87QSfykfA==
X-Received: by 2002:a17:902:780f:: with SMTP id p15-v6mr6285926pll.197.1541053161777;
        Wed, 31 Oct 2018 23:19:21 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:900:77c6:7824:4800:6aa6:75b4])
        by smtp.gmail.com with ESMTPSA id u190-v6sm71346726pgu.3.2018.10.31.23.19.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 23:19:21 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sean.wang@mediatek.com, linus.walleij@linaro.org,
        matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, amit.kucheria@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/4] Add initial pinctrl support for MT6797 SoC
Date:   Thu,  1 Nov 2018 11:49:03 +0530
Message-Id: <20181101061907.20224-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds initial pinctrl support for Mediatek MT6797 SoC.
The pinctrl driver is based on the vendor binding as like MT6765 and
implements only GPIO and pinmux functionalities.

The devicetree binding document consists of pinmux, pinconf and
interrupt functionalities documented since the binding should describe
what the hardware is capable of rather than what the driver offers.

This patchset has been tested on 96Boards MediatekX20 development board.

Thanks,
Mani

Changes in v2:

* Added devicetree bindings for Pin Controller
* Dropped the applied warning fix patch
* Added Tested-by tag from Matthias Brugger
* Added Acked-by tag from Sean Wang

Manivannan Sadhasivam (4):
  dt-bindings: pinctrl: Add devicetree bindings for MT6797 SoC Pinctrl
  arm64: dts: mediatek: mt6797: Add pinctrl support
  arm64: dts: mediatek: x20: Add pinmux support for UART1
  pinctrl: mediatek: Add initial pinctrl driver for MT6797 SoC

 .../bindings/pinctrl/pinctrl-mt6797.txt       |   74 +
 .../boot/dts/mediatek/mt6797-x20-dev.dts      |    2 +
 arch/arm64/boot/dts/mediatek/mt6797.dtsi      |   21 +
 drivers/pinctrl/mediatek/Kconfig              |    7 +
 drivers/pinctrl/mediatek/Makefile             |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt6797.c     |   82 +
 drivers/pinctrl/mediatek/pinctrl-mtk-mt6797.h | 2430 +++++++++++++++++
 include/dt-bindings/pinctrl/mt6797-pinfunc.h  | 1368 ++++++++++
 8 files changed, 3985 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt6797.txt
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt6797.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt6797.h
 create mode 100644 include/dt-bindings/pinctrl/mt6797-pinfunc.h

-- 
2.17.1

