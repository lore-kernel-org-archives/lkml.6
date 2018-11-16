Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04716C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 14:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B932F2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 14:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j+0K6lJz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B932F2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389742AbeKQBJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 20:09:03 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34921 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728458AbeKQBJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 20:09:03 -0500
Received: by mail-pf1-f196.google.com with SMTP id v9-v6so11529020pff.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 06:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=WSirrXbsFxARB56mv91wGf6iKQQ0otMzx5RVBqcCFzo=;
        b=j+0K6lJzduFb6jufCD4Qr/NMbxESt+I21rpfmJ+UFdaS1hK9MQiHT4M2/A8VeZd3o+
         PQMl6WD2eSRYSBFIHcQKxcuW9J0mcbxD/squkxOWW5XSqyzaubltiztkGKCcS2oZ11/K
         e0F0MlUrVAVtUTP3vh1diEuFjZD413NdOT2/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WSirrXbsFxARB56mv91wGf6iKQQ0otMzx5RVBqcCFzo=;
        b=eYsjptI+xetUh3OzCCVi2xO4v1nVw+DuVsEzt0EY1CoqzYtyh2TodBB8hN8QiELd+X
         nh/MH3+9b+yqlfPcsJ/4fOgTdgNhgjnCbKS3bQSVHwWBWnlvTCK7cuUfEBBwdsbapttd
         ZekBaf9ul4iMxG32JrDJC10uxc/Ifi9eKxV0SilKjCD6I6Ok7CJT7CqO1LzXUCOnYZLV
         YKrOKnZYxKa7YFu9EG5QEoA+rjwzhVqdQm7S6RbvNoYaWWWTd0KD2IMlCre8C+8PYTMF
         kjs4dhoSuljCHPv3iY2QgNaxlRH97bGQycHWZTfSqypFakAwpsrz1cQYmeCGVI/a9RBS
         k4vg==
X-Gm-Message-State: AGRZ1gJU6i0VOM2joEHnb/RX4CXIy1kBBx9mHKLkJDCB980PhuGNaNqm
        1Tdvw5J23F+m5trLvey/ifTuNA==
X-Google-Smtp-Source: AJdET5cMri/SoXgCeGynbZ8KkXJ4iBl8wocvmFyId9UIaZ60eB/9xiPBv48XwffILPgomSY7Rrg2ZQ==
X-Received: by 2002:a63:5b48:: with SMTP id l8mr10298980pgm.80.1542380181149;
        Fri, 16 Nov 2018 06:56:21 -0800 (PST)
Received: from localhost.localdomain (61-216-91-114.HINET-IP.hinet.net. [61.216.91.114])
        by smtp.gmail.com with ESMTPSA id u6sm31591670pgr.79.2018.11.16.06.56.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Nov 2018 06:56:20 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        Anu Ramanathan <anur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v3 0/2] Add Synopsys High-Speed USB PHY driver for Qualcomm SoCs
Date:   Fri, 16 Nov 2018 22:55:57 +0800
Message-Id: <20181116145559.31876-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's based on a downstream driver from Sriharsha Allenki <sallenki@codeaurora.org>
that uses USB phy framework, and gets rewrote to adpot generic phy
framework together with quite some cleanups.

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

 .../phy/qcom,snps-28nm-usb-hs-phy.txt         | 108 ++++
 drivers/phy/qualcomm/Kconfig                  |  10 +
 drivers/phy/qualcomm/Makefile                 |   1 +
 .../phy/qualcomm/phy-qcom-usb-hs-snsp-28nm.c  | 513 ++++++++++++++++++
 4 files changed, 632 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,snps-28nm-usb-hs-phy.txt
 create mode 100644 drivers/phy/qualcomm/phy-qcom-usb-hs-snsp-28nm.c

-- 
2.18.0

