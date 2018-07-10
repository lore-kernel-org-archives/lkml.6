Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96521C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51BEE20873
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51BEE20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932756AbeGJG44 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 02:56:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9215 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751274AbeGJG4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 02:56:51 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0A63B4F13A6E9;
        Tue, 10 Jul 2018 14:56:38 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.382.0; Tue, 10 Jul 2018
 14:56:30 +0800
To:     <akpm@linux-foundation.org>, <ericvh@gmail.com>,
        <rminnich@sandia.gov>, <lucho@ionkov.net>
CC:     <linux-kernel@vger.kernel.org>,
        <v9fs-developer@lists.sourceforge.net>,
        Jiangyiwen <jiangyiwen@huawei.com>
From:   piaojun <piaojun@huawei.com>
Subject: [PATCH] net/9p/client.c: add missing '\n' at the end of p9_debug()
Message-ID: <5B44589A.50302@huawei.com>
Date:   Tue, 10 Jul 2018 14:56:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In p9_client_getattr_dotl(), we should add '\n' at the end of printing
log.

Signed-off-by: Jun Piao <piaojun@huawei.com>
---
 net/9p/client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index 5c13431..8bc8b3e 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -1790,7 +1790,7 @@ struct p9_stat_dotl *p9_client_getattr_dotl(struct p9_fid *fid,
 		"<<< st_mtime_sec=%lld st_mtime_nsec=%lld\n"
 		"<<< st_ctime_sec=%lld st_ctime_nsec=%lld\n"
 		"<<< st_btime_sec=%lld st_btime_nsec=%lld\n"
-		"<<< st_gen=%lld st_data_version=%lld",
+		"<<< st_gen=%lld st_data_version=%lld\n",
 		ret->st_result_mask, ret->qid.type, ret->qid.path,
 		ret->qid.version, ret->st_mode, ret->st_nlink,
 		from_kuid(&init_user_ns, ret->st_uid),
-- 
