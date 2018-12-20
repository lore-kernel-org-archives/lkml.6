Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDD5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0B522176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545299227;
	bh=V1a2jopTCx7catPnDsbStJesgeWkvI8KHhYdbFQejXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DGHqv9excnjo/hid2lMgUGfxh1r1jtAEFYcK5Y+A1zJGe21sNvtt823s31fjP8yrh
	 cDNYQgLNt3dXH7MsfDX6mqrVWAAySWQSQ194R0kHqDOXnB+KhJenfLIiDNpO7EkQoC
	 ePr0cQ7vcgIhmJmI570Jbv1RebmbWf2eprBd2fmk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731323AbeLTJrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:47:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:46602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730372AbeLTJTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:19:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1562221773;
        Thu, 20 Dec 2018 09:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297590;
        bh=V1a2jopTCx7catPnDsbStJesgeWkvI8KHhYdbFQejXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jwm2YN0DDVk9B/Za+IDQ4KAGZboG66fBcu42+lI6N4jxv7iT92tOeIxsieiEdQv76
         5ZyqJETexLAyb8M1fg3MVB470xn1P8s/mDg+Od6rVmlxH9+nf6c5zz/TLOmecyy6Vb
         6JoZEiM48Wlu9kIO0iJSW55Cbnx8HbLd6rDe2Zuw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 17/31] sbus: char: add of_node_put()
Date:   Thu, 20 Dec 2018 10:18:29 +0100
Message-Id: <20181220085743.278824934@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085742.601260254@linuxfoundation.org>
References: <20181220085742.601260254@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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



