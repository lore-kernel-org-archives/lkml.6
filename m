Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36ED8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050DC214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XXTxM/Sj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbfAJMxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:53:40 -0500
Received: from mail-it1-f172.google.com ([209.85.166.172]:39867 "EHLO
        mail-it1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbfAJMxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 07:53:40 -0500
Received: by mail-it1-f172.google.com with SMTP id a6so16047556itl.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 04:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6vbhcvdkLKlaMENn/NDZIlJAD2tULxVTuxTmq+ZrNMQ=;
        b=XXTxM/SjWPZYPCoAMHByfK6CPiyx5WLqzAKbaINFxoV5nV1Cmcv8koEYdbGC1/AljH
         a6ZgDQu+w2uCIkZMrt8rkNoA1qTqJwx1FfCGnCD8Dhn792Mrool1kg8Shf3z2Pu2Op/d
         S+TPvQM/xav3m4uv+U6AyfUrAC3R7GaNa7wEDF6Hn9NUdqHkfPI5AmneONCKW+LMsClC
         W321NJmFYgN/kWYzaM+oKxowVUFUeBonNiLIMu5Ghs6ySI9eC2/m8N+eN6PmoqQ2JNGZ
         XWMm8iwlf509t4r4B+LSrf8xRPvFtYDBl+sj9LH23nF+DkBLlXqtul2trocChSCW+n60
         qKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6vbhcvdkLKlaMENn/NDZIlJAD2tULxVTuxTmq+ZrNMQ=;
        b=lH+5vUZF1Si5Ut3oLxTGU9QEgiQIFA5z2pcFh5PBb0CAwXqKQkdfJ6+VBdnUxI+cFD
         RW8bqY2VJz9F4tnXxyBlZu6Ub+D2OBaWxF0Ii5STXn8jVfcawsThRPjnc48IA4d6JcB5
         z5Q0T+nKF4PEeMWAnT474uIn02JsrP7raUcpAcllzSiFrL0ESnnfyaRSX3S4xnUi1ING
         +EEJqBedC1ulUMP2NHKRcIYhD+kgtalkQnAsb5ao8RZOE0maAQFvNtmwGklx+LB0vD9C
         mm1Quy7K5whbOCwG+nI0L78IV+0AH4N5JXGRRclil0+Ll6GUIG+HN+UphXNUcxrya2zV
         L+FA==
X-Gm-Message-State: AJcUukfdjD92CBnSZTpacxVez4LK2nVqGkFY8IND79wzIywGcflPcJFE
        75fIUoz6VcmDFoNHlsE7yd3Xc+roiK0C2m607etdBQ==
X-Google-Smtp-Source: ALg8bN71pWbop/TizwUCneCSJ4y2eQ9vnbJEohuldjgY8pVWlC/dev1PTBy4SNK5w8i1ESgDrKIqpB97qZPFA1+4yww=
X-Received: by 2002:a02:ac8c:: with SMTP id x12mr6388633jan.72.1547124818948;
 Thu, 10 Jan 2019 04:53:38 -0800 (PST)
MIME-Version: 1.0
References: <CAOMFOmU=t9YbE68YpoQn0Ug0XN1F+0iuJp9J=htCRRrbdaPSVA@mail.gmail.com>
 <20190108223746.shuwx3ro7cgwz7hh@breakpoint.cc> <20190110124123.GA21224@hirez.programming.kicks-ass.net>
In-Reply-To: <20190110124123.GA21224@hirez.programming.kicks-ass.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 10 Jan 2019 13:53:28 +0100
Message-ID: <CACT4Y+YZ-bOFM_vHN5GiE5Yh=qqGjO_cgsJD4cnNyupOd6-A-Q@mail.gmail.com>
Subject: Re: seqcount usage in xt_replace_table()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Florian Westphal <fw@strlen.de>,
        Anatol Pomozov <anatol.pomozov@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 1:41 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jan 08, 2019 at 11:37:46PM +0100, Florian Westphal wrote:
> > Anatol Pomozov <anatol.pomozov@gmail.com> wrote:
> > > Or maybe xt_replace_table() can be enhanced? When I hear that
> > > something waits until an event happens on all CPUs I think about
> > > wait_event() function. Would it be better for xt_replace_table() to
> > > introduce an atomic counter that is decremented by CPUs, and the main
> > > CPU waits until the counter gets zero?
> >
> > That would mean placing an additional atomic op into the
> > iptables evaluation path (ipt_do_table and friends).
> >
>
> For:
>
>         /*
>          * Ensure contents of newinfo are visible before assigning to
>          * private.
>          */
>         smp_wmb();
>         table->private = newinfo;
>
> we have:
>
>         smp_store_release(&table->private, newinfo);
>
> But what store does that second smp_wmb() order against? The comment:
>
>         /* make sure all cpus see new ->private value */
>         smp_wmb();
>
> makes no sense what so ever, no smp_*() barrier can provide such
> guarantees.

Do we want WRITE_ONCE here then?
We want it to be compiled to an actual memory access and then it's up
to hardware to make it visible to other CPUs.
smp_wmb should most likely have this as a side effect too, but
somewhat indirect.
Also race-detector-friendly.


> > Only alternative I see that might work is synchronize_rcu (the
> > _do_table functions are called with rcu read lock held).
> >
> > I guess current scheme is cheaper though.
>
> Is performance a concern in this path? There is no comment justifying
> this 'creative' stuff.
>
