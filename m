Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5B5ECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494E02124D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494E02124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732607AbeGLUmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 16:42:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:58854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732431AbeGLUmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 16:42:50 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D13020871;
        Thu, 12 Jul 2018 20:31:37 +0000 (UTC)
Date:   Thu, 12 Jul 2018 16:31:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v9 4/7] tracepoint: Make rcuidle tracepoint callers use
 SRCU
Message-ID: <20180712163135.22075cd4@gandalf.local.home>
In-Reply-To: <CAEXW_YSxxEXF5knSDXsq=dTkZjtw_Qr1voo0A3qqW+KN8LKcMQ@mail.gmail.com>
References: <20180628182149.226164-1-joel@joelfernandes.org>
        <20180628182149.226164-5-joel@joelfernandes.org>
        <20180711124954.GE2476@hirez.programming.kicks-ass.net>
        <20180711090003.42596c2b@gandalf.local.home>
        <20180711142744.GN3593@linux.vnet.ibm.com>
        <20180711104618.05dc4b46@gandalf.local.home>
        <20180711205249.GA32091@joelaf.mtv.corp.google.com>
        <20180711232120.5dbfa1c7@vmware.local.home>
        <20180712042825.GA154647@joelaf.mtv.corp.google.com>
        <20180712093512.1f612a24@gandalf.local.home>
        <20180712191701.GA107829@joelaf.mtv.corp.google.com>
        <20180712161538.0737ba7f@gandalf.local.home>
        <CAEXW_YSxxEXF5knSDXsq=dTkZjtw_Qr1voo0A3qqW+KN8LKcMQ@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jul 2018 13:29:32 -0700
Joel Fernandes <joel@joelfernandes.org> wrote:

> Also the kselftest patches were acked and can be taken independently,
> I had reposted them as a separate 2 patch series with some minor
> changes based on your suggestions. Could you check them?
>

Yep, I saw them. I was going to wait till these patches were sent, but
since they are agnostic, I'll look at them now. Thanks for letting me
know.

-- Steve
