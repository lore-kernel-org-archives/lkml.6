Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1E0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF05C214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S+snrzqV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730450AbfAJReR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:34:17 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41025 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729850AbfAJReQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:34:16 -0500
Received: by mail-pl1-f195.google.com with SMTP id u6so5470776plm.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=UMvSdiE9NQb8Gth/j6Scv5auomzdDy6K1LUx8wBPip4=;
        b=S+snrzqVx87Vv8vO3Vd4/93M99EhiAo+3zcwPBjfg+caaG83DhaALpoDIZcM5NbcNb
         V8hTusXjeWHskqvlbM51H4HUSXZsuoehPol+HkoMQcFe0BDjoJT6Q224yzQfhkI9j85C
         LlCoo1gci/dGQ+bVrLzIbaSgViF6Oq8ouSQHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UMvSdiE9NQb8Gth/j6Scv5auomzdDy6K1LUx8wBPip4=;
        b=B1p42vRYETGD0AWiRrCQLe7TKmlQH0t6OvgJvl1ZeDRZXPA1ii7DgYIBHVzBRSzKTW
         kFScLzZqzF3QySrzT0Ti0D92wBf2k5sF63x6ItYZ+eOtzXScNQvOhtdQqblg//ZwIQ/K
         EvO6PGmjzulDw9KtetUqUna6ITtDhNlTq6VO3iEd2hCTZxI+MGAqh0C04QxomlH/ZA45
         WpZ7Oj8A2J4kIRvTXOHVO/2dQRuiW9fY+RgJHgKO8N1Ll/ZTUWzPYjTwUbxBYIIrZ19d
         BxLHfbmLHUrr/6a+8P9nTofOWdN81dFio4tbrbyBvTAjrU3kZz7QyaISPXLYTxwZsADe
         aqrA==
X-Gm-Message-State: AJcUukccPaYEhJ01Hgndo4fGRefdnHdC4cdcXKoOQVCB2SyPbsT0Ee/I
        9cbWNAG9fVASNxvx8qm+osGtUEwDNqoLXg==
X-Google-Smtp-Source: ALg8bN5XWk2o54dWlRyD9TPXSEYKYh3HdyebYLKoOtSdvrA0c9KEPzTfpNiFMCAEsTt+WysR55zxDQ==
X-Received: by 2002:a17:902:780a:: with SMTP id p10mr11498934pll.54.1547141655294;
        Thu, 10 Jan 2019 09:34:15 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id k15sm125977409pfb.147.2019.01.10.09.34.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Jan 2019 09:34:14 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Wei Xu <xuwei5@hisilicon.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Guodong Xu <guodong.xu@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Ryan Grachek <ryan@edited.us>, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/8 v3] k3dma patches to add support for hi3660/HiKey960
Date:   Thu, 10 Jan 2019 09:34:04 -0800
Message-Id: <1547141652-8660-1-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is based on recent work by Tanglei Han, and
adds support for hi3660 SoCs as found on the HiKey960 board,
along with a few patches I've been carrying.

Review and feedback would be greatly appreciated!

thanks
-john

Cc: Tanglei Han <hantanglei@huawei.com>
Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Guodong Xu <guodong.xu@linaro.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Ryan Grachek <ryan@edited.us>
CC: devicetree@vger.kernel.org
Cc: dmaengine@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

John Stultz (3):
  Documentation: bindings: k3dma: Add binding for hisi-dma-avail-chan
  arm64: dts: hi3660: Add dma to uart nodes
  arm64: dts: hi3660: Fixup unofficial dma-min-chan to
    hisi-dma-avail-chan

Li Yu (2):
  dma: k3dma: Delete axi_config
  dma: k3dma: Add support for hisi-dma-avail-chan

Youlin Wang (3):
  Documentation: bindings: k3dma: Extend the k3dma driver binding to
    support hisi-asp
  dma: k3dma: Upgrade k3dma driver to support hisi_asp_dma hardware
  arm64: dts: hi3660: Add hisi asp dma device

 Documentation/devicetree/bindings/dma/k3dma.txt |  7 ++-
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi       | 20 ++++++++-
 drivers/dma/k3dma.c                             | 60 +++++++++++++++++++++----
 3 files changed, 76 insertions(+), 11 deletions(-)

-- 
2.7.4

