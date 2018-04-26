Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754672AbeDZJDd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 05:03:33 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:44124 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753487AbeDZJD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 05:03:27 -0400
X-Google-Smtp-Source: AIpwx4+TPfokBHtD44/m08BJWke6940iMWDDj/XPTk8M8qt1cuGjUtz17qRR25wAvA67JSqe1uZayqg3sSFexjonWrw=
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1804261050130.1584@nanos.tec.linutronix.de>
References: <CANq1E4QppGAaU5PYbGpuC00S6wGQcAt70Z7CntZHiLC6748z2A@mail.gmail.com>
 <alpine.DEB.2.21.1804241007410.5261@nanos.tec.linutronix.de>
 <1996930.B4PaKZ6i1F@aspire.rjw.lan> <1858767.c2KKoU8fl2@aspire.rjw.lan>
 <alpine.DEB.2.21.1804251502310.2082@nanos.tec.linutronix.de>
 <1524726236.7572.1.camel@gmx.de> <alpine.DEB.2.21.1804260941050.1589@nanos.tec.linutronix.de>
 <CAJZ5v0hs+B+0KMnBfyy9e7v209t0hGSm+-BqyA4gMXrq7G4E7A@mail.gmail.com> <alpine.DEB.2.21.1804261050130.1584@nanos.tec.linutronix.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 26 Apr 2018 11:03:26 +0200
X-Google-Sender-Auth: FGaWzQAYQ130JzC3otgKuDXPeVY
Message-ID: <CAJZ5v0ghbefVcCOFbJFQ_RXwCRZMHQiwkrH55OwyMzBvweFPLg@mail.gmail.com>
Subject: Re: [RFC/RFT patch 0/7] timekeeping: Unify clock MONOTONIC and clock BOOTTIME
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        John Stultz <john.stultz@linaro.org>, Genki Sky <sky@genki.is>,
        David Herrmann <dh.herrmann@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 10:51 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Thu, 26 Apr 2018, Rafael J. Wysocki wrote:
>
>> On Thu, Apr 26, 2018 at 9:42 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> > On Thu, 26 Apr 2018, Mike Galbraith wrote:
>> >> On Wed, 2018-04-25 at 15:03 +0200, Thomas Gleixner wrote:
>> >> > Right, it does not matter. The real interesting one is d6ed449afdb3.
>> >>
>> >> FWIW, three boxen here suspend/resume fine, but repeatably exhibit the
>> >> below after a very few minute suspend, and a short bisect fingered your
>> >> suspect.  Distro is opensuse 42.3.
>> >>
>> >> [  211.113902] Restarting tasks ... done.
>> >> [  211.114817] PM: suspend exit
>> >> [  212.312993] systemd-journald[7266]: File /var/log/journal/016627c3c4784cd4812d4b7e96a34226/system.journal corrupted or uncleanly shut down, renaming and replacing.
>> >> [  212.313363] systemd-coredump[7264]: Detected coredump of the journal daemon itself, diverted to /var/lib/systemd/coredump/core.systemd-journal.0.0aa39276decf4f1ab6fda3464e31f9dd.582.1524720954000000.
>> >>
>> >
>> > Huch, that rather looks like a genuine application bug.
>>
>> Well, say you set a timer to wake you up in X seconds.  When you wake
>> up, you look at a clock and see that Y seconds have passed and Y is
>> much greater than X.  I guess you'd think that something's wrong. :-)
>
> And that makes you coredump, right? Brilliant choice.

That wouldn't be my choice, but some people do make choices like that
even in their personal lives ...
