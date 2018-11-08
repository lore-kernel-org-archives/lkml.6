Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A649C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E51D20825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OsxHGY42"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E51D20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbeKHQjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 11:39:24 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:47024 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725724AbeKHQjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 11:39:24 -0500
Received: by mail-pf1-f196.google.com with SMTP id s9-v6so1538176pfm.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 23:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ahuJu7Ge1996Rr/ggZS3kkUUhLX18DlwfGCsBgvp7vw=;
        b=OsxHGY42IllEiWNjHrVeOfYWP1QZ5LqNEkqVLrJ/D7e6137cxiRToVHRKQuRSm3SNT
         ll6bzNzu6zMlmo9roV64AV7vciScP9q3pfyDv84zdDTORogAsmd9fQE/yE6W07iwq7FF
         DUzEy5bfUO1miy8l4tKrNR3HHu9ImlvcQzlBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ahuJu7Ge1996Rr/ggZS3kkUUhLX18DlwfGCsBgvp7vw=;
        b=gPuSNw1XcLsAig4s+87iBEtYIFDPyq+r9WMXlARs/Zv7gOIz+6rVF1wT/LpQji1FaG
         Ld2bSQKOVcVmfzP2byCvPGJCOvqFx89IM4KqpnDy0YRJY2bq0iks4xZnWbOxM04ozDo4
         xLkZ6XhZgZ5Lu7118mMBInRptEiaF6gKU7lcG9AX9RsEbmUrrk2/eaBu5lEhlyOidl1x
         mxdwIL/9+P0VXIcz7kMl26WJdpxPFd0no7/f5txF/9UGGhxy/4lBBqsl0AbsQANMzB0w
         HfKw2O5lIcfHG8UAJEUmT1MTK1M/4kaplg9B28SgphIA6cRdDkqKCmDONwpkIk0eM8o1
         7vkQ==
X-Gm-Message-State: AGRZ1gIJxoC1ArLoyEc4SqHMq7sn+gXwCKAfngYpK1Vh1yh6maSKpjtC
        9z2ArvaAfUnMTiddKniHovUJpQ==
X-Google-Smtp-Source: AJdET5cTtkcxWxWCcPkEYhD5J3na1ZfjmH6bOzU5h+D0fNb6iTBeXtkzV7Tc7e9bcHF+tiuEcGODKA==
X-Received: by 2002:a62:1c53:: with SMTP id c80-v6mr3454280pfc.14.1541660720298;
        Wed, 07 Nov 2018 23:05:20 -0800 (PST)
Received: from localhost.localdomain (61-216-91-114.HINET-IP.hinet.net. [61.216.91.114])
        by smtp.gmail.com with ESMTPSA id w63-v6sm2550618pgw.60.2018.11.07.23.05.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Nov 2018 23:05:18 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        Anu Ramanathan <anur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 0/2] Add Synopsys High-Speed USB PHY driver for Qualcomm SoCs
Date:   Thu,  8 Nov 2018 15:04:47 +0800
Message-Id: <20181108070449.23572-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's based on a downstream driver from Sriharsha Allenki <sallenki@codeaurora.org>
that uses USB phy framework, and gets rewrote to adpot generic phy
framework together with quite some cleanups.

Shawn Guo (1):
  phy: qualcomm: Add Synopsys High-Speed USB PHY driver

Sriharsha Allenki (1):
  dt-bindings: phy: Add Qualcomm Synopsys High-Speed USB PHY binding

 .../phy/qcom,snps-28nm-usb-hs-phy.txt         | 101 ++++
 drivers/phy/qualcomm/Kconfig                  |  10 +
 drivers/phy/qualcomm/Makefile                 |   1 +
 .../phy/qualcomm/phy-qcom-usb-hs-snsp-28nm.c  | 494 ++++++++++++++++++
 4 files changed, 606 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,snps-28nm-usb-hs-phy.txt
 create mode 100644 drivers/phy/qualcomm/phy-qcom-usb-hs-snsp-28nm.c

-- 
2.18.0

