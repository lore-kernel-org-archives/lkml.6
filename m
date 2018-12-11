Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FC2C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE6E2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="q7W0Cv7p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFE6E2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=posteo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbeLKKzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:55:08 -0500
Received: from mout02.posteo.de ([185.67.36.66]:57595 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbeLKKzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:55:02 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 13C6B240103
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 11:55:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1544525701; bh=NOPJD6beDgOUNfQFgRf9O0GPKflRAtz9k5A5JFjWEeY=;
        h=From:To:Cc:Subject:Date:From;
        b=q7W0Cv7pG6lH5+UnXS9NgXQ+FeGiS7ksQ5EDxMfamteV3U8KIUcbYI4y4FaUOYUmd
         FY6x10Ze0tclN5OrhqxcDb00CEClODs8O6Q9M/xOLa9crRIrEoUYQaMmz6giIBRhRF
         KWl7alm/LJX7hcdVcFCpF4hm6cTpe+OUIEzLrlEnC7K2y57yQEHIjgHSwvlX6PDMud
         hrabRcMNe0BtK1wvcTTq8//A8Cm0R50EvDy5kY9ijMP2nfEG742lHfOUjxLpcpCr2C
         FFRKJ/AA6w2j1+bfCxF+UXZhuRSFUvdSW35hiZPq+MCZQs1vXGvbYjLsCCiVeabPzA
         AvWG6oAkzbr4A==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 43DcKH5kSvz9rxf;
        Tue, 11 Dec 2018 11:54:59 +0100 (CET)
From:   Aaron Strahlberger <aaron.strahlberger@posteo.de>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chao Yu <yuchao0@huawei.com>, linux-erofs@lists.ozlabs.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-kernel@i4.cs.fau.de,
        Aaron Strahlberger <aaron.strahlberger@posteo.de>,
        Julius Wiedmann <julius.wiedmann@fau.de>,
        Dominik Huber <domi250@gmx.de>
Subject: [PATCH 3/5] drivers: staging: erofs: Fix spelling issue
Date:   Tue, 11 Dec 2018 11:54:41 +0100
Message-Id: <20181211105443.21826-4-aaron.strahlberger@posteo.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181211105443.21826-1-aaron.strahlberger@posteo.de>
References: <0ed9f3e7-9081-4a8a-06b0-e5ad14e2c872@huawei.com>
 <20181211105443.21826-1-aaron.strahlberger@posteo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changed "stoped" to "stopped".

Signed-off-by: Aaron Strahlberger <aaron.strahlberger@posteo.de>
Signed-off-by: Julius Wiedmann <julius.wiedmann@fau.de>
Signed-off-by: Dominik Huber <domi250@gmx.de>
---
 drivers/staging/erofs/dir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/erofs/dir.c b/drivers/staging/erofs/dir.c
index 49a4e7730df0..e83475260106 100644
--- a/drivers/staging/erofs/dir.c
+++ b/drivers/staging/erofs/dir.c
@@ -66,8 +66,8 @@ static int erofs_fill_dentries(struct dir_context *ctx,
 #endif
 
 		if (!dir_emit(ctx, de_name, de_namelen,
-					le64_to_cpu(de->nid), d_type))
-			/* stoped by some reason */
+			      le64_to_cpu(de->nid), d_type))
+			/* stopped by some reason */
 			return 1;
 		++de;
 		*ofs += sizeof(struct erofs_dirent);
-- 
2.19.2

