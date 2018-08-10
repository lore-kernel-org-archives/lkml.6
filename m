Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15649C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 12:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B122822408
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 12:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="J/KCZ1eL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B122822408
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbeHJOuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 10:50:02 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:46019 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbeHJOuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 10:50:02 -0400
Received: by mail-qt0-f193.google.com with SMTP id y5-v6so9938849qti.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 05:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QPGPxcfF/VjDANwqgLmR5xLlYxS85zF2uG9sq1OWSss=;
        b=J/KCZ1eLw49KUTJy8XsoENCaguwcVbbR4Q/X+yCYH8x6HtAVlQBnKKjoAY5d2d7op+
         DhY6iiyF4VB8IunMy0mkvlWGFBi0ZT4lizbisKamQWL49Zwoj1nO7noNyDkDEliXo2nN
         WZi47O6MVRS5wedjTn3E0FvmCaYKIMpUcblc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QPGPxcfF/VjDANwqgLmR5xLlYxS85zF2uG9sq1OWSss=;
        b=WFt1CNoqxkGNYFIZLog8lISlsiO1/5XVEyVtoEOE5EkhQLRNadH1hZAEhbJSqsM83v
         GnN+6BOp4pPOJIz1R3kz4k3CfxIwdh8AcY3dZ2ov66TLMdKzV5VVeZefMVXIq9TpJ52K
         8A5r2WozCA7Ec8jLe7NYvsJH62fL/uNnFKyPTjelHysIA4bBQqFfekSwlinhtUv730o5
         /8aNZUtTWg9yGQ0u2W3rMOEAlCVTlzq5EwEYSVh5ZEfkI5kD2RVNPENuI4iEnRecIVAL
         vDqvtRG1gi0mwFm7n0BkMc4aFZBVCFh2ESwggu4aPKFzlHtn0CREmRURi4soWrm2qBzH
         AIoQ==
X-Gm-Message-State: AOUpUlGzFsS1/FgxlsQcAaJezH5xSOnanznMMmN7XaZ23jk7CWjgLihV
        OO06HI+CbguwQXiSKxu2m96/eai/2wZ3uqOhuLRtNw==
X-Google-Smtp-Source: AA+uWPwdBKf0YZWjdetm8gMnpFnoMlqfQV6R3mDPiHKeCn1LH5hDWnXDEMUyWljmAF//eWyJcrQAXdP7ovnoV5o4WOU=
X-Received: by 2002:aed:3bba:: with SMTP id r55-v6mr5920737qte.304.1533903620212;
 Fri, 10 Aug 2018 05:20:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:3442:0:0:0:0:0 with HTTP; Fri, 10 Aug 2018 05:20:19
 -0700 (PDT)
In-Reply-To: <20180809210654.346880034@goodmis.org>
References: <20180809210333.588854137@goodmis.org> <20180809210654.346880034@goodmis.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 10 Aug 2018 05:20:19 -0700
Message-ID: <CAEXW_YS5MEpAtdy5sMfPZEDtTeANyMD4=qMsbzHPiKampgqOXg@mail.gmail.com>
Subject: Re: [for-next][PATCH 1/6] tracing: Partial revert of "tracing:
 Centralize preemptirq tracepoints and unify their usage"
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joelaf@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 9, 2018 at 2:03 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
>
> Joel Fernandes created a nice patch that cleaned up the duplicate hooks used
> by lockdep and irqsoff latency tracer. It made both use tracepoints. But it
> caused lockdep to trigger several false positives. We have not figured out
> why yet, but removing lockdep from using the trace event hooks and just call
> its helper functions directly (like it use to), makes the problem go away.
>
> This is a partial revert of the clean up patch c3bc8fd637a9 ("tracing:
> Centralize preemptirq tracepoints and unify their usage") that adds direct
> calls for lockdep, but also keeps most of the clean up done to get rid of
> the horrible preprocessor if statements.
>
> Link: http://lkml.kernel.org/r/20180806155058.5ee875f4@gandalf.local.home
>
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Fixes: c3bc8fd637a9 ("tracing: Centralize preemptirq tracepoints and unify their usage")

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

- Joel

> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  include/linux/irqflags.h        |  8 ++++++--
>  include/linux/lockdep.h         |  2 --
>  init/main.c                     |  2 --
>  kernel/locking/lockdep.c        | 14 ++-----------
>  kernel/trace/trace_preemptirq.c | 36 ++++++++++++++++++---------------
>  5 files changed, 28 insertions(+), 34 deletions(-)
>
> diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
