Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525C0C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B28A2177B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547132237;
	bh=c/qbdnKSZOdak4w2JWNqjRw6gFb+wYybIGhIdCnjS1I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=0YqADZOb0V4Qudl+Vg0x1KLbl0fV5QrmLk1VFLlMu8n0ZaRgEbEZQBg7WA4nahey+
	 82RWzGSksNTumGrHRqj1q93EIJSv7msK+PacERtySqXGEU1K0JpAbb2nLp7c82AuJk
	 t4nPwVzaeBuJglmPnGp5km9uLM8OjFi86sQX+p1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbfAJO5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:57:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:59310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728137AbfAJO5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 09:57:15 -0500
Received: from devnote (p7010-ipngnfx01kyoto.kyoto.ocn.ne.jp [114.179.123.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B7DF214DA;
        Thu, 10 Jan 2019 14:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547132234;
        bh=c/qbdnKSZOdak4w2JWNqjRw6gFb+wYybIGhIdCnjS1I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gh7hPP0kGsLvcbH1N3lq/u3cS9p/K32pr4D3KHj4AInnyE/DYEsSggtC5G/A2wQgO
         tGPJ9W1mx5oKKxMciDGxLTd/UiL2RcW6objSSX4dNNOIgyxnwocV5Mmd4o/egj2nFV
         coAc4r8PuRvBEgEs8BTbEnjF9Cl4T1eoTdZb11v0=
Date:   Thu, 10 Jan 2019 23:57:10 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Ingo Molnar <mingo@redhat.com>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/9] x86/kprobes: Prohibit probing on optprobe template
 code
Message-Id: <20190110235710.6b2a5cdb44ea05df73af997b@kernel.org>
In-Reply-To: <20190110060720.GA12546@kroah.com>
References: <154708884117.6325.4454464467156828009.stgit@devbox>
        <154708887054.6325.3201133039718891603.stgit@devbox>
        <20190110060720.GA12546@kroah.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019 07:07:20 +0100
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Thu, Jan 10, 2019 at 11:54:30AM +0900, Masami Hiramatsu wrote:
> > Prohibit probing on optprobe template code, since it is not
> > a code but a template instruction sequence. If we modify
> > this template, copied template must be broken.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Fixes: 9326638cbee2 ("kprobes, x86: Use NOKPROBE_SYMBOL() instead of __kprobes annotation")
> > ---
> >  arch/x86/kernel/kprobes/opt.c |    5 +++++
> >  1 file changed, 5 insertions(+)
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
> 
> </formletter>
> 
> Same for all patches in this series...

Oops, sorry. I'll fix the format again.
BTW, I'm still considering I should make it other patches in this series
as improvement instead of fix, since those are just adding blacklist, and
usually user can avoid it with KPROBE_EVENTS_ON_NOTRACE=n (which is default).

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
