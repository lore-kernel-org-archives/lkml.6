Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943D2C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 13:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE40208D4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 13:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="KvsDijvk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FE40208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbeHRQca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 12:32:30 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34943 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbeHRQca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 12:32:30 -0400
Received: by mail-ed1-f68.google.com with SMTP id e6-v6so5973229edr.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 06:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Yt93BPLDfVjLkUZ///kdCBdc5hre/vMNKZw/LDzwSvI=;
        b=KvsDijvkr6QtIquQGd6xj2KXcMk8QQaYKVYBpdt3i0Qha/dwkRt1vTf63t5qHAsUwA
         lZOzUucVwlkTyx7fYh7qMqh1/5gG4yxUd3pUnrZ6rsgGhftF5P8YnsQzTjne7WhmGGa0
         6ekB41z14+e/qamzYMN1vACauHUZfd0RwaKxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Yt93BPLDfVjLkUZ///kdCBdc5hre/vMNKZw/LDzwSvI=;
        b=ofcrnMCo2rsbymCk1us+uQg2aS3g8ixgJvHGWlwZxYfAWA+TSgDOqmvQO4O1Xs+by7
         Lqq3RuyDZJz253iNrWod8J4D3upxkeX39YClk0hxgM3gDMh1l0eL+0PxQQVRZcTkhtbx
         gsomQZHkwardWZQXRPHyxvDUZPMiW7vJVDY33m8y6cT2Y+lLCIIzjp2avHwD2wRPgiOV
         0z2GbrvkpzTvePMIIMeROGlCdF1GhlTaEkj6v3khZWh4V/jN8oUE12pRKYrTOJrgURh4
         s3rpJ6LNqVZ8C6NZ0ASrmSNomxuDx43g/ZUU9rku8VTlooWqyVbXwUvSDx12Bvrv9UYm
         9Mrw==
X-Gm-Message-State: AOUpUlFhL4KGmU4LABo3v1WKc7Txfe75S22SAh5lP3oFulsJRO1R759O
        17TMECOysFI3vXf5DIINUH4mIg==
X-Google-Smtp-Source: AA+uWPwTjsVya5cUtMkFivpgZu3z7xQo563C9lNVCFsSlQxFDSMqvljDtzIK/4Nz2wRixqFLw21bDg==
X-Received: by 2002:a50:b822:: with SMTP id j31-v6mr46211244ede.76.1534598686461;
        Sat, 18 Aug 2018 06:24:46 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-212.cgn.ip.fibianet.dk. [5.186.114.212])
        by smtp.gmail.com with ESMTPSA id a11-v6sm2739032edn.95.2018.08.18.06.24.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Aug 2018 06:24:45 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 4/8] proc: use seq_open_data() in proc_id_map_open()
Date:   Sat, 18 Aug 2018 15:24:30 +0200
Message-Id: <20180818132434.9515-4-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180818132434.9515-1-linux@rasmusvillemoes.dk>
References: <20180818132434.9515-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the code slightly by using the seq_open_data helper.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
Depends on 1/8 introducing seq_open_data.

fs/proc/base.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index aaffc0c30216..32ed72c44412 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2747,7 +2747,6 @@ static int proc_id_map_open(struct inode *inode, struct file *file,
 {
 	struct user_namespace *ns = NULL;
 	struct task_struct *task;
-	struct seq_file *seq;
 	int ret = -EINVAL;
 
 	task = get_proc_task(inode);
@@ -2758,19 +2757,11 @@ static int proc_id_map_open(struct inode *inode, struct file *file,
 		put_task_struct(task);
 	}
 	if (!ns)
-		goto err;
+		return ret;
 
-	ret = seq_open(file, seq_ops);
+	ret = seq_open_data(file, seq_ops, ns);
 	if (ret)
-		goto err_put_ns;
-
-	seq = file->private_data;
-	seq->private = ns;
-
-	return 0;
-err_put_ns:
-	put_user_ns(ns);
-err:
+		put_user_ns(ns);
 	return ret;
 }
 
-- 
2.16.4

