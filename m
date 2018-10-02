Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1952BC64EB5
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 02:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3FC8208AE
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 02:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/zzUTTo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3FC8208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbeJBJUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 05:20:02 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41949 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeJBJUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 05:20:01 -0400
Received: by mail-io1-f68.google.com with SMTP id q4-v6so590781iob.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 19:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BPastX5rxgolCsxo1cZqs/8RTdInA/A4IVQNI1iEWho=;
        b=R/zzUTTo6d3MGVRUCJkaEfKvtAm1IJncakiS+Yz5NsHzw+3xYqERCScs4TmLiCWTPD
         +2V9/IHtvnBgISEnULbTezwD6Wu/dy4CLiXQ2J6v5N0FVAhPbqQFG7/AIxnHAq0/DU4W
         QcLpJL308ow0xKeelx5vFZq7ZcI0uuQVcqvOfpPxJOmQkeoZocITzNTue7fgVFlsVNdH
         9SQQoKsRufdDNY0CAeayD8T/Lqna0Gs2qFMCqTJhzExwRI+XMSSm6WHSfUitMDNz6/Ol
         YKGHyH2wwkI27Qwyht8OVHk+3/Wk+K1/yku4mFI4gHQbsBUeOhpq/97x2Ped0350VcXG
         9Y9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BPastX5rxgolCsxo1cZqs/8RTdInA/A4IVQNI1iEWho=;
        b=DFnQ1Y1AWL2ANcV5V9QVdo/A8GQcHfdCoPDfIXLM88wdp2BzbTGNAG/rfctZKzaknK
         bkjlgnWNzxrTx1feWG9mxbgZHD5sUd4hTeTKyk0W1pQD1BZvY5P5AEZJBJcWJjrNi02h
         jeVFXOTiK7v+ayz+RA61nxx8Buv0aKx5UQqLa1po0+Rh8wRoa8B8NMNNjTQBoLUYocfC
         ypKr9tZQ9xT1SqECOlcnPV5NiiKjoYoglL6ICVFs0/2ojYYnih4CWlruZffRTmY5fgOz
         H/XseAqAZ95gEdGoslJVdHTZ+FidTun0LPrVONEMm5ju+ZlPS5fVkdcy7veVXloJDNux
         d/RA==
X-Gm-Message-State: ABuFfoilxLtsyh13bwbIM/rMc2XYJk1AMxEH7Xp2/EGeek/5qIn/lFbG
        hd5rmBeg3DsExt0ptguNPPM=
X-Google-Smtp-Source: ACcGV62c6epA9k4d0Ra6G1XWWwxXk184jdXz/ocPQlGCPYE1Wwzdmc+YsE78+WuojGO3a9nawAPtUA==
X-Received: by 2002:a62:6d02:: with SMTP id i2-v6mr14436880pfc.218.1538447948938;
        Mon, 01 Oct 2018 19:39:08 -0700 (PDT)
Received: from localhost.localdomain ([39.7.19.27])
        by smtp.gmail.com with ESMTPSA id v83-v6sm35902744pfa.103.2018.10.01.19.39.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 19:39:07 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [RFC][PATCH 3/3] printk: do not preliminary split up cont buffer
Date:   Tue,  2 Oct 2018 11:38:36 +0900
Message-Id: <20181002023836.4487-4-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002023836.4487-1-sergey.senozhatsky@gmail.com>
References: <20181002023836.4487-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a proper 'overflow' check which tells us that we need to
split up existing cont buffer in separate records:

	if (cont.len + len > sizeof(cont.buf))
		cont_flush();

At the same time we also have one extra flush: "if cont buffer is
80% full then split it up" in cont_add():

	if (cont.len > (sizeof(cont.buf) * 80) / 100)
		cont_flush();

This looks to be redundant, since the existing "overflow" check
should work just fine, so remove this 80% check and wait for either
a normal cont termination \n, for preliminary flush due to
possible buffer overflow or for preliminary flush due to cont race.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 kernel/printk/printk.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index aea37b7927dd..1856db8128c6 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1822,9 +1822,6 @@ static bool cont_add(int facility, int level, enum log_flags flags, const char *
 		cont_flush();
 	}
 
-	if (cont.len > (sizeof(cont.buf) * 80) / 100)
-		cont_flush();
-
 	return true;
 }
 
-- 
2.19.0

