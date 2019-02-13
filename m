Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E880C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 00:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6E9222BE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 00:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732937AbfBMAmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 19:42:13 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37033 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727871AbfBMAmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 19:42:12 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5so299139plr.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 16:42:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nUkT8JDi8uCvqGDVTdXMWuA0QjMDOfamEfJ5EcIGqkw=;
        b=XmFwxB3rBi0XhlrsA2zv7p8J53ihqvjMYk56r2bZTj/YyvjwS1zOV6o5gwlZXJcjr4
         q0JX7CZkyrR9PFn55s65gHaY6bu/iyhtuyuuGe0QnjjrOLBFwzjd5F4rBirV5fuVrvwU
         uZ9AIHw7A+Sf0WqQuCsjSgPdQiEebhvdhN4lX2G1S//JPOY6cN1ccTSoRIRQNTTc6me6
         vX/0p1nQYNHCHEq83j1DlXATe6MIP1+/ai2E68w8Qx3TZtQJZpYvoIkPgGmI0yFfutZ8
         pUi7kPKVSo0At/Gb2t36SHRUBvhd+ta7pAXJOIIx5CV2+m7U+bJGLUhF9AfC6nd0xKdH
         8QPg==
X-Gm-Message-State: AHQUAuYeu02l0KS1PITzxDy3mdEt5Hb5dgEKxVWu5fIkaC1BsUVWYcqs
        0zOGZiBrKN7jn0gFyxK2AbreyfAa/zg=
X-Google-Smtp-Source: AHgI3IYPjBQkUpKXzQsxNves1/e9KI7YxiJSxcpM4kyAv7unKsFKT8gSGZQfEDZerN3GaSZcGH/afQ==
X-Received: by 2002:a17:902:2966:: with SMTP id g93mr6646171plb.11.1550018531215;
        Tue, 12 Feb 2019 16:42:11 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id n1sm31709119pfi.123.2019.02.12.16.42.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 16:42:09 -0800 (PST)
Message-ID: <1550018527.19311.43.camel@acm.org>
Subject: Re: [PATCH v5 07/15] locking/lockdep: Free lock classes that are no
 longer in use
From:   Bart Van Assche <bvanassche@acm.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Date:   Tue, 12 Feb 2019 16:42:07 -0800
In-Reply-To: <20190110152412.GG30894@hirez.programming.kicks-ass.net>
References: <20181217213002.73776-1-bvanassche@acm.org>
         <20181217213002.73776-8-bvanassche@acm.org>
         <20190110152412.GG30894@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-10 at 16:24 +-0100, Peter Zijlstra wrote:
+AD4 +AFs ... +AF0
+AD4 +AEAAQA -4579,17 +-4559,19 +AEAAQA static void lockdep+AF8-reset+AF8-lock+AF8-reg(struc
+AD4   +ACo-/
+AD4  static void lockdep+AF8-reset+AF8-lock+AF8-imm(struct lockdep+AF8-map +ACo-lock)
+AD4  +AHs
+AD4 -	struct pending+AF8-free +ACo-pf+ADs
+AD4  	unsigned long flags+ADs
+AD4 +-	LIST+AF8-HEAD(zapped)+ADs
+AD4  
+AD4 -	pf +AD0 get+AF8-pending+AF8-free+AF8-lock+AF8-imm(+ACY-flags)+ADs
+AD4 -	if (+ACE-pf)
+AD4 -		return+ADs
+AD4 -	+AF8AXw-lockdep+AF8-reset+AF8-lock(pf, lock)+ADs
+AD4 -	arch+AF8-spin+AF8-unlock(+ACY-lockdep+AF8-lock)+ADs
+AD4 -	raw+AF8-local+AF8-irq+AF8-restore(flags)+ADs
+AD4 +-	raw+AF8-local+AF8-irq+AF8-save(flags)+ADs
+AD4 +-	if (+ACE-graph+AF8-lock())
+AD4 +-		goto out+AF8-irq+ADs
+AD4 +-
+AD4 +-	+AF8AXw-lockdep+AF8-reset+AF8-lock(+ACY-zapped, lock)+ADs
+AD4 +-	+AF8AXw-free+AF8-zapped+AF8-classes(+ACY-zapped)+ADs
+AD4  
+AD4 -	free+AF8-zapped+AF8-classes(+ACY-pf-+AD4-rcu+AF8-head)+ADs
+AD4 +-	graph+AF8-unlock()+ADs
+AD4 +-out+AF8-irq:
+AD4 +-	raw+AF8-local+AF8-irq+AF8-restore(flags)+ADs
+AD4  +AH0

If graph+AF8-lock() is used inside lockdep+AF8-free+AF8-key+AF8-range+AF8-imm() and/or
lockdep+AF8-reset+AF8-lock+AF8-imm() instead of arch+AF8-spin+AF8-lock() then the self-tests fail.
Anyway, I will integrate this patch in my patch series.

Thanks,

Bart.
