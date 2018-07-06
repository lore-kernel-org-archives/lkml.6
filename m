Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C7BC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 03:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ECA824067
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 03:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KixOeZI8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ECA824067
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932199AbeGFDz4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 23:55:56 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33764 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753974AbeGFDzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 23:55:54 -0400
Received: by mail-pf0-f193.google.com with SMTP id b17-v6so7217496pfi.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 20:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=bGIHAOxQHzpz/tHAtKYndHInAQlfC+pEEUtDUhXyLaA=;
        b=KixOeZI8bvEiHHbmBlUnQ8LVxjuO5BdkDAEfRjFM7Z4yfReVRWkhB6hqxL7eAZ4rto
         KAtnq9fjQrDdP8/+XQy6GI2zZ7IVkp1qvDdBWDKJNyGO+oTIYK66wMBKQe8PoKjSF67b
         iBp7iDMuee1COLkhE4XA5CQfHEO+8HpiV441k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bGIHAOxQHzpz/tHAtKYndHInAQlfC+pEEUtDUhXyLaA=;
        b=geKNNKAsOcd41FiDPOaXiC3NFDUc5tsYqi6wI1onRnwvTBFD7jXNdcASnmZ7QUM0pa
         FyR8mK2g/y2AZMU7xC3pXRb6fMmM+Y5t/1swoC/t3x5gsFYsyyWnD+eO44j580QNfKLg
         Y6DnLSmtYfiRkZuGuyoAiq6mH1DWZKLnKTzjpbqOsdfkb4z5u7QX1A8ieYOAQOtnnb1o
         DZ4P+anV3NHDa8tvvWGo80Qg2fy+R9N+WWro8BjdvRuQ/Z+jLi0bdnfnHRQYeCuv2Cal
         wVhgA9cBTHgS+WXFNdp6HVDm9JWd916UEMgKlvr6zPkSDE9o7Nii05U4IqEA+lBzU4Yt
         S9qw==
X-Gm-Message-State: APt69E04KlWNQy9rUWsy09/3/pLhX7luQNpY0c2Gw2Mp47zGwCdxBuLB
        KNlgXiGR+WnE8PXmeYiQ01XZ/Q==
X-Google-Smtp-Source: AAOMgpdKwjhkIztJFn8qgn1n45KV8AeJGIz3W+cVe2IzV234SVp0f7HUz7gSqReSpAZ1OwgyTvjpaw==
X-Received: by 2002:a65:5286:: with SMTP id y6-v6mr7952585pgp.65.1530849353874;
        Thu, 05 Jul 2018 20:55:53 -0700 (PDT)
Received: from localhost.localdomain ([64.64.108.33])
        by smtp.gmail.com with ESMTPSA id y14-v6sm12568403pgo.22.2018.07.05.20.55.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 20:55:52 -0700 (PDT)
From:   Guodong Xu <guodong.xu@linaro.org>
To:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        dan.j.williams@intel.com, xuwei5@hisilicon.com,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     liyu65@hisilicon.com, suzhuangluan@hisilicon.com,
        xuhongtao8@hisilicon.com, zhongkaihua@huawei.com,
        xuezhiliang@hisilicon.com, xupeng7@huawei.com,
        sunliang10@huawei.com, fengbaopeng@hisilicon.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Guodong Xu <guodong.xu@linaro.org>
Subject: [PATCH v2 0/4] k3dma: add support to reserved channels
Date:   Fri,  6 Jul 2018 11:55:17 +0800
Message-Id: <20180706035521.13736-1-guodong.xu@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes bug people found on hikey960 when allocating DMA
channels to peripherals such as SPI. It fails because the channel is
reserved and not accessible by kernel.

Patch 1, 2 and 3 add support to reserved channels for K3 DMA. Patch 4
includes a removal of axi_config who controls DMA secure/non-secure
access permission but is actually set in early stage by bootloader.

Guodong Xu (1):
  arm64: dts: hi3660: update property name hisilicon,dma-min-chan

Li Yu (3):
  dt-bindings: k3dma: add optional property hisilicon,dma-min-chan
  k3dma: add support to reserved minimum channels
  k3dma: delete axi_config

 Documentation/devicetree/bindings/dma/k3dma.txt |  6 ++++++
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi       |  2 +-
 drivers/dma/k3dma.c                             | 16 ++++++++--------
 3 files changed, 15 insertions(+), 9 deletions(-)

-- 
2.17.1

