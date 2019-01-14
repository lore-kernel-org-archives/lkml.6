Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F061C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DEBC2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfANLmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:42:02 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:54626 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726339AbfANLmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 06:42:02 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EC7EDB293F9E3C74C028;
        Mon, 14 Jan 2019 19:41:59 +0800 (CST)
Received: from 138.huawei.com (10.175.124.28) by smtp.huawei.com (10.3.19.204)
 with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 14 Jan 2019 19:41:50
 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chao Yu <yuchao0@huawei.com>, <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 0/5] staging: erofs: document, bugfix and cleanups
Date:   Mon, 14 Jan 2019 19:40:21 +0800
Message-ID: <20190114114026.11728-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
This is the first EROFS patchset for this new round.

An initial document describing the details of EROFS is added in this
patchset and it was previewed in
https://lists.ozlabs.org/pipermail/linux-erofs/2019-January/001227.html

In addition, Li Guifu found an unexpected crash related to fast symlink
in our internal test, this patchset also addresses this issue:
https://lists.ozlabs.org/pipermail/linux-erofs/2019-January/001190.html

and the rest patches are all cleanups, nothing special.

Thanks,
Gao Xiang

Chao Yu (1):
  staging: erofs: clean up erofs_map_blocks_iter

Gao Xiang (4):
  staging: erofs: add document
  staging: erofs: fix fast symlink w/o xattr when fs xattr is on
  staging: erofs: remove unneeded inode_operations
  staging: erofs: move erofs_xattr_handlers to xattr.h

 .../erofs/Documentation/filesystems/erofs.txt      | 195 +++++++++++++++++++++
 drivers/staging/erofs/data.c                       |  31 +---
 drivers/staging/erofs/inode.c                      |  38 ++--
 drivers/staging/erofs/internal.h                   |  67 +++----
 drivers/staging/erofs/namei.c                      |   4 -
 drivers/staging/erofs/super.c                      |   1 +
 drivers/staging/erofs/unzip_vle.c                  |  30 ++--
 drivers/staging/erofs/xattr.c                      |  25 ++-
 drivers/staging/erofs/xattr.h                      |   4 +-
 9 files changed, 278 insertions(+), 117 deletions(-)
 create mode 100644 drivers/staging/erofs/Documentation/filesystems/erofs.txt

-- 
2.14.4

