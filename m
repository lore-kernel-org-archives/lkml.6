Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753619AbeDZGxy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 02:53:54 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:54932 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753378AbeDZGxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 02:53:49 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Salyzyn <salyzyn@android.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>, Peter Anvin <hpa@zytor.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, Kevin Easton <kevin@guarana.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SergeySenozhatsky <sergey.senozhatsky@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:timers/urgent] Revert: Unify CLOCK_MONOTONIC and CLOCK_BOOTTIME
Date: Thu, 26 Apr 2018 08:53:37 +0200
Message-ID: <1862218.3bTVVn1vea@aspire.rjw.lan>
In-Reply-To: <20180425201908.GA1977@amd>
References: <tip-757d5a9b3052a4eebd029f207f1e1df59bef7b7d@git.kernel.org> <CA+55aFz2_cwCjBDAqvzeX89Md26JR=DLhQxTPGuq8OQkWi0ehw@mail.gmail.com> <20180425201908.GA1977@amd>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, April 25, 2018 10:19:08 PM CEST Pavel Machek wrote:
> 
> --J2SCkAp4GZ/dPZZf
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> Content-Transfer-Encoding: quoted-printable
> 
> On Wed 2018-04-25 12:41:23, Linus Torvalds wrote:
> > On Wed, Apr 25, 2018 at 12:09 PM, Thomas Gleixner <tglx@linutronix.de> wr=
> ote:
> > > On Wed, 25 Apr 2018, Linus Torvalds wrote:
> > >>
> > >> I don't see the reported watchdog things, and I run systemd and I ran
> > >> these patches.
> > >
> > > With suspend/resume?
> >=20
> > Yes. I run them on my laptop, and while I don't do a _lot_ of
> > suspend/resume, I do some. My laptop right now is running a "just
> > after rc1" kernel, and has been for the last week, and has a couple of
> > suspends in that time. Type "closed my laptop, took it elsewhere,
> > opened it again", so more than a few minutes.
> >=20
> > > Fair enough. Do the reporters have more information or do I have to cha=
> se
> > > it down myself?
> >=20
> > I think reporters should just say what distro they are running, and
> > systemd versions etc, and how they debugged this. Maybe the pattern is
> > obvious.
> >=20
> > For the record, I just run plain F27, obviously with my own kernel
> > (and a tweaked config, but it approaches just being a "make
> > localmodconfig" of the distro config).
> 
> So... I do have debian 8.10.

Does that use systemd at all?

> With 4.17-rc1, I get "networking
> disabled" message from network manager (and broken network), about
> half of the time.
> 
> But there's more visible symptom: suspend/resume with 4.16, machine is
> okay after resume. With 4.17-rc1, just after resume, display starts
> dimming and screensaver will kick in. MATE desktop.

Yeah, why not.  It thinks that you've been inactive for the duration of system
sleep. :-)

Thanks,
Rafael
