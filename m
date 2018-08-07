Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE49C4646D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 01:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D08621A71
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 01:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D08621A71
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387487AbeHGDy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 23:54:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729786AbeHGDy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 23:54:56 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DF6821A6A;
        Tue,  7 Aug 2018 01:43:02 +0000 (UTC)
Date:   Mon, 6 Aug 2018 21:43:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joelaf@google.com>
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
Subject: Re: [PATCH v12 3/3] tracing: Centralize preemptirq tracepoints and
 unify their usage
Message-ID: <20180806214300.13e63523@gandalf.local.home>
In-Reply-To: <CAJWu+oqvpev_EZC38_mi+UNRCxS8GqNVagHyGM4dUjruzKgwgQ@mail.gmail.com>
References: <20180730222423.196630-1-joel@joelfernandes.org>
        <20180730222423.196630-4-joel@joelfernandes.org>
        <20180806155058.5ee875f4@gandalf.local.home>
        <CAJWu+oqvpev_EZC38_mi+UNRCxS8GqNVagHyGM4dUjruzKgwgQ@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Aug 2018 17:43:19 -0700
Joel Fernandes <joelaf@google.com> wrote:

> On Mon, Aug 6, 2018 at 12:50 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > With this patch applied, I'm constantly getting lockdep errors. Instead
> > of doing a full revert of the patch, I did this, which makes all those
> > errors go away. I may apply this for now, and we can revisit having
> > lockdep use the tracepoint code. But since it's currently always
> > enabled, I'm thinking of just leaving this as is. The macros are still
> > clean from Joel's patch.
> >
> > Thoughts?  
> 
> I like your patch. Thanks a lot for doing this.. It keeps most of the
> benefits of my patch while avoiding the issues with lockdep. I agree
> we can look at the remaining lockdep issue after. There were several
> lockdep issues with this patch that I fixed over the the months, but
> there's still the one that Masami reported that I believe you're also
> seeing. Once I'm back I'll work on figuring that one out.
> 
> Could you pull in the fixes to the other issues I posted though? With
> that we should be good.
> https://lore.kernel.org/patchwork/patch/971104/
> https://lore.kernel.org/patchwork/patch/971829/
>

I already had these applied when I created this patch ;-)

Thanks, I'll add it.

-- Steve
