Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965297AbeBMRdG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:33:06 -0500
Received: from mail-io0-f171.google.com ([209.85.223.171]:33363 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964849AbeBMRdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:33:03 -0500
X-Google-Smtp-Source: AH8x22490nGLT3uA3wy78p+sULMZs8/EvfIirfetMbRaHVorYL3Jd2UvtYnwfGFikQjQPNKdm3YEIeaQZMnQ31pu7WM=
MIME-Version: 1.0
In-Reply-To: <xmqqmv0crepg.fsf@gitster-ct.c.googlers.com>
References: <20180213080036.3bf3a908@canb.auug.org.au> <CA+55aFwM0vy+pw-Xv=gA19ULMwAXNPhdO3qR5A3hkMrZKJFNSQ@mail.gmail.com>
 <CA+55aFzxsNxgKD1uGZQCiib+=+wCMSa0=B+Ye3Zi-u6kpz8Vrg@mail.gmail.com>
 <xmqqfu65sx20.fsf@gitster-ct.c.googlers.com> <CA+55aFwTp8gg70sHXqOgR01Liv5c8nnfUP0yTdwpkh-rg+2EMA@mail.gmail.com>
 <xmqqzi4drczv.fsf@gitster-ct.c.googlers.com> <20180212222157.0a3bd472@vento.lan>
 <xmqqmv0crepg.fsf@gitster-ct.c.googlers.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 13 Feb 2018 09:33:02 -0800
X-Google-Sender-Auth: RLJeNAPNsu-SnY8G5XVzo3Ipv2Q
Message-ID: <CA+55aFxkYTeY9h=VHFXi=gbXsnsHCRMAVZ9=1_EsFGSqr0sj9g@mail.gmail.com>
Subject: Re: linux-next: unnecessary merge in the v4l-dvb tree
To: Junio C Hamano <gitster@pobox.com>
Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 9:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> That makes me wonder if another heuristic I floated earlier is more
> appropriate.  When merging a tag object T, if refs/tags/T exists and
> it is that tag object, then an updated "merge" would default to "--ff";
> otherwise, it would keep the current default of creating a merge even
> when we could fast-forward, in order to record that tag T in the
> resulting history.

Oooh. Yes, that sounds like the right thing to do.

So the "no fast-forward" logic would trigger only if the name we used
for merging is one of the temporary ones (ie .git/{FETCH,MERGE}_HEAD),
not if the mentioned tag is already a normal tag reference.

Then it's very explicitly about "don't lose the signing information".

I'd still have to teach people to use "--only-ff" if they don't do the
"fetch and merge" model but literally just do  "git pull upstream
vX.Y", but at least the case Mauro describes would automatically just
DTRT.

Me likey.

           Linus
