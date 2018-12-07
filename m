Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94213C65BAF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6347D20673
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:05:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6347D20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbeLGQFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:05:12 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:58753 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726041AbeLGQFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 11:05:11 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 15F4B2562039B;
        Sat,  8 Dec 2018 00:05:07 +0800 (CST)
Received: from localhost.localdomain (10.175.124.28) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.408.0; Sat, 8 Dec 2018
 00:04:59 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 0/7] staging: erofs: decompression fixes & cleanups
Date:   Sat, 8 Dec 2018 00:19:11 +0800
Message-ID: <20181207161918.20747-1-gaoxiang25@huawei.com>
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

This patchset has been pending in the erofs mailing list for months.
It mainly focuses on cleaning up io submission flow in the decompression
subsystem in order to remove #ifdefs in related functions, which
were used to differentiate whether cached decompression is enabled
(rather than do in-place decompression only).

These patches has been tested by our Android beta users for these months,
no new issue reported.

Thanks,
Gao Xiang

Gao Xiang (7):
  staging: erofs: fix use-after-free of on-stack `z_erofs_vle_unzip_io'
  staging: erofs: introduce MNGD_MAPPING helper
  staging: erofs: localize UNALLOCATED_CACHED_PAGE placeholder
  staging: erofs: revisit the page submission flow
  staging: erofs: refine compressed pages preload flow
  staging: erofs: redefine where `owned_workgrp_t' points
  staging: erofs: simplify `z_erofs_vle_submit_all'

 drivers/staging/erofs/internal.h  |   6 +-
 drivers/staging/erofs/unzip_vle.c | 580 ++++++++++++++++++++++++--------------
 drivers/staging/erofs/unzip_vle.h |   4 +-
 3 files changed, 377 insertions(+), 213 deletions(-)

-- 
2.14.4

