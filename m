Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5DFC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35D020846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B35D020846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732025AbeG0Ast (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 20:48:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731587AbeG0Ast (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 20:48:49 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10C64205F4;
        Thu, 26 Jul 2018 23:29:45 +0000 (UTC)
Date:   Thu, 26 Jul 2018 19:29:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Francis Deslauriers <francis.deslauriers@efficios.com>,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] selftest/ftrace: Move kprobe selftest function
 to separate compile unit
Message-ID: <20180726192943.2499a61d@gandalf.local.home>
In-Reply-To: <153258443533.11602.8446454305778389593.stgit@devbox>
References: <153258437722.11602.12405835083073480618.stgit@devbox>
        <153258443533.11602.8446454305778389593.stgit@devbox>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jul 2018 14:53:55 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> From: Francis Deslauriers <francis.deslauriers@efficios.com>
> 
> Move selftest function to its own compile unit so it can be compiled
> with the ftrace cflags (CC_FLAGS_FTRACE) allowing it to be probed
> during the ftrace startup tests.
> 
> Signed-off-by: Francis Deslauriers <francis.deslauriers@efficios.com>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Hi Masami,

Actually, since you are sending this as part of your patch queue, you
need to add your Signed-off-by here and not Acked-by. That means it has
gone through you.

I've applied the first patch already, just resend this one, where you
add you Signed-off-by instead of Acked-by.

Thanks!

-- Steve


> ---
>  kernel/trace/Makefile                |    5 +++++
>  kernel/trace/trace_kprobe.c          |   12 +-----------
>  kernel/trace/trace_kprobe_selftest.c |   10 ++++++++++
>  kernel/trace/trace_kprobe_selftest.h |    7 +++++++
>  4 files changed, 23 insertions(+), 11 deletions(-)
>  create mode 100644 kernel/trace/trace_kprobe_selftest.c
>  create mode 100644 kernel/trace/trace_kprobe_selftest.h
> 
