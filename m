Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751244AbeDXWNx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 18:13:53 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:47376 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751167AbeDXWNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 18:13:50 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: tglx@linutronix.de, dmitry.torokhov@gmail.com,
        torvalds@linux-foundation.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: CLOCK_MONOTONIC, BOOTTIME, suspend and screensaver regression
Date: Wed, 25 Apr 2018 00:13:40 +0200
Message-ID: <69304060.FXLhE4Rftx@aspire.rjw.lan>
In-Reply-To: <20180424120659.GA14411@amd>
References: <20180424120659.GA14411@amd>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, April 24, 2018 2:07:00 PM CEST Pavel Machek wrote:
> 
> --CE+1k2dSO48ffgeK
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> Content-Transfer-Encoding: quoted-printable
> 
> Hi!
> 
> In 4.17-rc1 I have weird problems with network manager... and I also
> have screensaver kicking just after resume.

I seem to be able to reproduce this on an Acer Aspire S5 (Ivy Bridge
generation CPU).

This machine appears to crash during resume, but I have not been able to
collect any debug output from that so far.

It has to stay suspended for several minutes in order to trigger this
behavior, but it is reproducible enough for me to try to bisect it
(which I'm going to do tomorrow if time permits).

At this point it looks like the breakage was introduced somewhere between
commits 9abf8acea297 and bb2407a7219760, but I need to verify that the
latter really works.

Thanks,
Rafael
