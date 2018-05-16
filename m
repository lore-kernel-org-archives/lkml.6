Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752767AbeEPL6j (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 07:58:39 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:57551 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752272AbeEPL6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 07:58:38 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: valdis.kletnieks@vt.edu
Cc: ahs3@redhat.com, Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next 20180515 - ACPI disabled..
Date: Wed, 16 May 2018 13:58:04 +0200
Message-ID: <2369798.f7cP5IOQk6@aspire.rjw.lan>
In-Reply-To: <58438.1526423130@turing-police.cc.vt.edu>
References: <50539.1526419088@turing-police.cc.vt.edu> <664f2475-9718-d38e-7270-3426c94f86e8@redhat.com> <58438.1526423130@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, May 16, 2018 12:25:30 AM CEST valdis.kletnieks@vt.edu wrote:
> On Tue, 15 May 2018 15:49:15 -0600, Al Stone said:
> 
> > Not off-hand.  Could you please send me a copy of /sys/firmware/acpi/tables/APIC
> 
> cat /sys/firmware/acpi/tables/APIC | od -x
> 0000000 5041 4349 0072 0000 3903 4544 4c4c 2020
> 0000020 4243 3358 2020 0020 2009 0107 4d41 2049
> 0000040 0013 0001 0000 fee0 0001 0000 0800 0001
> 0000060 0001 0000 0800 0202 0001 0000 0800 0103
> 0000100 0001 0000 0800 0304 0001 0000 0c01 0002
> 0000120 0000 fec0 0000 0000 0a02 0000 0002 0000
> 0000140 0000 0a02 0900 0009 0000 000d 0604 05ff
> 0000160 0100
> 0000162
> 
> > on this machine?  The commit cd8c65a6442b that I wrote looks like it got pulled
> > in on 20180430, which if I'm understanding correctly, seems to have fixed the
> > problem.  Did this work before 20180415?  I assume it did.
> 
> 0430 is what I'm running right ow, and it works.  Everything before that too.
> It fell over sometime between 0430 and 0515,
> 
> > What puzzles me is that this message:
> >
> >    ACPI: [APIC:0x05] Invalid zero length
> >
> > should only have shown up if the MADT has a broken subtable, and I think that
> > bit of code has been that way for quite some time (git blame says somewhere
> > around 2012 when the test for this condition was put in).

There was one commit that I had to drop.

Please try linux-next tomorrow and let me know if it works for you.
