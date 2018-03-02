Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428943AbeCBO6b (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 09:58:31 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45247 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1426505AbeCBO62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 09:58:28 -0500
X-Google-Smtp-Source: AG47ELucTHKqBZjSa5FoCGbRH8ZfAcm2NPQd4TF+M+C9gENJeMRsT75fv2Lk52mUJ3IM5g93O89R3A==
From: srinivas.kandagatla@linaro.org
To: will.deacon@arm.com, robin.murphy@arm.com, bjorn.andersson@linaro.org
Cc: joro@8bytes.org, ohad@wizery.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/3] drivers: rpmsg: make rpmsg bus DMA capable
Date: Fri,  2 Mar 2018 14:55:28 +0000
Message-Id: <20180302145531.20463-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

On Qualcomm SoCs, DSP exposes many functionalities like audio,
as these drivers are child of rpmsg bus. Any dma allocations
or iommu operations on these devices would fail as the rpmsg
bus is not marked as dma capable bus.

This patchset makes the rpmsg bus dma capable.

This patchset is tested on DB410c and DB820c boards.

Thanks,
srini

Srinivas Kandagatla (3):
  rpmsg: core: export rpmsg bus type
  rpmsg: core: make rpmsg bus DMA capable
  iommu: armsmmu: set iommu ops for rpmsg bus

 drivers/iommu/arm-smmu.c   | 5 +++++
 drivers/rpmsg/rpmsg_core.c | 4 +++-
 include/linux/rpmsg.h      | 2 +-
 3 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.15.1
