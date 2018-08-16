Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9B9C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68E12064A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:49:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D68E12064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbeHPTss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:48:48 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55682 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727317AbeHPTsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:48:46 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5CDDBCD245175;
        Fri, 17 Aug 2018 00:49:05 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.399.0; Fri, 17 Aug 2018 00:49:08 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <dsterba@suse.com>
CC:     <jbacik@fb.com>, <clm@fb.com>, <linux-btrfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCHv4 0/3] btrfs: remove unneeded variable and if possbile 
Date:   Fri, 17 Aug 2018 00:37:12 +0800
Message-ID: <1534437435-51605-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3->v4:
 -  btrfs_destroy_delayed_refs return value would be actually needed.
    so just remove the unneeded variable "ret" and modify the subject

v2->v3:
 - repost the patches with detailed commit message.

v1->v2:
 - Fix v1 issue that forget to return after remove the variable "ret".

zhong jiang (3):
  btrfs: remove unneeded variable "ret" in btrfs_destroy_delayed_refs
  btrfs: change btrfs_free_reserved_bytes to be void funtion
  btrfs: change btrfs_pin_log_trans to be void function

 fs/btrfs/disk-io.c     | 5 ++---
 fs/btrfs/extent-tree.c | 6 ++----
 fs/btrfs/tree-log.c    | 5 +----
 fs/btrfs/tree-log.h    | 2 +-
 4 files changed, 6 insertions(+), 12 deletions(-)

-- 
1.7.12.4

