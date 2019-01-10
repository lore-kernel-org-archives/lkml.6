Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C16C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A2D52173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547100445;
	bh=WVKaTr39B1xRHqjpIIP2ImnsSCoM7wBmu5pieY5woLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TRrlBuVMB+QUrW4133zesbYNdvvGJxea8i7FIKguRagNrI0/3RgKIQbfWgweRCot7
	 5ByDTBM/mZ3GB874eqEt3uREGCJmXAhoYCFJ8LfG58L3vPCh+Ct3nyx65+F/UhDzVu
	 fqAdI34p53PxfiBGIifoUFsTkDHGsZNdYMAPCMHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfAJGHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 01:07:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:58418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfAJGHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 01:07:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C86A21738;
        Thu, 10 Jan 2019 06:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547100443;
        bh=WVKaTr39B1xRHqjpIIP2ImnsSCoM7wBmu5pieY5woLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WOpPYrnNoM9kOPJS+/Xn2DKgNkleTZakhXz74RqGN+ejAPsQGQ0n6WKADnPEbPahN
         6cEYR4fMAy6+z6bsuZpbug/oLWVK3VGB8pXyZbKjM1LCnOqNLP8GUZJIsun0iU4FcC
         sXQxerIxu5rdhqYI0qQnV+osn5lhYiPiHqTgtPbQ=
Date:   Thu, 10 Jan 2019 07:07:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/9] x86/kprobes: Prohibit probing on optprobe template
 code
Message-ID: <20190110060720.GA12546@kroah.com>
References: <154708884117.6325.4454464467156828009.stgit@devbox>
 <154708887054.6325.3201133039718891603.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154708887054.6325.3201133039718891603.stgit@devbox>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 11:54:30AM +0900, Masami Hiramatsu wrote:
> Prohibit probing on optprobe template code, since it is not
> a code but a template instruction sequence. If we modify
> this template, copied template must be broken.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Fixes: 9326638cbee2 ("kprobes, x86: Use NOKPROBE_SYMBOL() instead of __kprobes annotation")
> ---
>  arch/x86/kernel/kprobes/opt.c |    5 +++++
>  1 file changed, 5 insertions(+)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

Same for all patches in this series...
