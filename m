Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751618AbeCMAvM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 20:51:12 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:42416 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751496AbeCMAvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 20:51:09 -0400
X-Google-Smtp-Source: AG47ELtqxQ3GAHc3JEbE72cEoYKSwNv+B1gQ8d1v1H2NA1KthICe520qtJcqPNzLwVymTblCHtALTg==
Date: Tue, 13 Mar 2018 01:51:03 +0100
From: Ognjen =?utf-8?B?R2FsacSH?= <smclt30p@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        ACPI mailing list <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: linux-next on thinkpad x60: full battery is indicated as battery
 error in mate
Message-ID: <20180313005103.brhhrxlatxfkdw7p@thinkpad>
References: <20180312194715.GA3992@amd>
 <20180312194944.GA3979@amd>
 <CAJZ5v0gWd7OCy+P41CFWJ1E9Tzw++Ok=YmjQwLk+iSZutBzphA@mail.gmail.com>
 <20180312223521.vzccevf6z7ik5ysf@thinkpad>
 <20180312230407.GA7612@amd>
 <CAJZ5v0irEfMxURr2c8VZ=SZhsW+MWxRd4OwDH5bS6P=R3a0REw@mail.gmail.com>
 <20180312231847.GB7612@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312231847.GB7612@amd>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 12:18:47AM +0100, Pavel Machek wrote:
> Hi!
> 
> > >> > >> Fully charged
> > >> > >> battery shows as empty battery with red "x" in Mate desktop. After
> > >> > >> reboot to recent mainline problem goes away. Tooltip says "battery
> > >> > >> waiting to charge".
> > >> > >>
> > >>
> > >> For the MATE bug see:
> > >> https://github.com/mate-desktop/mate-power-manager/pull/251
> > >>
> > >> The problem is in the new composite battery system in UPower, it
> > >> "merges" two external batteries into a single one for reporting. That
> > >> battery does not understand "Not Charging" inside the MATE Power
> > >> Manager. The above patch fixes that in MATE.
> > >
> > > Ok, so problem is 91eea70e5e5ce12eb1c7cd922e561fab43e201bd.
> > >
> > > And now, I see that MATE should be improved.
> > >
> > > But what I also see is that kernel is changing its interface in a way
> > > that (while making sense) breaks existing application. And we don't
> > > break existing applications.
> > >
> > > [Now... maybe if the fix for the application is available for long
> > > long time and noone is really looking and everyone already has new
> > > application version, maybe ... But pull request for MATE is 9 days
> > > old, and not even merged. So there is no way this is suitable for
> > > 4.17.]
> > 
> > Right.
> > 
> > This basically means that we will have to defer the battery changes
> > until user space is ready and not just upstream, but also in distro
> > packages.
> 
> Yes please.
> 
> Note that only 91eea70e5e5ce12eb1c7cd922e561fab43e201bd should break
> anything, the others should be safe AFAICT?
> 
> 								Pavel
> 

Actually there is a bug in UPower itself, and that reflects the status
icon being broken in almost all desktop environments. I will work on
fixing UPower in the following days. Disregard my previous comment.

> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
