Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753251AbeDZHm3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 03:42:29 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45996 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751465AbeDZHm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 03:42:26 -0400
Date: Thu, 26 Apr 2018 09:42:04 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Mike Galbraith <efault@gmx.de>
cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        John Stultz <john.stultz@linaro.org>, Genki Sky <sky@genki.is>,
        David Herrmann <dh.herrmann@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org
Subject: Re: [RFC/RFT patch 0/7] timekeeping: Unify clock MONOTONIC and clock
 BOOTTIME
In-Reply-To: <1524726236.7572.1.camel@gmx.de>
Message-ID: <alpine.DEB.2.21.1804260941050.1589@nanos.tec.linutronix.de>
References: <CANq1E4QppGAaU5PYbGpuC00S6wGQcAt70Z7CntZHiLC6748z2A@mail.gmail.com>  <alpine.DEB.2.21.1804241007410.5261@nanos.tec.linutronix.de>  <1996930.B4PaKZ6i1F@aspire.rjw.lan> <1858767.c2KKoU8fl2@aspire.rjw.lan>  <alpine.DEB.2.21.1804251502310.2082@nanos.tec.linutronix.de>
 <1524726236.7572.1.camel@gmx.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Apr 2018, Mike Galbraith wrote:
> On Wed, 2018-04-25 at 15:03 +0200, Thomas Gleixner wrote:
> > Right, it does not matter. The real interesting one is d6ed449afdb3.
> 
> FWIW, three boxen here suspend/resume fine, but repeatably exhibit the
> below after a very few minute suspend, and a short bisect fingered your
> suspect.  Distro is opensuse 42.3.
> 
> [  211.113902] Restarting tasks ... done.
> [  211.114817] PM: suspend exit
> [  212.312993] systemd-journald[7266]: File /var/log/journal/016627c3c4784cd4812d4b7e96a34226/system.journal corrupted or uncleanly shut down, renaming and replacing.
> [  212.313363] systemd-coredump[7264]: Detected coredump of the journal daemon itself, diverted to /var/lib/systemd/coredump/core.systemd-journal.0.0aa39276decf4f1ab6fda3464e31f9dd.582.1524720954000000.
> 

Huch, that rather looks like a genuine application bug.

Thanks,

	tglx
