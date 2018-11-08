Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB10EECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A3020844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhMszQ+f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78A3020844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731414AbeKIHl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:41:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:33752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728174AbeKIHl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:41:58 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B7A920844;
        Thu,  8 Nov 2018 22:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714668;
        bh=tmjlXpqKbs52qaAaHz2YufGhn/NYDMwmhKsGM9LSCho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MhMszQ+fnyCVB4dLKQh1sGkXeej2QTj+GNymFQSSmy9N5bqVPI1UpaFcxtepELw4c
         jFAUR06+Oa4NQ+zWO+btOIEr7USYrYjoxM7ndyNbhZyYE9+I9UfGa2CBSkp2WsfMMs
         f4bLLclJoiPQOp6zkSfbjtIma24Zx5qLjdbR/br0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeremy Linton <lintonrjeremy@gmail.com>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 059/171] reset: hi6220: Set module license so that it can be loaded
Date:   Thu,  8 Nov 2018 13:50:29 -0800
Message-Id: <20181108215131.795197860@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 4497a224f759cd8350e07382307b55f870ef0df2 ]

The hi6220_reset driver can be built as a standalone module
yet it cannot be loaded because it depends on GPL exported symbols.

Lets set the module license so that the module loads, and things like
the on-board kirin drm starts working.

Signed-off-by: Jeremy Linton <lintonrjeremy@gmail.com>
Reviewed-by: Xinliang Liu <xinliang.liu@linaro.org>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/reset/hisilicon/hi6220_reset.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/reset/hisilicon/hi6220_reset.c b/drivers/reset/hisilicon/hi6220_reset.c
index 35ce53edabf9..d5e5229308f2 100644
--- a/drivers/reset/hisilicon/hi6220_reset.c
+++ b/drivers/reset/hisilicon/hi6220_reset.c
@@ -155,3 +155,5 @@ static int __init hi6220_reset_init(void)
 }
 
 postcore_initcall(hi6220_reset_init);
+
+MODULE_LICENSE("GPL v2");
-- 
2.17.1



