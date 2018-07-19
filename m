Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C112ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 07:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A3020693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 07:26:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0A3020693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730982AbeGSIIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 04:08:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55009 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726931AbeGSIIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 04:08:38 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0ADFDB128DB2B;
        Thu, 19 Jul 2018 15:26:52 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.382.0; Thu, 19 Jul 2018
 15:26:45 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH bpf-next] bpfilter: Fix mismatch in function argument types
Date:   Thu, 19 Jul 2018 15:25:56 +0800
Message-ID: <20180719072556.20076-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following warning:
net/ipv4/bpfilter/sockopt.c:28:5: error: symbol 'bpfilter_ip_set_sockopt' redeclared with different type
net/ipv4/bpfilter/sockopt.c:34:5: error: symbol 'bpfilter_ip_get_sockopt' redeclared with different type

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/linux/bpfilter.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpfilter.h b/include/linux/bpfilter.h
index 687b176..43acfa8 100644
--- a/include/linux/bpfilter.h
+++ b/include/linux/bpfilter.h
@@ -5,9 +5,9 @@
 #include <uapi/linux/bpfilter.h>
 
 struct sock;
-int bpfilter_ip_set_sockopt(struct sock *sk, int optname, char *optval,
+int bpfilter_ip_set_sockopt(struct sock *sk, int optname, char __user *optval,
 			    unsigned int optlen);
-int bpfilter_ip_get_sockopt(struct sock *sk, int optname, char *optval,
+int bpfilter_ip_get_sockopt(struct sock *sk, int optname, char __user *optval,
 			    int *optlen);
 extern int (*bpfilter_process_sockopt)(struct sock *sk, int optname,
 				       char __user *optval,
-- 
2.7.0


