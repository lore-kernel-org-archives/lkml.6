Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00351C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 11:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B2E620843
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 11:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B2E620843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeJ1UAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 16:00:49 -0400
Received: from tartarus.angband.pl ([54.37.238.230]:54408 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbeJ1UAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 16:00:49 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1gGj3R-0007Yw-ME; Sun, 28 Oct 2018 12:16:25 +0100
Date:   Sun, 28 Oct 2018 12:16:25 +0100
From:   Adam Borowski <kilobyte@angband.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: drivers by default (was Re: Another HID problem this merge window..)
Message-ID: <20181028111625.mr2hxbcqh5k4rskz@angband.pl>
References: <CAHk-=wiZ24JuVehJ5sEC0UG1Gk2nvB363wO02RRsR1oEht6R9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wiZ24JuVehJ5sEC0UG1Gk2nvB363wO02RRsR1oEht6R9Q@mail.gmail.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 27, 2018 at 11:13:17AM -0700, Linus Torvalds wrote:
> Ok, so this is a much smaller issue than the i2c one that cause boot
> problems, but it's annoying.
> 
> We do *not* enable new random drivers by default. And we most
> *definitely* don't do it when they are odd-ball ones that most people
> have never heard of.
> 
> Yet the new "BigBen Interactive" driver that was added this merge
> window did exactly that.
> 
> Just don't do it.

Amen to that.  But, perhaps you could encourage people to do enable drivers
once they become very popular?  For example, I just (72a9c673636) got hit by
USB 3.0 being off in defconfigs, and not having keyboard is not that cool.

So what about a policy that says "almost all drivers are to be =n initially,
but patches enabling popular stuff by default are welcome"?  Preferably if
obsolete crap gets mass-disabled at least once per decade (think of the
floppy driver's importance on day one vs now).

> Yes, yes, every developer always thinks that _their_ driver is so
> special and so magically important that it should be enabled by
> default. But no. When we have thousands of drivers, we don't randomly
> pick one new driver to be enabled by default just because some
> developer thinks it is special. It's not.

We don't know which drivers will become important and which won't, only time
can tell.  But not having such drivers on by default is also a problem.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ 
⣾⠁⢰⠒⠀⣿⡁ 10 people enter a bar: 1 who understands binary,
⢿⡄⠘⠷⠚⠋⠀ 1 who doesn't, D who prefer to write it as hex,
⠈⠳⣄⠀⠀⠀⠀ and 1 who narrowly avoided an off-by-one error.
