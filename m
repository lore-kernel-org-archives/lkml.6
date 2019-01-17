Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B865DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8AE2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547767724;
	bh=log21yoXAQNvP9PH7PgbzpBHk57E6ZQ+9WkfWsLjej0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ihe8VXqBh/UVYu9KkcK9gWgrNKCid3Yn6AIwRSdOQhaROLPp0bZWNqdQo0/HZI2xw
	 MdCN+tNCXMq33+x4sqrpDcpnsa4X+eTeK+K0dXaPlbaFH22Jhu5hMxIwZtSGWY4Kq9
	 tvW9Q8auP+Yobw0YeV2he9ucFUfgHdWlRO2hi7R0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfAQX2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 18:28:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:49310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726919AbfAQX2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 18:28:42 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DF1F20859;
        Thu, 17 Jan 2019 23:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547767721;
        bh=log21yoXAQNvP9PH7PgbzpBHk57E6ZQ+9WkfWsLjej0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XjgFsFnu90Cd6J7D66af2rnVK5KdAe5qxDfeS3/JjU7odEnwdBeoew5qIJM/2kRWo
         Hf9wqI0YfUO/+z8MbzNQpOTRTbR5p5rMG9mu8kyvwb8bkuevEcpsBLhUOyJaK6wEpq
         YDAUcbBaGQTHBF0gQLmLDUcypPWg6fktxWZgaAL8=
Date:   Fri, 18 Jan 2019 08:28:37 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andreas Ziegler <andreas.ziegler@fau.de>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: uprobes: fix typo in pr_fmt string
Message-Id: <20190118082837.6a4ff0668bf2d9e80846e454@kernel.org>
In-Reply-To: <20190117095316.303dafc2@vmware.local.home>
References: <20190117133023.19292-1-andreas.ziegler@fau.de>
        <20190117095316.303dafc2@vmware.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2019 09:53:16 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Masami,
> 
> Can you give an Acked-by?

Of course!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you Andreas!

> 
> Thanks!
> 
> -- Steve
> 
> 
> On Thu, 17 Jan 2019 14:30:23 +0100
> Andreas Ziegler <andreas.ziegler@fau.de> wrote:
> 
> > The subsystem-specific message prefix for uprobes was also
> > "trace_kprobe: " instead of "trace_uprobe: " as described in
> > the original commit message.
> > 
> > Fixes: 7257634135c24 ("tracing/probe: Show subsystem name in messages")
> > Signed-off-by: Andreas Ziegler <andreas.ziegler@fau.de>
> > ---
> >  kernel/trace/trace_uprobe.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> > index e335576b9411..19a1a8e19062 100644
> > --- a/kernel/trace/trace_uprobe.c
> > +++ b/kernel/trace/trace_uprobe.c
> > @@ -5,7 +5,7 @@
> >   * Copyright (C) IBM Corporation, 2010-2012
> >   * Author:	Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> >   */
> > -#define pr_fmt(fmt)	"trace_kprobe: " fmt
> > +#define pr_fmt(fmt)	"trace_uprobe: " fmt
> >  
> >  #include <linux/ctype.h>
> >  #include <linux/module.h>
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
