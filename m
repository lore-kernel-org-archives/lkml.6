Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D70BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33055218D9
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IOZYmgbh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="UXVfj+eh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388845AbfAKTji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:39:38 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59951 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730371AbfAKTjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:39:37 -0500
X-Greylist: delayed 412 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Jan 2019 14:39:35 EST
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 240E04C3C4;
        Fri, 11 Jan 2019 14:32:43 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=vG2aKQy+cfKY6IB9UEFcw9yTUOw=; b=IOZYmg
        bhQOJaL/fklFhU7aqfp7jy+c/sYZipnLfDFFyXrZzbbFX2wxqD8pXXx4s9gOhln0
        bkEkhga58qbtj/gNbQCo57lDUsG555HTc2gpijsgvSxn+hr7Df3qwZiIkMbi6pGh
        91EyAYxNUmkqhzkCui0Hly56dXCixTktFY3a8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1D2A54C3C3;
        Fri, 11 Jan 2019 14:32:43 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=8BsB+MVUqappM/wIgAyQg05SJx8e4t1Fl1VGMiMX5gE=; b=UXVfj+eh1mHGobPhUqXFm7OcfDW7SGwNY86TJIdRVI9GsI+NwPRcKsm7sCT4UcI2cPmHz1gFizC1s3xt6FBvhHBzFS9NuhPV9UwUbLqX9xPBBBSlDY5pn3rxH1fGAhZotm334ku+z+cmVU9pi9X7sNbNJwuTcagZ3Ly314SO2HI=
Received: from yoda.home (unknown [70.82.104.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 16B804C3C2;
        Fri, 11 Jan 2019 14:32:40 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 3205C2DA0173;
        Fri, 11 Jan 2019 14:32:38 -0500 (EST)
Date:   Fri, 11 Jan 2019 14:32:35 -0500 (EST)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Vito Caputo <vcaputo@pengaru.com>
cc:     Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Mark Rutland <mark.rutland@arm.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Tycho Andersen <tycho@tycho.ws>, Dave Mielke <dave@mielke.cc>,
        linux-kernel@vger.kernel.org
Subject: Re: commit 83d817f410 broke my ability to use Linux with a braille
 display
In-Reply-To: <20190111191155.s4e5sn5fqk33fqr4@shells.gnugeneration.com>
Message-ID: <nycvar.YSQ.7.76.1901111426250.1647@knanqh.ubzr>
References: <nycvar.YSQ.7.76.1901111239510.1512@knanqh.ubzr> <20190111191155.s4e5sn5fqk33fqr4@shells.gnugeneration.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: A886A468-15D7-11E9-A153-D889C09F693B-78420484!pb-smtp20.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2019, Vito Caputo wrote:

> On Fri, Jan 11, 2019 at 01:33:09PM -0500, Nicolas Pitre wrote:
> > I use Linux with the help of a braille display and the brltty daemon. It 
> > turns out that the latest mainline kernel I can work with comes from 
> > commit 231f8fd0cc. Anything past that and I lose the ability to read the 
> > console barely a few seconds after the system has booted as brltty is 
> > thrown a wrench and the braille display becomes completely inoperable.
> > 
> > Things get somewhat better with commit c96cf923a9 as brltty is not 
> > longer incapacitated, but some programs would randomly crash. Even the 
> > very first login attempt won't work as I soon as I hit enter after my 
> > user name the password prompt is skipped over, just like if the enter 
> > key had been hit twice. Then lynx (the text web browser) would crash as 
> > soon as I switch the virtual console with LeftAlt+FN. Mind you, this 
> > isn't easy to perform bisection in those conditions.
> > 
> > And the worst commit i.e. 83d817f410 is marked for stable!  :-(
> 
> This all sounds familiar, and I suspect this is the fix:
> 
> https://lkml.org/lkml/2019/1/8/1379

Yep, I confirm this patch did solve all my issues.


Nicolas
