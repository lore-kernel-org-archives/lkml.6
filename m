Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36ACC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69B0208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0BFVE69"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B69B0208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbeLGO1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 09:27:50 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52536 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbeLGO1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 09:27:45 -0500
Received: by mail-wm1-f68.google.com with SMTP id r11-v6so4550782wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 06:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4E4W8FBJ5YHJdE0GUrhz4uNO8f7GUqx2QN57IrdDl0E=;
        b=k0BFVE69ZUKYJaDR0JNvvrgTHK7p66VwDZevwMGOU6r4kd7tniNShVvijqsZxrDMIE
         FDSAQ8C8WAxNWkd7T/wWd/k3HKeh4/ocRAwoUX5d+0gfICEwCqy/PwfssYYTGaclq+j0
         ZRn8tyGNAFDfhq0LPjWWnaxbesI36IUFpYYxMwurllXNh2N5UvwxL31yTbJn8HC1AdVd
         Doj6R99Mq1PvGDVkoNaQ3pnBJMDEjBDQPvv5UfoYlZKbdnlMKkSgmsp+BemE07sMXbsF
         S0EgEfYQAvT/9TnJ923WzxQyIsd3BMTxapx8DGVOJYBUvgWItCe6sW/pCYJ2NAvvMC3V
         GSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4E4W8FBJ5YHJdE0GUrhz4uNO8f7GUqx2QN57IrdDl0E=;
        b=tmCf6j824GTH93K7OobyRmvNyULL6bJJCKzqnvB15TjQggYlJfHyQOpXvKuYkPW196
         HWe+ZbY/z4Csuvf4WQnwUDfhden4c7Yu09/hYubZRw6O3qo3JZLvLMlKT7/V6cSj+kUn
         We3Z/u3Hy+t58PJTFggBhNc8axUKMnhjYFUvbY0Zs/qH/k4N0EIAlnM2SvqRWFTs8NRv
         RNjbkdjm3jn+g47nZ9Jg+CECMsvXovE8nj3ks1QJy0sWX0GLwLieX/AS3d12yZpPIj/C
         9aOMJMRXuBDqfsy14OdwPqlSyTmOvGZqvyweZH6kpfOLfJMXenkrZ74T/kuuwQ1XqWxY
         Hi0Q==
X-Gm-Message-State: AA+aEWb9M91mMqlWzn/9ps7iZ7si3t+gY7T3Z9sfUGxmv+jBTbhoOfIM
        6d99pJPZor9tfttibpzQeHk=
X-Google-Smtp-Source: AFSGD/WQ0FtGh8TVok/S8CoCRFX0P/NWOtNpykrXaZKf0RqS8Qp7VLVno6Mfk1sjK9u7qoqUkjF2tw==
X-Received: by 2002:a1c:f509:: with SMTP id t9mr2597194wmh.76.1544192863757;
        Fri, 07 Dec 2018 06:27:43 -0800 (PST)
Received: from localhost.localdomain (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id 60sm7172523wrb.81.2018.12.07.06.27.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 06:27:43 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 5/5] char: lp: use new parport device model
Date:   Fri,  7 Dec 2018 14:27:34 +0000
Message-Id: <20181207142734.27370-5-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181207142734.27370-1-sudipm.mukherjee@gmail.com>
References: <20181207142734.27370-1-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify lp driver to use the new parallel port device model.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/char/lp.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/char/lp.c b/drivers/char/lp.c
index cef2ea386f5e..5c8d780637bd 100644
--- a/drivers/char/lp.c
+++ b/drivers/char/lp.c
@@ -912,9 +912,13 @@ static int __init lp_setup(char *str)
 
 static int lp_register(int nr, struct parport *port)
 {
-	lp_table[nr].dev = parport_register_device(port, "lp",
-						   lp_preempt, NULL, NULL, 0,
-						   (void *) &lp_table[nr]);
+	struct pardev_cb ppdev_cb;
+
+	memset(&ppdev_cb, 0, sizeof(ppdev_cb));
+	ppdev_cb.preempt = lp_preempt;
+	ppdev_cb.private = &lp_table[nr];
+	lp_table[nr].dev = parport_register_dev_model(port, "lp",
+						      &ppdev_cb, nr);
 	if (lp_table[nr].dev == NULL)
 		return 1;
 	lp_table[nr].flags |= LP_EXIST;
@@ -1002,8 +1006,9 @@ static void lp_detach(struct parport *port)
 
 static struct parport_driver lp_driver = {
 	.name = "lp",
-	.attach = lp_attach,
+	.match_port = lp_attach,
 	.detach = lp_detach,
+	.devmodel = true,
 };
 
 static int __init lp_init(void)
-- 
2.11.0

