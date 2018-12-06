Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF65DC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BF921479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="KHgU5odY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95BF921479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbeLFTVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:21:04 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38782 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbeLFTVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:21:03 -0500
Received: by mail-pl1-f194.google.com with SMTP id e5so615034plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 11:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rSaC9SU7NUaenLJEgGrswjOsUz6t3vRpatML8fByTlw=;
        b=KHgU5odYFw+qbiHlw7MuLqOS54Yf+Y1iZD9SoKPZQ0BYoC5CPqdIoTLH8O7+AoTlHk
         KPSH1vZVOa5FzbKUd5VjgPd9xDlMEwem0N1Ovp/y4yFBxuBFmITvRTd5rf9Dp1ElXn80
         Cg5VvHxroWc5v2s7GQAWmdo0KIok2AIG2C7gkjE0hOnta8ovSw261FkJgp9ZEUAZzL0O
         ifuEZHHPmQfq8cKGS5Y6+f9HOOHSK2A3HnLztcg/0iO2khr0eEahgaWFiBWwQg5kmKfn
         u5U+VCIfaMNi/8n94N2kJ/mzU4KrHho894owtwaO8yFfkfaxhWF9dpu64iTZ0P+Zl8Pt
         9Q2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rSaC9SU7NUaenLJEgGrswjOsUz6t3vRpatML8fByTlw=;
        b=c3AWjcstS2kewD270oRBxleHD8FJDuFVO+XemLGEN/zy9B7wxuHSWAb9UswvMqUEsY
         oBzJ4CrvY/vnVSjSv2oTY/M2iHiUZnjj4kXpIPqZi8Ez9p8AiS9JlEL9bM/MstQuTKq2
         pNO5yTBUpd9bvmeBVIereoVQV7Qqr8vAp40fiDgUjIlNjUNIKudnkAl37i3TGb0Q6SnX
         Cjl2SDGCSUKtC6Py196zidME+fyUBGMHxnlEFRSspzA45T46TXVERmLoMYjifa05Qlca
         HpJL9oFPv1m2J/riNYaa6mtIXhg7REXPg/PCpj1SkJOeSxbCWPh/ce3QZReeLUWNKopM
         lOGQ==
X-Gm-Message-State: AA+aEWYzkhJECUvwg/M56Qj0A7HEnfoZcKdmvjJWDSXdvdirD81FI28z
        70KvvrtVwzz2yLtFVZrRnDPQGg==
X-Google-Smtp-Source: AFSGD/XW0EacISQ0ly2bYPQ6Rnkb3PqegQr3A5dF+VgFQoE9ZA2YPi5wPyVaJ2KaGpd6rWhJfwUMgA==
X-Received: by 2002:a17:902:b40d:: with SMTP id x13mr30002325plr.237.1544124062854;
        Thu, 06 Dec 2018 11:21:02 -0800 (PST)
Received: from cisco ([128.107.241.180])
        by smtp.gmail.com with ESMTPSA id 125sm1939817pfx.159.2018.12.06.11.21.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 11:21:02 -0800 (PST)
Date:   Thu, 6 Dec 2018 12:20:59 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: siginfo pid not populated from ptrace?
Message-ID: <20181206192059.GD10086@cisco>
References: <20181112192443.GL3645@cisco>
 <20181127232126.GA23658@cisco>
 <CAGXu5jLw0m8pG16u3huThNM2fYGjKoB2-5baUmg_FH6Z=L2SAg@mail.gmail.com>
 <CAGXu5jJaZAOzP1qFz66tYrtbuywqb+UN2SOA1VLHpCCOiYvYeg@mail.gmail.com>
 <87zhtthkuy.fsf@xmission.com>
 <CAGXu5jJv+TG8hovHi3Z5kTccz+Cx-keu=KZf032mCz2VRpc=Og@mail.gmail.com>
 <87k1ktqoe5.fsf@xmission.com>
 <CAGXu5jJgFrWajK5m8ev72DV9ueznLnbGV2-UGECnz0iZ_EFDUg@mail.gmail.com>
 <87r2euiuql.fsf@xmission.com>
 <CAHk-=wjTzjOqEhWJskx7ToHL2d1KUxsNOZ2V0=v_R6VJYtOm7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjTzjOqEhWJskx7ToHL2d1KUxsNOZ2V0=v_R6VJYtOm7Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 10:48:39AM -0800, Linus Torvalds wrote:
> On Thu, Dec 6, 2018 at 6:40 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >
> > We have in the past had ptrace users that weren't just about debugging
> > so I don't know that it is fair to just dismiss it as debugging
> > infrastructure.
> 
> Absolutely.
> 
> Some uses are more than just debug. People occasionally use ptrace
> because it's the only way to do what they want, so you'll find people
> who do it for sandboxing, for example. It's not necessarily designed
> for that, or particularly fast or well-suited for it, but I've
> definitely seen it used that way.
> 
> So I don't think the behavioral test breakage like this is necessarily
> a huge deal, and until some "real use" actually shows that it cares it
> might be something we dismiss as "just test", but it very much has the
> potential to hit real uses.
> 
> The fact that a behavioral test broke is definitely interesting.
> 
> And maybe some of the siginfo allocations could depend on whether the
> signal is actually ever caught or not.
> 
> For example, a terminal signal (or one that is ignored) might not need
> siginfo. But if the process is ptraced, maybe that terminal signal
> isn't actually terminal? So we might have situations where we want to
> simply check "is the signal target being ptraced"..

Yes, something like this, I suppose? It works for me.

Tycho


From 3bcaadd56ebb532ab4d481556fcc0826d65efc43 Mon Sep 17 00:00:00 2001
From: Tycho Andersen <tycho@tycho.ws>
Date: Thu, 6 Dec 2018 12:15:22 -0700
Subject: [PATCH] signal: allocate siginfo when a traced task gets SIGSTOP

Tracers can view SIGSTOP:

https://lore.kernel.org/lkml/87zhtthkuy.fsf@xmission.com/T/#u

so let's allocate a siginfo for SIGSTOP when a task is traced.

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
---
 kernel/signal.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 9a32bc2088c9..ab4ba00119f4 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1056,11 +1056,14 @@ static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struc
 		goto ret;
 
 	result = TRACE_SIGNAL_DELIVERED;
+
 	/*
-	 * Skip useless siginfo allocation for SIGKILL SIGSTOP,
-	 * and kernel threads.
+	 * Skip useless siginfo allocation for SIGKILL and kernel threads.
+	 * SIGSTOP is visible to tracers, so only skip allocation when the task
+	 * is not traced.
 	 */
-	if (sig_kernel_only(sig) || (t->flags & PF_KTHREAD))
+	if ((sig == SIGKILL) || (!task_is_traced(t) && sig == SIGSTOP) ||
+	    (t->flags & PF_KTHREAD))
 		goto out_set;
 
 	/*
-- 
2.19.1

