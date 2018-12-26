Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2F2C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 03:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 422452070D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 03:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="WJJGdwN7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbeLZDJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 22:09:40 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:51406 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbeLZDJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 22:09:39 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 8577A9AB
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 03:09:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sG2cs-I3qNp3 for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 21:09:38 -0600 (CST)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 57AAD98C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 21:09:38 -0600 (CST)
Received: by mail-it1-f200.google.com with SMTP id t143so17551721itc.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 19:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=FIK1HRX1Wbbvae4jUifypk3LnHOa0FRphY/12zrKTeY=;
        b=WJJGdwN7RUnbTSx38holh0g4cxqTxAPE3vAhaM+qv68Kcv00YiB1LsT+/6w2RCN2q+
         S3vZrCwIE/KmZeTTuq4KtCW7jlhefrxbdYWkIRu66muo+jXVcZtqphTDqktt6cb1A6Ra
         uMeKVs8hwKs7UXD0S+6eappb4sE2Ue0gcbZFM6D/y5pm3trmeYFEkSNc1ND5tM8l5uyh
         RXC9ke2Qy/9rjS2tA2B8yfjESwQ0JGa2xCRJoLqoQT6Yc4byBdURi742yLLmveOQAmXo
         mYgNqY4I3XwAABktlns6teNwqrYWu8kyzVEzIPeLbApqugItaQ90hLERid2yUXZGf99R
         I9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FIK1HRX1Wbbvae4jUifypk3LnHOa0FRphY/12zrKTeY=;
        b=RmUjRDvzjOjgspSGVhP0Ub384DQZWnSH6YbdAaMbAjTJR+zUjsoxG3BJac5NWEbPUV
         1adO5S1/k15aMIaRV77mdohGFLXNfFtAKDaP2mUNq2gXa86LoAhT2AkZDpjbK4NBJHFu
         uP7AntfUtu2nEs86oVymmEroGrnUccTBM7EWgKsMrKFUSzF2PHLxKKCyG5PXRJKzBWXr
         +OjKK7IURZHuDeBY8rPK2IkjmWD5xpY1/3aRHLIkyHKHOEnD48dAKh4lna6vyaTWADFv
         Zt8eyGBU5T95AsHXDto9zSoK++snRrDGG1ZipgBmRKj3946jdJRn31kE/BD+ss76cjbF
         fPMA==
X-Gm-Message-State: AJcUukcjtGLa3g7vyC1lrVxINLnEf+IaBNDX2FLhU1SfpNyehNyTu0Vk
        Tpdto4ZHIrT2m/Em1FTJZ2TWVzI3u74PrE1rYxCW74ECoynQ2APdd9VJ9i2RaTbMn3ZgnmYRXRC
        IMUMiInVMCh4suFlXO6yUttNXwfhK
X-Received: by 2002:a05:660c:12c7:: with SMTP id k7mr11232044itd.148.1545793777964;
        Tue, 25 Dec 2018 19:09:37 -0800 (PST)
X-Google-Smtp-Source: ALg8bN4mYu3kTm4tGXoTcQnnrPFFDtpGZQdhq9wEPM9CGCPg7ThKlzfTQ4AY2aXodq3+SAGuEecdgA==
X-Received: by 2002:a05:660c:12c7:: with SMTP id k7mr11232033itd.148.1545793777712;
        Tue, 25 Dec 2018 19:09:37 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id m37sm12233667iti.6.2018.12.25.19.09.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 19:09:37 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: fix a missing check of block data read
Date:   Tue, 25 Dec 2018 21:09:11 -0600
Message-Id: <20181226030911.72845-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When i2c_smbus_read_i2c_block_data() fails, the read data in "buf" could
be incorrect and should not be used. The fix checks if
i2c_smbus_read_i2c_block_data fails, and if so, return its error code
upstream.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/rtc/rtc-hym8563.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-hym8563.c b/drivers/rtc/rtc-hym8563.c
index e5ad527cb75e..d03f5d212eea 100644
--- a/drivers/rtc/rtc-hym8563.c
+++ b/drivers/rtc/rtc-hym8563.c
@@ -109,6 +109,8 @@ static int hym8563_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	}
 
 	ret = i2c_smbus_read_i2c_block_data(client, HYM8563_SEC, 7, buf);
+	if (ret < 0)
+		return ret;
 
 	tm->tm_sec = bcd2bin(buf[0] & HYM8563_SEC_MASK);
 	tm->tm_min = bcd2bin(buf[1] & HYM8563_MIN_MASK);
-- 
2.17.2 (Apple Git-113)

