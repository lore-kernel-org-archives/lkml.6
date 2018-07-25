Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C740BC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700BC20671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="OyI/Csku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 700BC20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730965AbeGYVgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 17:36:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34408 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730536AbeGYVgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 17:36:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id y5-v6so6026021pgv.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 13:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nAABX7W6PQGGU6ZsqFpQQ8x5ujIgnZZlTVmnLpKI244=;
        b=OyI/CskuF9BCWXcsrVrJgX5+XInuoEEF4rINIkXYfVZCIOCmThGsnvFiwjyrC1f+4E
         zY17jBuK45s5URzJIxskmQ3hh+fAh/ClZSJXv49MbrdoWNDf7PFYvsgJOWZiW36iIpIu
         Nztj2yAL9fhH/6MmePrMB/bNgf+bLzvMaV4Ng5Go7orPZL39XlIU7990U0l5aO5ZZnAY
         NqaAgG+Qxqo65j7hnCC3Zww0pznnAwhTrjzXYy3lt1xfOm3G2AmOIpDjRRrkp+iatSKu
         IzUuw0346mdB8XZAQ5iwxcpgxIQ3lMk9pVD9CXQdqi4D/UGBmzuAu1ETvMIa3xkm4iPz
         p1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nAABX7W6PQGGU6ZsqFpQQ8x5ujIgnZZlTVmnLpKI244=;
        b=j1N8QNA7v3Lt+kUvK3ACqprA8Gnd52kT8ZAtppd22RQ37NC6SBBucEsaiRbdcBt0Nf
         npuzTbz9Cy0WEd3YyoIUJtL7xgYDgDgmDM26DUy1VcchtqB6Yf09qrqHc6aj6Y6hIEZD
         356nqz/lBuvxJNEU3yPNu4ETj8HB3QtYcrwHBjalOMMAq8JMxH0UvyFkLp50NThjQx9s
         e2ze456W+NX031EPjIaXglgIH2j1TvFweiL+anyD+4+Io0syspcMjdmJhp5NGzbosG0k
         sWZYhrp6lFPtVKgbTFgmuZfn4f7CG6YOHthBc4HIjIoTwkibpLMhZElZUYGYKsmhV/CE
         MkeA==
X-Gm-Message-State: AOUpUlFJOBPwSc4fYp3TToK/UO7b0x/Y60mR/hByU42ZG8XC2L9LSZ+/
        2JgJ32vCYXPfB1JiRtTYYLWuh8tf/m8=
X-Google-Smtp-Source: AAOMgpd1WMo3qAdyIHmGOn1gns4AvY6WCcv4mgf5sat4qAGRKprhi/yVF+xro1UaPam0dfbUilmHMw==
X-Received: by 2002:a63:6849:: with SMTP id d70-v6mr21332490pgc.7.1532550187347;
        Wed, 25 Jul 2018 13:23:07 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1611:8fc3:703d:7635:5997])
        by smtp.gmail.com with ESMTPSA id q25-v6sm31155574pfk.96.2018.07.25.13.23.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 13:23:06 -0700 (PDT)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, kernel-team@android.com,
        stable@vger.kernel.org
Subject: [PATCH] tracing: do not leak kernel addresses
Date:   Wed, 25 Jul 2018 13:22:36 -0700
Message-Id: <20180725202238.165314-1-salyzyn@android.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Desaulniers <ndesaulniers@google.com>

Switch from 0x%lx to 0x%pK to print the kernel addresses.

Fixes: CVE-2017-0630
Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: <kernel-team@android.com>
Cc: <stable@vger.kernel.org> # 3.18, 4.4, 4.9, 4.14
Cc: <linux-kernel@vger.kernel.org>

---
 kernel/trace/trace_printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_printk.c b/kernel/trace/trace_printk.c
index ad1d6164e946..93698023baf1 100644
--- a/kernel/trace/trace_printk.c
+++ b/kernel/trace/trace_printk.c
@@ -304,7 +304,7 @@ static int t_show(struct seq_file *m, void *v)
 	if (!*fmt)
 		return 0;
 
-	seq_printf(m, "0x%lx : \"", *(unsigned long *)fmt);
+	seq_printf(m, "0x%pK : \"", *(unsigned long *)fmt);
 
 	/*
 	 * Tabs and new lines need to be converted.
-- 
2.18.0.233.g985f88cf7e-goog

