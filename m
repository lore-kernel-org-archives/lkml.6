Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A528AC43444
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 02:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE762177B
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 02:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iLgpakor"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfALC6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 21:58:49 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34351 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbfALC6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 21:58:49 -0500
Received: by mail-wr1-f68.google.com with SMTP id j2so17232447wrw.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 18:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oA0YpQMCdJU1zfIVfz2vDT77FI6zrfK8PmyJGe88nf0=;
        b=iLgpakorSqfoGh51GzcIxeWq0hiHYjCnbrtcaS9N8pkXYywPrAlJe9Tyiz7J12ZjS7
         ZM4O1suQFAiFyoe0zMGmOa/gbzDG+a2bjCXFhpX7Bt2OZfP35C7+Z1+eOu+Eq+7yFILW
         UZCfpqrqASl++Pym/PWkOGDxJjfUS0/kAawW74ehg9mIVx1+oCu/ttNe02xmeS9iFYB/
         3Ql0apirfHi5TOi87Aw0oxVwffn/WzaT4CWysWjQ9ocQTLb2ksT9pypAj89fdu/CWjXj
         72MobcQlEe73OIeT4B+OcbWKc6/9oxbeLydbPz0f72L3EPO5vQo2ZNX6ldQctf0Jkl0q
         wZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oA0YpQMCdJU1zfIVfz2vDT77FI6zrfK8PmyJGe88nf0=;
        b=CoIvJal68OcBV27Pigvh/3QQ4j+I0tMcub9b7sGvawxDXYTzGT4BbMjkgiPk1GIZBg
         og3s2WBwYHEWwfpd4jelcOJE8CAe5tWq36gLna1wr32dInqFrpL+IBX9jyIvd4Q6ZECy
         BzwdFUphG6zXZxjOASAZGSdL7oErYRwlThlZQVd6JY93AcHzIN15Y6/ZLP293VhD3Y6E
         3xilecaT5X170JQJA1sQZSD6ECcArnUU/sWoT/Q3ZW+xz14rrI23VxTJ9HjsnBCiBrVG
         9z1ZA0+tN30fhDiaPSS9VJe4Q08+hh+KT4bsXYm72I2JxfcX4lpd4P8i/ATPDXEXYukw
         lr0Q==
X-Gm-Message-State: AJcUukdB+1Cl2ilO4Le1fUsbtsuI8JjO3g484WwuZPrdSexDkPz93Yb8
        gh/trsH6LkqY8sZk5UTEdE9UvodcoyI0WKvo333KIw==
X-Google-Smtp-Source: ALg8bN4K8kdswqFPg8E9VgzjlKUzEkixsQIlYoKhQ+uyxRmx+ztTcv8ihe5tqARyVlUkYDwnHjPoyQCaWf3pD/LyKCA=
X-Received: by 2002:adf:9246:: with SMTP id 64mr16726152wrj.130.1547261926762;
 Fri, 11 Jan 2019 18:58:46 -0800 (PST)
MIME-Version: 1.0
References: <20190111181600.GJ6310@bombadil.infradead.org> <20190111205843.25761-1-cai@lca.pw>
 <a783f23d-77ab-a7d3-39d1-4008d90094c3@lechnology.com>
In-Reply-To: <a783f23d-77ab-a7d3-39d1-4008d90094c3@lechnology.com>
From:   Michel Lespinasse <walken@google.com>
Date:   Fri, 11 Jan 2019 18:58:33 -0800
Message-ID: <CANN689G0zbk7sMbQ+p9NQGQ=NWq-Q0mQOOjeFkLp19YrTfgcLg@mail.gmail.com>
Subject: Re: [PATCH v2] rbtree: fix the red root
To:     David Lechner <david@lechnology.com>
Cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        esploit@protonmail.ch, jejb@linux.ibm.com, dgilbert@interlog.com,
        martin.petersen@oracle.com, joeypabalinas@gmail.com,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 3:47 PM David Lechner <david@lechnology.com> wrote:
>
> On 1/11/19 2:58 PM, Qian Cai wrote:
> > A GPF was reported,
> >
> > kasan: CONFIG_KASAN_INLINE enabled
> > kasan: GPF could be caused by NULL-ptr deref or user memory access
> > general protection fault: 0000 [#1] SMP KASAN
> >          kasan_die_handler.cold.22+0x11/0x31
> >          notifier_call_chain+0x17b/0x390
> >          atomic_notifier_call_chain+0xa7/0x1b0
> >          notify_die+0x1be/0x2e0
> >          do_general_protection+0x13e/0x330
> >          general_protection+0x1e/0x30
> >          rb_insert_color+0x189/0x1480
> >          create_object+0x785/0xca0
> >          kmemleak_alloc+0x2f/0x50
> >          kmem_cache_alloc+0x1b9/0x3c0
> >          getname_flags+0xdb/0x5d0
> >          getname+0x1e/0x20
> >          do_sys_open+0x3a1/0x7d0
> >          __x64_sys_open+0x7e/0xc0
> >          do_syscall_64+0x1b3/0x820
> >          entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >
> > It turned out,
> >
> > gparent = rb_red_parent(parent);
> > tmp = gparent->rb_right; <-- GPF was triggered here.
> >
> > Apparently, "gparent" is NULL which indicates "parent" is rbtree's root
> > which is red. Otherwise, it will be treated properly a few lines above.
> >
> > /*
> >   * If there is a black parent, we are done.
> >   * Otherwise, take some corrective action as,
> >   * per 4), we don't want a red root or two
> >   * consecutive red nodes.
> >   */
> > if(rb_is_black(parent))
> >       break;
> >
> > Hence, it violates the rule #1 (the root can't be red) and need a fix
> > up, and also add a regression test for it. This looks like was
> > introduced by 6d58452dc06 where it no longer always paint the root as
> > black.
> >
> > Fixes: 6d58452dc06 (rbtree: adjust root color in rb_insert_color() only
> > when necessary)
> > Reported-by: Esme <esploit@protonmail.ch>
> > Tested-by: Joey Pabalinas <joeypabalinas@gmail.com>
> > Signed-off-by: Qian Cai <cai@lca.pw>
> > ---
>
> Tested-by: David Lechner <david@lechnology.com>
> FWIW, this fixed the following crash for me:
>
> Unable to handle kernel NULL pointer dereference at virtual address 00000004

Just to clarify, do you have a way to reproduce this crash without the fix ?

I don't think the fix is correct, because it just silently ignores a
corrupted rbtree (red root node). But the code that creates this
situation certainly needs to be fixed - having a reproduceable test
case would certainly help here.

Regarding 6d58452dc06, the reasoning was that this code expects to be
called after inserting a new (red) leaf into an rbtree that had all of
its data structure invariants satisfied. So in this context, it should
not be necessary to always reset the root to black, as this should
already be the case...
