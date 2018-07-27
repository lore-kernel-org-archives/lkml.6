Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6312C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D701208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxxsJdRk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D701208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731071AbeG0ONw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 10:13:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:40300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729568AbeG0ONw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 10:13:52 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3535208AF;
        Fri, 27 Jul 2018 12:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532695924;
        bh=bOE96dyZLDaRRMQsfxTkd/KC3I4FnAk80+73Do25fro=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZxxsJdRkRnoYKEQcgG9CZsSYhQD9icvbqhmm+6UmjyNgUZPPhm/al9nS88OSOAOeQ
         4qtNjtHB+yi0DoYV5+JP36b9YIXM5Caf0IWttVFt7yTXkzeo5efKafyhkzOmdCG4ug
         SQSOvD1/ZDB3Box2TqFm3RQjAVtcMMPa2WRAwq7M=
Date:   Fri, 27 Jul 2018 21:52:02 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Artem Savkov <asavkov@redhat.com>
Subject: Re: [PATCH] tracing/kprobes: Simplify the logic of
 enable_trace_kprobe()
Message-Id: <20180727215202.0af90e09709f7699e033ef54@kernel.org>
In-Reply-To: <20180726164352.tctldcryo4fs3nap@treble>
References: <20180726121152.4dd54330@gandalf.local.home>
        <20180726164352.tctldcryo4fs3nap@treble>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jul 2018 11:43:52 -0500
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Thu, Jul 26, 2018 at 12:11:52PM -0400, Steven Rostedt wrote:
> > 
> > [ Note this is applied on top of the other patch to quiet gcc ]
> > 
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > 
> > The function enable_trace_kprobe() performs slightly differently if the file
> > parameter is passed in as NULL on non-NULL. Instead of checking file twice,
> > move the code between the two tests into a static inline helper function to
> > make the code easier to follow.
> > 
> > Link: http://lkml.kernel.org/r/20180725224728.7b1d5db2@vmware.local.home
> > 
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> The enable_probe() name is a bit confusing, since it's not clear what
> the difference is between enable_probe() and enable_trace_kprobe()
> without looking at the code.
> 
> Maybe call it __enable_trace_kprobe()?

+1, I this this is better.

With that function name change,

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> 
> Otherwise it's a definite improvement.
> 
> Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
> 
> -- 
> Josh


-- 
Masami Hiramatsu <mhiramat@kernel.org>
