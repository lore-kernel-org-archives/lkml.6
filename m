Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8A9C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F162086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtzNQ55y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6F162086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbeLLSuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:50:40 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42648 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727897AbeLLSuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:50:39 -0500
Received: by mail-lf1-f66.google.com with SMTP id l10so14335448lfh.9;
        Wed, 12 Dec 2018 10:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YLwgMJD+1tBrr8wRp0pWBAexh0G8k6R3jdDuuvTpqA8=;
        b=VtzNQ55yzqOfKxjdMQ6R9g6PunkSPmMrDfI3v+tEGVwYEakTvffYRYtw1imEuXjAe+
         s3sCPjh80UhUyTgGCdHeIuI/u10CTtI58uCxCwHPP57lkfv42QkPXV/jwxgvrz6MtBDJ
         HX+U/OVHmoQNvDs99RBm95/HqNulfakvlBC1/8Qs7lLjnDVsKSMg7L3THbZDTqGYdP32
         iVBUReZCTbKCfCBqFUoH2nULAcoGEHUmaPOAtuRd/wuIgkolYG5CEIZ1dbyK+QrfRT3V
         AyfK9xaqb5UcU9ThUg14+ZHSBkHYCOa9SrXnQD2Jiu/1aWKgVP9e0ij8QeDnd3rnpe6q
         PDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YLwgMJD+1tBrr8wRp0pWBAexh0G8k6R3jdDuuvTpqA8=;
        b=qfcYFdQYQYhuALabHJbKGQcAvWG4MBVmPEHqtapVJgp0YW9qKw5OkXedsEY+3GIdnD
         XebTYPbu9hc/fT+6Qi2mQ8GOTYqWm7M/yxjaPvsqY+cIlQS7Rxs1c9OCVmshBzvnkAz7
         VcUO5UJQA8APcT4ZhW2K1Lt8nAhNbVb0cS1y5ip+/DL1/YJ32Ll/+rMqabOJy8xORnHz
         MY7qmaW6CyXD9fkArgHNJwj8RrtlV1xLb1IoTnVAQWDwvhUT2y0062PsEXVJVmM5UEb3
         +i1bjZovf5V7bG9ttglUwGLGYmg+L7/Mm2SpLVco/fuWzlSAyUp6JlMfUXVHfArjpMdo
         TVDw==
X-Gm-Message-State: AA+aEWY/W9H70nCOjTBwloU9cSXyoYLwwQvARQpxbkso3hq4wepGxV2x
        uRzOd8eV5w/vudOdmhPEWyMFAJOLVUFFcVnoo38=
X-Google-Smtp-Source: AFSGD/VwtquAZB/9wHPEdqtosTPDgeTVP9hmbB3CAbJfBoGlC/B7ocK9VeNH9puc4MvaAj0w8aqsztit1RwwHqiFlmc=
X-Received: by 2002:a19:945b:: with SMTP id w88mr11659238lfd.15.1544640637371;
 Wed, 12 Dec 2018 10:50:37 -0800 (PST)
MIME-Version: 1.0
References: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com>
 <CAHk-=wi_Kp=3XmGDdzmadzFSPFvuL+aAJ6ZPAR=o4z=KwYT2vw@mail.gmail.com>
 <Pine.BSM.4.64L.1812112150480.21176@herc.mirbsd.org> <CALCETrWgpAX7FV23zHmid83SsgnwFMKD4a_-xSEgB6v0kJR5sA@mail.gmail.com>
 <Pine.BSM.4.64L.1812112327500.21176@herc.mirbsd.org> <CALCETrXf0rmadycxmpGxd41qP9X+PAjyGHTwbGhKyp6oMKMRrA@mail.gmail.com>
 <Pine.BSM.4.64L.1812120231410.21176@herc.mirbsd.org> <CAK8P3a3yurujkdic98H02j0YfctSBf9NeXQreLZVhTzsttoc9g@mail.gmail.com>
 <alpine.DEB.2.21.1812121811080.21643@digraph.polyomino.org.uk>
In-Reply-To: <alpine.DEB.2.21.1812121811080.21643@digraph.polyomino.org.uk>
From:   Ivan Ivanov <qmastery16@gmail.com>
Date:   Wed, 12 Dec 2018 21:50:23 +0300
Message-ID: <CAAaskFA5cssU+fGAOUJO4u5XYBP6XYtSeWRhaSAr3BqOBTYjmw@mail.gmail.com>
Subject: Re: Can we drop upstream Linux x32 support?
To:     joseph@codesourcery.com
Cc:     arnd@arndb.de, tg@mirbsd.de, luto@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, hpa@zytor.com, peterz@infradead.org,
        bp@alien8.de, fweimer@redhat.com, vapier@gentoo.org,
        hjl.tools@gmail.com, dalias@libc.org, x32@buildd.debian.org,
        will.deacon@arm.com, catalin.marinas@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please don't drop x86 support from the Linux kernel ! You may not
realize it, but there are plenty of people who care about x86 systems.
I have a good old Pentium 4 based computer which is 32-bit, using it
for some weird Linux experiments + retro gaming, and if I can't run
new Linux kernels there - it would be SAD
=D1=81=D1=80, 12 =D0=B4=D0=B5=D0=BA. 2018 =D0=B3. =D0=B2 21:15, Joseph Myer=
s <joseph@codesourcery.com>:
>
> On Wed, 12 Dec 2018, Arnd Bergmann wrote:
>
> > > MIPS had o32, n32, n64 since like forever.
> >
> > o32 and n32 are practically the same, the only difference on the
> > syscall ABI that I can see are the actual syscall numbers, and
> > the 'struct sigcontext' definition.
>
> And for syscalls that have 64-bit arguments, n32 generally passes those i=
n
> a single register (like n64), not pairs of registers (like o32).  But,
> yes, userspace structure layout for n32 is generally much closer to o32
> than to n64.
>
> --
> Joseph S. Myers
> joseph@codesourcery.com
