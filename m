Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D90C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D087218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bgKLtKIu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbfAXUYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:24:30 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39858 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbfAXUY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:24:29 -0500
Received: by mail-pf1-f194.google.com with SMTP id r136so3565906pfc.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 12:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=bp8b67pG2vTJ7yWzC/S5wh8lIvcx0mZj/HjgKpZRDlc=;
        b=bgKLtKIufJMwtHBgfGMqC+7n6MJbRWrqDhVyWcgTLdVlF3WxSryGjvn4NFTKtMxnul
         eISMksc55KItcYirUqh9zmt3q1zdsoWrjRSJI3d9JPvgTHVMFxU4jAslj5SOImQOq8UY
         RMT8wZeWsgM2jT9P/HZ3zwnrHEu9QZq8RLAOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bp8b67pG2vTJ7yWzC/S5wh8lIvcx0mZj/HjgKpZRDlc=;
        b=uCwGOe5RZ6oW0mA+7+YorEROI+wN7BiwQfkYxQLsklX4W4oN15CUS2uAgGU7Eq2uty
         gMHsr5Mc8hwa/LqHSpic2KgfSfYhfzLvpeoKJwcQZ2rkOEDWtKF9286/wIA+6NdB1RNP
         V/Jt2Fh4dpqVaqSnGAfF9Sg9lxIjRUpd57QHPdEwMOn/UEU9FewMDOE0uxWV1a4DdQbJ
         ICalpn0vU1bEy5olXMcNSc187+WNhB9TowKfcXgY6wLo08WHWnABu5VDH7JBF363T1eD
         OPk//yMkpPvkuwGo+dcWGUrmgRrnxAIvqpOpQxKP8BY2wSJFeJEeIs0sBVI/CR/oyciL
         yu8w==
X-Gm-Message-State: AJcUuke44qTAPv/y9w9/odbQLDiqNj6z3qdoo67F407r0zAbzLPWMZD4
        3J2gWvpzwvIkOesiU9O1O9E135tHqX1t0A==
X-Google-Smtp-Source: ALg8bN4dXRv1fmtfHH9kDqCWAAdrhTfrb2iLdGric4sRzwtXAUuaN++SnL9PbVNOik8ST2bSLXtLug==
X-Received: by 2002:a63:c848:: with SMTP id l8mr7214918pgi.78.1548361467519;
        Thu, 24 Jan 2019 12:24:27 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id c72sm45263309pfb.107.2019.01.24.12.24.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Jan 2019 12:24:26 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Wei Xu <xuwei5@hisilicon.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Guodong Xu <guodong.xu@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Ryan Grachek <ryan@edited.us>, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/8 v5] k3dma patches to add support for hi3660/HiKey960
Date:   Thu, 24 Jan 2019 12:24:15 -0800
Message-Id: <1548361463-28372-1-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is based on recent work by Tanglei Han, and
adds support for hi3660 SoCs as found on the HiKey960 board,
along with a few patches I've been carrying.

thanks
-john

New in v5:
* Minor typo fixes, minor rework to use BIT() macros 

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
  Documentation: bindings: dma: Add binding for dma-channel-mask
  arm64: dts: hi3660: Add dma to uart nodes
  arm64: dts: hi3660: Fixup unofficial dma-min-chan to dma-channel-mask

Li Yu (2):
  dma: k3dma: Delete axi_config
  dma: k3dma: Add support for dma-channel-mask

Youlin Wang (3):
  Documentation: bindings: k3dma: Extend the k3dma driver binding to
    support hisi-asp
  dma: k3dma: Upgrade k3dma driver to support hisi_asp_dma hardware
  arm64: dts: hi3660: Add hisi asp dma device

 Documentation/devicetree/bindings/dma/dma.txt   |  4 ++
 Documentation/devicetree/bindings/dma/k3dma.txt |  4 +-
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi       | 20 +++++++-
 drivers/dma/k3dma.c                             | 61 +++++++++++++++++++++----
 4 files changed, 78 insertions(+), 11 deletions(-)

-- 
2.7.4

