Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B56C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E312220862
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJQPGo/B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E312220862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389953AbeKLJHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:07:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:49388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389767AbeKLIVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:21:38 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50058223DD;
        Sun, 11 Nov 2018 22:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975501;
        bh=NdRptz1YxUF9mlS1fiwKFrbL340XfU1/0DXPCaxGfCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iJQPGo/B2hSNCwjBb4+aEmEQkkHT9m4827K5qEGmUqSIK0blLD+uHvAKlvjAlPxFD
         JpWbFxddvymXW9fDJFKOwe70ZTbhetZKl/LJrU2KMs4CdJ7iDjHbsxODbXiDgPNAx9
         SQnrgyVxzK8AahnLQ4ErL9W4ZcKWzvKNZI2SwwvI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Soeren Moch <smoch@web.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 4.18 277/350] rtc: ds1307: fix ds1339 wakealarm support
Date:   Sun, 11 Nov 2018 14:22:21 -0800
Message-Id: <20181111221719.627958672@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Soeren Moch <smoch@web.de>

commit 7dceef78f310f5351735060d78a1777c69606016 upstream.

Commit 51ed73eb998a1c79a2b0e9bed68f75a8a2c93b9b ("rtc: ds1340: Add support
for trickle charger.") breaks ds1339 wakealarm support by limiting
accessible registers. Fix this.

Fixes: 51ed73eb998a ("rtc: ds1340: Add support for trickle charger.")
Cc: stable@vger.kernel.org
Signed-off-by: Soeren Moch <smoch@web.de>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/rtc/rtc-ds1307.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1372,7 +1372,6 @@ static void ds1307_clks_register(struct
 static const struct regmap_config regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
-	.max_register = 0x9,
 };
 
 static int ds1307_probe(struct i2c_client *client,


