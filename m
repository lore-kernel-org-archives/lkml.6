Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752047AbeENA6R convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 20:58:17 -0400
Received: from static-87-79-237-121.netcologne.de ([87.79.237.121]:47938 "EHLO
        herc.mirbsd.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751533AbeENA6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 20:58:15 -0400
Date: Mon, 14 May 2018 00:50:07 +0000 (UTC)
From: Thorsten Glaser <tg@mirbsd.de>
X-X-Sender: tg@herc.mirbsd.org
To: "Theodore Y. Ts'o" <tytso@mit.edu>
cc: Adrian Bunk <bunk@debian.org>, Ben Hutchings <ben@decadent.org.uk>,
        Debian release team <debian-release@lists.debian.org>,
        Debian kernel maintainers <debian-kernel@lists.debian.org>,
        krb5@packages.debian.org, libbsd@packages.debian.org,
        systemd@packages.debian.org, Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Fixing Linux getrandom() in stable
In-Reply-To: <20180514003034.GI14763@thunk.org>
Message-ID: <Pine.BSM.4.64L.1805140044300.26761@herc.mirbsd.org>
References: <75577b3d2efd01aaf563f1a1400a2c655556b258.camel@decadent.org.uk>
 <20180513204828.GI10643@localhost> <Pine.BSM.4.64L.1805132113450.15657@herc.mirbsd.org>
 <20180514003034.GI14763@thunk.org>
Content-Language: de-DE-1901, en-GB
X-Message-Flag: Your mailer is broken. Get an update at http://www.washington.edu/pine/getpine/pcpine.html for free.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Y. Ts'o dixit:

>that problems helps most of our users, and we shouldn't let the
>perfect be the enemy of the good.

Agreed. Start small, then enhance one bootloader at a time.
Or boot protocol, I assume.

>Also note that the bootloader has depend on userspace to refresh the
>seed entropy, both in early boot (in case the syscrashes), and at
>shutdown (so the entropy captured while the system is running can be

Definitely!

>saved as seed entropy).  And this is trickier in Linux because the
>bootloader lives in a different source tree, and is maintained by
>different people from the systemd and/or initscripts people, and for

Yes, unfortunately.

>that matter the bootloader doesn't know which distribution it is

But in this case, the distribution can tell the bootloader the
path to the file to load.

>the *BSD's has its advantages.  And this is where perhaps Debian as a
>distribution can solve this problem by coordinating action across
>multiple Debian packages.)

Of course.

>The *point* is that we can't really make a turn-key solution which
>will work for everyone.  For as much we have the desire for a
>"Universal OS", something that works for all hardware, all users, and
>all workloads, is probably just not attainable here.

As Debian, we can try to come close, but, as you said, don’t let
the perfect be the enemy of the good. Perhaps there are multiple
somethings that, together (or having the local admin choose) can
help more people than one simple solution, even if the latter may
help a majority. (I’m a fan of minorities, in case you couldn’t
tell. I run an x32 system, after all, and helped out m68k a bit…)

>(It never was a complete solution, BTW; even before the patches to
>address CVE-2018-1108, there were already hardware systems where you
>couldn't count on the RNG being initialized in time and getrandom(2)

Another question is what it means that the RNG is initialised.
It all depends on what in the end boils down to guesswork,
although I tip my hat because that RNG code of yours, both the
Linux and the BSD version, are pretty impressive.

But the point here is that, even if the RNG thinks it’s fully
initialised, it may not be “good” yet, depending on circumstances.
(Again, it should not stop us from trying.)

bye,
//mirabilos
-- 
Solange man keine schmutzigen Tricks macht, und ich meine *wirklich*
schmutzige Tricks, wie bei einer doppelt verketteten Liste beide
Pointer XORen und in nur einem Word speichern, funktioniert Boehm ganz
hervorragend.		-- Andreas Bogk über boehm-gc in d.a.s.r
