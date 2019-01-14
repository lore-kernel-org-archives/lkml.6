Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563F0C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A0EF206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfANVeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 16:34:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:53632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbfANVeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 16:34:18 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FE2220659;
        Mon, 14 Jan 2019 21:34:17 +0000 (UTC)
Date:   Mon, 14 Jan 2019 16:34:15 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: annotate implicit fall through
Message-ID: <20190114163415.6245b939@gandalf.local.home>
In-Reply-To: <20190114203039.16535-1-malat@debian.org>
References: <20190114203039.16535-1-malat@debian.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2019 21:30:37 +0100
Mathieu Malaterre <malat@debian.org> wrote:

> There is a plan to build the kernel with -Wimplicit-fallthrough and
> this place in the code produced a warning (W=1).
> 
> This commit remove the following warning:
> 
>   kernel/trace/trace_probe.c:302:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

I'm pulling this in, but I'm changing the subject. Even when doing
clean ups, don't use the exact same subject for multiple patches, it
gets confusing when looking for a specific change.

Also, Linus prefers that a subject header starts with a capital letter.

 [PATCH 1/2] tracing: Annotate implicit fall through in parse_probe_arg()

-- Steve


> ---
>  kernel/trace/trace_probe.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 9962cb5da8ac..89da34b326e3 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -300,6 +300,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
>  
>  	case '+':	/* deref memory */
>  		arg++;	/* Skip '+', because kstrtol() rejects it. */
> +		/* fall through */
>  	case '-':
>  		tmp = strchr(arg, '(');
>  		if (!tmp)

