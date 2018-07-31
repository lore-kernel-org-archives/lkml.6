Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9158C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1454E20844
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Byu7vC6b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1454E20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbeGaTOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 15:14:12 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:55653 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729580AbeGaTOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 15:14:12 -0400
Received: by mail-it0-f66.google.com with SMTP id p7-v6so5627237itf.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 10:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y1BnrtqVG/s28YgDNCfZ28RW59JM/ZDS0R3VqqeJLt8=;
        b=Byu7vC6bpS1kqBjTxluAR+SVN7KiD8TrA8F65lOG/AIYXmPJTyYpxqdQlBTmtW7Omi
         7fXjSTneNj6+4T1AShb6eA53kKWnqRRA7i4bXcqjL21vtdM0qd3jpLONw4SZQuxPaY9t
         7zVDxjXJXNgMVs4aiMu+ZIBK1I+DrMlS6XbCxtB0/MumzCEntMKqu9ON4l371jWrFoiq
         XvB8Dmj0yq5Mrr6YOEGMaNLrLhM9klXOTmSLjQhccUUbsLCoJYuDhw+iMehmGC9xon4R
         pdjSSxAyGGJ3+FmMzmpG35PH1kY+bEHrTjlGaojb9BsI7HvhpfLJ9g3fyO2MpSJY7/7u
         53aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y1BnrtqVG/s28YgDNCfZ28RW59JM/ZDS0R3VqqeJLt8=;
        b=inxPgi9smR9dweDswTPWfE2yLHLLNvRtlPEWXUOmuu9gdxmawn4hVYabwDvCFiOfzW
         Lq4YR3xAe4fI9agifEk8uNxgMDPOtCOTKo2pkrHmeCOJcSleuwttOrMSLNOikoWBOugX
         uf6SbxCo9EKifapy3QMCNag8TQRNySsrAX+yQu0F1RAYUkeDZx1hOk7GlNzNgPdaXrPI
         6KnQUKRPAUMKfWCJoQ63rCVV2EMn/l6ygXjK/2ZBfXKh22h60U88VVoXKmYUOWT763+Q
         5ELqKJAMs43Lg0HXZ+6Nw9GymHQn6FmTCcDgrbHOrMPNXy6bB/oOd7vkYu7KzDcFb3BY
         p0fw==
X-Gm-Message-State: AOUpUlFEMJX4Q5lYpilZPQpMC5uI72+nAG99fMhz8rf3x8ui6j8gf9Nx
        7/+Pfs1tl65Xf6LVHsKaxxOAePSrmRDRxZmjJRaqfQ==
X-Google-Smtp-Source: AAOMgpdr2VUNhGoPP5FfWW37TdO1haQf0DiePn8sKlnV76M4GEZqhKWlsUYbO7OsG3/um9cu2/ncUqZrDnyBoehNP8k=
X-Received: by 2002:a24:5f92:: with SMTP id r140-v6mr579163itb.45.1533058370483;
 Tue, 31 Jul 2018 10:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <e3b48104-3efb-1896-0d46-792419f49a75@virtuozzo.com> <20180731170957.o4vhopmzgedpo5sh@breakpoint.cc>
In-Reply-To: <20180731170957.o4vhopmzgedpo5sh@breakpoint.cc>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 31 Jul 2018 10:32:39 -0700
Message-ID: <CANn89iLKwJ5oDfXu8M9z9_Xh0FKHFo961c_ocdUmHQc3Onmykw@mail.gmail.com>
Subject: Re: SLAB_TYPESAFE_BY_RCU without constructors (was Re: [PATCH v4
 13/17] khwasan: add hooks implementation)
To:     Florian Westphal <fw@strlen.de>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "Theodore Ts'o" <tytso@mit.edu>, jack@suse.com,
        linux-ext4@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        David Miller <davem@davemloft.net>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev <netdev@vger.kernel.org>,
        Gerrit Renker <gerrit@erg.abdn.ac.uk>, dccp@vger.kernel.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ursula Braun <ubraun@linux.ibm.com>,
        linux-s390@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 10:10 AM Florian Westphal <fw@strlen.de> wrote:
>
> Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
> > Guys, it seems that we have a lot of code using SLAB_TYPESAFE_BY_RCU cache without constructor.
> > I think it's nearly impossible to use that combination without having bugs.
> > It's either you don't really need the SLAB_TYPESAFE_BY_RCU, or you need to have a constructor in kmem_cache.
> >
> > Could you guys, please, verify your code if it's really need SLAB_TYPSAFE or constructor?
> >
> > E.g. the netlink code look extremely suspicious:
> >
> >       /*
> >        * Do not use kmem_cache_zalloc(), as this cache uses
> >        * SLAB_TYPESAFE_BY_RCU.
> >        */
> >       ct = kmem_cache_alloc(nf_conntrack_cachep, gfp);
> >       if (ct == NULL)
> >               goto out;
> >
> >       spin_lock_init(&ct->lock);
> >
> > If nf_conntrack_cachep objects really used in rcu typesafe manner, than 'ct' returned by kmem_cache_alloc might still be
> > in use by another cpu. So we just reinitialize spin_lock used by someone else?
>
> That would be a bug, nf_conn objects are reference counted.
>
> spinlock can only be used after object had its refcount incremented.
>
> lookup operation on nf_conn object:
> 1. compare keys
> 2. attempt to obtain refcount (using _not_zero version)
> 3. compare keys again after refcount was obtained
>
> if any of that fails, nf_conn candidate is skipped.


Yes, the key here is the refcount, this is only what we need to clear
after kmem_cache_alloc()

By definition, if an object is being freed/reallocated, the refcount
should be already 0, and clearing it again is a NOP.
