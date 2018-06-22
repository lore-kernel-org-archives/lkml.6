Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF2DC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 01:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED24C23C29
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 01:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED24C23C29
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934311AbeFVByy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 21:54:54 -0400
Received: from tartarus.angband.pl ([89.206.35.136]:40926 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934184AbeFVByx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 21:54:53 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1fWBHh-0002xG-5W; Fri, 22 Jun 2018 03:54:45 +0200
Date:   Fri, 22 Jun 2018 03:54:45 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Dave Mielke <Dave@mielke.cc>
Cc:     Nicolas Pitre <nicolas.pitre@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] have the vt console preserve unicode characters
Message-ID: <20180622015445.7r5u5nn6ofhd4k57@angband.pl>
References: <20180617190706.14614-1-nicolas.pitre@linaro.org>
 <20180619130953.bxil552igfkckjmr@angband.pl>
 <nycvar.YSQ.7.76.1806191047070.16670@knanqh.ubzr>
 <20180621014317.ebslk3gwvpq3k6sq@angband.pl>
 <20180621022137.GB18453@beta.private.mielke.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180621022137.GB18453@beta.private.mielke.cc>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 10:21:37PM -0400, Dave Mielke wrote:
> [quoted lines by Adam Borowski on 2018/06/21 at 03:43 +0200]
> 
> >It's meant for displaying braille to _sighted_ people.  And in real world,
> >the main [ab]use is a way to show images that won't get corrupted by
> >proportional fonts. :-þ
> 
> It's not abuse at all. I often use U+28xx to show sighted people what the
> braille for something looks like. I often need to do this when, for example, I
> need them to comapre what I'm showing them to what's on an actual braille
> display. U+28xx is the only way for me to do this without a lengthy description
> containing sequences of dot number combinations.

What you describe is the intended use.  Abuse is when people use these
glyphs to write text like this:

⡎⠉⠂⠠⠤⡀⣄⠤⡀⠀⠀⠀⡄⠀⡄⡠⠤⡀⡄⠀⡄⠀⠀⠀⣄⠤⡀⡠⠤⡀⠠⠤⡀⡠⠤⡇⠀⠀⠀⠤⡧⠄⣇⠤⡀⠠⡅⠀⡠⠤⠄⠎⢉⠆
⠣⠤⠂⠪⠭⠇⠇⠀⠇⠀⠀⠀⠨⠭⠃⠣⠤⠃⠣⠤⠃⠀⠀⠀⠇⠀⠀⠫⠭⠁⠪⠭⠇⠣⠤⠇⠀⠀⠀⠀⠣⠄⠇⠀⠇⠀⠣⠀⠬⠭⠂⠀⠅⠀

(Not sure if you're completely blind or merely very weakly sighted; if the
former, this is my way to show you how actual Latin letters look like,
without a lengthy description of letter shapes. :) )

or for graphs.  Here's commits per UTC hour of day:

⡀⠀⠀⢀⣴⣤⣴⣶⣶⣶⣾⣦
⣿⣷⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿

git log --pretty=format:'%at'|
perl -pe 'use integer;/^(\d+)$/ or die;$_=$1/3600%24 ."\n"'|
sort -n|uniq -c|cut -c3-7|braillegraph -y 8

or arbitrary images, like my .sig in all my mails in this thread.

But your patch set doesn't special-case braille in any way, thus allowing
such abuse to work on the console is merely an unintended side effect.

> >The primary users would be:
> >* people who want symbols uncorrupted (especially if their language uses a
> >  non-latin script)
> >* CJK people (as discussed below)
> 
> Again, that's not true. Why aren't braille users included in this list? After
> all, it's we who motivated this enhancement. I guess actual blind people
> mustn't count just because there are relatively fewer of us. :-(

Well, I meant users of Unicode display fonts, ie, _additional_ functionality
that's not yet coded but would rely on this patchset.  What you guys want is
already included.

The reason I'm raising this issue now is because if the Unicode struct would
be the primary one, there's no point in keeping vc_data in addition to
uni_screen.  And that would require designing the struct well from the
start, to avoid unnecessary changes in the future.

But then, taking a bitmask from that 32-bit value wouldn't be a big change
-- you already take variously 8 or 9 bits out of a 16-bit field, depending
on 256 vs 512 glyph mode.

The other point is a quite pointless assumption that existing scrollback is
"optimized".  Even vgacon mostly uses software scrollback these days, as the
amount of VGA display memory is really small.

I don't know much about console display drivers in general, though, and it
looks like most of them are unmaintained (just noticed that sisusb for
example hasn't seen a maintainer action for 13 years, and that person's
domain expired in 2006).


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ There's an easy way to tell toy operating systems from real ones.
⣾⠁⢰⠒⠀⣿⡁ Just look at how their shipped fonts display U+1F52B, this makes
⢿⡄⠘⠷⠚⠋⠀ the intended audience obvious.  It's also interesting to see OSes
⠈⠳⣄⠀⠀⠀⠀ go back and forth wrt their intended target.
