Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8110C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9887E20449
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298338;
	bh=Epr97QKXoz3Vska7DZyhU2YDxUDnYgherMq6ZAXKrYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l/U72XuMVvDpcBmfihhsPG5+/zloqTkz0ZJ7YfmsKjk1Cf72tvk8YFKgDc6zYx3I9
	 NNvv4SeIYcp1e76iKG9tDjqJPrdIX/syWOCODtjNqbmc2h94tr5oTrxauZM9rGLpt9
	 doQ0QmXKgMslKBNx+G7YzVyfroZelprneEQFBDtU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733221AbeLTJcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:32:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:47032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733113AbeLTJbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:31:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 624B720989;
        Thu, 20 Dec 2018 09:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298282;
        bh=Epr97QKXoz3Vska7DZyhU2YDxUDnYgherMq6ZAXKrYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zoUbkjSDAYDO/8xe45h2SNItjAyok5x+GR/ERG9CmPEbgfxD0QmEcSUQemff99sIG
         umuqHDDUTIj88cxqC1jzSAlsuhstgBk/tztyFI9kwmuJaUtYaf2+ibXkPRcjLkxwB2
         4AC6LUKUqjhZO+xtcdj+ilKNxZubyg/BNvAUYbrk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 29/67] sbus: char: add of_node_put()
Date:   Thu, 20 Dec 2018 10:18:41 +0100
Message-Id: <20181220085904.699977321@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085903.562090333@linuxfoundation.org>
References: <20181220085903.562090333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 87d81a23e24f24ebe014891e8bdf3ff8785031e8 ]

use of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/sbus/char/display7seg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/sbus/char/display7seg.c b/drivers/sbus/char/display7seg.c
index 5c8ed7350a04..a36e4cf1841d 100644
--- a/drivers/sbus/char/display7seg.c
+++ b/drivers/sbus/char/display7seg.c
@@ -220,6 +220,7 @@ static int d7s_probe(struct platform_device *op)
 	dev_set_drvdata(&op->dev, p);
 	d7s_device = p;
 	err = 0;
+	of_node_put(opts);
 
 out:
 	return err;
-- 
2.19.1



