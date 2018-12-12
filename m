Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CB1C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 276DB20873
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544641967;
	bh=3WSChpvIXB1c7K3KZdENrnon2UHVwW9t4DsguHNug/A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lTb690ExcrQSFSzDVZD7WwaYN6l8RW8c/G+Y1lByGKzIjiMhLH9GXQasGClan2Kp/
	 CGWhIGAocS8mNIRXkt4RK12hdyAcS9DtTtyzAgf8iyPtXq3EEafHrD1YXO6caddzfm
	 MLeEcCznZ6Jaq7iKAMxeMqiBQp8QWnFDkzx755/A=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 276DB20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbeLLTMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 14:12:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:54208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726490AbeLLTMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 14:12:45 -0500
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C4CB2145D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 19:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544641965;
        bh=3WSChpvIXB1c7K3KZdENrnon2UHVwW9t4DsguHNug/A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wTw1Vd4UseB/Y7od8J9pYswmPbmmreqqc7M15o0+Va5e52hqvPnGwk6iQKiA8328K
         iZGKQ+T5u3hhsPOPoF047zbYNod230PGWhauNX2oacNX/sRF7ThIfFVr6OgmSBUVgd
         ah3Nn+D5dNP+bgvaZ3OGsOQ6Kl411PMDOlK5eDrQ=
Received: by mail-wr1-f47.google.com with SMTP id b14so18808101wru.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 11:12:44 -0800 (PST)
X-Gm-Message-State: AA+aEWazSu35Q/9+qQmxiX1AC8+t9wf5bGLWmEf/4q6cORmxEkBhSoMZ
        EZm+QejIid2+SsSgAV3yqVwFemFp5vlURzZE4chkbg==
X-Google-Smtp-Source: AFSGD/VlNLg/0Fu4XsMoy9GnPUeKRMSmBxcUC9XKlp2dcZNSqOKzVpq2/c6cwhjD5g+vcv6DInE6ak0vkHtePFMWWdU=
X-Received: by 2002:adf:8323:: with SMTP id 32mr17606044wrd.176.1544641963333;
 Wed, 12 Dec 2018 11:12:43 -0800 (PST)
MIME-Version: 1.0
References: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com>
 <CAHk-=wi_Kp=3XmGDdzmadzFSPFvuL+aAJ6ZPAR=o4z=KwYT2vw@mail.gmail.com>
 <Pine.BSM.4.64L.1812112150480.21176@herc.mirbsd.org> <CALCETrWgpAX7FV23zHmid83SsgnwFMKD4a_-xSEgB6v0kJR5sA@mail.gmail.com>
 <Pine.BSM.4.64L.1812112327500.21176@herc.mirbsd.org> <CALCETrXf0rmadycxmpGxd41qP9X+PAjyGHTwbGhKyp6oMKMRrA@mail.gmail.com>
 <Pine.BSM.4.64L.1812120231410.21176@herc.mirbsd.org> <CAK8P3a3yurujkdic98H02j0YfctSBf9NeXQreLZVhTzsttoc9g@mail.gmail.com>
 <alpine.DEB.2.21.1812121811080.21643@digraph.polyomino.org.uk> <CAAaskFA5cssU+fGAOUJO4u5XYBP6XYtSeWRhaSAr3BqOBTYjmw@mail.gmail.com>
In-Reply-To: <CAAaskFA5cssU+fGAOUJO4u5XYBP6XYtSeWRhaSAr3BqOBTYjmw@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 12 Dec 2018 11:12:31 -0800
X-Gmail-Original-Message-ID: <CALCETrUzyEENFc8rgDnbx9U-tALR4sjKsORjAwTY5ko1zzAVsQ@mail.gmail.com>
Message-ID: <CALCETrUzyEENFc8rgDnbx9U-tALR4sjKsORjAwTY5ko1zzAVsQ@mail.gmail.com>
Subject: Re: Can we drop upstream Linux x32 support?
To:     qmastery16@gmail.com
Cc:     "Joseph S. Myers" <joseph@codesourcery.com>,
        Arnd Bergmann <arnd@arndb.de>, tg@mirbsd.de,
        Andrew Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Florian Weimer <fweimer@redhat.com>,
        Mike Frysinger <vapier@gentoo.org>,
        "H. J. Lu" <hjl.tools@gmail.com>, Rich Felker <dalias@libc.org>,
        x32@buildd.debian.org, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 10:50 AM Ivan Ivanov <qmastery16@gmail.com> wrote:
>
> Please don't drop x86 support from the Linux kernel ! You may not
> realize it, but there are plenty of people who care about x86 systems.
> I have a good old Pentium 4 based computer which is 32-bit, using it
> for some weird Linux experiments + retro gaming, and if I can't run
> new Linux kernels there - it would be SAD

Just to clarify: no one is proposing to drop 32-bit hardware support
or normal x86 compatibility support from new kernels.

That being said, you should seriously consider replacing that P4.
Unless you live somewhere with *very* cheap power or you barely use
it, replacing it will pay for itself quite quickly.
