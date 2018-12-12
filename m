Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_MIXED_ES autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22F8C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F1420879
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=snewbury.org.uk header.i=@snewbury.org.uk header.b="XM7jsIYZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F1420879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=snewbury.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbeLLOpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 09:45:35 -0500
Received: from know-smtprelay-omc-11.server.virginmedia.net ([80.0.253.75]:56763
        "EHLO know-smtprelay-omc-11.server.virginmedia.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbeLLOpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 09:45:35 -0500
Received: from mail.snewbury.org.uk ([77.243.189.247])
        by cmsmtp with ESMTPA
        id X5lUgQkxAhtC0X5lUgNU6T; Wed, 12 Dec 2018 14:45:32 +0000
X-Originating-IP: [77.243.189.247]
X-Authenticated-User: sjnewbury@virginmedia.com
X-Spam: 0
X-Authority: v=2.3 cv=KJXu82No c=1 sm=1 tr=0 a=7eWGW6afXjFjJVQJLTi0Pg==:117
 a=7eWGW6afXjFjJVQJLTi0Pg==:17 a=IkcTkHD0fZMA:10 a=2ur7OfE09M0A:10
 a=4KbsWil0Dqb4rt546ZAA:9 a=P7_C82-sqWY_hZRs:21 a=1MS2vNhKCJGKZQS5:21
 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=snewbury.org.uk;
         h=content-transfer-encoding:mime-version:x-mailer:content-type
        :content-type:references:in-reply-to:date:date:from:from:subject
        :subject:message-id; s=eater; t=1544625930; x=1546440331; bh=VIX
        GhhuMptuRgLiLGn5B4vXHEkFze8nFYg8g4h+O810=; b=XM7jsIYZiGCBCqnRL6E
        3QvxhppTqOz65Ra3t3nnGs86zLju4kWy6PW/ldyDakZmhPxdyrZ3BhbCgo6ZaP+R
        7IMkY1Q22OIChyrH03pxhlnrEiJfdQsGri4PBNyHevsf7y1/roVDgxQJcliF4p33
        T+YbB04Kien68YwIFclOw3yA=
X-Virus-Scanned: amavisd-new at snewbury.org.uk
Received: from android-a9f8fd57ba190b44.media.snewbury.org.uk (android-a9f8fd57ba190b44.media.snewbury.org.uk [192.168.75.105] (may be forged))
        (authenticated bits=0)
        by mail.snewbury.org.uk (8.14.9/8.14.9) with ESMTP id wBCEjTUs012285
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 12 Dec 2018 14:45:29 GMT
Message-ID: <1544625960.117529.58.camel@snewbury.org.uk>
Subject: Re: Can we drop upstream Linux x32 support?
From:   Steven Newbury <steve@snewbury.org.uk>
To:     Rich Felker <dalias@libc.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        macro@linux-mips.org, tg@mirbsd.de, luto@kernel.org, arnd@arndb.de,
        s@ecloud.org, catalin.marinas@arm.com, fweimer@redhat.com,
        glaubitz@physik.fu-berlin.de, christian.brauner@canonical.com,
        hjl.tools@gmail.com, hpa@zytor.com
Date:   Wed, 12 Dec 2018 14:46:00 +0000
In-Reply-To: <20181212140147.GR23599@brightrain.aerifal.cx>
References: <1544605954.117529.27.camel@snewbury.org.uk>
         <20181212140147.GR23599@brightrain.aerifal.cx>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMIgZwkAVNsB0/sRf5tOZHOUMtF/0bXWrJrLjJGySSPB5oHFCa5X9pvq4T+3ZYdSvucTiIcoUsnPZB8f4ureiWifhOkzuM9uiKMGgELamgOWnzi+i7dM
 qX5HOFnrV+pKVi6aVY9+HoqO5FlnQNKq3yRcCru31AlQr/D6d5zZng1ikA0AiH/iCsuh/Zid+fT76x5kIkY1qClvO2023++a6bAxOIQPQPTQ9ZR/GK7AwgOR
 g2rrXCNPqxWbv04zPHBPW0u9Um/6Wkx182ldlAl8Iha1okTzNl70FQS84PKpEfWw9Ua2ammxcmxuwjf8lBH1TIv3o3t1gD12ubl2ajHRN3UfhyUnNKtYcDRm
 AEtX+YLV0A6Am1Ta2ip+36RVVnfoiP5loPRvGJoiCWJ23Lyp/S543H02YOEpJHxH6slenp9Nk1h2+0k/sQ8XgzX1Fv1ENAf8H5e/XS8uMs2YcZlVyebiO+a1
 VT9v9XCkBExTvl74nwFigKjUNRaJK2kn2qMZIA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On Wed, 2018-12-12 at 09:01 -0500, Rich Felker wrote:
> On Wed, Dec 12, 2018 at 09:12:34AM +0000, Steven Newbury wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA256
> > 
> > First off I'd like to request: Please don't break my userspace!
> > 
> > I have a number of systems running with x32-abi as native.  They
> > work
> > well, I've no want or desire to upgrade their memory or CPUs to
> > make
> > keep them working as well as they do now.  Let alone the hassle of
> > having to redeploy with a completely different ABI.
> > 
> > 
> > I've been working on getting as much userspace as I can working
> > with
> > x32 since it first became somewhat usable, I've sent patches
> > upstream
> > and pushed to encourage projects to write portable code.  Sometimes
> > that has meant just little tweaks to build systems, or sometimes
> > disabling asm where I consider it isn't worth the effort of making
> > it
> > work.  For other projects I've converted the asm or even in some
> > cases
> > got the JIT working, mozjs17 for example.
> > 
> > So I'm both a user and a developer.
> > 
> > Breaking support for x32 would be really bad for me, but if I'm the
> > only one using it I suppose I can't really justify it being kept on
> > that basis.  I know CERN has sucessfully experimented with it over
> > the
> > years though, so I wouldn't be surprised if there are other users
> > hiding out there.
> > 
> > I can't help but wonder if it wouldn't make more sense to drop x86
> > support from long mode than x32.  AMD64 x86 support was always
> > intended
> >  as a compatibility feature, I very much doubt there are more
> > people
> > out there using an x86 native userspace on a 64 bit kernel than
> > there
> 
> I am. The only reason I'm using a 64-bit kernel with it is to get the
> full 4GB address space for userspace rather than just 3GB. I suspect
> there are more users like me than like you.
> 
You may well be right, I lack any data either way.  I just find it hard
to believe I'm, what, one of two users of x32?

> Unlike x32, i386 is actually widely supported and works, and achieves
> most of the benefits of x32, but with marginally worse performance
> due
x32 works, and is widely supported by the fact that the vast majority
of free software is just a compile away.  Now, there are holes, I've
been trying to get Chromium/qtwebengine ported for the last couple of
weeks.

The performance isn't marginally worse, it's much worse, unless the
code in question is hand optimized SIMD or is otherwise not really
standard "IA32 ISA" anyway.

> to register scarcity, lack of native 64-bit arithmetic, bad function
> call ABI, and bad PC-relative addressing. For applications that
> aren't
Exactly, much worse.

> performance sensitive it's the right choice for shipping static
> binaries, especially if they may be memory-hungry, since it works on
> pretty much any box.
> 
When it comes to power usage and latency any code that runs often is
peformance senstitive.  I can't argue about shipping i386 static
binaries, they'll work on pretty much any *x86* box, I agree.

> > are native x32 users.  x86 support could be implemented via KVM
> > and/or
> > qemu-user.  There is no reason to keep the extra complexity in the
> > kernel for what is effectively an emulation layer anyway.
> 
> qemu-user is a non-solution. Not only does it result in being much
> slower and using more resources than just running a 64-bit userspace
> (defeating the purpose); it's also incapable of correctly emulating
> lots of corner cases. I've never been able to get it to work with
> thread cancellation, and doing so is fundamentally hard because it
> would require heavy emulation of signals rather than passing them
> through.
> 
What's the purpose?  Running IA32 binaries is for legacy.  You don't
run i386/IA32 binaries for the performance.  You use i386 as x32 was
intended, that's succifient for you.  Great.  I get the benefits I want
from an x32 userspace with amd64 binaries and libraries where it makes
sense as I understand does Thorsten.  Are you saying this wrong,
broken(?), and should be removed?

My point about qemu-user is that there is an alternative (non-)solution 
to legacy support in long mode, in addition to simply running an i386
kernel with or without virtualisattion.  If that's insufficient for
your use case of running an i386 userspace on an amd64 kernel that's
fair enough, and from your point of view is a *really* good reason for
not dropping i386 binary support... I feel the same way about x32! ;-)
-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEWa1B4K0Hk12RDstE+lAa6BzrmeAFAlwRHykACgkQ+lAa6Bzr
meAZegf/WnQN8rOekchuSDbohDlsnW114/E2cEpnyfMAR4T6pNbzjoPronTfYO+Y
yOWlQVgkImuJyjkupqKNa4FfQgCqEVav+p79G5SEeS+42kL5GyNlIgnYEjEjU2/i
hKZxpk9YNSgTVX2rMZiRJ9UoLmk8cVz7DhaRhlSvH0ZYeJD8vZYzBLaZvs9Z9Qps
xlh8S8sJA5v2vXHGg/iRMxmYT3nKfaH63cY9hCcpvxrcoIGV7UH5a4IDJ6ISCPzO
U8KEfllu7a6slHMLOzw52TVH4jk1XtmzfjNKQdAHP0lArbvNRI+JNLOz2syyx12P
P50Bh6ZBQ/OrEvf8z7Mdidz7Oqr04Q==
=6TKC
-----END PGP SIGNATURE-----

