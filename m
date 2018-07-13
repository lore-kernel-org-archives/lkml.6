Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F55ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 12:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 632C220871
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 12:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632C220871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbeGMMcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 08:32:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:50042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729646AbeGMMcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 08:32:31 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4361620871;
        Fri, 13 Jul 2018 12:18:05 +0000 (UTC)
Date:   Fri, 13 Jul 2018 08:18:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Francis Deslauriers <francis.deslauriers@efficios.com>,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: kprobes: Prohibit probing on notrace
 functions
Message-ID: <20180713081803.1b78ebbc@gandalf.local.home>
In-Reply-To: <20180713115301.532ab1484e8b0befd90782d0@kernel.org>
References: <1500044315-9508-3-git-send-email-francis.deslauriers@efficios.com>
        <1531418053-21414-1-git-send-email-francis.deslauriers@efficios.com>
        <1531418053-21414-2-git-send-email-francis.deslauriers@efficios.com>
        <20180713115301.532ab1484e8b0befd90782d0@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jul 2018 11:53:01 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Thu, 12 Jul 2018 13:54:12 -0400
> Francis Deslauriers <francis.deslauriers@efficios.com> wrote:
> 
> > From: Masami Hiramatsu <mhiramat@kernel.org>
> > 
> > Prohibit kprobe-events probing on notrace function.
> > Since probing on the notrace function can cause recursive
> > event call. In most case those are just skipped, but
> > in some case it falls into infinite recursive call.  
> 
> BTW, I'm considering to add an option to allow putting
> kprobes on notrace function - just for debugging 
> ftrace by kprobes. That is "developer only" option
> so generally it should be disabled, but for debugging
> the ftrace, we still need it. Or should I introduce
> another kprobes module for debugging it?

No, I think the former is better (to add an option to allow putting
kprobes on notrace functions). By default we let people protect
themselves. But if then provide a switch that lets you do things that
might let you shoot yourself in the foot.

BTW, I'm now leaving on vacation. I'll be back on the 23rd and will be
looking for patches that I should be pulling in then.

Thanks!

-- Steve
