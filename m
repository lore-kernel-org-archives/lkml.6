Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56056C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1569B2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="jpxPPljV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfAKU5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 15:57:02 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:60658 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfAKU5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 15:57:01 -0500
Received: from trochilidae.toradex.int (unknown [37.17.239.109])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 225775C1BA6;
        Fri, 11 Jan 2019 21:57:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1547240220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JFqLj9+HILy7SY6/wKCwqhTdwOFoWAa5K5unX1dWAAU=;
        b=jpxPPljVCI2PulnUHzs/99Q1NkVq1O6vfnlLWEpr/NuX+aqWeujiu78gam0rvEwoQAW5NX
        OF49PGCBvLEYQSIaDTLU/JVtwr8dui2aTI1JbmgasqhbIWbMPE9JGzAQTg/CGPKIfZizab
        Wel/BgbGZpEtNaXyg0jxNDpm5yWwQvQ=
From:   Stefan Agner <stefan@agner.ch>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     huxm@marvell.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH 2/2] bluetooth: btmrvl_sdio: lower log level of informational message
Date:   Fri, 11 Jan 2019 21:56:57 +0100
Message-Id: <20190111205657.2792-2-stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111205657.2792-1-stefan@agner.ch>
References: <20190111205657.2792-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform specific wake-up interrupt is optional. Don't print
an error message in case it is missing, merely inform the user in
this case.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/bluetooth/btmrvl_sdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 6f9a1735039d..8ff4c31e0e48 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -88,7 +88,7 @@ static int btmrvl_sdio_probe_of(struct device *dev,
 
 	if (!dev->of_node ||
 	    !of_match_node(btmrvl_sdio_of_match_table, dev->of_node)) {
-		dev_err(dev, "sdio platform data not available\n");
+		dev_info(dev, "sdio device tree data not available\n");
 		return -1;
 	}
 
-- 
2.20.1

