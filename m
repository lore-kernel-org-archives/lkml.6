Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752537AbeBIThQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 14:37:16 -0500
Received: from mail-it0-f54.google.com ([209.85.214.54]:40589 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752483AbeBIThO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 14:37:14 -0500
X-Google-Smtp-Source: AH8x224nqyfr3ZKDmXvavFrRxqWqCwM6MxCKNeuP5n/Zmdyq8SVhc8i8lDKTclhjkMBCNQa3xMuEFBWjRoIwgM27/O4=
MIME-Version: 1.0
In-Reply-To: <86b2120d-bf1b-16ba-0341-8e629425b799@suse.com>
References: <20180209142800.25485-1-jgross@suse.com> <CA+55aFxyEpQUgpZtkRbc1ESbMBw6FcbLgbzB3ioPN_097HpzOg@mail.gmail.com>
 <86b2120d-bf1b-16ba-0341-8e629425b799@suse.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 9 Feb 2018 11:37:13 -0800
X-Google-Sender-Auth: xFlYqW9QOM0cxWjHgk82z78NUyE
Message-ID: <CA+55aFxOeE4_8pcGmOXxDbUpXH5=XvjDMUjgo_bY+J-pGO-deA@mail.gmail.com>
Subject: Re: [GIT PULL] xen: fixes for 4.16 rc1
To: Juergen Gross <jgross@suse.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 9, 2018 at 10:59 AM, Juergen Gross <jgross@suse.com> wrote:
>
> Do you want me to setup the patches for pulling again?

No, I've pulled, I just don't want to see these unexplained merges again.

Preferably I don't want to see back-merges at all, but when I do see
them, I want to see an explanation for what they do and why they merge
that particular upstream point.

That "why that particular point" is less of an issue when you merge a
release tag (like that v4.14 merge), because at least then the point
you merge is fairly clear. But even then I want to see the "why".

We've done a really good job in the kernel of trying to have good
commit logs. It annoys me that our merge logs are sometimes really
bad.

I encourage maintainers to do

     git log --merges

and just look at the result.

I very much try to make *my* merges be informative, and - in order to
get them to that point - I obviously require help from maintainers in
the form of good pull requests. And I will literally reject pull
requests if I feel they don't have sufficiently good explanations.

My merge explanations aren't always perfect either, but on the whole I
think they at least show that I try to care. I try to format things to
be legible - often the maintainer does a great job and I can pretty
much just cut-and-paste (or take the tag message as-is), but in a lot
of those merge messages I have done a fair amount of "try to make it
legible and look good". Sometimes it's grammar and layout, and
occasionally it's me actually looking at the code and adding my own
commentary.

Now, look at merges *not* by me.

Let's just say that quality of commit messages is "varied".

Sometimes it's ok to be terse - there's a fair number of "merge topic
branch" oneliners where just the name of the topic kind of gives
things away, and I don't really complain about those (as long as the
maintainer then sent me a good explanation for *my* merge).

But sometimes even that is lacking. And for back merges, where you
aren't merging some clear development history from a topic branch of
your own or a submaintainer, the merge really *needs* an explanation.

The explanation may be "handle complex merge conflict due to XYZ so
that Linus doesn't have to", but then I really do want to see that
"XYZ" reason for whaty happened, and it really should be something
complicated, not just trivial "somebody else happened to touch
something nearby".

Or, in the case of pulling a release tag because you want to sync up,
at least _say_ so, and mention why syncing up makes things easier.

In this case, for example, those merges were actually pointless. You
merged your 4.13 tree with the 4.14 tree - which *should* have been
just a fast-forward, but I think you got a real merge just because of
the signed tag.  But you should have looked at the merge, and realized
you didn't actually have any work, and told yourself "I shouldn't
_merge_ v4.14, I should just update to it!"

So one of the reasons I want to see explanations for merges is
literally to avoid the _mindless_ merges. If you had had a policy to
write an explanation about _why_ that merge happened, you would
probably simply have realized that the merge shouldn't have happened
in the first place.

                 Linus
