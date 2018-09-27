Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0117C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8560A2159D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkK8ojG7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8560A2159D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbeI0RGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:06:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:53270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727062AbeI0RGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 13:06:42 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3179421571;
        Thu, 27 Sep 2018 10:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538045342;
        bh=36Ae7fnWr8P6TcMb3Z45Ig+ZYhAi7jaNqNSW2vwPIVI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bkK8ojG7x/mvg2gausALnQrNKi5H4yxb5pLSvQrAnFyaicq544gIkJMzBaehYscGD
         0ci1F6v8yjUxh+XTQKHFkfck0zDzbw+HBvNjvKpIMtv5lTw5wM2gMNSoBvgWaLpqQW
         NdBJlCoK+zATDl79RzlZXOnE+2pU3U4+Mt/L1N/E=
Date:   Thu, 27 Sep 2018 19:48:58 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [ftrace/kprobes PATCH 0/3] tracing: probeevent: Fix module
 symbol probing
Message-Id: <20180927194858.7419c4ee4821f3985d3b0918@kernel.org>
In-Reply-To: <153547303754.26502.5265242979168613920.stgit@devbox>
References: <153547303754.26502.5265242979168613920.stgit@devbox>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Steve,

Could you also include this series to the branch?

Thank you,

On Wed, 29 Aug 2018 01:17:18 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi,
> 
> This series is for fixing some bugs in Steve's ftrace/kprobes branch.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
> 
> Which is based on my fetcharg improvement series.
> 
> https://lkml.org/lkml/2018/4/25/601
> 
> This includes following fixes.
> 
> - Fix copy_from_user() misusing which Dan was reported.
> - Fix to reject incorrect probeevent on loaded kernel module.
> - Fix to update symbol-based argument on module.
>   This also checks the symbol-based argument is correct or not when
>   target module is loaded. If it is not correct, the event is kept
>   unavailable.
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (3):
>       tracing/uprobes: Fix to return -EFAULT if copy_from_user failed
>       tracing/kprobes: Check the probe on unloaded module correctly
>       tracing/kprobes: Allow kprobe-events to record module symbol
> 
> 
>  kernel/trace/trace_kprobe.c |   51 ++++++++++++++++++++++++++---------
>  kernel/trace/trace_probe.c  |   62 +++++++++++++++++++++++++++++++++++++------
>  kernel/trace/trace_probe.h  |    4 ++-
>  kernel/trace/trace_uprobe.c |    2 +
>  4 files changed, 95 insertions(+), 24 deletions(-)
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
