Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752356AbeDETEr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 15:04:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59174 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751913AbeDETEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 15:04:45 -0400
Date: Thu, 5 Apr 2018 20:04:41 +0100
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Takashi Iwai <tiwai@suse.de>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] sound updates for 4.17-rc1
Message-ID: <20180405190441.GC12349@sirena.org.uk>
References: <s5hwoxmdpmu.wl-tiwai@suse.de>
 <CA+55aFxuowsvQyq0+xeq=ganTHqw2uZ6kkZ8DBk0k01cJHUzjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ncSAzJYg3Aa9+CRW"
Content-Disposition: inline
In-Reply-To: <CA+55aFxuowsvQyq0+xeq=ganTHqw2uZ6kkZ8DBk0k01cJHUzjA@mail.gmail.com>
X-Cookie: Last week's pet, this week's special.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ncSAzJYg3Aa9+CRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 05, 2018 at 10:50:26AM -0700, Linus Torvalds wrote:

> Mark, we talked about this already. YOU ARE DOING SOMETHING HORRIBLY
> WRONG. You already admitted to automated merging, I already told you
> not to do that.

Ah, sorry - my impression was rather that the issue was the mess caused
by the history being too complex for git to eliminate null merges.  IIRC
you didn't say much when I explained what the automation is there for
which I (apparently incorrectly) took as as being OK with the
automation, just not the results it ended up doing in that particular
pull request.

> I'm attaching a screenshot of part of this to give as an example of
> what I see when I pull.

I agree it's not super lovely.

I looked at the image and also rechecked the history I'm seeing in gitk
and I didn't spot cases where one topic branch was merged more than once
though it's possible I missed something.  I do see a couple of cases
where I merged the fix branch up into the topic branch more than once in
order to resolve some conflicts that'd otherwise have been painful for
anyone working on things, and one case where I applied a fix twice for
some reason.  There *are* a very large number of commits with very
similar subject lines sitting in branches but I'm not seeing any
instances of the previous problem, AFAICT it's that there's lots of
branches since Morimoto-san ended up touching almost every driver and I
put them on per-driver branches like I usually do.

> STOP MERGING THE SAME BRANCHES OVER AND OVER AGAIN, DAMMIT!

> If you have merged a branch once, don't do it again tomorrow.

Just to be clear the merges I did one day get thrown away the next if
they weren't included in a pull request, the scripts only try to merge
anything once and are done this way mainly to try to avoid generating
pull requests which have incremental merges of the same branch.

I'm a little bit confused about what's best to do here.  The reason I'm
throwing the merge away and redoing it is that you've previously said
that you don't want to see main development branches that contain
nothing but long strings of merges, if I keep the same set of branches
and just do the merges incrementally every time a branch is added or
changes then there'd be even more merges which I'm pretty sure you
wouldn't be at all happy with either.

I could also just stop doing topic branches but that makes any cross
tree merges that need doing painfully big, this was why I started doing
topics so much.  I could go half way to that and try to figure out in
advance which things will end up needing cross tree merges but that
never worked out that well in the past.  I suppose I could also just
duplicate commits to make the topic branches if things need cross tree
merges after the fact, that's not great either though it does make for a
minimal number of branches while avoiding messy cross tree merges.

In the absence of any other feedback I guess I should just stop using
topic branches so much and go back to putting everything I don't
explicitly know will need a cross tree merge on just one fixes and one
-next branch and hope we don't need too many cross tree merges I didn't
anticipate.  Or possibly keep the fixes branches since they do get
individually used much more often and there's far fewer of them.

--ncSAzJYg3Aa9+CRW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrGc0gACgkQJNaLcl1U
h9CuPgf/Xv9MASyg1zGcWcnt1elkXnhcAjRilPds5r6DYxfCVQHfUF67P9oEJsz/
1uaQ+JDktXTwLJQdj6aLAOwU1To8XEe38SbuR8vFMA5G9SQMUudRyoiNdGRaNA7b
uHHfmgeiCtYC4WDFAS51wVOO9DBapJaDDtSzs3wxH2is+l1bvu4VbtBNOaNcvR3L
fDrX5Jem2235j5TxGPwg12tAlTgmYrUyCGEzJEAFA7BtMJGNPmHX1C29iy2tr/Oe
xBas6BF+M5s2UW3jtu1eRVfS7NicIr0Vn7VBxpJ7F6KkLzZHHVr/xz1I63ju6y21
9L6ZHbE3cQkaENm5B8mZupdD0xFLcw==
=OJ+f
-----END PGP SIGNATURE-----

--ncSAzJYg3Aa9+CRW--
