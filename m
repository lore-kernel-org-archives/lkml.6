Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EC7C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15EEA20849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544676266;
	bh=TQdZFuogCcmcV0UnMaONQEz/YtbH+UD5v4jxi4/9u3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jum/dGFKMhhDKx7WeadTibXCfNbRvz90TmhDjvhG98R/qTAkSRBTTuqQUhe4r3xAn
	 0dL4H6Cun0Sp1cmwAnZam4ZK+zhAgXiCilhXZfzpMC3hwNrBWTdt5cFup5Q+poQW8N
	 G/Ybd6Ug7DEyEqpaW0MgIKhRdF+TuiwCjIiHsa+A=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15EEA20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbeLMEoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:44:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:44080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728680AbeLMEbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:31:15 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F62520873;
        Thu, 13 Dec 2018 04:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675474;
        bh=TQdZFuogCcmcV0UnMaONQEz/YtbH+UD5v4jxi4/9u3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=izjLOl4B8OeFkO1XU1QGqIW2/3LGsd0k/sEDL2l4GT7mEcACsft2IG+z+1x4++JnZ
         P6fzDNKSuP4oKDtXs9NBQMGH/tlGnrQt+PJlbFoH1WMxKfX+rMIG+AbRC8BUyw49TV
         7lTeKsiNkKGnd+uJBnd8t8enlwV40NMBsMBwLxpU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, sparclinux@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 13/41] sbus: char: add of_node_put()
Date:   Wed, 12 Dec 2018 23:30:26 -0500
Message-Id: <20181213043054.75891-13-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213043054.75891-1-sashal@kernel.org>
References: <20181213043054.75891-1-sashal@kernel.org>
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
index f32765d3cbd8..db761aca8667 100644
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

