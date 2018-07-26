Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08815C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C0720673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2C0720673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731316AbeGZNqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 09:46:16 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58698 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729948AbeGZNqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 09:46:16 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0A0758E1B96FB;
        Thu, 26 Jul 2018 20:29:34 +0800 (CST)
Received: from szvp000100637.huawei.com (10.162.55.131) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.382.0; Thu, 26 Jul
 2018 20:29:27 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, <yuchao0@huawei.com>,
        <miaoxie@huawei.com>, <weidu.du@huawei.com>, <hsiangkao@aol.com>,
        <chao@kernel.org>, Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 25/25] staging: erofs: add a TODO and update MAINTAINERS for staging
Date:   Thu, 26 Jul 2018 20:22:08 +0800
Message-ID: <1532607728-103372-26-git-send-email-gaoxiang25@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532607728-103372-1-git-send-email-gaoxiang25@huawei.com>
References: <1527764767-22190-1-git-send-email-gaoxiang25@huawei.com>
 <1532607728-103372-1-git-send-email-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.162.55.131]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a TODO to list the things to be done, and
the relevant info to MAINTAINERS so we can take all the blame :)

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 MAINTAINERS                |  7 +++++++
 drivers/staging/erofs/TODO | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)
 create mode 100644 drivers/staging/erofs/TODO

diff --git a/MAINTAINERS b/MAINTAINERS
index 0fe4228..8d470b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13487,6 +13487,13 @@ M:	H Hartley Sweeten <hsweeten@visionengravers.com>
 S:	Odd Fixes
 F:	drivers/staging/comedi/
 
+STAGING - EROFS FILE SYSTEM
+M:	Gao Xiang <gaoxiang25@huawei.com>
+M:	Chao Yu <yuchao0@huawei.com>
+L:	linux-erofs@lists.ozlabs.org
+S:	Maintained
+F:	drivers/staging/erofs/
+
 STAGING - FLARION FT1000 DRIVERS
 M:	Marek Belisko <marek.belisko@gmail.com>
 S:	Odd Fixes
diff --git a/drivers/staging/erofs/TODO b/drivers/staging/erofs/TODO
new file mode 100644
index 0000000..f99ddb8
--- /dev/null
+++ b/drivers/staging/erofs/TODO
@@ -0,0 +1,45 @@
+
+EROFS is still working in progress, thus it is not suitable
+for all productive uses. play at your own risk :)
+
+TODO List:
+ - add the missing error handling code
+   (mainly existed in xattr and decompression submodules);
+
+ - finalize erofs ondisk format design  (which means that
+   minor on-disk revisions could happen later);
+
+ - documentation and detailed technical analysis;
+
+ - general code review and clean up
+   (including confusing variable names and code snippets);
+
+ - support larger compressed clustersizes for selection
+   (currently erofs only works as expected with the page-sized
+    compressed cluster configuration, usually 4KB);
+
+ - support more lossless data compression algorithms
+   in addition to LZ4 algorithms in VLE approach;
+
+ - data deduplication and other useful features.
+
+erofs-mkfs (preview version) binaries for i386 / x86_64 are available at:
+
+   https://github.com/hsiangkao/erofs_mkfs_binary
+
+It is still in progress opening mkfs source code to public,
+in any case an open-source mkfs will be released in the near future.
+
+
+Code, suggestions, etc, are welcome. Please feel free to
+ask and send patches,
+
+To:
+  linux-erofs mailing list   <linux-erofs@lists.ozlabs.org>
+  Gao Xiang                  <gaoxiang25@huawei.com>
+  Chao Yu                    <yuchao0@huawei.com>
+
+Cc: (for linux-kernel upstream patches)
+  Greg Kroah-Hartman         <gregkh@linuxfoundation.org>
+  linux-staging mailing list <devel@driverdev.osuosl.org>
+
-- 
1.9.1

