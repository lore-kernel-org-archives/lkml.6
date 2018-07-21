Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E337ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE15A20856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqLjXwuJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE15A20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbeGUNug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:50:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44819 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729549AbeGUNuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:50:35 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1-v6so9021963pgp.11
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 05:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=khOxDhevnymFnYRKR9We1vfbyjly4X6615Z796xc6sM=;
        b=NqLjXwuJsht0IxdNDln4O/zUEfRuz4V3008aWJJjNgNrN5YThsWpt3fgNHuIzicnD5
         ik9jOpQcN5u6de/c3JMks66LczNKZ+BBjsSZxkX6GPJlUKY7YbbiKBRFauSQMSTH5o2+
         WEprf/sdnffMalLWeyB8iLjhR7OxwGFAkqEuTIhrPnVxcBaJVL+vzG8RI+7mciXCmq0W
         eC26hlQDbvbJtexB6dL8tpP1IH+Ea+bRhR/1Fpq6wz2PpM8FDhyiIdEGmixFZ/LktogI
         KIo0FY8Ddm8rrV8HQ41mAsGcUXxuTAizfpPZAw53pG/cV1dwryvKeSdjjRYNlJvnhb97
         Gbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=khOxDhevnymFnYRKR9We1vfbyjly4X6615Z796xc6sM=;
        b=KLrZJ88pRd8By/jJXd83EyQlngi3quhMKKcYauOgi1MgIRvhE7/TgAyjl1WzZwRGvG
         NR41qG4I36A/OKVU8wGL0hMXDcdn0MBQ1R+2UoYAdD6vbWaJBCdeVWTTcYs1Uj6rbg40
         WdFdlE5pc4cbr/fl+9U0RQHRqvMGtn/PDuFu9N0AXblI6Fw5P9P4yoxx9yHNLboVQlqT
         ib5dVlTX5PkfgKXbrvZUvFy0YRxeWto1Ve4btJ0XREylZPtrF+miFrjWqe3cbZuznd6Q
         BSnMYvc47+4M8aaxSgxXi7BItnGV0r+c41sQyNhI89d3Vc9Dtxn/puTg6ra0ymzwrUK8
         ZmFA==
X-Gm-Message-State: AOUpUlEfB5a8gbLxejTcAD548hKQPsQxccpaL1dHuLolGZNg+AsFifRu
        1oPCwk2yZvpyQsvFGGMUok8=
X-Google-Smtp-Source: AAOMgpd5okGp8f4QQKkY7ORSNmbUbFMqGgW29QMCiRDt9GF/MsgwukC2dNLmjnkFIuUOUwPBvQcm0g==
X-Received: by 2002:a63:f557:: with SMTP id e23-v6mr5478078pgk.170.1532177875312;
        Sat, 21 Jul 2018 05:57:55 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id d19-v6sm1072542pfe.42.2018.07.21.05.57.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 05:57:54 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>,
        Simon Que <sque@chromium.org>
Subject: [PATCH 12/20] staging: gasket: remove unnecessary parens in page table code
Date:   Sat, 21 Jul 2018 05:57:03 -0700
Message-Id: <20180721125713.88501-25-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180721125713.88501-1-toddpoynor@gmail.com>
References: <20180721125713.88501-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

gasket_alloc_coherent_memory() extra parentheses in statement.

Reported-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Simon Que <sque@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_page_table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index 617d602b8b447..9f8116112e0ac 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -1639,7 +1639,7 @@ int gasket_alloc_coherent_memory(struct gasket_dev *gasket_dev, u64 size,
 	dma_addr_t handle;
 	void *mem;
 	int j;
-	unsigned int num_pages = (size + PAGE_SIZE - 1) / (PAGE_SIZE);
+	unsigned int num_pages = (size + PAGE_SIZE - 1) / PAGE_SIZE;
 	const struct gasket_driver_desc *driver_desc =
 		gasket_get_driver_desc(gasket_dev);
 
-- 
2.18.0.233.g985f88cf7e-goog

