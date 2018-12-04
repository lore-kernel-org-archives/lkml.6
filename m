Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71A6C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C4132081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E/wBMkJj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C4132081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbeLDAfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 19:35:25 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34091 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeLDAfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 19:35:24 -0500
Received: by mail-oi1-f193.google.com with SMTP id h25so12772968oig.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 16:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OctTzfGiKx9+SW307GLGZ4f1lZnGP2F7kKB6Nur7RAA=;
        b=E/wBMkJjigcH7Rxq7ZQW0RsQay8T+t+NBXjok5bs1I6tpMH4rf2r4S6Cz+YjLGFxyg
         FNphztIQi+sWkcTlJfPzV0aq9mYKdatlLJ5m8XrxHrJ+ZJtwDISc3EXlJC7cwAs0aLB5
         mqdQzcZVH1uNiH7XJjXKrpWVJOR4zJMF3i09E0wGH5Zys9nBH8zZrC10E9T//eI6YYAR
         aNp5YYHmBo0b0rWH4NqQrX4BPXxkE+bQxwNcuXzDzr0889sZirYPnMs4rkj2vMcfaNzq
         FXXP06IFvXnTy6wFQHTVfCeT0x3BIgtXvIkBquMBs4MFLoL0BKfylqywnY3FXJEL07Sv
         StLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OctTzfGiKx9+SW307GLGZ4f1lZnGP2F7kKB6Nur7RAA=;
        b=pvEfPjj8B9YiI+hPQ75g9FsutsIDLerYfhpTZPAm9SBsQqCCJT/aF0UtsH/Kt2LZoM
         dovzG1uvieO7/hTQonsorkqhrySEj+Ci1md1W/e89AXEwV6Vc1SZ/WE4lXZUVhT+hPPF
         9T5SzufnKJ1MKm04tFcvbaB9Fh2IbEkdBt/nzBAyb8TEphfBxtVAz8goMyVAA7oMJMEA
         WZFrGsTMxxzmBbE0cpK7Kds3QrBsHZvVx2eBe37sah6UFQ5mu7EMnpU06mX7gPdCLlTd
         IoWIbXHOkusfUDeIiZFMw8/gcv1Q7JUdh5GvTxOynyGMLIKo8sHkfX85QyNY2pca1Vn6
         iDVg==
X-Gm-Message-State: AA+aEWYy2QwK/1FvR1VOPiTnEDU2VZzOlszFA9dSsL8PBKGwCeW+nDfn
        cMSs5hc2roACKYJfholmtB/gz8yj664rg6I6WvZl2A==
X-Google-Smtp-Source: AFSGD/XMrsuT5Fp9BHcb2mURjOehlLvR64WVwHYvMBPSZGrcn37H0A+sQ/nLH9YVSRy7bYGx59vNyqwt3/8F8mf9yRE=
X-Received: by 2002:aca:bd41:: with SMTP id n62mr11688409oif.348.1543883723458;
 Mon, 03 Dec 2018 16:35:23 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-4-brendanhiggins@google.com> <20181130032924.GH18410@garbanzo.do-not-panic.com>
 <20181203105517.vbedwygttxxbdtan@pathway.suse.cz>
In-Reply-To: <20181203105517.vbedwygttxxbdtan@pathway.suse.cz>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 3 Dec 2018 16:35:12 -0800
Message-ID: <CAFd5g47pWbPso4LG93ffRUZjLhxnqws5VfYc5SfFf8FbuYCWvA@mail.gmail.com>
Subject: Re: [RFC v3 03/19] kunit: test: add string_stream a std::stream like
 string builder
To:     Petr Mladek <pmladek@suse.com>
Cc:     mcgrof@kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, shuah@kernel.org,
        Joel Stanley <joel@jms.id.au>, mpe@ellerman.id.au,
        joe@perches.com, brakmo@fb.com, rostedt@goodmis.org,
        Tim.Bird@sony.com, khilman@baylibre.com,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh@kernel.org>,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        kieran.bingham@ideasonboard.com,
        Frank Rowand <frowand.list@gmail.com>,
        Knut Omang <knut.omang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 2:55 AM Petr Mladek <pmladek@suse.com> wrote:
>
> On Thu 2018-11-29 19:29:24, Luis Chamberlain wrote:
> > On Wed, Nov 28, 2018 at 11:36:20AM -0800, Brendan Higgins wrote:
> > > A number of test features need to do pretty complicated string printing
> > > where it may not be possible to rely on a single preallocated string
> > > with parameters.
> > >
> > > So provide a library for constructing the string as you go similar to
> > > C++'s std::string.
> >
> > Hrm, what's the potential for such thing actually being eventually
> > generically useful for printk folks, I wonder? Petr?
>
> printk() is a bit tricky:
>
>    + It should work in any context. Any additional lock adds risk of a
>      deadlock. Especially the NMI and scheduler contexts are problematic.
>      There are problems with any other code that might be called
>      from console drivers and calls printk() under a lock.
>
>    + It should work also when the system is out of memory. Especially
>      atomic context is problematic because we could not wait for
>      memory reclaim or swap.
>
>    + We also do to the best effort to get the message out on the
>      console. It is important when the system is about to die.
>      Any extra buffering layer might cause delay and avoid seeing the
>      message.
>
> From this point of views, this API is not generally usable with printk().

Yeah, that makes sense. I wouldn't really expect this to work well in
those cases.

> Now, the question is how many of the above fits also for unit testing.
> At least, you might need to be careful when allocating memory in
> atomic context.

True, but this is only supposed to be used for constructing
expectation failure messages which should only happen from a
non-atomic context.

>
> BTW: There are more existing printk APIs: Well, I admit the they are
> not easily reusable in unit testing:
>
>    + printk() is old, crappy code, complicated with all the
>      cornercases and consoles.
>
>    + include/linux/seq_buf.h is simple buffering. It is used primary
>      for sysfs output. It might be usable if you add support for
>      loglevel and use big enough buffer. I quess that you should
>      flush the buffer regularly anyway.
>
>    + trace_printk() uses lockless per-CPU buffers. It currently does not
>      support loglevels. But it might be pretty interesting choice as well.
>
>
> I do not say that you have to use one of the existing API. But you
> might consider them if you encouter any problems and maintaining
> your variant gets complicated.

Alright, I will take a look.

Thanks!
