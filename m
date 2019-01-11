Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881CCC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5094D2183F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216467;
	bh=7ct6IFvTvpHHRB+lDLFl7365LkRR7Zv0O54hCicmnoU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZOBNI/d0wJQdYrCD7OsJucdyLl0Gc0XAiahMzpTjy04+idg7o9uNQw5Szenpf0aHR
	 To1LdJzl01OVt5mmpxP1r6yw4QjXlPdWLq6FwdSpmPNZrbloTt9mzu++CO3Ui2Hjpc
	 7XnU+teCLiAuJnyG/L5ItjCXhPxYwhTaB0slK4KA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732520AbfAKOVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:21:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:39152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731427AbfAKOVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:21:04 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D12972177B;
        Fri, 11 Jan 2019 14:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216464;
        bh=7ct6IFvTvpHHRB+lDLFl7365LkRR7Zv0O54hCicmnoU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jmVc0UQeTIZEkw77dTvEpM0Xr4sDGZv/pl2KcVlog0y+TPEKT4/0gsyBLJON/Ky3n
         hNCGxYb5yl5jSa/erurEiwzMdlGGdjaklLD6ShqnnCvS7stYMWui+3VMIwUc14mqGq
         e9Naq2plC3xJBIfPVu4V4ISI1PfNx7+eszdyATIU=
Date:   Fri, 11 Jan 2019 23:21:01 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 6/9] kprobes: Prohibit probing on hardirq tracers
Message-Id: <20190111232101.572db64cd592c43f20efdf95@kernel.org>
In-Reply-To: <20190110121231.446b3396@gandalf.local.home>
References: <154708884117.6325.4454464467156828009.stgit@devbox>
        <154708901305.6325.18088274750877716004.stgit@devbox>
        <20190110121231.446b3396@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019 12:12:31 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 10 Jan 2019 11:56:53 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Since kprobes breakpoint handling involves hardirq tracer,
> > probing these functions cause breakpoint recursion problem.
> > 
> > Prohibit probing on those functions.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  kernel/trace/trace_irqsoff.c    |    9 +++++++--
> >  kernel/trace/trace_preemptirq.c |    5 +++++
> >  2 files changed, 12 insertions(+), 2 deletions(-)
> > 
> 
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Thank you for your Ack!

> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
