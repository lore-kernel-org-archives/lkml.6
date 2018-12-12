Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9ADC67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A192084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRvqOzHn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A192084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbeLLTSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 14:18:37 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36739 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbeLLTSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 14:18:34 -0500
Received: by mail-lj1-f194.google.com with SMTP id g11-v6so17303060ljk.3;
        Wed, 12 Dec 2018 11:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ohMys6KHIPtUWunAD3pr18fITApz1/IHsTt+cu0pFrU=;
        b=ZRvqOzHnPzPNpJhVp1SU6NqYygcKSx/VOQwbCH7F2j2QMuYIgwaeP+6iPM8trkcZEF
         nWPRmV5SGzGZSfyZiPw4w1LGCynOyJLFY4AQkgbqQ87vthkwZ91eQkfbWzcsT7HJ++Oi
         SgMx2ZvCpWHRE0NhJs+5V4xXkWfif2U3GKr0Ql2aM3lqaVbCp4Cz3s07ptCJbG5GGhkG
         BI3uWTSrzsTTvdcOUXJae3q8I4SNbgzaKiJ6ZNwjen14CjxYcHMCs6rST48q1T0LzFUp
         +w2nP2K981qzv+RfYqa/uvS7HJppkZ+wa67NO6UUTr7a/+97DsWDWguJUHXC9CWU6xZH
         SY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ohMys6KHIPtUWunAD3pr18fITApz1/IHsTt+cu0pFrU=;
        b=a7JLloNT1v811qUqqSR1+sHDZOFjM+dzGktTGkA1RlCCmloHXA1UMq5VopyLHYqLwb
         +G4NfgLGwRx1aHZKqHodCa8bdUIXkZ+BDmO8pdSIgerEZCsp58JeLJz67U+a9N9+OG1m
         G0jQ/BiwZ7cuzRWyRPeSAE9Mylds+GKJUXT+VINH6j9GCWtS/lqBCyAjkjbXEyiOO8Qp
         ZmHdmiklCsn81GaBqOWq8OOQ41GbMCYxrQP0XvOn1h/0LBACyVkZpg3QAemmAB03ssXO
         OlUdjFejRjwi4tDN5cFo3myUAd9b+J/k+z4x7BBJqBzGceiWoFf+slRgr7/eAjBnGPGi
         IR8w==
X-Gm-Message-State: AA+aEWZtT/oIAaWO+W+LAer9LpRvxwLt0z0Cd6qVisEVTHVug0ySxqcC
        RnqwTjdcAShHQ17gH1MT4mLiHhuWHm6iAKQc2ug=
X-Google-Smtp-Source: AFSGD/WJuFT4gBF5g37NlwA010DSCJPMrhaKcnfwSaR23KuN2/hMlugc+/FpRvSqcjRCa89Myr+D3rtbSvfuG2qFRiU=
X-Received: by 2002:a2e:841:: with SMTP id g1-v6mr14039568ljd.21.1544642311647;
 Wed, 12 Dec 2018 11:18:31 -0800 (PST)
MIME-Version: 1.0
References: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com>
 <CAHk-=wi_Kp=3XmGDdzmadzFSPFvuL+aAJ6ZPAR=o4z=KwYT2vw@mail.gmail.com>
 <Pine.BSM.4.64L.1812112150480.21176@herc.mirbsd.org> <CALCETrWgpAX7FV23zHmid83SsgnwFMKD4a_-xSEgB6v0kJR5sA@mail.gmail.com>
 <Pine.BSM.4.64L.1812112327500.21176@herc.mirbsd.org> <CALCETrXf0rmadycxmpGxd41qP9X+PAjyGHTwbGhKyp6oMKMRrA@mail.gmail.com>
 <Pine.BSM.4.64L.1812120231410.21176@herc.mirbsd.org> <CAK8P3a3yurujkdic98H02j0YfctSBf9NeXQreLZVhTzsttoc9g@mail.gmail.com>
 <alpine.DEB.2.21.1812121811080.21643@digraph.polyomino.org.uk>
 <CAAaskFA5cssU+fGAOUJO4u5XYBP6XYtSeWRhaSAr3BqOBTYjmw@mail.gmail.com> <CALCETrUzyEENFc8rgDnbx9U-tALR4sjKsORjAwTY5ko1zzAVsQ@mail.gmail.com>
In-Reply-To: <CALCETrUzyEENFc8rgDnbx9U-tALR4sjKsORjAwTY5ko1zzAVsQ@mail.gmail.com>
From:   Ivan Ivanov <qmastery16@gmail.com>
Date:   Wed, 12 Dec 2018 22:18:18 +0300
Message-ID: <CAAaskFD3R1ha0TvrxZydW3NWAbg01rMAMmd400if4=nHVRhYkw@mail.gmail.com>
Subject: Re: Can we drop upstream Linux x32 support?
To:     luto@kernel.org
Cc:     joseph@codesourcery.com, arnd@arndb.de, tg@mirbsd.de,
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

My main reason on staying at Pentium 4 is that it does not contain
Intel ME backdoor (it came starting with Core 2 Duo)
=D1=81=D1=80, 12 =D0=B4=D0=B5=D0=BA. 2018 =D0=B3. =D0=B2 22:12, Andy Lutomi=
rski <luto@kernel.org>:
>
> On Wed, Dec 12, 2018 at 10:50 AM Ivan Ivanov <qmastery16@gmail.com> wrote=
:
> >
> > Please don't drop x86 support from the Linux kernel ! You may not
> > realize it, but there are plenty of people who care about x86 systems.
> > I have a good old Pentium 4 based computer which is 32-bit, using it
> > for some weird Linux experiments + retro gaming, and if I can't run
> > new Linux kernels there - it would be SAD
>
> Just to clarify: no one is proposing to drop 32-bit hardware support
> or normal x86 compatibility support from new kernels.
>
> That being said, you should seriously consider replacing that P4.
> Unless you live somewhere with *very* cheap power or you barely use
> it, replacing it will pay for itself quite quickly.
