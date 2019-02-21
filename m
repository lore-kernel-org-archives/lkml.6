Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E9FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5FE92075C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K77ZsW/1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbfBUO2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:28:54 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:43729 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfBUO2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:28:53 -0500
Received: by mail-yw1-f65.google.com with SMTP id u200so10689139ywu.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 06:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tHFrjYbJjzzsBN4FCSQLd4n9P2bn+tCZVe8ylQfXhW4=;
        b=K77ZsW/1oNEw7xTFnPDR0RuFvHgeW6FdGNATC5dH+D/lhNHAmQjJ82cHxWZ5oFBsu3
         R4vhTpGOHomnuoKAI7LKvhyWI+pVdupoehTixVwngliAI0oZ89+4Yrv+TJ7khWBrlrBp
         pXtF64Bo4jyVNgR6XACt4eabJkJRxOebjUgw9G8wdM0aAklRQCy/j/PiTD7SA1KJYy8t
         Bs4Wl2xxP4DN242zy2S/d8AFfE4MbIW+SWoaK0Z//HV0GzvI7as8MfcI09rxrYYRKyU3
         gA2pHgG0frwS7oazG5eJzYN/lEohKJ5EmjzLPHAzimaUaKesw5mS7wD2L01StdER8tQZ
         uy/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tHFrjYbJjzzsBN4FCSQLd4n9P2bn+tCZVe8ylQfXhW4=;
        b=P1dgniJbFANTuU7KY1U4nkMi9HsmLHzeahcQtVpgykomKlF9/lP1p9EMPPWOz2IaBY
         2rEPI3h+OGI+Tmqs675rQZcr+XukKOR7a8Yu1xlGSfDo8s5hJ0hodCGtFBhifsttSUGc
         ozFKjuxTn93IMzqNQiXaU9QmASSKAml+sE5v0IboJqO7+FTaBJw2vNWJC2HDTTIWa4Lz
         jj8bDbEovH9+GeA9EgujNb0WaoqThWTQrSa05pfpodES0NPOZLzPWY/hUYyQLszbh7b5
         0+usRrUIik2eOktqiJGbQEKi0VjewaoV4Jcq3jbZkl56NSZVSVQl3YfiRxBFumtegOCI
         yyYA==
X-Gm-Message-State: AHQUAublETXix9yNF8D6GDAMjyLmdSS9E2n7PaxHdVVW3kMTMbKjdFr8
        ag1hq1zCOkNd6oU13ZnUeIg=
X-Google-Smtp-Source: AHgI3Ib3lkmIhEC2TsP6ZsZYfyci6+VkhpuvdwRwOTW9fergIsLTGSe/pplUD1GJoXM7yxHZlH0NDA==
X-Received: by 2002:a0d:e703:: with SMTP id q3mr21978097ywe.382.1550759333059;
        Thu, 21 Feb 2019 06:28:53 -0800 (PST)
Received: from localhost.localdomain ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id b7sm9420776ywa.86.2019.02.21.06.28.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 06:28:52 -0800 (PST)
From:   Bo YU <tsu.yubo@gmail.com>
To:     gaoxiang25@huawei.com, yuchao0@huawei.com,
        gregkh@linuxfoundation.org, yuzibode@126.com
Cc:     Bo Yu <tsu.yubo@gmail.com>, linux-erofs@lists.ozlabs.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging/erofs: fix sparse's warnings on undeclared symbols in erofs
Date:   Thu, 21 Feb 2019 09:28:45 -0500
Message-Id: <20190221142845.13604-1-tsu.yubo@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bo Yu <tsu.yubo@gmail.com>

Fix sparse warnings:

drivers/staging/erofs/utils.c:134:6: warning: symbol
'erofs_try_to_release_workgroup' was not declared. Should it be static?

Fixes: 51232df5e4b26("staging: erofs: fix race when the managed cache is enabled")
Cc: Gao Xiang <gaoxiang25@huawei.com>
Cc: Chao Yu <yuchao0@huawei.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Bo Yu <tsu.yubo@gmail.com>
---
 drivers/staging/erofs/utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/erofs/utils.c b/drivers/staging/erofs/utils.c
index b535898ca753..33cd5ad55cb8 100644
--- a/drivers/staging/erofs/utils.c
+++ b/drivers/staging/erofs/utils.c
@@ -131,7 +131,7 @@ static void erofs_workgroup_unfreeze_final(struct erofs_workgroup *grp)
 	__erofs_workgroup_free(grp);
 }
 
-bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
+static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
 				    struct erofs_workgroup *grp,
 				    bool cleanup)
 {
-- 
2.11.0

