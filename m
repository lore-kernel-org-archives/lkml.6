Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9D8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 13:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9B92243E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 13:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dRpVu5JS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA9B92243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729628AbeKLWyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 17:54:21 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36682 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729595AbeKLWyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 17:54:20 -0500
Received: by mail-pg1-f194.google.com with SMTP id z17-v6so4059055pgv.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 05:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Sp2FbehNrMTXiq9aXK8DZGzE6dFd7k0MNs0CMmA6kHY=;
        b=dRpVu5JSL610x1Fx5Z7cNzkOATgBzaLUJDOIVQTMmRtP+K9KxxZSNC6Wwus5qDRsaB
         ASDg5Wz1Cop6pJvcKwyXfmwIaUaynolAtoAk00KFjeJ7cp5KurJ7p4FnflhP1X1//WdT
         +8hTPn0SRuB61EkRkokMt4Q5JS7BGcBhlGdvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Sp2FbehNrMTXiq9aXK8DZGzE6dFd7k0MNs0CMmA6kHY=;
        b=Ve+alIEeIkkBCZsPrpxKq98+JRrUW55mENlqOF5f4/HRlk7efw0dyx1Gh+uX8GWumu
         qiWxbI7b47jpW7PFXit/08F3OYYjIJcTeSLVeCp+v3TU/92zVaEUeCN5oSCKY70Imxmi
         qMAO/eKz8Bc4/vx0mL/sQuFencUO+FspDYiQtbJ9VTWbhbOBVCX6njzePc5YAxOwAOL8
         HEBfS5QSFWpArccYOuIOtzfQM8p+PrSvDkiq3gs2+ojCV1tAwfJKNCgJJOCRj0FmOecE
         u+g4A8/DunN6BYc7Nm1l7ULM1e6X6MqTWdcyPzv0sxCPs/JQOHbUNIN7m2jFSkIsKVhb
         +fRg==
X-Gm-Message-State: AGRZ1gJq9wWENDGrHYOhvYcG5WC2libaJEEHTBSzpfwukxoefd4uYTOJ
        +5QTvcxBGDyXv0vpkc/CQaEZmw==
X-Google-Smtp-Source: AJdET5dmBfmywoNIfUoSJPlpE567I3oXexx/7c9h76qQaERY5+k54jSqc9UC3BnCqKCRTzeV2E2eoQ==
X-Received: by 2002:a65:4784:: with SMTP id e4mr741726pgs.12.1542027668698;
        Mon, 12 Nov 2018 05:01:08 -0800 (PST)
Received: from localhost.localdomain (61-216-91-114.HINET-IP.hinet.net. [61.216.91.114])
        by smtp.gmail.com with ESMTPSA id w2-v6sm20152023pfn.89.2018.11.12.05.01.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Nov 2018 05:01:07 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        Anu Ramanathan <anur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 0/2] Add Synopsys High-Speed USB PHY driver for Qualcomm SoCs
Date:   Mon, 12 Nov 2018 21:00:38 +0800
Message-Id: <20181112130040.18793-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's based on a downstream driver from Sriharsha Allenki <sallenki@codeaurora.org>
that uses USB phy framework, and gets rewrote to adpot generic phy
framework together with quite some cleanups.

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

 .../phy/qcom,snps-28nm-usb-hs-phy.txt         | 101 ++++
 drivers/phy/qualcomm/Kconfig                  |  10 +
 drivers/phy/qualcomm/Makefile                 |   1 +
 .../phy/qualcomm/phy-qcom-usb-hs-snsp-28nm.c  | 505 ++++++++++++++++++
 4 files changed, 617 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,snps-28nm-usb-hs-phy.txt
 create mode 100644 drivers/phy/qualcomm/phy-qcom-usb-hs-snsp-28nm.c

-- 
2.18.0

