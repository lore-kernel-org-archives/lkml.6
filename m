Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8617DC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4016C20671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ijTqL5ne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4016C20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbeGSLhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:37:41 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42521 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbeGSLhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:37:41 -0400
Received: by mail-pf0-f195.google.com with SMTP id l9-v6so3739167pff.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 03:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Ad37GBksqsdtVnfpTJiJkH5MBS1wUULi10lJki/yU3M=;
        b=ijTqL5neVlOvlBeq/X8mS7jNjxpjlxMQKkaEYtYRHSNmKv/EdABIJA4c6bkwIV9ELR
         sWRLfmAD1LAKn0U7r0/ojFXzvKRLhmKKdIvtsLfS1V77AtSHktWJ4PqYmrYRwliKPkUJ
         fgAVAZDCZjmi53ecfGFOuOzALLT+dE+wwCHaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ad37GBksqsdtVnfpTJiJkH5MBS1wUULi10lJki/yU3M=;
        b=PGZIIvyMCwxSmMz1v8UEeNQ9nj0h0n8xp/c5BQCl84qbXKVMCA+5xpYaEB1wZ3YHQh
         4LptaOdMN0LEqF9iWCVuQYxRk8LbVtNLchv5yXmiBMVem5E9w7xliXujT1PScSVnGV+b
         q30ibfdyruX8UAfISSyFrztc8TQfNga/II+kh+xL/ssefuBLToxFg5cTsGXEnTeCH+VF
         Bs+W+IVwCAKICmcZZ5u8AXQLYPbIaPUGiOqgubmc7OPTazKcGOwMITc0h3YWQkHA8Ns4
         gGgt+0X3FXp8fwATDw1JuYXQF0uC4UoNuyDawNJ9Mxpzsq/dB4CiGubAoVXU2man5ljK
         IgLQ==
X-Gm-Message-State: AOUpUlHlJlYHBHRwKRFhp3PEdh+rBMNfhG2JinYNn9pt+QAaz5Uggfvs
        2pB+7mRaM1r+dCHqLx0F/bT9
X-Google-Smtp-Source: AAOMgpcMeomxl+knRX9w1inniCTs3PtWfD3inIz3o6YhGhROxlw9ilvF87hzJh819Z4gIMJGBco7JQ==
X-Received: by 2002:a62:1b07:: with SMTP id b7-v6mr9116513pfb.70.1531997705308;
        Thu, 19 Jul 2018 03:55:05 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id 85-v6sm3653262pgd.81.2018.07.19.03.55.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jul 2018 03:55:04 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, taiten.peng@linaro.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        manivannanece23@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 0/2] Add Mediatek X20 Development Board support
Date:   Thu, 19 Jul 2018 16:24:48 +0530
Message-Id: <1531997690-6040-1-git-send-email-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree support for Mediatek X20 Development Board by Archermind.
This board is based on the Deca-Core MT6797 SoC from Mediatek and is
one of the 96Boards Consumer Edition platform.

With this devicetree change, board can boot into initramfs.

More information about this board can be found in 96Boards product page:
https://www.96boards.org/product/mediatek-x20/

Thanks,
Mani

Changes in v3:

* Modified the memory size to 2GB (0x80000000) in board DTS

Changes in v2:

* Added documentation for board compatible
* Dropped vendor documetation patch since it got applied

Manivannan Sadhasivam (2):
  dt-bindings: arm: mediatek: Document Mediatek X20 Development Board
  arm64: dts: Add Mediatek X20 Development Board support

 Documentation/devicetree/bindings/arm/mediatek.txt |  3 ++
 arch/arm64/boot/dts/mediatek/Makefile              |  1 +
 arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts    | 33 ++++++++++++++++++++++
 3 files changed, 37 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts

-- 
2.7.4

