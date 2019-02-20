Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFC7C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9820E21773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfBTKRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:17:31 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4238 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726760AbfBTKR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 05:17:27 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4EC6875236298C4075B6;
        Wed, 20 Feb 2019 18:17:25 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Wed, 20 Feb 2019
 18:17:15 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     <linux-mtd@lists.infradead.org>
CC:     David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        <linux-kernel@vger.kernel.org>, <houtao1@huawei.com>
Subject: [PATCH 0/2] jffs2: fixes for file creation failed halfway
Date:   Wed, 20 Feb 2019 18:21:31 +0800
Message-ID: <20190220102133.7878-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There are the fixes for file creation which failed halfway, the first
one is used to reclaim flash spaces had been used by the inode, and
the second one fixes a BUG assertion in jffs2_do_read_inode().

These two problems can be reproduced by concurrently creating files
until no space is left, and then removing these files, and repeating.

Comments are welcome.

Hou

Hou Tao (2):
  jffs2: reset pino_nlink to 0 when inode creation failed
  jffs2: handle INO_STATE_CLEARING in jffs2_do_read_inode()

 fs/jffs2/dir.c       | 28 ++++++++++++++++++++++++----
 fs/jffs2/readinode.c |  1 +
 2 files changed, 25 insertions(+), 4 deletions(-)

-- 
2.16.2.dirty

