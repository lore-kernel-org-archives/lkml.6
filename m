Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751923AbeBAUua (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 15:50:30 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34372 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751677AbeBAUuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 15:50:22 -0500
X-Google-Smtp-Source: AH8x227Q6lPtd3nQAqzqsGZ0xKJSYdL1TkFv1Wv3l9q+L6RP73xZ0g25kgsKlxCM0qfmboLkn6pNSw==
Date: Thu, 1 Feb 2018 15:50:18 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        jani.nikula@linux.intel.com
Subject: Re: [PATCH v2] Documentation/process: kernel maintainer PGP guide
Message-ID: <20180201205018.fmjjvrvc4ytsg2fh@gmail.com>
Mail-Followup-To: Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        jani.nikula@linux.intel.com
References: <20180130184917.GA32095@gmail.com>
 <20180201144233.GA19712@gmail.com>
 <20180201111450.646b9974@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20180201111450.646b9974@lwn.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2018 at 11:14:50AM -0700, Jonathan Corbet wrote:
> - Capitalizing "Kernel" bugs me.  Obviously not a big deal.

Noted.

> - The "master keys vs. subkeys" section is nice, but it's missing one
>   thing, IMO: a sentence saying what a subkey *is* in the first place.

I'll work that in for subsequent changes

> - We don't normally endorse commercial products in kernel docs.  OTOH, I
>   don't see any other way for people to know which keycards they should
>   get. This section is sure to go obsolete as products come and go,
>   though - you're on the hook for maintaining it :)

If we wanted to avoid this, one way would be to refer people to the 
"Protecting Code Integrity" guide for smartcard recommendations, though 
it uses slightly different criteria (Mac users suddenly become 
important).

> - The suggestion to sign individual commits is, as I understand it,
>   controversial (Linus doesn't agree with it) and is 100% contrary to
>   current practice.  Are there any signed commits in the kernel repo
>   now?  Given that, I'm a bit nervous about putting commit-signing
>   forward as standard practice.

Linus isn't against it, he just points out that it serves no purpose -- 
the only thing that needs to be signed is the tip of each branch. Since 
each commit contains the parent checksum of the previous commit, that 
provides a backward chain for the rest of the branch, and that is 
sufficient to give cryptographic assurances for the remainder of all 
repo objects without needing to separately sign each of the commits 
leading to the tip.

And, of course, all those PGP signatures are lost when commits are 
converted to patches, so in his view the whole thing is pretty 
pointless. All he needs is signatures on tags that he pulls directly 
from maintainers.

However, there is currently no way to tell git "sign just the tip of the 
branch" -- I'm not even sure how it would work, because git has no 
knowledge of your intentions. A tip may only remain a tip for a couple 
of seconds before you add more commits. And should signatures be removed 
from previous commit tips, or just left there? And if so, why not just 
sign every commit anyway, since it doesn't *hurt* anything, especially 
if gpg-agent is properly configured -- it's just a background operation 
that doesn't even slow down your work if you use ECC subkeys.

Anyway, I feel it should remain as a weak recommendation just in case 
someone has to prove at any point their authorship of a specific commit, 
but I'm happy to change it, remove it, or add more detail explaining the 
above if you think the section should be expanded. I can talk about it 
for pages on end, I was just trying to be succinct. ;)

> - I'm not quite sure what the "finding paths to Linus" link is supposed
>   to do for the reader.

The idea is that it's a weak substitute for a web of trust. If someone 
isn't keeping one going, then using the PGP Pathfinder will give them at 
least *some* indication about whether the key is trusted or not. I do 
agree that if you don't already know what you're looking at, the output 
is fairly opaque. It's long been my desire to put together a 
kernel.org-specific tool where you can check similar data using pretty 
graphs (e.g. https://mricon.com/misc/korg-wot-graph.png), but I haven't 
had a chance yet.

>Anyway, these are all quibbles, and I think the documentation is
>definitely improved by having this, so I'm going ahead and applying it.
>It may be worth considering some tweaks for the issues above, though, as
>time allows.

Will do, thank you for the feedback!

-K
