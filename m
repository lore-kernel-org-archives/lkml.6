Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADB5C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 19:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A7CD20893
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 19:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKoyL0Rs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A7CD20893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbeG1VBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 17:01:54 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41449 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730538AbeG1VBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 17:01:53 -0400
Received: by mail-pg1-f195.google.com with SMTP id z8-v6so5067451pgu.8
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 12:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZVEwWukYPY8Zy0zuTqzgs9wPaQH10zsivuderDr4YaY=;
        b=ZKoyL0RszOc/+Ag5tR7KTbV4jO01xyKMpq/HwjqTNimr7JU2X90zT8/8lRegwCpEqk
         0UnFkPZhJGdWGsm1YVescRq2jEsv0DfTuSv2x6OLehomvjKXul6GTWUh0Y1m7aFuFIWM
         1TWe9v+icySXexWP43MtxhIO+WiqcnrFj/wEXGGzhTYXp533P4mQSLSEiV9bM4sjzR1z
         +u6+wGQ+hpkbkuSzufSSTvwAlj/xoitVQdxVgLHHL1odqTdumgLp81dLRYiobRrx8oXp
         FwcOhJv1gzDuuikFC0bcOohuuMUATCw26sZv+w+ObQVqR7LKQlxfeMtK5RxlQjmcw4YE
         5AOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZVEwWukYPY8Zy0zuTqzgs9wPaQH10zsivuderDr4YaY=;
        b=mwrpFNpUConUYg+BXgl34mloBDF6BQPzPGbVWz8rwHKt7LfpZ3lVNX0Nsg8zIoEa0t
         rXaMxfU1pwgECHohnpkFkNMT85pGdHbZb8sOqdLynIKcYheymGvOVYOqh2gMX2RIlQgZ
         zCCweAutPj4IZ9yUJoZaIWL7+RyQwbu6DZ7jMYfZO77UYNW59SwEtnDAFQS0zPcWwVjz
         Jom+vhIFZA555XUO/elcme4QU97XbBYnvnnicE4MffbU+IFCHmRH0l5KrrJy60ih3elN
         aLCD50Hf8hz/dVNwXGE2yjYavVTU8Z1ibaCI3iQouiOPO29L2sjM304ClzzShjcDH5Pq
         QawA==
X-Gm-Message-State: AOUpUlFkW0GljX5HZqsYTzLfw/U3vQUxeUdy8f4rBhRC7a14i4jTcAGW
        lZjKNMBcnVyWamkntdBgz9g=
X-Google-Smtp-Source: AAOMgpc6IwlO0ibBjqQHk4lUklGAOgUMH3UGprTdkQa7dqcuBnAVBAaupSOaPWADSUZalja+06eOIw==
X-Received: by 2002:a62:4c0f:: with SMTP id z15-v6mr11623859pfa.110.1532806460972;
        Sat, 28 Jul 2018 12:34:20 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id e16-v6sm9607483pfn.46.2018.07.28.12.34.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 12:34:20 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 1/1] staging: gasket: core: hold reference on device while in use
Date:   Sat, 28 Jul 2018 12:33:24 -0700
Message-Id: <20180728193324.142821-2-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180728193324.142821-1-toddpoynor@gmail.com>
References: <20180728193324.142821-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Hold a reference on the struct device while a pointer to that
device is in use by gasket.

Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 859a6df9e12df..2b484d067c38a 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -448,7 +448,7 @@ static int gasket_alloc_dev(
 	gasket_dev->internal_desc = internal_desc;
 	gasket_dev->dev_idx = dev_idx;
 	snprintf(gasket_dev->kobj_name, GASKET_NAME_MAX, "%s", kobj_name);
-	gasket_dev->dev = parent;
+	gasket_dev->dev = get_device(parent);
 	/* gasket_bar_data is uninitialized. */
 	gasket_dev->num_page_tables = driver_desc->num_page_tables;
 	/* max_page_table_size and *page table are uninit'ed */
@@ -487,7 +487,7 @@ static void gasket_free_dev(struct gasket_dev *gasket_dev)
 	mutex_lock(&internal_desc->mutex);
 	internal_desc->devs[gasket_dev->dev_idx] = NULL;
 	mutex_unlock(&internal_desc->mutex);
-
+	put_device(gasket_dev->dev);
 	kfree(gasket_dev);
 }
 
-- 
2.18.0.345.g5c9ce644c3-goog

