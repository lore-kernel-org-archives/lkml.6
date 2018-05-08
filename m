Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754030AbeEHCuF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 22:50:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:55218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753780AbeEHCuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 22:50:03 -0400
X-Google-Smtp-Source: AB8JxZpvvELJ7tU7YTXrMkhcrHl32Lq4cTzBUShqwhwjXUtZmXVEJcrCN/PbAxx0RGCxmDS+12CcN46dV/7eqcJkbao=
MIME-Version: 1.0
References: <20180329180112.11055-1-labbott@redhat.com> <1522413619.15770.88.camel@fedoraproject.org>
 <CAK7LNAR5ZtwWH1SPMJeVpPkB38+9FyZOAG4AmS7NQ8NqCo_t9Q@mail.gmail.com>
In-Reply-To: <CAK7LNAR5ZtwWH1SPMJeVpPkB38+9FyZOAG4AmS7NQ8NqCo_t9Q@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 08 May 2018 02:49:50 +0000
X-Gmail-Original-Message-ID: <CALCETrWNrk-5GPEamVSwtnTxCOV4foreRUu789ZcOzykd0DYPA@mail.gmail.com>
Message-ID: <CALCETrWNrk-5GPEamVSwtnTxCOV4foreRUu789ZcOzykd0DYPA@mail.gmail.com>
Subject: Re: [RFCv2 PATCH 0/3] Salted build ids via linker sections
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Mark Wielaard <mjw@fedoraproject.org>,
        Laura Abbott <labbott@redhat.com>, Andrew Lutomirski <luto@kernel.org>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Nick Clifton <nickc@redhat.com>, Cary Coutant <ccoutant@gmail.com>,
        linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 6, 2018 at 11:59 PM Masahiro Yamada <
yamada.masahiro@socionext.com> wrote:

> 2018-03-30 21:40 GMT+09:00 Mark Wielaard <mjw@fedoraproject.org>:
> > On Thu, 2018-03-29 at 11:01 -0700, Laura Abbott wrote:
> >> I'm still mostly looking for feedback whether
> >> this would be acceptable for merging or if we should just persue a
> >> --build-id-salt in binutils.
> >
> > Personally I would go with this approach. It seems simple and it might
> > take years before a new linker option is available everywhere.


> Indeed.  This series is easier than --build-id-salt.

> If you do not see any better solution, I can accept this.


> BTW, when I read
> https://fedoraproject.org/wiki/Changes/ParallelInstallableDebuginfo
> I thought "we could reverse the symlink direction from debug file to
> build-id file)"
> sensible (but I understand it is not easy to change this way).


> If two packages share an identical image,
> one package can borrow the image from the other,
> then the storage space will be saved.

> So, having identical ID should be advantage,
> but we actually see only disadvantage...




> > To simplify things I think you could just always add the extra vdso
> > .comment initialized to something like KERNELRELEASE. Which distros
> > seem to update anyway to include their build number, so they wouldn't
> > need to do anything special to "update the build salt".
> >

That's what I was thinking, too.  Would that solve Fedora's problem?
