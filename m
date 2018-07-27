Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EB6C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F371F208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJXSBAVP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F371F208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730631AbeG0OBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 10:01:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:39648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729541AbeG0OBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 10:01:44 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC5122064D;
        Fri, 27 Jul 2018 12:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532695198;
        bh=1qKoEEzawp0g4OoNEuWg6LON48UvGft538GPqY6sn/Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AJXSBAVPdty2iSAjd66QCezMi8b89cfIlb+hIE7pWnJIzF3+UKQ98ZNt71a+C/f9P
         xiqGPb3XRUhPieLmqEvIdFq9DRtl75QCU0X1wF24/88uWTVuERf0pfEgIIdS5OAqAm
         r+CjuPbNsbRshUg1gM0ZJvbGWCHt3LBRliXNsOyg=
Date:   Fri, 27 Jul 2018 21:39:56 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Francis Deslauriers <francis.deslauriers@efficios.com>,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] selftest/ftrace: Move kprobe selftest function
 to separate compile unit
Message-Id: <20180727213956.f2a5509996cac359d1c3c80a@kernel.org>
In-Reply-To: <20180726192943.2499a61d@gandalf.local.home>
References: <153258437722.11602.12405835083073480618.stgit@devbox>
        <153258443533.11602.8446454305778389593.stgit@devbox>
        <20180726192943.2499a61d@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jul 2018 19:29:43 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 26 Jul 2018 14:53:55 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > From: Francis Deslauriers <francis.deslauriers@efficios.com>
> > 
> > Move selftest function to its own compile unit so it can be compiled
> > with the ftrace cflags (CC_FLAGS_FTRACE) allowing it to be probed
> > during the ftrace startup tests.
> > 
> > Signed-off-by: Francis Deslauriers <francis.deslauriers@efficios.com>
> > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Hi Masami,
> 
> Actually, since you are sending this as part of your patch queue, you
> need to add your Signed-off-by here and not Acked-by. That means it has
> gone through you.

Ah, I see.

> 
> I've applied the first patch already, just resend this one, where you
> add you Signed-off-by instead of Acked-by.

OK, I'll do that soon.

Thanks!

> 
> Thanks!
> 
> -- Steve
> 
> 
> > ---
> >  kernel/trace/Makefile                |    5 +++++
> >  kernel/trace/trace_kprobe.c          |   12 +-----------
> >  kernel/trace/trace_kprobe_selftest.c |   10 ++++++++++
> >  kernel/trace/trace_kprobe_selftest.h |    7 +++++++
> >  4 files changed, 23 insertions(+), 11 deletions(-)
> >  create mode 100644 kernel/trace/trace_kprobe_selftest.c
> >  create mode 100644 kernel/trace/trace_kprobe_selftest.h
> > 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
