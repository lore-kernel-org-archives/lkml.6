Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7200C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 14:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E0F52082E
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 14:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ve/3FBK6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E0F52082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbeKDXrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:47:55 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:34298 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbeKDXrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:47:55 -0500
Received: by mail-it1-f194.google.com with SMTP id t189-v6so5496200itf.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 06:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mTqncDFkWSPxrkfWfS+PVBK3VTvu8+moWor7mB98kcI=;
        b=Ve/3FBK6Ng6Bbx5p7qIhb/4gr4mLD8nSy4mk5U1020SQiyXTAx9/Gv0H0Pg84/8Kfn
         Wfy1pg7DnkJ1fhwiXLD58+NgI8eADdd6YuEvD+kU6sAFOzSTdA3X+9y682kZGUaRTRfM
         7n1/KhIRUspPVx1QW6Hh9q6IvizAukkkrdqAnkIppERmK3aFEdVqrvPLVp9qME6VtmG9
         OCAmEOLHsipbnbu3i19OlZpT8TZZkfICNqom3Sz4N3qG9HXNEq7tAa/VHuq+sBeCKyIq
         WmSIS9NMfbPzIv2ww4c+wgXu/s47NnEIXqtv2F9xj66v3hysgrm46IqudB3RcnSXiw25
         IP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mTqncDFkWSPxrkfWfS+PVBK3VTvu8+moWor7mB98kcI=;
        b=QQZ10w+eYo6qjzsqDvu8gYJfqXikJcBynzPKB2PJqNYtpp1YV/QtUgYszj8SAAQSJm
         rT3sVO6v8toWzC0scLeJO1GMoVsD6ELAQzMdn7scPSb3nk1FHWyLPcIEmrFiwrcyNfSw
         yEHkM8k3FSKUDxV1v9Q4n3aGWqRLGtJZ7df5VhRNWRjvzB11Ct9tzfALDv/u+AdMXkMG
         FLv80FMXzGndc6VmbFijHEM/s/oXOWgIj4yZhR5CpB4EL2C+eSAt+KQO331x4z9WLpms
         BQ0it7QvHD30thyCppO9QUKof0kGuIsrMExQXlPrT6ePwvgb2kZqLm7r6EKNdc6Yr21C
         HbrQ==
X-Gm-Message-State: AGRZ1gLzfd3VX4hj2Hn0MeZIAte41g6b1n989mksV8v3+3X063aDGBeY
        iY/Wshgs9/30W4hWU8/nXs/Z9nw4MHg3VipMyiF+LJoAE9uM/g==
X-Google-Smtp-Source: AJdET5e0UQClkd/dfVlpPfnhN4FdUVfva7ORlWcQJXfLhdAMXSZzi2PCOh1yXiCSjyZzoBYhg3hRL+t7rXujSLgjd7A=
X-Received: by 2002:a02:9b46:: with SMTP id g6-v6mr17208708jal.60.1541341961778;
 Sun, 04 Nov 2018 06:32:41 -0800 (PST)
MIME-Version: 1.0
References: <20181104023537.2626-1-tiny.windzz@gmail.com> <20181104090649.7c206915@vmware.local.home>
In-Reply-To: <20181104090649.7c206915@vmware.local.home>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sun, 4 Nov 2018 22:32:27 +0800
Message-ID: <CAEExFWuGZnz3hKCUNzr+Y2-uA0QCZLtTHM5bcLB1StLkMgxkRA@mail.gmail.com>
Subject: Re: [PATCH] tracing/fgraph: remove unnecessary unlikely()
To:     rostedt@goodmis.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for this place, I should consider this situation.
-- Yangtao

On Sun, Nov 4, 2018 at 10:06 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Sat,  3 Nov 2018 22:35:37 -0400
> Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> > WARN_ON() already contains an unlikely(), so it's not necessary to use
> > unlikely.
>
> NACK... see below.
>
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  kernel/trace/trace_functions_graph.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
> > index 169b3c44ee97..f8c2a08e4985 100644
> > --- a/kernel/trace/trace_functions_graph.c
> > +++ b/kernel/trace/trace_functions_graph.c
> > @@ -201,9 +201,8 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
> >       if (index < 0)
> >               index += FTRACE_NOTRACE_DEPTH;
> >
> > -     if (unlikely(index < 0 || index >= FTRACE_RETFUNC_DEPTH)) {
> > +     if (WARN_ON(index < 0 || index >= FTRACE_RETFUNC_DEPTH)) {
>
> When function graph is enabled, the printk from the warn on will likely
> be traced as well and trigger the same WARN_ON, which will again cause
> a recursion loop and crash and reboot the box with no output at all.
>
> >               ftrace_graph_stop();
>
> Notice that I call ftrace_graph_stop() *before* the WARN_ON(). This
> disables the ftrace graph tracer and prevents the recursion loop from
> happening.
>
> There's a reason that the WARN_ON() is placed where it is.
>
> But thanks for the report, it shows that I need to add a comment here
> so that someone else doesn't send a similar patch in the future.
>
> -- Steve
>
>
> > -             WARN_ON(1);
> >               /* Might as well panic, otherwise we have no where to go */
> >               *ret = (unsigned long)panic;
> >               return;
> > @@ -274,9 +273,8 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
> >        */
> >       ftrace_graph_return(&trace);
> >
> > -     if (unlikely(!ret)) {
> > +     if (WARN_ON(!ret)) {
> >               ftrace_graph_stop();
> > -             WARN_ON(1);
> >               /* Might as well panic. What else to do? */
> >               ret = (unsigned long)panic;
> >       }
>
