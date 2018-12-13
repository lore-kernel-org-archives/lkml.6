Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCA8C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E12FA20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675724;
	bh=bFDRiFkfAhElG4zFWRf+PXbyhXXmbAiM+1/bSQll5lI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r3Mwbu43/Y2Ed+U6ZOdaBP0Yqslm8sYnDitof5CgjxL4NY/gpZui+cQJoWq+BnKj+
	 6/DDX510sH5kntROIfEIGqVL8fkMbmzthOx+SlrQYnTrxigsHrVOCQFTqQOWHTWEgA
	 tGsdOdW95wTcB9+tDg5VopHiJkae9uVfUGBOYNAw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E12FA20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbeLMEfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:35:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:47122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729472AbeLMEd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:33:57 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDC2620672;
        Thu, 13 Dec 2018 04:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675636;
        bh=bFDRiFkfAhElG4zFWRf+PXbyhXXmbAiM+1/bSQll5lI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b8Lq1eWWO140BdBRKsnBO3+IWasSFlbwdTYKcb+2BoDhdbiriEEDITQ1+yXvTNnbj
         HyPsMbH+vLeYEraukGIBpGlCwI6UcTWhDSzc9OkqqHp84b0zm2Fl9xjrA/+ak40QG3
         e1Kt5ZC5Yb+mlZdbl5FSw3eBzYbOzEst3h2xrbsg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, sparclinux@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 07/16] sbus: char: add of_node_put()
Date:   Wed, 12 Dec 2018 23:33:34 -0500
Message-Id: <20181213043343.76896-7-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213043343.76896-1-sashal@kernel.org>
References: <20181213043343.76896-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

[ Upstream commit 87d81a23e24f24ebe014891e8bdf3ff8785031e8 ]

use of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/sbus/char/display7seg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/sbus/char/display7seg.c b/drivers/sbus/char/display7seg.c
index 2b0ce7c350ee..98661714688b 100644
--- a/drivers/sbus/char/display7seg.c
+++ b/drivers/sbus/char/display7seg.c
@@ -221,6 +221,7 @@ static int d7s_probe(struct platform_device *op)
 	dev_set_drvdata(&op->dev, p);
 	d7s_device = p;
 	err = 0;
+	of_node_put(opts);
 
 out:
 	return err;
-- 
2.19.1

