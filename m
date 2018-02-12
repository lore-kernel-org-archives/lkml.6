Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754137AbeBLVPH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 16:15:07 -0500
Received: from mail-it0-f51.google.com ([209.85.214.51]:34648 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751441AbeBLVPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 16:15:05 -0500
X-Google-Smtp-Source: AH8x225M6RUYVhMv2eFugdswImcqdLGK/M4ckBrlZwXO31xTmdOuLKInFTwAuIrdVP9sPpnOmbvRi0uXnfXiqeIxgYw=
MIME-Version: 1.0
In-Reply-To: <20180213080036.3bf3a908@canb.auug.org.au>
References: <20180213080036.3bf3a908@canb.auug.org.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 12 Feb 2018 13:15:04 -0800
X-Google-Sender-Auth: HhhET1ykQmQ9TZ_zQOooMIkXTeM
Message-ID: <CA+55aFwM0vy+pw-Xv=gA19ULMwAXNPhdO3qR5A3hkMrZKJFNSQ@mail.gmail.com>
Subject: Re: linux-next: unnecessary merge in the v4l-dvb tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Junio C Hamano <gitster@pobox.com>
Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 1:00 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Linus, this happens a bit after the merge window, so I am wondering
> about the rational of not doing a fast forward merge when merging a
> signed tag (I forget the reasoning).

The reasoning is to avoid losing the signature from the tag (when
merging a signed tag, the signature gets inserted into the merge
commit itself - use "git log --show-signature" to see them).

So when I merge a signed tag, I do *not* want to fast-forward to the
top commit, because then I'd lose the signature from the tag. Thus the
"merging signed tags are non-fast-forward by default" reasoning.

But, yes, that reasoning is really only valid for proper merges of new
features, not for back-merges.

The problem, of course, is that since git is distributed, git doesn't
know who is "upstream" and who is "downstream", so there's no
_technical_ difference between merging a development tree, and a
development tree doing a back-merge of the upstream tree.

Maybe it was a mistake to make signed tag merges non-fast-forward,
since they cause these kinds of issues with people who use "pull" to
update their otherwise unmodified trees.

I can always teach myself to just use --no-ff, since I end up doing
things like verifying at the signatures anyway.

Junio, comments?

               Linus
