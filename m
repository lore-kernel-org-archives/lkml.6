Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02CCC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 08:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A632082A
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 08:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A632082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbeI3O6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 10:58:34 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34767 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727651AbeI3O6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 10:58:33 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D427A87F053BC;
        Sun, 30 Sep 2018 16:26:28 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.399.0; Sun, 30 Sep 2018 16:26:23 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] dump.f2fs: allow dump data on mounted image
Date:   Sun, 30 Sep 2018 16:26:13 +0800
Message-ID: <20180930082613.106905-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xfstests assumes it's allow to dump data on mounted image, for example,
some common functions call dumpe2fs on mounted ext[2|3|4] image to check
feature lists. To adapt such requirement, let's follow that rule in
dump.f2fs.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck/main.c b/fsck/main.c
index e20f31ca09e4..675c603b1a76 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -744,7 +744,7 @@ int main(int argc, char **argv)
 
 	f2fs_parse_options(argc, argv);
 
-	if (f2fs_devs_are_umounted() < 0) {
+	if (c.func != DUMP && f2fs_devs_are_umounted() < 0) {
 		if (errno == EBUSY)
 			return -1;
 		if (!c.ro || c.func == DEFRAG) {
-- 
2.18.0.rc1

