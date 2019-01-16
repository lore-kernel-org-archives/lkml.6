Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C99BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B5020651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbfAPCkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 21:40:07 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:42412 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728626AbfAPCkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 21:40:06 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CB9FBE00A66F474BB694;
        Wed, 16 Jan 2019 10:40:03 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Wed, 16 Jan 2019
 10:39:56 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <borisp@mellanox.com>, <aviadye@mellanox.com>,
        <davejwatson@fb.com>, <john.fastabend@gmail.com>,
        <daniel@iogearbox.net>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net/tls: Make function tls_sw_do_sendpage static
Date:   Wed, 16 Jan 2019 10:39:28 +0800
Message-ID: <20190116023928.28796-2-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20190116023928.28796-1-yuehaibing@huawei.com>
References: <20190116023928.28796-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following sparse warning:

 net/tls/tls_sw.c:1023:5: warning:
 symbol 'tls_sw_do_sendpage' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/tls/tls_sw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index c475538..b8e50e2 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1020,8 +1020,8 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	return copied ? copied : ret;
 }
 
-int tls_sw_do_sendpage(struct sock *sk, struct page *page,
-		       int offset, size_t size, int flags)
+static int tls_sw_do_sendpage(struct sock *sk, struct page *page,
+			      int offset, size_t size, int flags)
 {
 	long timeo = sock_sndtimeo(sk, flags & MSG_DONTWAIT);
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
-- 
2.7.0


