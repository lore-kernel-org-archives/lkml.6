Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB29AC4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 08:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6942F20844
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 08:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6942F20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbeIHNdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 09:33:36 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50474 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726171AbeIHNdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 09:33:35 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 00E76101A951C;
        Sat,  8 Sep 2018 16:48:34 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.399.0; Sat, 8 Sep 2018 16:48:30 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <tiwai@suse.com>, <perex@perex.cz>, <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <bgoswami@codeaurora.org>,
        <plai@codeaurora.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] sound: Use kmemdup to replace kzalloc + memcpy
Date:   Sat, 8 Sep 2018 16:36:18 +0800
Message-ID: <1536395780-18725-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I find the issue with the help of Coccinelle.

zhong jiang (2):
  sound: q6core: Use kmemdup to replace kzalloc + memcpy
  sound: skl-topology: Use kmemdup to replace kzalloc + memcpy

 sound/soc/intel/skylake/skl-topology.c | 3 +--
 sound/soc/qcom/qdsp6/q6core.c          | 8 ++------
 2 files changed, 3 insertions(+), 8 deletions(-)

-- 
1.7.12.4

