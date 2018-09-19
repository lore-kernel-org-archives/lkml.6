Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BD8ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C727E206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="aWlxAVYg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C727E206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387442AbeITDpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:45:02 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37283 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387414AbeITDpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 23:45:00 -0400
Received: by mail-ed1-f67.google.com with SMTP id a20-v6so6176879edd.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 15:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IMH8w4N6Rz6yz8TMOvh/OtAwbVaZMnw1zT3c2bzn7Sc=;
        b=aWlxAVYgiR2QwVADaNxfnFl3wsNpGJHhyzYYS1OwsHJLm3f1f2ERQLmQ8uCfuVt5xD
         QxRvz6ZEsoBjHsG08xI1OpuwR+nJMxJanaiFviBA1XcLJ8fX+fH8OI+s4DPc5/C75C0C
         fCDe7wwCXa8YkzlD+78CZOgGSTecAGVt7Myus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IMH8w4N6Rz6yz8TMOvh/OtAwbVaZMnw1zT3c2bzn7Sc=;
        b=tCOQ0MkQTMZQnq0G3VPg4EmRZ+QLQoag3D1TEdaceOYXxH3waPujprH0zOAedm4wlD
         G+DYRPGK1jrMZqtm1BVy/lGRz8sTS2V35esmCNmjv393Fdewsk5i7b8t8Ge9g/rHjX1z
         0B8V7Xr8kSA98s5MZ8for0Py9Z+GujN37/RFOlY62yTE6PqiQSmh+qTOJDX4n9BRjS73
         dS1HtsROmqwaNZmP9PzDlpNhPeHLewuZXSAltEEZUFP+W5wPOsWu5jugBCpzTx9pJ62S
         jBCj+/bSI4GzPGvVWORp8S/CqgQLesfRx6TKJMANd1UqgpQnMIzGMTRRe9ltcloT+QHJ
         +IfA==
X-Gm-Message-State: APzg51Bm1a492xXgQ33JUGd1asAtHRnjiXPRqTxboxwzP7Lq3AkaGHEB
        EIlck5gw+4kDd79vk1rt2aDAgg==
X-Google-Smtp-Source: ANB0VdYm6JbYoelNxFpHIEfDAYRAHWTL9vIvpAnrWysepyeFwtAC/6Ph9K6QEaXaJvUrDC2PQLtIDQ==
X-Received: by 2002:a50:a705:: with SMTP id h5-v6mr61334377edc.162.1537394703059;
        Wed, 19 Sep 2018 15:05:03 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-115-161.cgn.ip.fibianet.dk. [5.186.115.161])
        by smtp.gmail.com with ESMTPSA id a9-v6sm2798edi.26.2018.09.19.15.05.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Sep 2018 15:05:02 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 11/22] dynamic_debug: move pr_err from module.c to ddebug_add_module
Date:   Thu, 20 Sep 2018 00:04:33 +0200
Message-Id: <20180919220444.23190-12-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serves two purposes: First, we get a diagnostic if (though
extremely unlikely), any of the calls of ddebug_add_module for built-in
code fails, effectively disabling dynamic_debug. Second, I want to make
struct _ddebug opaque, and avoid accessing any of its members outside
dynamic_debug.[ch].

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 kernel/module.c     | 4 +---
 lib/dynamic_debug.c | 4 +++-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 6746c85511fe..381f9bf282fe 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2716,9 +2716,7 @@ static void dynamic_debug_setup(struct module *mod, struct _ddebug *debug, unsig
 	if (!debug)
 		return;
 #ifdef CONFIG_DYNAMIC_DEBUG
-	if (ddebug_add_module(debug, num, mod->name))
-		pr_err("dynamic debug error adding module: %s\n",
-			debug->modname);
+	ddebug_add_module(debug, num, mod->name);
 #endif
 }
 
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index f1de45a100fa..e90459dca34b 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -849,8 +849,10 @@ int ddebug_add_module(struct _ddebug *tab, unsigned int n,
 	struct ddebug_table *dt;
 
 	dt = kzalloc(sizeof(*dt), GFP_KERNEL);
-	if (dt == NULL)
+	if (dt == NULL) {
+		pr_err("error adding module: %s\n", name);
 		return -ENOMEM;
+	}
 	/*
 	 * For built-in modules, name lives in .rodata and is
 	 * immortal. For loaded modules, name points at the name[]
-- 
2.16.4

