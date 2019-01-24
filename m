Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1DAC41518
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 00:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B0621872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 00:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PH9V0/KK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfAXAVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 19:21:00 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37819 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfAXAVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 19:21:00 -0500
Received: by mail-lf1-f66.google.com with SMTP id y11so2992133lfj.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 16:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8I8uV3WmaHvuIIbILWs8wayzXWD2yoy7pULfBcUtKtA=;
        b=PH9V0/KK92bXTEP81nt/LjQ6SSJLxS2F5++KT1VQvagruTtDYwwS38WCMe6QCTl1S9
         M/9QB21XB+xpradFhe9+OrMMThoKxz5UPxF1nlYho5qbehIWzvZfhcn0/eS81yXC++tg
         bTuEa1IIpQqjLr/qqfcnvuWomWwQUP+zq6EPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8I8uV3WmaHvuIIbILWs8wayzXWD2yoy7pULfBcUtKtA=;
        b=PGgxpG42vp7iTg4pEOctDczIiU6P35FRhAliYBjyOD8RE5V6uyvmPRjQ6X+EN1kVM0
         NU+FLEnEx7vTwQ4n2Wgiy0zWmA3kjWS8+DQ0l7ZjNjWHWRaznRejgvUUNRnzIDRCsY9X
         KN9F+bc7nQPGiaG6BtQHLpPlmTZ8UBxCxJ6Muo3+quR/5tHDHJHmeZUp7bb8mf30/CcU
         p34QJyt4FXaZMAljBdLikSluZMfE1CXGBUYDDfSHD0atDgjlH12jEsGjua+isyTa4Sr+
         ES9NaBluTWCEdjSC5qQdremNtwwol8Jr/ScnAkylEvwtCF+FVujW/SDKr+zJRYKAmzkn
         dRFQ==
X-Gm-Message-State: AJcUukfJg7Vxjyz59Q4czLZR6smj65BGVDWxYiCB8Tfu4AjTAD5y9M1I
        OeW2e8GSZNEfvBv9HRSn7MvVV7dt0bD2yw==
X-Google-Smtp-Source: ALg8bN55VOzJ7YWLM8Q7hWNz+zBormgmN06xGuq4fG5GFZq016kvpDjx+32WoPEG7yU2DjdCjDl6Qw==
X-Received: by 2002:a19:5a05:: with SMTP id o5mr3663781lfb.140.1548289257136;
        Wed, 23 Jan 2019 16:20:57 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id u65sm739551lff.54.2019.01.23.16.20.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 16:20:55 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id b20so2967851lfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 16:20:54 -0800 (PST)
X-Received: by 2002:a19:980f:: with SMTP id a15mr3398536lfe.103.1548289254203;
 Wed, 23 Jan 2019 16:20:54 -0800 (PST)
MIME-Version: 1.0
References: <20190110004424.GH27534@dastard> <CAHk-=wg1jSQ-gq-M3+HeTBbDs1VCjyiwF4gqnnBhHeWizyrigg@mail.gmail.com>
 <20190110070355.GJ27534@dastard> <CAHk-=wigwXV_G-V1VxLs6BAvVkvW5=Oj+xrNHxE_7yxEVwoe3w@mail.gmail.com>
 <20190110122442.GA21216@nautica> <CAHk-=wip2CPrdOwgF0z4n2tsdW7uu+Egtcx9Mxxe3gPfPW_JmQ@mail.gmail.com>
 <5c3e7de6.1c69fb81.4aebb.3fec@mx.google.com> <CAHk-=wgF9p9xNzZei_-ejGLy1bJf4VS1C5E9_V0kCTEpCkpCTQ@mail.gmail.com>
 <9E337EA6-7CDA-457B-96C6-E91F83742587@amacapital.net> <CAHk-=wjqkbjL2_BwUYxJxJhdadiw6Zx-Yu_mK3E6P7kG3wSGcQ@mail.gmail.com>
 <20190116054613.GA11670@nautica> <CAHk-=wjVjecbGRcxZUSwoSgAq9ZbMxbA=MOiqDrPgx7_P3xGhg@mail.gmail.com>
 <nycvar.YFH.7.76.1901161710470.6626@cbobk.fhfr.pm> <CAHk-=wgsnWvSsMfoEYzOq6fpahkHWxF3aSJBbVqywLa34OXnLg@mail.gmail.com>
 <nycvar.YFH.7.76.1901162120000.6626@cbobk.fhfr.pm> <CAHk-=wg+C65FJHB=Jx1OvuJP4kvpWdw+5G=XOXB6X_KB2XuofA@mail.gmail.com>
 <CAHk-=wgy+1YT-Rhj5qWb_aCuBADhcq42GDKHB74sqrnOVPKzPg@mail.gmail.com> <nycvar.YFH.7.76.1901240009560.6626@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1901240009560.6626@cbobk.fhfr.pm>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 24 Jan 2019 13:20:37 +1300
X-Gmail-Original-Message-ID: <CAHk-=whVyE2TL4NpEgsSnx=w0Pf-vNBidJY9HEeOVLO-m=Mx+g@mail.gmail.com>
Message-ID: <CAHk-=whVyE2TL4NpEgsSnx=w0Pf-vNBidJY9HEeOVLO-m=Mx+g@mail.gmail.com>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Josh Snyder <joshs@netflix.com>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 12:12 PM Jiri Kosina <jikos@kernel.org> wrote:
>
> >
> > I think the "test vm_file" thing may be unnecessary, because a
> > non-anonymous mapping should always have a file pointer and an inode.
> > But I could  imagine some odd case (vdso mapping, anyone?) that
> > doesn't have a vm_file, but also isn't anonymous.
>
> Hmm, good point.
>
> So dropping the 'vma->vm_file' test and checking whether given vma is
> special mapping should hopefully provide the desired semantics, shouldn't
> it?

Maybe. But on the whole I think it would  be simpler and more
straightforward to just instead add a vm_file test for the
inode_permission() case. That way you at least know that you aren't
following a NULL pointer.

If the file then turns out to be some special thing, it doesn't really
_matter_, I think. It won't have anything in the page cache etc, but
the code should "work".

             Linus
