Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258EDC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF87214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:10:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEF87214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732618AbeGLPUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 11:20:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9177 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732319AbeGLPUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 11:20:01 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9FE783073F838;
        Thu, 12 Jul 2018 23:09:44 +0800 (CST)
Received: from huawei.com (10.113.189.234) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.382.0; Thu, 12 Jul 2018
 23:09:38 +0800
From:   Yunlong Song <yunlong.song@huawei.com>
To:     <jaegeuk@kernel.org>, <chao@kernel.org>, <yuchao0@huawei.com>,
        <yunlong.song@icloud.com>, <yunlong.song@huawei.com>
CC:     <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/5] f2fs: fix some bugs in lfs mode with large section
Date:   Thu, 12 Jul 2018 23:09:25 +0800
Message-ID: <1531408170-45758-1-git-send-email-yunlong.song@huawei.com>
X-Mailer: git-send-email 1.8.5.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.113.189.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

f2fs has some bugs in section:segment > 1 and lfs mode, so fix them.

Yunlong Song (5):
  f2fs: do not set free of current section
  f2fs: clear the remaining prefree_map of the section
  f2fs: blk_finish_plug of submit_bio in lfs mode
  f2fs: disable small discard in lfs mode
  f2fs: do not __punch_discard_cmd in lfs mode

 fs/f2fs/data.c    |  2 +-
 fs/f2fs/segment.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++++------
 fs/f2fs/segment.h | 10 +++++-
 fs/f2fs/sysfs.c   |  4 +++
 4 files changed, 102 insertions(+), 12 deletions(-)

-- 
1.8.5.2

