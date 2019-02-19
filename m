Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B9BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C375521736
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u0wXslPg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbfBSXYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 18:24:14 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:54532 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbfBSXYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 18:24:14 -0500
Received: by mail-it1-f195.google.com with SMTP id f10so10775887ita.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 15:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EoAN64V8xqKACBMQZ9QRn2FkaanXJtKgPuk5uO+jw24=;
        b=u0wXslPgPVBkg5R3Ocwa/AAoXoHJdYfTtTD2Sry2U8AEkZUod++9zaT8bk09QLkb8u
         yidnuf5sNnhXG9xyrse0JJDxGXxURUatvAqhmfL+zZ/7d8hG2V63hRwpLAN7GQOOzi5E
         SYNwvpMEA/SBrDCtPC0vXyqjMXhqhLwjqcGeBm5jxSTmTq2BvSz1JgBldy2JF95h3Trt
         fBzJXWHhDSGCLwZV0GRq3y8aNNCBWncCKwSTyPl1TGBRwYrEiXcOnsQzOMmFy3mu2ujz
         W5Uj2rMpOOVrY+k3ga2KxWc2avBPOtxUWDm01SXC/VqkLcqGLQBmTk2w0tanKiGNg6Dn
         ODNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EoAN64V8xqKACBMQZ9QRn2FkaanXJtKgPuk5uO+jw24=;
        b=FdWrJbd30nprIAI3tB85oarJ+YIOOTCCv+NFvniLi8nrUwLiLUNnAfGLBnlJPevNmz
         eaW6S2o6QgPs9TTR1H1aW44LLF1WLh+cG6M8Fuv1DKs4gzyytrsam1U+8ZglUtuV2YDq
         +AlZqEJ/DMRvZSEQ0KYBj/pQS8h7KE/ZpjoDmg3LETJr9Wbv/qyQ0xMCsuAP773e9JJx
         b8jFUHUFNHdID/Mwgz3JzAmhIwmsC4+mTlDl3/Fnc/eeWOMZwv0xF6FQjxMLPPKgFG/X
         f69breYEP9dHqdl77Gwy6A+oSrRlS4/gbwps36zhAxKzMxzgxvtzT4er1AkQ1MRZV+TA
         5ptA==
X-Gm-Message-State: AHQUAubIDTHMGorLbnt7jbxHR+SlUPbPfc6kMoLp7jSF0xx4LXbjLYHO
        /aMnuJ4BmY0gac3v+QWSTdBHsNMKVrR1FC4ZcSOA1w==
X-Google-Smtp-Source: AHgI3IZK4wDy45kftvJkNyCP5nFuLjqH6iOasnJ74LcPSOuwBAdmjslI3X76UbXPqFsVRqoLaEMtefMl5VVcv0Pky64=
X-Received: by 2002:aca:c745:: with SMTP id x66mr4007409oif.44.1550618652636;
 Tue, 19 Feb 2019 15:24:12 -0800 (PST)
MIME-Version: 1.0
References: <20190214213729.21702-1-brendanhiggins@google.com>
 <20190214213729.21702-3-brendanhiggins@google.com> <155026451067.115909.17082794837098610153@swboyd.mtv.corp.google.com>
In-Reply-To: <155026451067.115909.17082794837098610153@swboyd.mtv.corp.google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 19 Feb 2019 15:24:01 -0800
Message-ID: <CAFd5g47yPUQFiEb4PaN_6xgY-ORTr-Z6W_gf8sWmpQ82fuSB_g@mail.gmail.com>
Subject: Re: [RFC v4 02/17] kunit: test: add test resource management API
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Rob Herring <robh@kernel.org>, shuah@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>, brakmo@fb.com,
        Steven Rostedt <rostedt@goodmis.org>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Knut Omang <knut.omang@oracle.com>,
        devicetree <devicetree@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        amir73il@gmail.com, dan.carpenter@oracle.com, wfg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 1:01 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-02-14 13:37:14)
> > @@ -104,6 +167,7 @@ struct kunit {
> >         const char *name; /* Read only after initialization! */
> >         spinlock_t lock; /* Gaurds all mutable test state. */
> >         bool success; /* Protected by lock. */
> > +       struct list_head resources; /* Protected by lock. */
> >         void (*vprintk)(const struct kunit *test,
> >                         const char *level,
> >                         struct va_format *vaf);
> > @@ -127,6 +191,51 @@ int kunit_run_tests(struct kunit_module *module);
> >                 } \
> >                 late_initcall(module_kunit_init##module)
> >
> > +/**
> > + * kunit_alloc_resource() - Allocates a *test managed resource*.
> > + * @test: The test context object.
> > + * @init: a user supplied function to initialize the resource.
> > + * @free: a user supplied function to free the resource.
> > + * @context: for the user to pass in arbitrary data.
>
> Nitpick: "pass in arbitrary data to the init function"? Maybe that
> provides some more clarity.

I think that makes sense. Will fix in next revision.
