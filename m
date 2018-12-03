Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D800C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 233C32082F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="VXgwP1ja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 233C32082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbeLCU0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 15:26:16 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44437 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeLCU0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 15:26:16 -0500
Received: by mail-pl1-f194.google.com with SMTP id k8so7024588pls.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 12:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EZ0xbqQZqIrzvN+Xj1I28GBx4CSSG5lfYWs8cFSxGkk=;
        b=VXgwP1jaz76eIuI2ZHhW8EEdUGFfAFcbLBPc7UhKFlO0P9qxVQy4QhJ30B2IUdMa6t
         PL+g4FKXi80HH5A23h8hV6HjQ0ty9bwVizpJJKo47m1xoeWROcpXVy1tKMnv7HVkMjum
         yY9gj+3QerASxIoRWwXCxtCAtN88Vb2t8zu5O3maeUMfqmPfkHnp98hD13I4s87CpnIl
         9wMgugZLyi+LRRTQF5+6UyGDf93eQYBR4vnRtXx013oM1MjxvhwXWHY68U657PXfP6i1
         JnsyjGudffBJ3oySxsoVWd2OBRTTlZ/Y4xkTcvFcn8f8pfZj+c9KdFFeyx6yfu/J46AJ
         mH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EZ0xbqQZqIrzvN+Xj1I28GBx4CSSG5lfYWs8cFSxGkk=;
        b=V3QFjRjlCssNh/a4avHhzwzgLk3CR+trhPUbm9K6JOILjgFcNv5MjVLSaT2yubknYd
         tEFJXJ8/wc5S9G4+QnJkL1/W87l2jjmw/uKgqePM44TErNPJY+iKCOHaxrlxOjoD5mOc
         9dnv/ELwuDdCDOMIwkFZcmLytrnInjdfmJxlzcCis8yLnp2pjHzWQIlXYWmMDwLNiTFR
         MUmZIu+zp4CC8GcVXYPDxBAwSsLdy2Y/BpGoQ02A+/W/3yjwY/fpH9/8/E4lJCcUUCz6
         6h8EboUKIKfV7cab6eT8CG39XYJY72R6PCdc+SQhByUT15wNSMTmvDAcubi+71t2366j
         iwcQ==
X-Gm-Message-State: AA+aEWZFq4OrreZbqBuA7vKt7yHiwjwrBa3Bg/ZsSKuBRpdx8XRusV2J
        4GV+wi4oNQMYfSq27qrmpHnw/Q==
X-Google-Smtp-Source: AFSGD/VhL3TDyzkIOrqwLqyOj7EpLrxiAw/EwHkmo9sEmY/PFABRj1gvCAHnAX5OYuCQjmqPVedTUw==
X-Received: by 2002:a17:902:f64:: with SMTP id 91mr3734986ply.132.1543868773739;
        Mon, 03 Dec 2018 12:26:13 -0800 (PST)
Received: from ava-linux2.mtv.corp.google.com ([2620:0:1000:1601:6cc0:d41d:b970:fd7])
        by smtp.googlemail.com with ESMTPSA id q7sm16562725pgp.40.2018.12.03.12.26.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 12:26:13 -0800 (PST)
From:   Todd Kjos <tkjos@android.com>
X-Google-Original-From: Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com, joel@joelfernandes.org
Cc:     kernel-team@android.com
Subject: [PATCH] binder: filter out nodes when showing binder procs
Date:   Mon,  3 Dec 2018 12:24:56 -0800
Message-Id: <20181203202457.228972-3-tkjos@google.com>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <20181203202457.228972-1-tkjos@google.com>
References: <20181203202457.228972-1-tkjos@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When dumping out binder transactions via a debug node,
the output is too verbose if a process has many nodes.
Change the output for transaction dumps to only display
nodes with pending async transactions.

Signed-off-by: Todd Kjos <tkjos@google.com>
---
 drivers/android/binder.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 9f2059d24ae2d..c525b164d39d2 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -5432,6 +5432,9 @@ static void print_binder_proc(struct seq_file *m,
 	for (n = rb_first(&proc->nodes); n != NULL; n = rb_next(n)) {
 		struct binder_node *node = rb_entry(n, struct binder_node,
 						    rb_node);
+		if (!print_all && !node->has_async_transaction)
+			continue;
+
 		/*
 		 * take a temporary reference on the node so it
 		 * survives and isn't removed from the tree
-- 
2.20.0.rc1.387.gf8505762e3-goog

