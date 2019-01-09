Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94CAC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1D420821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="f50Ynldt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbfAIHpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 02:45:43 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:38148 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfAIHpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 02:45:42 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 305909CB
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jan 2019 07:45:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XPrMUnAaYr_r for <linux-kernel@vger.kernel.org>;
        Wed,  9 Jan 2019 01:45:41 -0600 (CST)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 0401B9C5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jan 2019 01:45:40 -0600 (CST)
Received: by mail-it1-f200.google.com with SMTP id 123so6408904itv.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 23:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6RqttAT5X6DxeRBBZADc9RbMYc+xtLZbn2qcRfY/qik=;
        b=f50Ynldt2Ks579uo3WLEPqCutINF4g+51AxC5RF6kaxfyv0qFITYKRR5r7kRevyWXe
         oNBbrQiSXMbT8vEts6CBkPkdlAk7wBCvN/dVYycsYMF/HfQzltArTamOWwta2KpjTc/F
         fXX9OSLW70BC3vSmf4X43BMDiuj9D7lLX38ASTgj7/EocnEk+F7dhpe7kghvBfIPEaN+
         /X1j0Lu0RMcliCE5TiTZNgwLToi4VfeIjB9SlT+fq6xDXNxumVfJwe5bfktsLFlNgVD+
         5ZM3P9s2KH8c+k1b/MJJz3YA5DJ0ZexsBKjIQKAvUaLLKM5tbztcmMbaA+nl6Zlb0xkB
         YVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6RqttAT5X6DxeRBBZADc9RbMYc+xtLZbn2qcRfY/qik=;
        b=C2BmnCDJgx+mYa8rKLNrPVWkijwGjkDAl0XwoUFjGdjCKynSLzmKaXXPcSWhJdfsJv
         48E8bAND/iW3ixIKZNzVk8J1FiD8cOWWMsV/mBggZTca+r2fy7PlhCWbtMjAvGumUeZG
         8WTrtOUku0ktXsy330vFg+EpPZGFfdQ2tTzc7Ow0ovQvvkk0aGLz6tJtHPzfWsclClVL
         C0PAz56YScGLH6U7ghX9eTKqWWe/ZfJnmmZkknIdrCYtADRh+Hopjigz40MmWwjwGLoy
         avhyTZCbd4wB7n/SjA6D0CIk8Lhy1JKz8en3rtXVCQmsatdvrqqMG4WbpysX4FPNdOhz
         7Lag==
X-Gm-Message-State: AJcUukeuWZIsW8rhCTGeDKOThaggjoricO2M3nLhFiRvEXcNJOXLaClp
        vVH68ViNau6w28CwzlbU0wBtKjJLQVKPx9yl387k5yPjDEzah0kRNI8ps9buAB+XF+K+h2pN1Sw
        vn6qt2l+rkE90SVYdJAjiLselM7nr
X-Received: by 2002:a5e:991a:: with SMTP id t26mr3168272ioj.253.1547019940380;
        Tue, 08 Jan 2019 23:45:40 -0800 (PST)
X-Google-Smtp-Source: ALg8bN6VQCOMYv2QfJhS2OmpHEDQt+I0z6wa2kvr5F2TE3ueiw+SW4TR10eN6NM/3w3C4xhWUb4wrw==
X-Received: by 2002:a5e:991a:: with SMTP id t26mr3168261ioj.253.1547019940145;
        Tue, 08 Jan 2019 23:45:40 -0800 (PST)
Received: from bee.cs.umn.edu (cs-bee0u.cs.umn.edu. [134.84.121.28])
        by smtp.gmail.com with ESMTPSA id w24sm20649660ioc.11.2019.01.08.23.45.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 23:45:39 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] sched: fix a potential double-fetch bug in sched_copy_attr
Date:   Wed,  9 Jan 2019 01:45:24 -0600
Message-Id: <20190109074524.10176-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190107171101.GI14122@hirez.programming.kicks-ass.net>
References: <20190107171101.GI14122@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"uattr->size" is copied in from user space and checked. However, it is
copied in again after the security check. A malicious user may race to
change it. The fix sets uattr->size to be the checked size.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 kernel/sched/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6fedf3a98581..e868cc25ac2a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4499,6 +4499,9 @@ static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *a
 	if (ret)
 		return -EFAULT;
 
+	/* In case attr->size was changed in the user space */
+	attr->size = size;
+
 	/*
 	 * XXX: Do we want to be lenient like existing syscalls; or do we want
 	 * to be strict and return an error on out-of-bounds values?
-- 
2.17.1

