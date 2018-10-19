Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2680C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 01:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB4221477
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 01:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKyipwu3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FB4221477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbeJSJVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 05:21:34 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43220 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbeJSJVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 05:21:33 -0400
Received: by mail-ed1-f66.google.com with SMTP id y20-v6so29950296eds.10;
        Thu, 18 Oct 2018 18:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EkR8gMq62S4DjkM79QLXmfpWy6agKlIDL1G3casjips=;
        b=WKyipwu38Xhd8NzVodKIMBkV5KXWN4DLsUvPJRkBqh3FtN0HmHDe9t9ARDc6Z6RE4T
         E1KzdO/UvLrGPkykDM4D4LyPh3v9FnHToQ9Cj69+9fuGnJDkAnnwEA0h04emL/yI6V4U
         WOeiBy3rLWJxAgeeDy7VTiHIRDQUjYraluhSTwMnNzdDtuwg1k2Q9nYdzi8JogGG2Ijv
         BfoNQcqGRE7fxR4LIfB1/1xkSh3MotJsD02GEG4Mqpvzb0KnJ0hDFW1ACpx7NciTAfjh
         q4p2H2J+Dpf3Th/u7YAJLECWkTscrHhjmlJlKMH3HPe6PuY1qrIiaw1HfBJ7DqltrWZP
         5V/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EkR8gMq62S4DjkM79QLXmfpWy6agKlIDL1G3casjips=;
        b=Kp+HvASBrpsytb+sXgj1BGp1AWgdZ9lUTtiSyvQ6BD8W6GcFTsiZrueGrIGS+FyXl+
         +/g8BeYN6Ol+bhVgvNDk2lSo0yj8YGrzfHI17GA5DdQVlgdhGyZvzrvpOjrtU/E0/79T
         zLL/9UdYornzUZBQdwjl8T+o23x/doQQQ++zCmTbMhtoMkURyizsUtlh8fxm+WaJxx4c
         TYeqJj6grK6tMu2mhVTMCFkOqcWURQtyqVD8IiZP7YQQE3vMOpcAa2kWNl0qkSE7fvNm
         qNa6jRr5ma8gC8oto8ca7upXgGR8LC1ULFF8G/XLtfzL4zsir7qvu8o1nzRdP2TEQ/nm
         ERQw==
X-Gm-Message-State: ABuFfoh4oecan90peO3BzdFZeDucHHe/IFDi8Ooi0Si3t9KjDebA66rm
        tuvLZE//3ymKdEkjQ8mw80w9FlNnGPQ/n3jcCA==
X-Google-Smtp-Source: ACcGV60SOU95/2cjqUGybWh/qO9IDdZhsN+sNb7m0KbOOfGjG8ttiK5MBiW4HpaD5FPbrhJg2/Z5YmX1cAV9LmXrJdw=
X-Received: by 2002:a50:a384:: with SMTP id s4-v6mr4902526edb.121.1539911867992;
 Thu, 18 Oct 2018 18:17:47 -0700 (PDT)
MIME-Version: 1.0
References: <20181009063500.GB3555@osiris> <CAFgQCTsnWRyN--dS0oVCzPykkt33M=9so2sv2a3+iu-kCdpV7A@mail.gmail.com>
 <CAFgQCTtQ2+bu44top5Fy=7KWRVrpFLnsRGupksK1ixR9oFZs+g@mail.gmail.com> <20181016073629.GA3194@osiris>
In-Reply-To: <20181016073629.GA3194@osiris>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Fri, 19 Oct 2018 09:17:36 +0800
Message-ID: <CAFgQCTsRP_gEMzDo6jYTeFMmkRJDPxg_sAUDWQ2Xpa=HpbqejQ@mail.gmail.com>
Subject: Re: [BUG -next 20181008] list corruption with "mm/slub: remove
 useless condition in deactivate_slab"
To:     heiko.carstens@de.ibm.com
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-next@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 3:36 PM Heiko Carstens
<heiko.carstens@de.ibm.com> wrote:
>
> On Tue, Oct 16, 2018 at 02:29:28PM +0800, Pingfan Liu wrote:
> > > I think it is caused by the uinon page->lru and page->next. It can be fixed by:
> > > diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
> > > index 3a1a1db..4aa0fb5 100644
> > > --- a/include/linux/slub_def.h
> > > +++ b/include/linux/slub_def.h
> > > @@ -56,6 +56,7 @@ struct kmem_cache_cpu {
> > >  #define slub_set_percpu_partial(c, p)          \
> > >  ({                                             \
> > >         slub_percpu_partial(c) = (p)->next;     \
> > > +       p->next = NULL; \
> > >  })
> > >
> > > I will do some test and post the fix.
> > >
> > Please ignore the above comment. And after re-check the code, I am
> > sure that all callers of deactivate_slab(), pass c->page, which means
> > that page should not be on any list. But your test result "list_add
> > double add: new=000003d1029ecc08,
> > prev=000000008ff846d0,next=000003d1029ecc08"  indicates that
> > page(new) is already on a list. I think that maybe something else is
> > wrong which is covered.
> > I can not reproduce this bug on x86. Could you share your config and
> > cmdline? Any do you turn on any debug option of slub?
>
> You can re-create the config with "make ARCH=s390 debug_defconfig".
>
> Not sure which machine I used to reproduce this but most likely it was
> a machine with these command line options:
>
> dasd=e12d root=/dev/dasda1 userprocess_debug numa_debug sched_debug
> ignore_loglevel sclp_con_drop=1 sclp_con_pages=32 audit=0
> crashkernel=128M ignore_rlimit_data
>
> You can ignore the dasd and sclp* command line options. These are
> s390 specific. The rest should be available on any architecture.
>
Thank you for the info. I can reproduce the bug, and find that this
bug is caused by this commit. In deactivate_slab(), page is firstly
add_full(), then hit the redo condition, hence it should be
remove_full(). This wrong commit erases the related code.

Regards,
Pingfan
