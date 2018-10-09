Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26F1C67879
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 01:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E9521476
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 01:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04E9521476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbeJIIvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 04:51:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbeJIIvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 04:51:50 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC3B92075E;
        Tue,  9 Oct 2018 01:37:19 +0000 (UTC)
Date:   Mon, 8 Oct 2018 21:37:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Helsley <mhelsley@vmware.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>
Subject: Re: [POC][RFC][PATCH 0/2 v2] PROOF OF CONCEPT: Dynamic Functions
 (jump functions)
Message-ID: <20181008213717.07c59434@vmware.local.home>
In-Reply-To: <20181006120125.376880240@goodmis.org>
References: <20181006120125.376880240@goodmis.org>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 06 Oct 2018 08:01:25 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> [ Sending v2 because I updated quilt and it added back that stupid
>   "Content-Disposition: inline; filename=$patch" line, messing up
>   how the patches look in gmail. This should be better. ]
> 

Actually, this wasn't suppose to go out. I started to resend this, and
had my quilt send mail going, and I stopped at the "edit prologue"
where I wrote all this.

But then I postponed it to fix up the code a bit more, and in the mean
time, Peter, et. al. replied, and I figured we go down a different
path. But I forgot that I had the quilt mail opened. I came back to the
window with it up, thought it was just some text file I haven't saved
yet, typed ":wq" and then saw the "sendmail" message pop out. Oops!

This also explains why the date is set to Oct 6 (that's when I started
the quilt send mail).

Feel free to ignore this :-)

-- Steve
