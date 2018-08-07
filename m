Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0933C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 00:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB3421A5D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 00:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nMDVCarc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CB3421A5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388025AbeHGCzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 22:55:01 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:41280 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733264AbeHGCzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 22:55:00 -0400
Received: by mail-yb0-f193.google.com with SMTP id q5-v6so2851434ybk.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 17:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CssHMhQnX4nuokqk36kmBZ7Cn6+uZ6BPziEHxT/eqps=;
        b=nMDVCarc1+05aH52IPL2Ol1BB98ZU1hXAV/ofRchW5xrpp88bqDRrEBsUrg689ybtC
         1cAlhoRFEU/WczWftKy9gjyJoU0iQTChe/ObpIvGKoo/fEvyN4sk6os9JIKu5fv94G2c
         9xGgixWLQY60iveKpbcTCJBo6Gj9LLKvEj5n2shymUX0DLuL02rBHj8iSZFzd7B6jZJb
         PhGFuDHiGsy98YVx1aOaRiRUdejYYP9jeY+qtkR2DvoMSVTdbK7yt5RjCqJcrjOsj6F3
         Dn0xnt6RdLuBW/eL0SppNtuhlj51v2rJ9yF/mWG6CPPQ9glBx6I5AKpKEBF0hRKG3/r6
         l8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CssHMhQnX4nuokqk36kmBZ7Cn6+uZ6BPziEHxT/eqps=;
        b=VPaouP03ZZVEr2/KCCIyDLlCrrMmL8M4Fo7p+S3Mks9tE2SpDZF46WwgBgFiZPjD5D
         XFKGd99p+hhlXDd1QYnZbE6mnc+XZ4PskjK9utWBJpsHFG5ZhDBR4nBPEbK1+o7Kxhm+
         6PPlagVjx7wZ2959wtm88t4FViJz8ngndov2ZAqgdsh4l9lBZ2A7mL5lwPKZgb9i75DC
         Va1V/bi8tOoYmXVav8dqVwIvlv0huzVDjG3ojFZLq80Pl5U6kNW9RGDbMxma16Gr5K9T
         oPC58OU8xi8O53RtEHuSRjvJ9zY0USZDGZBr1sZWPWYGArtiWSAmA2xFCxswqd+KZ7cc
         IrUA==
X-Gm-Message-State: AOUpUlHOcGibKhZ1QvuV/POHOSTFirMUsBb/16LmAM5oJQFEfkBzckZO
        kbKKdmo2Bo2xVps+YyuYtY9xE4Az1L98QaKDEnIPkmHvkyE=
X-Google-Smtp-Source: AAOMgpeLJ1TphPmgMSSwboTsATL6OrEhDdCrXkH4e1uOQIhzGlqsSjvukdO3afcGBwhNSmtD401bFJVtSnUOhbHvlcY=
X-Received: by 2002:a25:9185:: with SMTP id w5-v6mr8739591ybl.417.1533602599887;
 Mon, 06 Aug 2018 17:43:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:bfce:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 17:43:19 -0700 (PDT)
In-Reply-To: <20180806155058.5ee875f4@gandalf.local.home>
References: <20180730222423.196630-1-joel@joelfernandes.org>
 <20180730222423.196630-4-joel@joelfernandes.org> <20180806155058.5ee875f4@gandalf.local.home>
From:   Joel Fernandes <joelaf@google.com>
Date:   Mon, 6 Aug 2018 17:43:19 -0700
Message-ID: <CAJWu+oqvpev_EZC38_mi+UNRCxS8GqNVagHyGM4dUjruzKgwgQ@mail.gmail.com>
Subject: Re: [PATCH v12 3/3] tracing: Centralize preemptirq tracepoints and
 unify their usage
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 6, 2018 at 12:50 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> With this patch applied, I'm constantly getting lockdep errors. Instead
> of doing a full revert of the patch, I did this, which makes all those
> errors go away. I may apply this for now, and we can revisit having
> lockdep use the tracepoint code. But since it's currently always
> enabled, I'm thinking of just leaving this as is. The macros are still
> clean from Joel's patch.
>
> Thoughts?

I like your patch. Thanks a lot for doing this.. It keeps most of the
benefits of my patch while avoiding the issues with lockdep. I agree
we can look at the remaining lockdep issue after. There were several
lockdep issues with this patch that I fixed over the the months, but
there's still the one that Masami reported that I believe you're also
seeing. Once I'm back I'll work on figuring that one out.

Could you pull in the fixes to the other issues I posted though? With
that we should be good.
https://lore.kernel.org/patchwork/patch/971104/
https://lore.kernel.org/patchwork/patch/971829/

thanks,

- Joel
