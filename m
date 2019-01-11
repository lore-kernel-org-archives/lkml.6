Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8462C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB0D20872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jyHoWA2N";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="cpizkqld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390053AbfAKSdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:33:19 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55948 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732979AbfAKSdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 13:33:18 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A1A013063A;
        Fri, 11 Jan 2019 13:33:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:mime-version:content-type; s=sasl; bh=X4H
        2bcYWNLqtXC5emIJfjgZruI8=; b=jyHoWA2Nfn1qGyar4bJES1VHRJ2k5A8dWZ0
        ZNtxYMBXSMySg/Uapbu/9PTDUix0NapuitH+p4Hu5oMf1GZOvSItKtb1WULUwTtk
        YnjSNZ4aU/YXWzcLnMWr6fqULms02qziwBKWd83NB9/dk3lm91TQE8dBaP1Jrzt2
        ed0QBIY4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 715E5130639;
        Fri, 11 Jan 2019 13:33:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=2016-12.pbsmtp; bh=nu9g/Ge59NXEgOqatWTIi9YnE6UKg67uTNcjWgLrszE=;
 b=cpizkqldwg9OOiwVGWvPzsdQplKLCthtWqPrbY4FLa73vxgpZcs9/jLaOJgk9AOpE+NACGHFyyoVoo3V0gHXdl8wU8V87QVRkEDvyIl6g/1JJC3pWDZ/iEMbf2ypbQX2kjPDOlnRFylbAUQntY0VlsEmaVHpP9naEHiE+c5XAbU=
Received: from yoda.home (unknown [70.82.104.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D3991130636;
        Fri, 11 Jan 2019 13:33:12 -0500 (EST)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id C3C8E2DA0173;
        Fri, 11 Jan 2019 13:33:11 -0500 (EST)
Date:   Fri, 11 Jan 2019 13:33:09 -0500 (EST)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>
cc:     Mark Rutland <mark.rutland@arm.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Tycho Andersen <tycho@tycho.ws>, Dave Mielke <dave@mielke.cc>,
        linux-kernel@vger.kernel.org
Subject: commit 83d817f410 broke my ability to use Linux with a braille
 display
Message-ID: <nycvar.YSQ.7.76.1901111239510.1512@knanqh.ubzr>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 5A4BA7E2-15CF-11E9-B3C0-84B4F54BB12D-78420484!pb-smtp2.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I use Linux with the help of a braille display and the brltty daemon. It 
turns out that the latest mainline kernel I can work with comes from 
commit 231f8fd0cc. Anything past that and I lose the ability to read the 
console barely a few seconds after the system has booted as brltty is 
thrown a wrench and the braille display becomes completely inoperable.

Things get somewhat better with commit c96cf923a9 as brltty is not 
longer incapacitated, but some programs would randomly crash. Even the 
very first login attempt won't work as I soon as I hit enter after my 
user name the password prompt is skipped over, just like if the enter 
key had been hit twice. Then lynx (the text web browser) would crash as 
soon as I switch the virtual console with LeftAlt+FN. Mind you, this 
isn't easy to perform bisection in those conditions.

And the worst commit i.e. 83d817f410 is marked for stable!  :-(

Some interaction with brltty must be at play here otherwise such 
breakage would never have survived up to the mainline kernel.

As far as latest mainline is concerned, I managed to reproduce at least 
one of the unwelcome behavior change (hoping that's all there is to this 
issue) with a very simple test case so you won't have to learn braille 
to debug this:

# from any vt, make sure tty40 is allocated and empty
openvt -c 40 -f -- true

# open it and wait on read()
cat /dev/tty40

# from a second vt, simply open tty40 again
true < /dev/tty40

# come back to the first vt and watch cat bailing out with EAGAIN.

Please fix.


Nicolas
