Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F80C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA3D92086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA3D92086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mirbsd.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbeLKWOH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:14:07 -0500
Received: from static-87-79-237-121.netcologne.de ([87.79.237.121]:45957 "EHLO
        herc.mirbsd.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbeLKWOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:14:07 -0500
X-Greylist: delayed 627 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Dec 2018 17:14:06 EST
Received: from herc.mirbsd.org (tg@herc.mirbsd.org [192.168.0.82])
        by herc.mirbsd.org (8.14.9/8.14.5) with ESMTP id wBBLrpFu017954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 11 Dec 2018 21:53:53 GMT
Date:   Tue, 11 Dec 2018 21:53:51 +0000 (UTC)
From:   Thorsten Glaser <tg@mirbsd.de>
X-X-Sender: tg@herc.mirbsd.org
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Andrew Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Peter Anvin <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, bp@alien8.de,
        fweimer@redhat.com, vapier@gentoo.org, hjl.tools@gmail.com,
        dalias@libc.org, x32@buildd.debian.org,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Can we drop upstream Linux x32 support?
In-Reply-To: <CAHk-=wi_Kp=3XmGDdzmadzFSPFvuL+aAJ6ZPAR=o4z=KwYT2vw@mail.gmail.com>
Message-ID: <Pine.BSM.4.64L.1812112150480.21176@herc.mirbsd.org>
References: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com>
 <CAHk-=wi_Kp=3XmGDdzmadzFSPFvuL+aAJ6ZPAR=o4z=KwYT2vw@mail.gmail.com>
Content-Language: de-DE-1901, en-GB
X-Message-Flag: Your mailer is broken. Get an update at http://www.washington.edu/pine/getpine/pcpine.html for free.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note: please keep me in Cc because I am not subscribed.

Linus Torvalds dixit:

>I'm not opposed to trying to sunset the support, but let's see who complains..

I will hereby complain.

I’m using Debian/x32 on my main desktop at work, and do
occasionally help out with porting issues. It’s a good
way to make more out of 64-bit machines without going
all 64 bit; it’s also helped me find bugs in software.
It’s a nice architectural idea, and a way forward for
things that are constricted to 32 bits while opening
up stuff like 64-bit time_t without taking up half the
available CPU registers (while more than doubling the
number of the available CPU registers, too).

I was also considering investing a nontrivial amount of
work into porting klibc to x32, since hpa does not wish
to do it himself. Thankfully I have only done a bit yet.

Furthermore, x32 was the first of the many *64ilp32
architectures; I know I’ve seen amd64ilp32 and at least
one other I don’t recall. It will have prototyped many
of the problems users of these will run in, and I’d prefer
to keep it (completely selfish because I don’t wish to
have to crossgrade a whole system yet again).

Thanks for your consideration,
//mirabilos
--  
When he found out that the m68k port was in a pretty bad shape, he did
not, like many before him, shrug and move on; instead, he took it upon
himself to start compiling things, just so he could compile his shell.
How's that for dedication. -- Wouter, about my Debian/m68k revival
