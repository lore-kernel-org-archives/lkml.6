Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7C4C43444
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 08:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE2A218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 08:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdX+L9oJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbfABI7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 03:59:42 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41811 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728969AbfABI7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 03:59:42 -0500
Received: by mail-lj1-f194.google.com with SMTP id k15-v6so26426934ljc.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 00:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eD6vdBsepWppEQ05SRQmT4a1zoaGvTyTVp6rRdsMwk0=;
        b=LdX+L9oJjaEbV8ti2QJpvLcZOUtKiQVck+e5aVjKDtYH2v0lAytvrjIX0tGf2Kcnqi
         KTRLGvbOaerIEhGNAONWpz42zy765uVTfz8fO16111mBmaoclKa8rjmUkGxNLvhRlR23
         IG8mE7gbO7BbtNvkd15RuWvkAyx3p7p7z6+1Dv08LFkM4aSnH5dceEc6yl9dBbUck2jT
         L+gj2v7BNSwoHqy98s0rvWcYViVMznos7a78sPVgvMaYBqYycfvBcPGfgCCWdNesgZhk
         6bsjI6wKFJOuVR6ZlVrhWEUwaR0Kew77fFAEwshjwg5vohuWP3bIEEwp9zu703n1sl2U
         6wMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eD6vdBsepWppEQ05SRQmT4a1zoaGvTyTVp6rRdsMwk0=;
        b=JYG0CfoWdVbXtI6lBrYsXvWlyiJJCIKL8OQPpcPt239xYaqeK0XL3xNc63LizuP+e/
         if34gNLnd9pvV+kfP4hd83dX/qS7bNMsIzF6gzlt72H8uGYVv07XmtsQ1746m4KOSmig
         UNNMjm0Z1smDFYBnq5FEhQ7v9QgOrXV1E32RMfmEZTuS90m3bVfo0mnYWY0htG8kkhiS
         UAzffgj9FT54+dOY8NKk4ZQL2pvxwpBNVp0Eq9hdqzdjjtGS2VgzVAMeTVHdQyB2Ogc5
         rPDW9dtk1PWeKA1j0k+qtJzfoZrwZJTDtYCjWWQaJOLQRESgSyui7lR/99KtjaqTdpDV
         a/dw==
X-Gm-Message-State: AJcUukdFC74IavFAsLbMNFTZGU8ItIwq+R/rrzlefEVTx9sYkg5p9bGx
        +rd6BnHtlKKri1Ig+zLezss=
X-Google-Smtp-Source: ALg8bN7hJI84B2jJc/Xzb8Y9ANMnx2S/0tA8wHEFVPx9/IPXJrgzwTuz57uq8dCl5bMOQNIzuO3MVw==
X-Received: by 2002:a2e:3803:: with SMTP id f3-v6mr24073174lja.169.1546419580634;
        Wed, 02 Jan 2019 00:59:40 -0800 (PST)
Received: from localhost.localdomain (mm-79-4-214-37.mogilev.dynamic.pppoe.byfly.by. [37.214.4.79])
        by smtp.gmail.com with ESMTPSA id 10sm7489670ljr.4.2019.01.02.00.59.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 00:59:40 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Michal Hocko <mhocko@suse.com>, Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [RFC v3 1/3] vmalloc: export __vmalloc_node_range for CONFIG_TEST_VMALLOC_MODULE
Date:   Wed,  2 Jan 2019 09:59:22 +0100
Message-Id: <20190102085924.14145-2-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190102085924.14145-1-urezki@gmail.com>
References: <20190102085924.14145-1-urezki@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export __vmaloc_node_range() function if CONFIG_TEST_VMALLOC_MODULE is
enabled. Some test cases in vmalloc test suite module require and make
use of that function. Please note, that it is not supposed to be used
for other purposes.

We need it only for performance analysis, stressing and stability check
of vmalloc allocator.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index cfea25be7754..1f24aecd1d7e 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1764,6 +1764,15 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 	return NULL;
 }
 
+/*
+ * This is only for performance analysis of vmalloc and stress purpose.
+ * It is required by vmalloc test module, therefore do not use it other
+ * than that.
+ */
+#ifdef CONFIG_TEST_VMALLOC_MODULE
+EXPORT_SYMBOL_GPL(__vmalloc_node_range);
+#endif
+
 /**
  *	__vmalloc_node  -  allocate virtually contiguous memory
  *	@size:		allocation size
-- 
2.11.0

