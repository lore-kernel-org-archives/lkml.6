Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB86ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A0B420856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:10:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A0B420856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388183AbeGWPML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 11:12:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9667 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388099AbeGWPML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 11:12:11 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 65D09ED36F85D;
        Mon, 23 Jul 2018 22:10:35 +0800 (CST)
Received: from huawei.com (10.113.189.234) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.382.0; Mon, 23 Jul 2018
 22:10:28 +0800
From:   Yunlong Song <yunlong.song@huawei.com>
To:     <jaegeuk@kernel.org>, <chao@kernel.org>, <yuchao0@huawei.com>,
        <yunlong.song@icloud.com>, <yunlong.song@huawei.com>
CC:     <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/5] f2fs: fix and improve for victim_secmap
Date:   Mon, 23 Jul 2018 22:10:17 +0800
Message-ID: <1532355022-163029-1-git-send-email-yunlong.song@huawei.com>
X-Mailer: git-send-email 1.8.5.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.113.189.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some fixes and improvements for using with victim_secmap.

Yunlong Song (5):
  f2fs: clear victim_secmap when section has full valid blocks
  f2fs: add cur_victim_sec for BG_GC to avoid skipping BG_GC victim
  f2fs: clear_bit the SSR selected section in the victim_secmap
  f2fs: let BG_GC check every dirty segments and gc over a threshold
  f2fs: add proc entry to show victim_secmap bitmap

 fs/f2fs/f2fs.h              |  5 ++++-
 fs/f2fs/gc.c                | 39 ++++++++++++++++++++++++++++++---------
 fs/f2fs/segment.c           |  4 +++-
 fs/f2fs/segment.h           | 12 +++++++++++-
 fs/f2fs/super.c             |  3 ++-
 fs/f2fs/sysfs.c             | 25 +++++++++++++++++++++++++
 include/trace/events/f2fs.h | 18 ++++++++++++------
 7 files changed, 87 insertions(+), 19 deletions(-)

-- 
1.8.5.2

