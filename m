Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D6CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06590214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WykBnvyU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbfAJMyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:54:55 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:33178 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbfAJMyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 07:54:54 -0500
Received: by mail-it1-f194.google.com with SMTP id m8so15378245itk.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 04:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2cdP6/5Fqkqmb0tNkcbxeH7uHn1xjS+3ysDd2FphhiY=;
        b=WykBnvyUpG+/YoQVXAUZNJ3UjQECtxlhiDVgDTLwoz6dP13hcKmlAgVOzN0VQCJZGQ
         IWyg4/bDtZ+cUuchzsvdV6LyEBlwE0fvVCZ0UoU+Y0qhlVFaGceAc6Da7oT0gNQBfrZa
         3bjqOoKKE3/GZQoGI91BeGWHV7jDReiam4xcpEOy1HzhisMG2WhlitCStLiFF9jUTlmk
         veiPymm0Ne0CD3ussP7wB93D2N3RYv716bLOHg6acEutOohZpuaQBnJZ+FSuw0Lv06X/
         FUziqYsxRosnHfchlkB1AuEZqXjJ/VMQ5Xkbox/4v9PmXicm33FStE4lkac+gwIEAJ/2
         9SUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2cdP6/5Fqkqmb0tNkcbxeH7uHn1xjS+3ysDd2FphhiY=;
        b=XI0quOYkgMmgXF3DBpCys61ERumsxttJaIZSVa12wLjQqh02ugWc1oCouNJa/04RQ/
         L11HJxhml2hqW4+dDOVmmi43RxbLFBBpIzCvje8Eus/eqe9fkR7B/TZWrlgmES2taJX6
         JrbzrbMhj+9wAZAXifQ7cGPT8lJYahodjglEnpzbH+jYcpT4rE1MM877IxzG5TLpyuUY
         iXlboofKhgsJIrZB6Raiog/JMUlSsolyPtEalwYbE0wlGlihTWam0qP3ggYdTI1Tm1eQ
         5wybDp2A/8/SHIASuPT9+PLKOIsX+Pcb6UYJnQFA5SSYvfLU2pYRPHWs8kClzmukO1uv
         cU8g==
X-Gm-Message-State: AJcUukffctyrgPjzkT/3itj4TjXGg9RHWvtqI4Arc15aa/UUkQTdhz6I
        qrOMZPpAPdM4OxrP5XwD0VQ33muS6Ag9rs3FzUFhJw==
X-Google-Smtp-Source: ALg8bN6Yf/PkqLeZox61Ys8x8XmyppSbAj9kzxjwpz1QjxsX+4luwLYloSF7q3AmBFLKqIZpuVkvPTlEsRiRC0bGopg=
X-Received: by 2002:a24:6511:: with SMTP id u17mr7094767itb.12.1547124892666;
 Thu, 10 Jan 2019 04:54:52 -0800 (PST)
MIME-Version: 1.0
References: <CAOMFOmU=t9YbE68YpoQn0Ug0XN1F+0iuJp9J=htCRRrbdaPSVA@mail.gmail.com>
 <20190110124427.GB21224@hirez.programming.kicks-ass.net>
In-Reply-To: <20190110124427.GB21224@hirez.programming.kicks-ass.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 10 Jan 2019 13:54:41 +0100
Message-ID: <CACT4Y+Zr3J=uawBhFVbsbds0p0nteS_SJQMybvMZ7Gcw6TTqmw@mail.gmail.com>
Subject: Re: seqcount usage in xt_replace_table()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Anatol Pomozov <anatol.pomozov@gmail.com>,
        Florian Westphal <fw@strlen.de>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 1:44 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jan 08, 2019 at 11:33:39AM -0800, Anatol Pomozov wrote:
> > Hello folks,
> >
> > A bit of context what I am doing. I am trying to port KTSAN (Kernel
> > Thread Sanitizer) tool to v4.20. That tool tracks shared data usage
> > and makes sure it is accessed in a thread-safe manner.
> >
> > seqlock is a synchronization primitive used by Linux kernel. KTSAN
> > annotates read_seqbegin()/read_seqretry() and tracks what data been
> > accessed in its critical section.
> >
> > During KTSAN port I found and interesting seqcount usage introduced in
> > commit 80055dab5de0c8677bc148c4717ddfc753a9148e
> >
> > If I read this commit correctly xt_replace_table() does not use
> > seqlock in a canonical way to specify a critical section. Instead the
> > code reads the counter and waits until it gets to a specific value.
>
> (gets away from)
>
> > Now I want KTSAN to play with this code nicely. I need to tell KTSAN
> > something like "this raw_read_seqcount() does not start a critical
> > section, just ignore it". So temporary I introduced
> > raw_read_seqcount_nocritical() function that is ignored by KTSAN. Is
> > it a good solution?
>
> This code is special enough to just do: READ_ONCE(->sequence) and be
> done with it. It doesn't need the smp_rmb() or anything else.

Sounds good to me.
From KTSAN perspective it then should work without any additional
dance, it's always good when code works as-is.
