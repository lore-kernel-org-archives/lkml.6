Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AA1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660E52173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gO2ad/HU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfAJIIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 03:08:34 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44445 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfAJIIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 03:08:34 -0500
Received: by mail-pg1-f195.google.com with SMTP id t13so4503448pgr.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 00:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=iSUvtlmz7HRG1KEi4a3SboSz9E/V0kDVcYhcnqIe4qQ=;
        b=gO2ad/HURJwsyHjGuSd53WT0Fe1QjfjRmTcvDyCE32Hz6/VkQLW6Nfg/qe6loWhY66
         lOc9moMCkTXuSRauoqLo55EwGnabcqSNPCfQxUXU+V9ztRMQpUwLKTyWx2IfuR3Szcq8
         aR8uFPeO0Uyr6K9cISPy3pSmmV/AG9aa7nUTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iSUvtlmz7HRG1KEi4a3SboSz9E/V0kDVcYhcnqIe4qQ=;
        b=C27ZAkYJ0Bm610C/16CFkWC5iDGYbGmDf4aZw633twechbK4Z+UpnKk4IW6qh7o1NR
         0wF+ArXogE7FfOheHyHqhWvOOvHR9OQgI6rl2j55h1JPCUCu1mLN7Dz797cuFMJPCQQ5
         q3FR0GMcO6U0GxRpynLlvvG8I04jks0FJ2ERLnym2QvMGuleuNzXdfy/UwLhdael2Epj
         3c60vOBBDrDzj7aOZr+kEWiaMIo+NiZgX9ccABhNi4e0WxEIlcc6Ho4EZMGmnKS2we/A
         YdkdNfTFgF/y70ZyYSI0eBxyt9u5p0Ye42qQ5JWCrrTrZTHQ5GDawiYbTdH1aEQ63iMA
         zJDA==
X-Gm-Message-State: AJcUukf0Hi94ioGfOD2Qm8WS7RBVTth7yTbRNW3srrEl+xgLJoOyU8Yh
        I7gREF3P/wY0lsMKCxS2R6DW
X-Google-Smtp-Source: ALg8bN75uRydOKOeNSyFja7FTS42cWEHqVE9OeylGWb6tLCL+yqKDDLTXu7sAFMbWg2AkUCQdwnPhg==
X-Received: by 2002:a63:ee0e:: with SMTP id e14mr8333960pgi.8.1547107712096;
        Thu, 10 Jan 2019 00:08:32 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:89d:654d:749c:afde:a8a6:224d])
        by smtp.gmail.com with ESMTPSA id w23sm27401007pgc.72.2019.01.10.00.08.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 00:08:31 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, a.tropschug@ebs-systart.com,
        m.bittner@ebs-systart.com, amit.kucheria@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/3] Add Oxalis board support
Date:   Thu, 10 Jan 2019 13:38:18 +0530
Message-Id: <20190110080821.30280-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset adds Oxalis board support. This board is one of the
96Boards Enterprise Edition platform from EBS-SYSTART GmbH. Below are some
of the key features of this board:

* SoC: NXP Layerscape LS1012A
* RAM: 1GB DDR3L
* PMU: NXP VR5100
* Storage: 64MByte SPI Flash for bootloader and RCW, MicroSD Card, SATA
* Connectivity: 2x Ethernet
* USB: 2x USB3.0

More information about this board can be found in 96Boards product
page: https://www.96boards.org/product/oxalis/

Ethernet and SPI flash are not supported yet!

Thanks,
Mani

Manivannan Sadhasivam (3):
  dt-bindings: vendor-prefixes: Add EBS-SYSTART GmbH Vendor Prefix
  dt-bindings: arm: fsl: Add devicetree binding for Oxalis
  arm64: dts: freescale: Add devicetree for Oxalis

 Documentation/devicetree/bindings/arm/fsl.txt |  4 +
 .../devicetree/bindings/vendor-prefixes.txt   |  1 +
 arch/arm64/boot/dts/freescale/Makefile        |  1 +
 .../boot/dts/freescale/fsl-ls1012a-oxalis.dts | 96 +++++++++++++++++++
 4 files changed, 102 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dts

-- 
2.17.1

