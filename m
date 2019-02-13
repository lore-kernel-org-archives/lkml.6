Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63742C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FCEB222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FeLX+3d5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389172AbfBMMeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:34:10 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42530 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732510AbfBMMeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:34:08 -0500
Received: by mail-pg1-f195.google.com with SMTP id d72so1065629pga.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 04:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=GudpVIkvtynchlucvfiMRd0jQS8JTQZc8GCI+FuWiNA=;
        b=FeLX+3d5+9TtNzVNG164w/vkUdZh721ypHcIVt8WuYYyy/PwzzL/4xY5SosB8o6Lu6
         DZLGN8znPK5ORUM0oTgAk7yDP9wIIIhlFM1wXT5UZPAi1D/FiS3aCBxJKCKWVB2DzcHs
         +7XtfPXLAgYqcC8J3eRPTooxSoiw+nrQLW73gqL3eTn7Bnu0J8en5CIQnb6NQQQ1ieq7
         qWV6LTKT3hgrwFPm06Dl0DKwx0ND/iMJto6ESrS7xCmV1Nkw/JwrOejtOnuZOGDZe2VI
         papjLGL0mA6O2QumPtIf/JpO1TTxj9JzaUv/NTxvLe7sRUz0zn5CeA0kax3T2KNhOP8M
         nvyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GudpVIkvtynchlucvfiMRd0jQS8JTQZc8GCI+FuWiNA=;
        b=UDn9iWhe9bMPtv9EwqbrTy9H4o8rCUf3mqpsEVXl7HvMw19ViuX5XoPDO9+zVJKjB5
         DAsbBr6izPpKIkYbxSnITlcEaFL370mx3ZwlMtT3nyXk23qZCaMk6oFB6kLwljMD5yu9
         3TTdfOMmvIGMMryzlGn4gEt/nI9m6UzxiRfbQqqaXNLMk4JXly/vaqljw+oD20PzmFBl
         pdl+f9yrruc6MfZZ5y6E54cj0m/pXqxd6OOULrMuEUsRK8NJpVILzR4Mw9IyMLAe548X
         gw3DvxruPJCzjVJkPuQw+bu7MAYkzm5s2D3HiaG5B6lOxrqvSRi1HqDLOr8YPq67xBmq
         uTxg==
X-Gm-Message-State: AHQUAua/PZVD31RkNdLgcoULgK+TsYfChB2GOgtrFGmVCNcqGbhj5fjK
        9/kHxvUWQfgSYtmcaPnM/Lqheg==
X-Google-Smtp-Source: AHgI3IY+ZRhCuxwGFT5B36GF2b3HGA/L9uYM6oFAL9kUrp5JdBpPCYm/6giqzMr5QEMMLh0ad/htXA==
X-Received: by 2002:a62:e716:: with SMTP id s22mr282681pfh.35.1550061247605;
        Wed, 13 Feb 2019 04:34:07 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id l5sm21223640pgl.51.2019.02.13.04.34.03
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Feb 2019 04:34:06 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de
Cc:     olof@lixom.net, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        devicetree@vger.kernel.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, baolin.wang@linaro.org
Subject: [PATCH v2 0/5] Add new device nodes for Spreadtrum SC9860 platform
Date:   Wed, 13 Feb 2019 20:32:44 +0800
Message-Id: <cover.1550060543.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds charger and fuel gauge device nodes for Spreadtrum
SC2731 PMIC, it also removes redundant irq trigger setting for PMIC
devices and adds nvmem cells for ADC to calibrate the ADC channel scales.

Moreover we also remove the wildcard compatible string.

Changes from v1:
 - Remove wildcard compatible string.

Baolin Wang (5):
  arm64: dts: sprd: Remove PMIC INTC irq trigger type
  arm64: dts: sprd: Add ADC calibration support
  arm64: dts: sprd: Add SC2731 charger device
  arm64: dts: sprd: Add SC27XX fuel gauge device
  arm64: dts: sprd: Remove wildcard compatible string

 arch/arm64/boot/dts/sprd/sc2731.dtsi      |   56 +++++++++++++++++++++++------
 arch/arm64/boot/dts/sprd/sp9860g-1h10.dts |   16 +++++++++
 2 files changed, 61 insertions(+), 11 deletions(-)

-- 
1.7.9.5

