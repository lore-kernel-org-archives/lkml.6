Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25749C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C741522408
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:06:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C741522408
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbeHJPfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 11:35:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727539AbeHJPfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 11:35:54 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67E942186B;
        Fri, 10 Aug 2018 13:06:03 +0000 (UTC)
Date:   Fri, 10 Aug 2018 09:06:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joelaf@google.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH ftrace/core] tracing: irqsoff: Account for additional
 preempt_disable
Message-ID: <20180810090601.32de3915@gandalf.local.home>
In-Reply-To: <CAJWu+opTKi5+LFRea1oim9-pPci13kH-Af65hQ+SjKtcazu+Bw@mail.gmail.com>
References: <20180806034049.67949-1-joel@joelfernandes.org>
        <20180806230536.ef217b2c2c008838606bedc3@kernel.org>
        <CAJWu+orzTpcjAcWRmgE8bLtK6BfzfQ_SW1WMho5Y-nsiACTCyQ@mail.gmail.com>
        <20180810215511.60d5882c8efd271c01043881@kernel.org>
        <CAJWu+opTKi5+LFRea1oim9-pPci13kH-Af65hQ+SjKtcazu+Bw@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Aug 2018 06:01:34 -0700
Joel Fernandes <joelaf@google.com> wrote:


> > Even though, it should be verified or atleast commented on the function header.  
> 
> Ok.  ftrace/core has been fixed since since so this patch is outdated
> and isn't needed any more, but I agree a separate patch doc comment
> would help make it clear about this fact. Both IRQ and preempt
> tracepoints work this way, they fire only within their critical
> section.

Note, I'm keeping the patch in the git history. As an artifact that can
be found easily when looking at this code for further enhancements.

Feel free to send a patch that adds comments to these callbacks.

-- Steve

