Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B569DECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755D52146E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755D52146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbeINT4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:56:00 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11713 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728186AbeINTzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:55:42 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E347F8CE1416D;
        Fri, 14 Sep 2018 22:40:42 +0800 (CST)
Received: from szvp000100637.huawei.com (10.162.55.131) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.399.0; Fri, 14 Sep
 2018 22:40:38 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 0/8] staging: erofs: error handing and more tracepoints
Date:   Fri, 14 Sep 2018 22:40:22 +0800
Message-ID: <1536936030-62362-1-git-send-email-gaoxiang25@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.162.55.131]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to avoid conflicts with cleanup patches, Chao and I think
it is better to send reviewed preview patches in the erofs mailing list
to the community in time.

So here is reviewed & tested patches right now, which clean up and
enhance the error handing and add some tracepoints for decompression.

Note that in this patchset, bare use of 'unsigned' and NULL comparison are
also fixed compared with the preview patches according to the previous
discussion in the staging mailing list.

Thanks,
Gao Xiang

Chen Gong (2):
  staging: erofs: add trace points for reading zipped data
  staging: erofs: replace BUG_ON with DBG_BUGON in data.c

Gao Xiang (6):
  staging: erofs: fix a missing endian conversion
  staging: erofs: clean up z_erofs_map_blocks_iter
  staging: erofs: complete error handing of z_erofs_map_blocks_iter
  staging: erofs: fix a bug when appling cache strategy
  staging: erofs: complete error handing of z_erofs_do_read_page
  staging: erofs: avoid magic constants when initializing clusterbits

 drivers/staging/erofs/data.c                       |  31 ++--
 drivers/staging/erofs/include/trace/events/erofs.h |  20 ++-
 drivers/staging/erofs/super.c                      |   5 +-
 drivers/staging/erofs/unzip_vle.c                  | 195 +++++++++++++--------
 4 files changed, 162 insertions(+), 89 deletions(-)

-- 
1.9.1

