Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932507AbeBLVhI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 16:37:08 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:44100 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932204AbeBLVhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 16:37:06 -0500
X-Google-Smtp-Source: AH8x224FFU4aYxIF8BjQupXZ2fFtCI5r52QuvlglvU8tT8nbRNW7l3RzPVhzmR99ysePBV24b20lbNV/rjVXIOyPCII=
MIME-Version: 1.0
In-Reply-To: <CA+55aFwM0vy+pw-Xv=gA19ULMwAXNPhdO3qR5A3hkMrZKJFNSQ@mail.gmail.com>
References: <20180213080036.3bf3a908@canb.auug.org.au> <CA+55aFwM0vy+pw-Xv=gA19ULMwAXNPhdO3qR5A3hkMrZKJFNSQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 12 Feb 2018 13:37:04 -0800
X-Google-Sender-Auth: yZypYrjvgTauC04HjSreCF1XlgE
Message-ID: <CA+55aFzxsNxgKD1uGZQCiib+=+wCMSa0=B+Ye3Zi-u6kpz8Vrg@mail.gmail.com>
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

On Mon, Feb 12, 2018 at 1:15 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The reasoning is to avoid losing the signature from the tag (when
> merging a signed tag, the signature gets inserted into the merge
> commit itself - use "git log --show-signature" to see them).

I think the commit that actually introduced the behavior was

    fab47d057: merge: force edit and no-ff mode when merging a tag object

back in 2011, so we've had this behavior for a long time. So it's
probably not be worth tweaking the behavior any more, and maybe we
need to educate people to not update to other peoples state with "git
pull".

Maybe we could just tell people to have something like

       git config --global alias.update pull --ff-only

and use that for "try to update to upstream".

               Linus
