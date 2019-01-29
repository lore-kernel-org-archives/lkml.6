Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC957C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C092C2080F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J+vXHO/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfA2Sbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:31:53 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45187 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728818AbfA2Sbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:31:53 -0500
Received: by mail-wr1-f66.google.com with SMTP id t6so23186284wrr.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 10:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0m3skRRv8gGXarJnQx7v/9n5i4k4SmQKxcZwANz4wvY=;
        b=J+vXHO/cVQyn/1ZJqpK6skQGqPQVpUQSFTHNxOQ/z+6XxcF12Z91kemu2Nn9BKNMUz
         VP2EBsuvQUqdG6OJx/S2GiAKnWo+P7aQJs+XX8IYSA27JNRhIyd5zPGOuA4KgMsq7Kee
         QiadlZ0vaoAxeOniQYEFw+UqJTxEOOafgjs+b2yXFkK417Qtr48IV6RG7VIffB2j+Njb
         c7cVImBJqH3RrxBu4gbUXHt5GgzGTblW6m3mg+uCtQfvUNk0vGUqQKmZ3QJ8lvIbM0cH
         QoErGjgId+U39N2tUYBt2csNLu2AJeqjLyj3WU/Qlx6fW9iBFyqFB9iWtV5dL84G55L8
         HcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0m3skRRv8gGXarJnQx7v/9n5i4k4SmQKxcZwANz4wvY=;
        b=pFprfKmjgwMAGrlyqy/ilLQwnH6RnFtJftbt6Fspl3CRkojue0+XlmyGQRA1OBv+v0
         pfgtB+k0npr1idVUgyNWQdFfxQlduPMit7Yc7UDhguzEILYDiJKwRAKe5uuvR68gv4t8
         oyzZHvMINWv9aA7nG90LEht0KHCe0WYE/KquO5ZV7nCsyZiJnjG78J+VZSHua8CcwFJ3
         mBqS185Yb5g6s3aQujXnMoagWjInSTg7/opGTUB+lb/IZ/Sp3K6SfMILmwuD1RESdwZw
         lBmj99c1TALfldA0SuUO0zjbelVQTXtlJWutJgSRco2rDE7giHzJqxhGAHkLtb0U9wh3
         GIYQ==
X-Gm-Message-State: AHQUAuaB5EaxiW7KSeG8esI8qPE0DM55nz+1q/l8vz0/RrXsojDC4TvR
        O11IU2RLcFkEMCFQlvhfiazqqdKnzmz91eP1vfIytw==
X-Google-Smtp-Source: AHgI3Ibx6/OVbETdDnoEV80C1606vDQP1T/8S7POacnT0d0ekLrAVuNZHS4p8b+VSew2Gru4p8xK+9b8kamEI0pS2KE=
X-Received: by 2002:adf:dc4e:: with SMTP id m14mr7291068wrj.107.1548786711280;
 Tue, 29 Jan 2019 10:31:51 -0800 (PST)
MIME-Version: 1.0
References: <20190124211518.244221-1-surenb@google.com> <20190124211518.244221-6-surenb@google.com>
 <20190129123843.GK28467@hirez.programming.kicks-ass.net> <CAJuCfpGxtGHsow002nd8Ao8mo9MaZQqZau_NLTMrZ8=aypTkig@mail.gmail.com>
In-Reply-To: <CAJuCfpGxtGHsow002nd8Ao8mo9MaZQqZau_NLTMrZ8=aypTkig@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 29 Jan 2019 10:31:40 -0800
Message-ID: <CAJuCfpHdtY7cRBfVP-+e9hQrTigStj2XK_qpk8z91HSKW+Y5WA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] psi: introduce psi monitor
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, lizefan@huawei.com,
        Johannes Weiner <hannes@cmpxchg.org>, axboe@kernel.dk,
        dennis@kernel.org, Dennis Zhou <dennisszhou@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 10:18 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Tue, Jan 29, 2019 at 4:38 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Jan 24, 2019 at 01:15:18PM -0800, Suren Baghdasaryan wrote:
> > > +                     atomic_set(&group->polling, polling);
> > > +                     /*
> > > +                      * Memory barrier is needed to order group->polling
> > > +                      * write before times[] read in collect_percpu_times()
> > > +                      */
> > > +                     smp_mb__after_atomic();
> >
> > That's broken, smp_mb__{before,after}_atomic() can only be used on
> > atomic RmW operations, something atomic_set() is _not_.
>
> Oh, I didn't realize that. After reading the following example from
> atomic_ops.txt I was under impression that smp_mb__after_atomic()
> would make changes done by atomic_set() visible:
>
> /* All memory operations before this call will
> * be globally visible before the clear_bit().
> */
> smp_mb__before_atomic();
> clear_bit( ... );
> /* The clear_bit() will be visible before all
> * subsequent memory operations.
> */
> smp_mb__after_atomic();
>
> but I'm probably missing something. Is there a more detailed
> description of these rules anywhere else?

I was referred to memory-barriers.txt that explains this clearly
stating that "These functions do not imply memory barriers.". Thanks
for noticing! Will change to smp_mb().

> Meanwhile I'll change smp_mb__after_atomic() into smp_mb(). Would that
> fix the ordering?
>
> > --
> > You received this message because you are subscribed to the Google Groups "kernel-team" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> >
