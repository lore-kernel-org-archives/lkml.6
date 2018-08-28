Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B10C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 03:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C132087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 03:40:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08C132087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbeH1H34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 03:29:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11202 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725832AbeH1H34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 03:29:56 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BE64313B82B;
        Tue, 28 Aug 2018 11:40:17 +0800 (CST)
Received: from szvp000100637.huawei.com (10.162.55.131) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.399.0; Tue, 28 Aug
 2018 11:40:08 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        <weidu.du@huawei.com>, Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH] Revert "staging: erofs: disable compiling temporarile"
Date:   Tue, 28 Aug 2018 11:39:48 +0800
Message-ID: <1535427588-69630-1-git-send-email-gaoxiang25@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.162.55.131]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 156c3df8d4db4e693c062978186f44079413d74d.

Since XArray and the new mount apis aren't merged in 4.19-rc1
merge window, the BROKEN mark can be reverted directly without
any problems.

Fixes: 156c3df8d4db ("staging: erofs: disable compiling temporarile")
Cc: Matthew Wilcox <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---

Hi Greg,

 Could you please apply this patch to enable EROFS from 4.19-rc2, thanks...

 p.s. We would like to provide a more stable EROFS when linux-4.19 is out,
      and there are also two patchsets (the one is already sent out by Chao
      and me, the other is previewing in linux-erofs mailing list and it will
      be sent out after gathering enough testdata and feedback from community
      and carefully reviewed), could you also please consider applying these
      two patchsets in the later 4.19-rc (both >2, or the first patchset
      could be in rc2 in advance) if it is convenient to do so, or the next
      4.20 is also ok...

 LINK: https://lore.kernel.org/lkml/20180821144937.20555-1-chao@kernel.org/
       https://lore.kernel.org/lkml/1535076160-99466-1-git-send-email-gaoxiang25@huawei.com/

Thanks,
Gao Xiang

 drivers/staging/erofs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/erofs/Kconfig b/drivers/staging/erofs/Kconfig
index 96f6149..663b755 100644
--- a/drivers/staging/erofs/Kconfig
+++ b/drivers/staging/erofs/Kconfig
@@ -2,7 +2,7 @@
 
 config EROFS_FS
 	tristate "EROFS filesystem support"
-	depends on BROKEN
+	depends on BLOCK
 	help
 	  EROFS(Enhanced Read-Only File System) is a lightweight
 	  read-only file system with modern designs (eg. page-sized
-- 
1.9.1

