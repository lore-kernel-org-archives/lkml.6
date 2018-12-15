Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891E9C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 05:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C8521721
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 05:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbeLOFDk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 00:03:40 -0500
Received: from static-87-79-237-121.netcologne.de ([87.79.237.121]:2499 "EHLO
        herc.mirbsd.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729245AbeLOFDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 00:03:40 -0500
Received: from herc.mirbsd.org (tg@herc.mirbsd.org [192.168.0.82])
        by herc.mirbsd.org (8.14.9/8.14.5) with ESMTP id wBF4rmGx012362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 15 Dec 2018 04:53:50 GMT
Date:   Sat, 15 Dec 2018 04:53:48 +0000 (UTC)
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
In-Reply-To: <CALCETrUYn=S=hmJ0tKdm2LoSgkWchY2_65sH7hJZp7wfS30giw@mail.gmail.com>
Message-ID: <Pine.BSM.4.64L.1812150450500.18185@herc.mirbsd.org>
References: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com>
 <CAHk-=wi_Kp=3XmGDdzmadzFSPFvuL+aAJ6ZPAR=o4z=KwYT2vw@mail.gmail.com>
 <Pine.BSM.4.64L.1812112150480.21176@herc.mirbsd.org>
 <CALCETrWgpAX7FV23zHmid83SsgnwFMKD4a_-xSEgB6v0kJR5sA@mail.gmail.com>
 <Pine.BSM.4.64L.1812112327500.21176@herc.mirbsd.org>
 <CALCETrXf0rmadycxmpGxd41qP9X+PAjyGHTwbGhKyp6oMKMRrA@mail.gmail.com>
 <Pine.BSM.4.64L.1812120231410.21176@herc.mirbsd.org>
 <CALCETrUYn=S=hmJ0tKdm2LoSgkWchY2_65sH7hJZp7wfS30giw@mail.gmail.com>
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

>x32 is not this at all.  The kernel ABI part of x32 isn't ILP32.  It's
>IP32, 32-bit size_t, and *64-bit* long.  The core kernel doesn't

Yeah, I was looking at this from userspace PoV, as I said I’m not
a Linux kernel programmer.

In BSD we have register_t which is probably the equivalent to your
__kernel_long_t? Maybe removing the “long” from the name helps.

But yes, x32 is just a (second to i386) ILP32 userspace API in an
amd64 kernel. This does imply mapping on the userspace (x32) to
kernel (amd64) boundary and back. I would have thought full struct
member mapping, as dalias described, to be the most robust.

>something similar to work using the normal x86_64 syscalls.  And I'm

But those would require the longer structs etc. and therefore
lose all the benefits of x32…

bye,
//mirabilos
-- 
„Cool, /usr/share/doc/mksh/examples/uhr.gz ist ja ein Grund,
mksh auf jedem System zu installieren.“
	-- XTaran auf der OpenRheinRuhr, ganz begeistert
(EN: “[…]uhr.gz is a reason to install mksh on every system.”)
