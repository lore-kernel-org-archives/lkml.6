Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C2FECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FF92146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:26:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1FF92146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbeIRT64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:58:56 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56542 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730065AbeIRT6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:58:55 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4C12DCD8B00EA;
        Tue, 18 Sep 2018 22:26:01 +0800 (CST)
Received: from szvp000100637.huawei.com (10.162.55.131) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.399.0; Tue, 18 Sep
 2018 22:25:52 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v2 0/8] staging: erofs: error handing and more tracepoints
Date:   Tue, 18 Sep 2018 22:25:32 +0800
Message-ID: <1537280740-122019-1-git-send-email-gaoxiang25@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.162.55.131]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

change log v2:
  - fix a gcc warning reported by Greg for the patch
        staging: erofs: clean up z_erofs_map_blocks_iter


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
 drivers/staging/erofs/unzip_vle.c                  | 196 +++++++++++++--------
 4 files changed, 163 insertions(+), 89 deletions(-)

-- 
1.9.1

