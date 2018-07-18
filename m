Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EE8ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F2E2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cOjR1Lve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5F2E2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbeGRUsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 16:48:16 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35860 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729776AbeGRUsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 16:48:16 -0400
Received: by mail-pl0-f68.google.com with SMTP id e11-v6so2517695plb.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 13:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=wIr4kNwoFEqSdaZpIdHL68f83dzsEGLYfaM+xhxAnLM=;
        b=cOjR1Lve5uMr1pui3luHzDatDM6q21SWmV79THswBwr0wP+wir60+JJ7pOL+pgJBPm
         Hcqu1HQpEufPKDNMVG3eIjUEjSDKY6uZmrpwwUG2rhuYgEPpiWqqAbagV3RYdHQ+qGic
         Ks0qvE1HRvhRpP8zPYnwKrHEPe2h1ezR2nyN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wIr4kNwoFEqSdaZpIdHL68f83dzsEGLYfaM+xhxAnLM=;
        b=pMyH/06iS7JlB3ZrkWenfi6/QBFrPy5v+hIvJLzitqo9ei70PloUaKaCDxGXvkHX6E
         puJT8cPdAX5u9Ewmhr7qn7p495PrCFG5DKsFvWAD1oiKI/H7uVX4Ba4nHnKL0y0cfDT2
         IlevgeR2ycdSTNc13ZsK75wJ1owyompLXPOwa7hizLRjbZsL8koPPHHYAQzsOJX9zXX1
         5hgOJSv0WgignAn+pS+7zJMC7vOKXjAOgUysjfFv5SCoUIz1T7JlP4AFmx62gXAEVvFB
         fIIl6YBU5cdVICnt+q63hZIRL5VU2SPakEc5SR051TOR6UTkU6LK0AgDRus6nOFawyaj
         axwQ==
X-Gm-Message-State: AOUpUlGOVE/zPoTjFSwX2ham/f7Z8Z16BbWUArg1z6QtUYMxclOAKGWK
        DKNTd3eIq0g98xvwO8aoRrtq
X-Google-Smtp-Source: AAOMgpcb6QLqpdWgV7WT6PzDbXrn7Ho1Ipzp4C7CPg6g1sl4p6aKnBrNLsX8eTFJo3CDSi1PVXhuJQ==
X-Received: by 2002:a17:902:74c2:: with SMTP id f2-v6mr7156345plt.260.1531944527157;
        Wed, 18 Jul 2018 13:08:47 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:628d:5c0b:b467:58cc:4c91:39b3])
        by smtp.gmail.com with ESMTPSA id c7-v6sm6924697pfh.25.2018.07.18.13.08.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 13:08:46 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vkoul@kernel.org, dan.j.williams@intel.com, afaerber@suse.de,
        robh+dt@kernel.org
Cc:     dmaengine@vger.kernel.org, liuwei@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com, pn@denx.de, edgar.righi@lsitec.org.br,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/4] Add Actions Semi Owl family S900 DMA Controller support
Date:   Thu, 19 Jul 2018 01:37:05 +0530
Message-Id: <20180718200709.27102-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds DMA controller support for Actions Semi Owl family
S900 SoC. This driver has been structured in a way such that there will be only
one controller driver for the whole Owl family series (S500, S700 and
S900 SoCs).

There are 12 physical channels and 46 logical channels supported by the
DMA controller.

The DMA controller also supports 4 software configurable interrupt lines for
the priority based DMA usecase. But the DMA driver supports only 1 interrupt
for simplification. By default, the driver uses Linked list mode for all
transfers. Right now only MEMCPY support has been added and the rest
(SLAVE, CYCLIC) will be added in upcoming patches.

The driver has been tested using dmatest utility on the Bubblegum-96
board.

The DTS patches in this series depends on the pinctrl DTS patches
submitted [1], which is yet to be merged by the platform maintainer
Andreas. Since the DMA driver goes through DMA tree and the relevant
DTS patches goes through ARM-SoC tree, Andreas will pick it up once
it has been reviewed.

For the reference, I have queued up all reviewed dts patches so far
in my repo [2] from which Andreas is picking them for 4.19.

Thanks,
Mani

[1] https://patchwork.kernel.org/patch/10322937/
[2] https://git.linaro.org/people/manivannan.sadhasivam/linux.git/log/?h=s900-for-next

Manivannan Sadhasivam (4):
  dt-bindings: dma: Add binding for Actions Semi Owl SoCs
  arm64: dts: actions: Add Actions Semi S900 DMA Controller
  dma: Add Actions Semi Owl family S900 DMA driver
  MAINTAINERS: Add entry for Actions Semi Owl SoCs DMA driver

 .../devicetree/bindings/dma/owl-dma.txt       |   46 +
 MAINTAINERS                                   |    2 +
 arch/arm64/boot/dts/actions/s900.dtsi         |   13 +
 drivers/dma/Kconfig                           |    8 +
 drivers/dma/Makefile                          |    1 +
 drivers/dma/owl-dma.c                         | 1021 +++++++++++++++++
 6 files changed, 1091 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/owl-dma.txt
 create mode 100644 drivers/dma/owl-dma.c

-- 
2.17.1

