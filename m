Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A9EC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 13:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C469E20854
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 13:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwRGzsZH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbfALNd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 08:33:28 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42786 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfALNd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 08:33:28 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so18045773wrx.9
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 05:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0kkqdieB9f9WIkareRlSWbiL/GmmZStikR5DwhXP05o=;
        b=QwRGzsZHE701NxD1+8fxFHYhDkoPaBWBYDudxdHvIaKKfczTKoZ9TukMI/NXyfzsbb
         x4E5Pr6Q9hZYvDUSZnW+995X4zDTCVcDboW8WSomEu0zm3MLl0+EUEIwxVvjkM8g4iyL
         yGFx3grkWpDAjwfLqnAd753xkMeLZ2GQkN3yPhB9aFdKgFTzGugicfdJ833VF0l4Vf2V
         f3fOB34R+xvH+SAmvtG5ttGI8IiwEP3cVrPQcbAOs3c92fvo5T3Xhji3y6NPyPhvgjm6
         JM5Syh+jDef8zE1pTp/mmzPQQj3x7gON1q4HnbcvWRLHSCBeoTWSC/WZ6Cbrw3RO9XX/
         GtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0kkqdieB9f9WIkareRlSWbiL/GmmZStikR5DwhXP05o=;
        b=n9+Hq2ZlzybEBKseWu2N+Sp/byHYcvVPYUSz/q9SQyX2zXb9hPUpvJLdDpTm7eglV0
         zNRxJmVJl3U91G0VIkQap7xp3LK/vILvorfmcGa4nKdfWVaP7sbDRPRAJ0JgWEM52ZoH
         nJ3AjinY9ubfQcezCfPhyL80VCtqvtnWezBSJHIvksGBS1arj0nzEIJgeenwrrSg+3//
         ALPf+xp5EJElXFtmA3rBQk9hOfHASDaI5awNYMG3q7PkJ+Ou/4FQaHLw7mLKWXTdgDJl
         jhAD2mZljhbB/e/BgfUVV2adFbY53Q53QEHUpi2A0QdzqNW46W0n6NGK9e6umwSUbqnN
         LJYA==
X-Gm-Message-State: AJcUukeeYNl0CVfNfnxc3bCo1R15BiO+YTWIp8vQFSJXW9ZoRr60wqer
        cCTXdg1IMrdTuMKaXDuuJY1eao0=
X-Google-Smtp-Source: ALg8bN51MUNEH5mQOxn5SRGcMallpUzBz23kqreFsTcslzf5nltff/7dAcJQYavCb9aK7FdObv0Hfw==
X-Received: by 2002:adf:8323:: with SMTP id 32mr16845865wrd.176.1547300006537;
        Sat, 12 Jan 2019 05:33:26 -0800 (PST)
Received: from localhost (host89-130-dynamic.43-79-r.retail.telecomitalia.it. [79.43.130.89])
        by smtp.gmail.com with ESMTPSA id y13sm50483368wrw.85.2019.01.12.05.33.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 12 Jan 2019 05:33:25 -0800 (PST)
Date:   Sat, 12 Jan 2019 14:33:24 +0100
From:   Andrea Righi <righi.andrea@gmail.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 0/9] kprobes: Fix and improve blacklist symbols
Message-ID: <20190112133324.GA2009@xps-13>
References: <154725993986.18060.2759150647140353514.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154725993986.18060.2759150647140353514.stgit@devbox>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 11:25:40AM +0900, Masami Hiramatsu wrote:
...
> And I found several functions which must be blacklisted.
>  - optprobe template code, which is just a template code and
>    never be executed. Moreover, since it can be copied and
>    reused, if we probe it, it modifies the template code and
>    can cause a crash. ([1/9][2/9])
>  - functions which is called before kprobe_int3_handler()
>    handles kprobes. This can cause a breakpoint recursion. ([3/9])
>  - IRQ entry text, which should not be probed since register/pagetable
>    status has not been stable at that point. ([4/9])
>  - Suffixed symbols, like .constprop, .part etc. Those suffixed
>    symbols never be blacklisted even if the non-suffixed version
>    has been blacklisted. ([5/9])
>  - hardirq tracer also works before int3 handling. ([6/9])
>  - preempt_check debug function also is involved in int3 handling.
>    ([7/9])
>  - RCU debug routine is also called before kprobe_int3_handler().
>    ([8/9])
>  - Some lockdep functions are also involved in int3 handling.
>    ([9/9])
> 
> Of course there still may be some functions which can be called
> by configuration change, I'll continue to test it.

Hi Masami,

I think I've found another recursion problem. Could you include also
this one?

Thanks,

From: Andrea Righi <righi.andrea@gmail.com>
Subject: [PATCH] kprobes: prohibit probing on bsearch()

Since kprobe breakpoing handler is using bsearch(), probing on this
routine can cause recursive breakpoint problem.

int3
 ->do_int3()
   ->ftrace_int3_handler()
     ->ftrace_location()
       ->ftrace_location_range()
         ->bsearch() -> int3

Prohibit probing on bsearch().

Signed-off-by: Andrea Righi <righi.andrea@gmail.com>
---
 lib/bsearch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bsearch.c b/lib/bsearch.c
index 18b445b010c3..82512fe7b33c 100644
--- a/lib/bsearch.c
+++ b/lib/bsearch.c
@@ -11,6 +11,7 @@
 
 #include <linux/export.h>
 #include <linux/bsearch.h>
+#include <linux/kprobes.h>
 
 /*
  * bsearch - binary search an array of elements
@@ -53,3 +54,4 @@ void *bsearch(const void *key, const void *base, size_t num, size_t size,
 	return NULL;
 }
 EXPORT_SYMBOL(bsearch);
+NOKPROBE_SYMBOL(bsearch);
-- 
2.17.1

