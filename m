Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177D6C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D26A72086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GI8WIknl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D26A72086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbeK0VFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:05:15 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45678 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbeK0VFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 16:05:15 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so7629462pgc.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 02:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=l3hLvTtx6xtNQ2hZkfWDlWg7A5zQP7PjQIve/V9CR1g=;
        b=GI8WIknl+tHhB/ejbCmEwYy0ko1t3BslddN7Vejjbe0tJ0rkkYZWhAZmX5IMF/W9ib
         vjLi89i84taSNQyxWrh0CWFd2JxcgyOhmeU6r6d5luPw6PvzL+ZabhMUau4Av41uw6ty
         1sPCYwzrACNPaID/vA/xwVm807aBcGSfb4DjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=l3hLvTtx6xtNQ2hZkfWDlWg7A5zQP7PjQIve/V9CR1g=;
        b=Y5HSCMIEdJdwZ8deNPIHSQyUkVzElGH6qn4gLm5wYQ8ynESvfH0aybWK15HYnjzFXG
         K/UJXG7E1pRFG3CcPq5zxiTsrQjamAm6WBB0z/YuWRQpULobDoP8jaS01M7cykatD2FX
         cE0pVVkRfSVtJY06ORmxeOV8GwA4Fx/vNZLVpmcwVqLW4OH+/N9orB8IJ2h/oZ6ONmN7
         eyO4Mdpp8y2FchOJfypEP6G/INj8xbI/jEgm2sC2ONC/7Q5Cl8zNgO1usjLvrGBXG7iH
         yblrhpz2JQlPVhCf/7nnSnHatFk5f55OdcfDf19NLuhl5KUjPFS7PiloOe4sdOVY5ynx
         15TQ==
X-Gm-Message-State: AA+aEWb8W5TCxbUQAZPKRB0c4EK9MWrLPRU8N3dKBD8huy52NVxTvVAx
        WOVg/6sSKqBYzQuQm+GgE3FKdQ==
X-Google-Smtp-Source: AFSGD/UcUSpsvfIpgU0cJgUyHC6XLjunqGJKT875ncpV5LGMLHF3TvkWf8jyroUM2QZgR0pUSfL62w==
X-Received: by 2002:a62:5c41:: with SMTP id q62mr809602pfb.171.1543313271876;
        Tue, 27 Nov 2018 02:07:51 -0800 (PST)
Received: from localhost.localdomain (61-216-91-114.HINET-IP.hinet.net. [61.216.91.114])
        by smtp.gmail.com with ESMTPSA id y66-v6sm4006875pfy.24.2018.11.27.02.07.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Nov 2018 02:07:50 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        Anu Ramanathan <anur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v5 0/2] Add Synopsys High-Speed USB PHY driver for Qualcomm SoCs
Date:   Tue, 27 Nov 2018 18:07:20 +0800
Message-Id: <20181127100722.9993-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's based on a downstream driver from Sriharsha Allenki <sallenki@codeaurora.org>
that uses USB phy framework, and gets rewrote to adpot generic phy
framework together with quite some cleanups.

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
 .../phy/qualcomm/phy-qcom-usb-hs-snsp-28nm.c  | 529 ++++++++++++++++++
 4 files changed, 627 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,snps-28nm-usb-hs-phy.txt
 create mode 100644 drivers/phy/qualcomm/phy-qcom-usb-hs-snsp-28nm.c

-- 
2.18.0

