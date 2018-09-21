Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F046C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D242C20673
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D242C20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390869AbeIUXSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:18:04 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46773 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389545AbeIUXSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 19:18:04 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 73A0B130405E8;
        Sat, 22 Sep 2018 01:28:09 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.399.0; Sat, 22 Sep 2018 01:28:03 +0800
From:   John Garry <john.garry@huawei.com>
To:     <z.liuxinliang@hisilicon.com>, <kong.kongxinwei@hisilicon.com>,
        <puck.chen@hisilicon.com>, <airlied@linux.ie>
CC:     <linuxarm@huawei.com>, <chris@chris-wilson.co.uk>,
        <dri-devel@lists.freedesktop.org>, <baowenyi@huawei.com>,
        <linux-kernel@vger.kernel.org>, <zourongrong@gmail.com>,
        <daniel.vetter@ffwll.ch>, John Garry <john.garry@huawei.com>
Subject: [PATCH 0/3] HiBMC driver fixes
Date:   Sat, 22 Sep 2018 01:25:24 +0800
Message-ID: <1537550727-21257-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes a couple of issues in probing the HiBMC driver, as
follows:
- fix the probe error path to not carry an error code in the pointer
- don't use invalid legacy fb bpp/depth combination

Another more trivial patch is for using the standard Huawei PCI vendor ID
instead of hard-coding it.

Tested on Huawei D05 board. I can see tux on BMC VGA console.

John Garry (3):
  drm/hisilicon: hibmc: Do not carry error code in HiBMC framebuffer
    pointer
  drm/hisilicon: hibmc: Don't overwrite fb helper surface depth
  drm/hisilicon: hibmc: Use HUAWEI PCI vendor ID macro

 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   | 2 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
1.9.1

