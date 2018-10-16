Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C616C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 06:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A5221479
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 06:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c110U2PM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A5221479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbeJPOSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 10:18:34 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36872 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbeJPOSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 10:18:34 -0400
Received: by mail-ed1-f67.google.com with SMTP id c22-v6so20141098edc.4;
        Mon, 15 Oct 2018 23:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KTrVOGVgEywVztcysBQdQRgEmj2OtWS64SprP8sBxSM=;
        b=c110U2PMw8ludfsyaSXq3ZchoxjuXEqtahiH8RZEa0Tw0j1DYKWqtecCeT2L6HIe24
         z5s3vF+ruwBkfLGhm0xX4RWBbAWSdHwGVhj5tI+O8Swooxucsz3RinaT5CaYQ/N03Hks
         5Tp5Zjl1D7BR1p/EK/rfjk8LzB4w9BygjGnEIJOAYbYf9TzjN4OBeytnD5LoB/3tzmCn
         mcUAIV24mR+snXUtFgIMotNQFSSf8EEmetTDFRfF+QeVzLO9TIgJw2vfatBsxp2NxNqK
         G9ac1DguBKNRGenl1On48wvxJ8kl19/G/gFX51vBftQ1V9EKjrYVvNOcSQGu/pPbBjcl
         QezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KTrVOGVgEywVztcysBQdQRgEmj2OtWS64SprP8sBxSM=;
        b=CZEh3MBOLUwTGdtRkKpgt2vNtc+8f1D1a+fx/B6PfBEz/cobTee4SnCZpBakjpMnzp
         fNQMD+H7gmozfgL4VLXtjXPklkQ9tEO+OFJG9cY+RROajNRHjsHF58bCneAnZWPlOSF6
         ee/WzVz/u1+9obR4Z5MPHUsiYFOu+zDoYnvFiu/IXE5SSaw5e1bey9hcqlV4pPw/l3mg
         6UpxIZ/TjRW0xQuB+EE4DRVtr4KlycMS2BOSzkn63082rMJ32gGOb1sozLt/ys38UEOr
         5vUXO8EJpotbFHAbfWIYvlBRp6C9OJendqDWLsQDS+eO5kTxPWhF+Nbz8B11kLM9wrwI
         52fg==
X-Gm-Message-State: ABuFfoi2pRNceY3sh8fh8ApUoaLPTcWVxUSpkFU7sONGdNw/JAOQ21ee
        NCT3naEKZa37/gSP73ttVoVax1C4N8uszWf4JQ==
X-Google-Smtp-Source: ACcGV63rBtbaOqt0GJVrvz3GcAU1SGb0EJXo34n+9M577R/fQ0KGq3huwafGzkhz5X/YcFoV4gIb92cb2UT9kNZ/SeM=
X-Received: by 2002:a50:a510:: with SMTP id y16-v6mr27076631edb.148.1539671379478;
 Mon, 15 Oct 2018 23:29:39 -0700 (PDT)
MIME-Version: 1.0
References: <20181009063500.GB3555@osiris> <CAFgQCTsnWRyN--dS0oVCzPykkt33M=9so2sv2a3+iu-kCdpV7A@mail.gmail.com>
In-Reply-To: <CAFgQCTsnWRyN--dS0oVCzPykkt33M=9so2sv2a3+iu-kCdpV7A@mail.gmail.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Tue, 16 Oct 2018 14:29:28 +0800
Message-ID: <CAFgQCTtQ2+bu44top5Fy=7KWRVrpFLnsRGupksK1ixR9oFZs+g@mail.gmail.com>
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

Hi heiko,

On Mon, Oct 15, 2018 at 1:54 PM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> On Tue, Oct 9, 2018 at 2:35 PM Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> >
> > Hello,
> >
> > with linux-next for 20181008 I can reliably crash my system with lot's of
> > debugging options enabled on s390. List debugging triggers the list
> > corruption below, which I could bisect down to this commit:
> >
> > fde06e07750477f049f12d7d471ffa505338a3e7 is the first bad commit
> > commit fde06e07750477f049f12d7d471ffa505338a3e7
> > Author: Pingfan Liu <kernelfans@gmail.com>
> > Date:   Thu Oct 4 07:43:01 2018 +1000
> >
> >     mm/slub: remove useless condition in deactivate_slab
> >
> >     The var l should be used to reflect the original list, on which the page
> >     should be.  But c->page is not on any list.  Furthermore, the current code
> >     does not update the value of l.  Hence remove the related logic
> >
> >     Link: http://lkml.kernel.org/r/1537941430-16217-1-git-send-email-kernelfans@gmail.com
> >     Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> >     Acked-by: Christoph Lameter <cl@linux.com>
> >     Cc: Pekka Enberg <penberg@kernel.org>
> >     Cc: David Rientjes <rientjes@google.com>
> >     Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> >     Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> >
> > list_add double add: new=000003d1029ecc08, prev=000000008ff846d0,next=000003d1029ecc08.
> > ------------[ cut here ]------------
> > kernel BUG at lib/list_debug.c:31!
> > illegal operation: 0001 ilc:1 [#1] PREEMPT SMP
> > Modules linked in:
> > CPU: 3 PID: 106 Comm: (sd-executor) Not tainted 4.19.0-rc6-00291-gfde06e077504 #21
> > Hardware name: IBM 2964 NC9 702 (z/VM 6.4.0)
> > Krnl PSW : (____ptrval____) (____ptrval____) (__list_add_valid+0x98/0xa8)
> >            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3
> > Krnl GPRS: 0000000074311fdf 0000000080000001 0000000000000058 0000000000e7b8b2
> >            0000000000000000 0000000075438c64 00000000a7b31928 001c007b00000000
> >            000000008fe99d00 00000000a7b31b40 000003d1029ecc08 00000000a7c03a80
> >            000003d1029ecc08 000000008ff84680 00000000007b5674 00000000a7c03960
> > Krnl Code: 00000000007b5668: c0200034734a        larl    %r2,e43cfc
> >            00000000007b566e: c0e5ffd0cf51        brasl   %r14,1cf510
> >           #00000000007b5674: a7f40001            brc     15,7b5676
> >           >00000000007b5678: a7290001            lghi    %r2,1
> >            00000000007b567c: ebcff0a00004        lmg     %r12,%r15,160(%r15)
> >            00000000007b5682: 07fe                bcr     15,%r14
> >            00000000007b5684: 0707                bcr     0,%r7
> >            00000000007b5686: 0707                bcr     0,%r7
> > Call Trace:
> > ([<00000000007b5674>] __list_add_valid+0x94/0xa8)
> >  [<000000000037d30e>] deactivate_slab.isra.15+0x45e/0x810
> >  [<000000000037ede4>] ___slab_alloc+0x76c/0x7c0
> >  [<000000000037eeb0>] __slab_alloc.isra.16+0x78/0xa8
> >  [<00000000003808c8>] kmem_cache_alloc+0x160/0x458
> >  [<0000000000141a3a>] vm_area_dup+0x3a/0x60
> >  [<0000000000142f0a>] copy_process+0xd72/0x2100
> >  [<000000000014449a>] _do_fork+0xba/0x688
> >  [<0000000000144bb0>] sys_clone+0x48/0x50
> >  [<0000000000b8faf0>] system_call+0xd8/0x2d0
> > INFO: lockdep is turned off.
> > Last Breaking-Event-Address:
> >  [<00000000007b5674>] __list_add_valid+0x94/0xa8
> >
> > Kernel panic - not syncing: Fatal exception: panic_on_oops
> >
>
> Sorry that just see this email, and reply late.
> I think it is caused by the uinon page->lru and page->next. It can be fixed by:
> diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
> index 3a1a1db..4aa0fb5 100644
> --- a/include/linux/slub_def.h
> +++ b/include/linux/slub_def.h
> @@ -56,6 +56,7 @@ struct kmem_cache_cpu {
>  #define slub_set_percpu_partial(c, p)          \
>  ({                                             \
>         slub_percpu_partial(c) = (p)->next;     \
> +       p->next = NULL; \
>  })
>
> I will do some test and post the fix.
>
Please ignore the above comment. And after re-check the code, I am
sure that all callers of deactivate_slab(), pass c->page, which means
that page should not be on any list. But your test result "list_add
double add: new=000003d1029ecc08,
prev=000000008ff846d0,next=000003d1029ecc08"  indicates that
page(new) is already on a list. I think that maybe something else is
wrong which is covered.
I can not reproduce this bug on x86. Could you share your config and
cmdline? Any do you turn on any debug option of slub?

Thanks,
Pingfan
