Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF554C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 11:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 948DF21104
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 11:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HgMDSgz7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 948DF21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbeKSVcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 16:32:06 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33425 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbeKSVcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 16:32:06 -0500
Received: by mail-pg1-f196.google.com with SMTP id z11so11067887pgu.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 03:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hcrTEn3IZek4MtdyEmTE+H8Qe3S1camCgGNvKmUVN5g=;
        b=HgMDSgz7lIVkinQSPRcD0hc7uKMliZQy2dYzUBwzn50T/gCRORyT1jXm6M60h9IFFE
         W41VZW5kwuIinDWx0EpVvKWP0N1ift1G4vn26fAJa1NVA0TrqGhqpvMONck5xLXZRtVu
         SjXxfQ94tbKbJKEUe7m13/A6YWdmSfo7oAJ+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hcrTEn3IZek4MtdyEmTE+H8Qe3S1camCgGNvKmUVN5g=;
        b=YRyVyj5myuZZAAuH8My+PUjyLwvg3e2jnl/NaABtLjGKh1dYPGLUVKiDPZrlzv3pJi
         Mhye6GJma2ML04iRxB2gN0JnqHxoBakeBI8dyucJRU7Mrj9Wo4oP+nZenpyMBfOCk/Ud
         hqXyzkgvj+WTJYcKFpcoI5n2I7XoUFjtpLOoFPzzUDYMTFAYcs1Y19ZloW/EqzNtVF8q
         eWKZFuBtA+TxFphti/Y1fO7nl4unx/fn0V+eel0HwN4rOlGpkUWANJYIvo+zRR02/yZh
         Z6Bc4opEew6Zauv4zEq/ncmLGRvoLC3FIJ9DtSwEsPnRaooSBDrulROsP/Grp8edXHSe
         CIjA==
X-Gm-Message-State: AGRZ1gI37SM9wlAJ2+7pV+mcHATj5BHJzYkU0CcQ31tD6gUzMWzSzVBV
        o2KlZLj1m5eKgwwnp4M5JK36hw==
X-Google-Smtp-Source: AJdET5d5xxObNJZbrcPazy5hRYcV7QKciHdrN370vaxeI4POrOkFjT//0qHX4PcmI4RBjzf6s47LHg==
X-Received: by 2002:a62:a511:: with SMTP id v17-v6mr22366371pfm.18.1542625728236;
        Mon, 19 Nov 2018 03:08:48 -0800 (PST)
Received: from localhost.localdomain (61-216-91-114.HINET-IP.hinet.net. [61.216.91.114])
        by smtp.gmail.com with ESMTPSA id q25sm43906934pgb.2.2018.11.19.03.08.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Nov 2018 03:08:46 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        Anu Ramanathan <anur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v4 0/2] Add Synopsys High-Speed USB PHY driver for Qualcomm SoCs
Date:   Mon, 19 Nov 2018 19:08:10 +0800
Message-Id: <20181119110812.15825-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's based on a downstream driver from Sriharsha Allenki <sallenki@codeaurora.org>
that uses USB phy framework, and gets rewrote to adpot generic phy
framework together with quite some cleanups.

Changes for v4:
 - Kill device tree property 'qcom,init-seq' by moving the settings
   into phy driver as device match data.

Changes for v3:
 - Use SoC specific compatible "qcom,qcs404-usb-hsphy".
 - Use OF graph instead of extcon bindings to model the link to USB
   connector.

Changes for v2:
 - Add a pointer to phy/phy-bindings.txt for property #phy-cells.
 - Roll back voltage settings in case function
   qcom_snps_hsphy_config_regulators() fails in the middle.
 - Add a comment for init-seq tuple which consists of 3 numbers.
 - Sort include headers alphabetically.
 - Sort register definitions in order of offset.

Shawn Guo (1):
  phy: qualcomm: Add Synopsys High-Speed USB PHY driver

Sriharsha Allenki (1):
  dt-bindings: phy: Add Qualcomm Synopsys High-Speed USB PHY binding

 .../phy/qcom,snps-28nm-usb-hs-phy.txt         |  87 +++
 drivers/phy/qualcomm/Kconfig                  |  10 +
 drivers/phy/qualcomm/Makefile                 |   1 +
 .../phy/qualcomm/phy-qcom-usb-hs-snsp-28nm.c  | 535 ++++++++++++++++++
 4 files changed, 633 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,snps-28nm-usb-hs-phy.txt
 create mode 100644 drivers/phy/qualcomm/phy-qcom-usb-hs-snsp-28nm.c

-- 
2.18.0

