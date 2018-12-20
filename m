Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52531C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 01:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C112084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 01:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KBWJRoI7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730622AbeLTBCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 20:02:34 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44340 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbeLTBCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 20:02:33 -0500
Received: by mail-pf1-f193.google.com with SMTP id u6so17238pfh.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 17:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=UThqOMSj/e32khQsvP+4qgV2MNKq1vax+X8KO/NkEnw=;
        b=KBWJRoI7dQlfaCd75ztTRWpVcrwXoKWiwYq9iDR55ZVrPL4jnRPD6KzJw6Yd3/3zdl
         rrtRtbVsiFp4Pem7I/ebH5DydGDjqM0q7P/baeGH27wFO77IeRG6F71u1Rgvh9ats4ip
         mYmmwe4S5rc15iq1nl0FXO0XZAn5YB4/qp1X0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UThqOMSj/e32khQsvP+4qgV2MNKq1vax+X8KO/NkEnw=;
        b=CnW3m8eaWpshjWQPSEbwl9GgdO+ll7jqfkOzhpU3aAJcoyN+by1uVgmiIvpduW+t0K
         R708RPC8/8SpWwf20gmPNkcQmJopwTIbOEzr59tJXEqqFWgwrng50/Abnu2Nq80vTy4j
         wfIjwh1H228Vyso4M/I3Jex7FKU+sK/gi+ywjILVpiOv7CoORXYvoOEIixOBIUown0uZ
         AnbZv78po5oqRCT/nvKlt4WGncQVItNEYwCJe9lG05w5Une29EivkixewgqVW3FXyxY2
         OqjmCALEld/Rij94Zab48tYDrbN8+Ds+s0z1z7uX8aE1eqGoiwZ/tX2wfHYa0+ut/AUj
         yIuw==
X-Gm-Message-State: AA+aEWbo2dGOGJLCvriZyG7MuR5ZnR6iX+sZwUIfyLA7PKOghcGJvvid
        PRXkCnKkTXwkH1ZuyoQ7bncm4g==
X-Google-Smtp-Source: AFSGD/V2uUN5i5lTJ+JmC3TovgCNfPIn/LRCyQlq4hWc86BBX5n3wUj2x4foRueFE/xlE3UBzCnPRg==
X-Received: by 2002:a62:42d4:: with SMTP id h81mr22420635pfd.259.1545267752568;
        Wed, 19 Dec 2018 17:02:32 -0800 (PST)
Received: from localhost.localdomain (61-216-91-114.HINET-IP.hinet.net. [61.216.91.114])
        by smtp.gmail.com with ESMTPSA id e16sm25334392pfn.46.2018.12.19.17.02.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Dec 2018 17:02:30 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        Anu Ramanathan <anur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Jack Pham <jackp@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v6 0/2] Add Synopsys High-Speed USB PHY driver for Qualcomm SoCs
Date:   Thu, 20 Dec 2018 09:01:10 +0800
Message-Id: <20181220010112.16824-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's based on a downstream driver from Sriharsha Allenki <sallenki@codeaurora.org>
that uses USB phy framework, and gets rewrote to adpot generic phy
framework together with quite some cleanups.

Changes for v6:
 - Fix the typo of "snsp" in driver file name. (Thanks Jack)

Changes for v5:
 - Drop mb() call from function qcom_snps_hsphy_init_sequence() and
   qcom_snps_hsphy_por_reset().

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
 .../phy/qualcomm/phy-qcom-usb-hs-snps-28nm.c  | 529 ++++++++++++++++++
 4 files changed, 627 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,snps-28nm-usb-hs-phy.txt
 create mode 100644 drivers/phy/qualcomm/phy-qcom-usb-hs-snps-28nm.c

-- 
2.18.0

