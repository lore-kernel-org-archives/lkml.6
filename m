Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD79C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D1A21720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297708;
	bh=VflhI5pFTXDRKxiI1N9lv9fdBqWwp4wljcqAMywVJ14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S8VOX4pL/zziJJY2XFsqAaeIOGphw7I7at0yxsfcD3LPEQuV2ZpMKvB4wtnzTaYYp
	 f36WS9kOUUJskvExrT4abEXlNjNw9H1Z++yOMUEYSSFlq88L8mlTRdVRbIZ4L0Z9Kr
	 HSxrna2KgVn+QWtA8QD11IP+cHG+H7aTHEsXZ2/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731188AbeLTJVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:21:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:37022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731168AbeLTJVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:21:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 009A42177B;
        Thu, 20 Dec 2018 09:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297704;
        bh=VflhI5pFTXDRKxiI1N9lv9fdBqWwp4wljcqAMywVJ14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lXfVIZ5uw7nNhstIWRLku9AXM8N3oXj7h42xvWVkUi0ar8syUpNrq1PzbxLHGiIHH
         nkLpYOawkhuaxFuKEVHrXR84225Lt1LpiDiSxcFECOHHOTYxW63e8O4At+14vjr3S8
         Mg60ZbXg8F3Wcn6zE1iMCs5ZJXDFWbPbDdo+/esk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 26/40] sbus: char: add of_node_put()
Date:   Thu, 20 Dec 2018 10:18:38 +0100
Message-Id: <20181220085827.513899773@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085826.212663515@linuxfoundation.org>
References: <20181220085826.212663515@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
index 33fbe8249fd5..044cffbc45e8 100644
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



