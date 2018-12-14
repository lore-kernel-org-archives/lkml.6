Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8402C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4550208C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=schoebel-theuer.de header.i=@schoebel-theuer.de header.b="ceHnaYiL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731041AbeLNVWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 16:22:44 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:27630 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730928AbeLNVWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 16:22:44 -0500
X-Greylist: delayed 378 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Dec 2018 16:22:42 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1544822561;
        s=strato-dkim-0002; d=schoebel-theuer.de;
        h=In-Reply-To:Date:Message-ID:From:References:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=PhoTtfHaxkHavh5sKoh5tXffz6R4azdKf5J/Gd0ZPXw=;
        b=ceHnaYiLWXNF5MXUkyy2GBsPvbj80Tvp1fDWk0QVlgqo+kwU72GOME1znucGKVF4jN
        7zTX7VSch2lQrM+7yAHTXfHwVXqFd58muydBekEk0/Crvl2chWd/J8J1x2GeDdOnwE4o
        vXo1skyXzQZzZ/OYVj2cITJPWz1sVrBtbEXk4tI7zczm6cOA4dNAeAuZtBf1s8tFrNjz
        LeoZywldWfmYxSe/7LBb/+TQB2JJAgLfS5vdWuZwoMeWQHwL0VrubogK0FlHP+nxaUA0
        v3mpW0UviQAMDizIW4OzobFxyXxZVTR4K/I75Ly40JEO+0bU12vYqGy+znJQrdl/w+yM
        KkTA==
X-RZG-AUTH: ":OH8QVVOrc/CP6za/qRmbF3BWedPGA1vjs2e0bDjfg8OiOrPJifeRMRhMbfKobJAvSmsJbFO0KIY="
X-RZG-CLASS-ID: mo00
Received: from [192.168.2.24]
        by smtp.strato.de (RZmta 44.8 DYNA|AUTH)
        with ESMTPSA id V03c59uBELGI6te
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 14 Dec 2018 22:16:18 +0100 (CET)
Subject: Re: Can we drop upstream Linux x32 support?
To:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Florian Weimer <fweimer@redhat.com>,
        Mike Frysinger <vapier@gentoo.org>,
        "H. J. Lu" <hjl.tools@gmail.com>, Rich Felker <dalias@libc.org>,
        x32@buildd.debian.org, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com>
From:   =?UTF-8?Q?Thomas_Sch=c3=b6bel-Theuer?= <thomas@schoebel-theuer.de>
Message-ID: <6577ac4f-524c-37f4-a4d0-6eb94ec7d9a5@schoebel-theuer.de>
Date:   Fri, 14 Dec 2018 22:16:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/18 02:23, Andy Lutomirski wrote:
> I'm seriously considering sending a patch to remove x32 support from
> upstream Linux.

I am downstream maintainer of several self-patched kernels at 1&1 Ionos. 
The kernels are rolled out to several tenthousands of production servers 
running in several datacenters and in multiple continents.

Currently, we have a few thousands of servers relying on 32bit ABIs in 
some thousands of VMs and/or containers of various types (LXC, OpenVZ, etc).

Here is my private opinion, not speaking for 1&1: at some point the 
future, 32bit userspace support needs to be dropped anyway, somewhen in 
future. This is inevitable in the very long term.

Thus the discussion should be about _timing_ / _roadmaps_, but not about 
the fact as such.

My suggestion:

1) please release / declare a new LTS kernel, with upstream support for 
at least 5 years (as usual). Currently, only 4.4 and 4.9 are marked as 
LTS. Either mark another existing stable kernel as LTS, or a future one.

2) please _announce_ _now_ that after the _next_ LTS kernel (whichever 
you want to declare as such), you will _afterwards_ drop the legacy 
32bit support for 64 kernels (I am deliberately using "management speak" 
here).

=> result: the industry should have to fair chance to deal with such a 
roadmap. Yes, it will hurt some people, but they will have enough time 
for their migration projects.

Example: I know that out of several millions of customers of webhosting, 
a very low number of them have some very old legacy 32bit software 
installed in their webspace. This cannot be supported forever. But the 
number of such cases is very small, and there just needs to be enough 
time for finding a solution for those few customers.

3) the next development kernel _after_ that LTS release can then 
immediately drop the 32bit support. Enterprise users should have enough 
time for planning, and for lots of internal projects modernizing their 
infrastructure. Usually, they will need to do this anyway in the long term.

A roadmap should be _reliable_ for planning, and there should be no 
"unexpected surprises". That's the most important requirements.

Notice: 5 years is what I know will very likely work for 1&1 Ionos. I 
cannot speak for other large-scale enterprise users, but I think most of 
them should be able to deal with suchalike intervals in a clear roadmap.


Addendum / side note: I know of cases where _critical_ / sometimes even 
proprietary 32bit enterprise software needs to run for several 
_decades_. Please don't drop KVM/qemu support for 32bit guests using 
_old_ (unchanged) 32bit kernels, which are just happen to run on 64bit 
hypervisors. But AFAICS that was not the intention of this initiative. 
Just keep the latter in mind as another (independent) requirement.


Cheers,

Thomas
