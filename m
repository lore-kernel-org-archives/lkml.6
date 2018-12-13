Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2696C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B09432086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/KXkiOD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B09432086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbeLMPqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:46:36 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40912 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbeLMPqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 10:46:35 -0500
Received: by mail-qk1-f193.google.com with SMTP id y16so1366232qki.7;
        Thu, 13 Dec 2018 07:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E6eri7DERpU5AOSLUsbXMPV0GqnePrnLSVUgtfhWszE=;
        b=S/KXkiODv2W7QOfSUDruPhBBdCRupdFMC8ATReRcmvWAiYrZ1VYt+iU8BFcBSs4pgD
         D1lcXDmO7v+ZnZfLm2zqCFJ57FcpTdRzrL/eIWhlULW876EVZRsoYY8fxI0pguZKjrQR
         LFoc7BtDNbxohgLONDOEJi17qrK8JiI7LtFjxMNLGnfpk8KbyS+QPPFonSBR/LK5zy8U
         aUNLt7FZ4ZHL7QPiWYJQAOkiNHNzG2E7Yx51LaWf9aKXezKDUUfBkKvH6Br43WqRPzIC
         n3VH8AbZjj6ZKA0Rlixqt9TfbeRS8gmBzwv4Gzcf8isapuPZD5WlhCjz7tM8jkaIFdgG
         RM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E6eri7DERpU5AOSLUsbXMPV0GqnePrnLSVUgtfhWszE=;
        b=bvFz2nsv1z2eqMoGsmSWGUB/QpHDbIOzKTLG52FKOI3HM4iafw31oGMyvng11lJ9ym
         qtbh/Yu85EuGyQpkR/WjFwLcqsdHlMxHGcOik6hdQSLbakTQvjlbO/bCySlhl0ux49qT
         ra/25K6pwo2r2L7Xsd3nMgNJqPwe4RXX49cTnUtKtieNwTdkw/bpgFiGuCKPYPl1/InM
         KBmJ/bFkTl/BhavSqd+dDPi9XAsCVZ/JF1XVNG1CxRo4bTPztz26IEKnJ+pchZk9ECjB
         UKX5/f0nL6C4x+46fd0UwDVLs/RVrUZJoI5+sr880jFbvpQ973t5TP04UHwlc9ae8/vE
         yR/w==
X-Gm-Message-State: AA+aEWZYThK3zN6ZUyeu3qSQ8Es15eE8PVyiX8GmW/SjpbzBaLFW1jkL
        r3TvrO7w0H4ltRZqK7jcb/jWWF3v1Eh1MJkJqaU=
X-Google-Smtp-Source: AFSGD/U8WEEbjQDSrj0cBsMmviywryuFDX8s3UjsGxtYG/CC0l9lVo4YHmokrtYyQrEzvMoHZcG2hHnXAhbL0tgpgIY=
X-Received: by 2002:a37:99c5:: with SMTP id b188mr23381956qke.100.1544715994395;
 Thu, 13 Dec 2018 07:46:34 -0800 (PST)
MIME-Version: 1.0
References: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com>
 <CAHk-=wi_Kp=3XmGDdzmadzFSPFvuL+aAJ6ZPAR=o4z=KwYT2vw@mail.gmail.com> <CAOesGMgu1i3p7XMZuCEtj63T-ST_jh+BfaHy-K6LhgqNriKHAA@mail.gmail.com>
In-Reply-To: <CAOesGMgu1i3p7XMZuCEtj63T-ST_jh+BfaHy-K6LhgqNriKHAA@mail.gmail.com>
From:   Lance Richardson <lance.richardson.net@gmail.com>
Date:   Thu, 13 Dec 2018 10:46:23 -0500
Message-ID: <CAPmeqMrVqJm4sqVgSLqJnmaVC5iakjJ_OxGWo4eFbOCxKEx=GA@mail.gmail.com>
Subject: Re: Can we drop upstream Linux x32 support?
To:     olof@lixom.net
Cc:     torvalds@linux-foundation.org, luto@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        hpa@zytor.com, peterz@infradead.org, bp@alien8.de,
        fweimer@redhat.com, vapier@gentoo.org, hjl.tools@gmail.com,
        dalias@libc.org, x32@buildd.debian.org, arnd@arndb.de,
        will.deacon@arm.com, catalin.marinas@arm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 9:39 AM Olof Johansson <olof@lixom.net> wrote:
>
> On Tue, Dec 11, 2018 at 9:40 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Mon, Dec 10, 2018 at 5:23 PM Andy Lutomirski <luto@kernel.org> wrote:
> > >
> > > I'm seriously considering sending a patch to remove x32 support from
> > > upstream Linux.  Here are some problems with it:
> >
> > I talked to Arnd (I think - we were talking about all the crazy ABI's,
> > but maybe it was with somebody else) about exactly this in Edinburgh.
> >
> > Apparently the main real use case is for extreme benchmarking. It's
> > the only use-case where the complexity of maintaining a whole
> > development environment and distro is worth it, it seems. Apparently a
> > number of Spec submissions have been done with the x32 model.
> >
> > I'm not opposed to trying to sunset the support, but let's see who complains..
>
> I'm just a single user. I do rely on it though, FWIW.
>
> I hadn't finished my benchmarking in Edinburgh, but for my new machine
> that does kernel builds 24/7, I ended up going with x32 userspace (in
> a container).
>
> Main reason is that it's a free ~10% improvement in runtime over
> 64-bit. I.e. GCC-as-a-workload is quite a bit faster as x32,
> supposedly mostly due to smaller D cache footprints (I ran out of
> cycles to tinker with back and forth perf data collection and settled
> down on just running it).
>
> Running classic 32-bit (i386? i686? whatever it's called) is about
> half as good. I.e. even then I get a ~5% performance win. Less than
> x32, but still better than 64-bit userspace.
>
>
> -Olof

I'm familiar with two embedded Linux systems using x32 ABI for the
following reasons:
   - Significant performance benefits over i386 ABI.
   - Smaller memory footprint than x86_64 (pointer-heavy data structures)
   - Large legacy software base with many ILP32 assumptions, much
     smaller effort to move to x32 than x86_64.

Some examples of (relatively minor) problems encountered with x32:
   - Time-related data type mismatch in socket options (fixed)
     https://patchwork.ozlabs.org/patch/904254/

   - Userspace overrun with select() (patch proposed)
     https://patchwork.kernel.org/patch/10245677/

   - glibc get_phys_pages() doesn't work correctly with x32
     (assumes that struct sysinfo fields are not wider than "long").

So, one small vote for keeping x32 with the hope that support for it
can continue to be improved...

   - Lance
