Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD915C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D852084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:39:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D852084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mirbsd.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbeLLCjB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 21:39:01 -0500
Received: from static-87-79-237-121.netcologne.de ([87.79.237.121]:48017 "EHLO
        herc.mirbsd.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbeLLCjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 21:39:01 -0500
Received: from herc.mirbsd.org (tg@herc.mirbsd.org [192.168.0.82])
        by herc.mirbsd.org (8.14.9/8.14.5) with ESMTP id wBC2XuIu018245
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 12 Dec 2018 02:33:57 GMT
Date:   Wed, 12 Dec 2018 02:33:56 +0000 (UTC)
From:   Thorsten Glaser <tg@mirbsd.de>
X-X-Sender: tg@herc.mirbsd.org
To:     Andy Lutomirski <luto@kernel.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Florian Weimer <fweimer@redhat.com>,
        Mike Frysinger <vapier@gentoo.org>,
        "H. J. Lu" <hjl.tools@gmail.com>, Rich Felker <dalias@libc.org>,
        x32@buildd.debian.org, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Can we drop upstream Linux x32 support?
In-Reply-To: <CALCETrXf0rmadycxmpGxd41qP9X+PAjyGHTwbGhKyp6oMKMRrA@mail.gmail.com>
Message-ID: <Pine.BSM.4.64L.1812120231410.21176@herc.mirbsd.org>
References: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com>
 <CAHk-=wi_Kp=3XmGDdzmadzFSPFvuL+aAJ6ZPAR=o4z=KwYT2vw@mail.gmail.com>
 <Pine.BSM.4.64L.1812112150480.21176@herc.mirbsd.org>
 <CALCETrWgpAX7FV23zHmid83SsgnwFMKD4a_-xSEgB6v0kJR5sA@mail.gmail.com>
 <Pine.BSM.4.64L.1812112327500.21176@herc.mirbsd.org>
 <CALCETrXf0rmadycxmpGxd41qP9X+PAjyGHTwbGhKyp6oMKMRrA@mail.gmail.com>
Content-Language: de-DE-1901, en-GB
X-Message-Flag: Your mailer is broken. Get an update at http://www.washington.edu/pine/getpine/pcpine.html for free.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski dixit:

>That’s the thing, though: the whole generic kernel compat
>infrastructure assumes there are at most two ABIs: native and, if
>enabled and relevant, compat. x32 breaks this entirely.

MIPS had o32, n32, n64 since like forever.

ARM has old ABI, EABI and now 64-bit.

Other architectures are yet to come.

>IMO the real right solution would be to push the whole problem to
>userspace: get an ILP32 system working with almost or entirely LP64

Is this a reflex of Linux kernel developers? ;-)

I doubt that userspace is the right place for this, remember
the recent glibc vs. syscalls debate. It would also need to
multiply across various libcs.

>How hard would it be to have __attribute__((ilp64)), with an optional
>warning if any embedded structs are not ilp64?  This plus a wrapper to

You mean LP64. Impossible, because LP64 vs. ILP32 is not the only
difference between amd64 and x32.

bye,
//mirabilos
-- 
I believe no one can invent an algorithm. One just happens to hit upon it
when God enlightens him. Or only God invents algorithms, we merely copy them.
If you don't believe in God, just consider God as Nature if you won't deny
existence.		-- Coywolf Qi Hunt
