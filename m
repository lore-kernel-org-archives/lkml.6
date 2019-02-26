Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21884C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 05:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0CC12173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 05:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xk3xGW2b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfBZFk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 00:40:28 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:42185 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfBZFk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 00:40:27 -0500
Received: by mail-io1-f68.google.com with SMTP id p196so9532871iod.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 21:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bIKVYbyUVD0x9jdnyL5+5v/G/5aUpgYhlC/5rQZY9dI=;
        b=Xk3xGW2bqs+MwP5/OcRg0YjG9YK6BLHu1KzjWW9S0qmW7NMxGSExR/Kxrg9HIevQ6g
         kY8uVzwwSOeom37T8+lBvj8V4Cmm1+zqbAUyZ+/L4iFZwCnTCgjNNiY3Gj6v+K+LwFTN
         wqfnsg6Ab+sDGisUbqN+Aw/FslwU29H4SfDJOnq1sMOnpy3tWwY5U9DRuznQG7exZKss
         QG3txwqor0aEb6S4xbgJj8ccQ0O/Wdtk/EPN7qnlTMhdBmGbjN799O44fBw/yI+GbrQ8
         u+hZcW0iDPfh0wJPdmFOG+wCvIyrv99j71kS+E0xMKOEy1g2d6J91YpHGfjf39+8QD24
         Z9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bIKVYbyUVD0x9jdnyL5+5v/G/5aUpgYhlC/5rQZY9dI=;
        b=W2sWXJAKJd5sdEAD/KBRrlo7cM0rQpQkBd8Q/cu65s6L8ogtIfuK0kIwDTS6NvaokD
         HJCyOmRGFHpBIEmDzg7faKcJDE1nYu3YMJprBNTJBefpwbZJvBh+FdIObzbKuhFRwTNG
         u9Dy4UB7VgRJT++0U/MCZ1M8YP+4DES5xBqPGQTeeFtvlh0mnJ4jiFOh3sI6EilcmYWX
         35BmLkoBtDG20J3ikBkH24r4HuckYRGgIEqoMsMp3gR6o+1FRKufKMUE0Y+oEvhZX/iX
         WHKQiPmMcLfYcpxIRt9yWbsW5OWahCWrQ3O5E8TbJuG0fFRf5D0D896NzJPLs7KVWFgx
         8IuA==
X-Gm-Message-State: APjAAAUTeseUaSuuoqiGeCtZMoo1+VifEJ+3KTcxooYCJanHETjfyZXt
        tVWUhMGJkLtFuKPqepufg7ZV7jNCVxFM+RUdgA==
X-Google-Smtp-Source: AHgI3IYmVN0LcCx7sA2wfEjGjxoRPGcF9q1sVEiceCmzWHXRkjjxMmrkI1iTdBUJuPNPILwfnxsyWEMd8bKC6uNA8lc=
X-Received: by 2002:a6b:640d:: with SMTP id t13mr5456944iog.102.1551159626677;
 Mon, 25 Feb 2019 21:40:26 -0800 (PST)
MIME-Version: 1.0
References: <1551011649-30103-1-git-send-email-kernelfans@gmail.com>
 <1551011649-30103-4-git-send-email-kernelfans@gmail.com> <8f703c5f-44c7-3a96-487e-3bdf46ee41b0@intel.com>
In-Reply-To: <8f703c5f-44c7-3a96-487e-3bdf46ee41b0@intel.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Tue, 26 Feb 2019 13:40:15 +0800
Message-ID: <CAFgQCTsOqnBdiFHbFVRsjbPkMuV+egUU7RZ-OoXRLndwJAFjoA@mail.gmail.com>
Subject: Re: [PATCH 3/6] x86/numa: define numa_init_array() conditional on CONFIG_NUMA
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Daniel Vacek <neelx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 11:24 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 2/24/19 4:34 AM, Pingfan Liu wrote:
> > +#ifdef CONFIG_NUMA
> >  /*
> >   * There are unfortunately some poorly designed mainboards around that
> >   * only connect memory to a single CPU. This breaks the 1:1 cpu->node
> > @@ -618,6 +619,9 @@ static void __init numa_init_array(void)
> >               rr = next_node_in(rr, node_online_map);
> >       }
> >  }
> > +#else
> > +static void __init numa_init_array(void) {}
> > +#endif
>
> What functional effect does this #ifdef have?
>
> Let's look at the code:
>
> > static void __init numa_init_array(void)
> > {
> >         int rr, i;
> >
> >         rr = first_node(node_online_map);
> >         for (i = 0; i < nr_cpu_ids; i++) {
> >                 if (early_cpu_to_node(i) != NUMA_NO_NODE)
> >                         continue;
> >                 numa_set_node(i, rr);
> >                 rr = next_node_in(rr, node_online_map);
> >         }
> > }
>
> and "play compiler" for a bit.
>
> The first iteration will see early_cpu_to_node(i)==1 because:
>
> static inline int early_cpu_to_node(int cpu)
> {
>         return 0;
> }
>
> if CONFIG_NUMA=n.
>
> In other words, I'm not sure this patch does *anything*.

I had thought separating [3/6] and [4/6] can ease the review. And I
will merge them in next version.

Thanks and regards,
Pingfan
