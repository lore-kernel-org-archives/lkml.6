Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC10C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 22:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB9F21470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 22:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pR4+wdSB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB9F21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbeJDEwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 00:52:11 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40483 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725723AbeJDEwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 00:52:11 -0400
Received: by mail-qt1-f196.google.com with SMTP id e9-v6so7733553qtp.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 15:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xEEPCFf52nRFBMVWAXi5MbnjwSQJGXQbdy342ERi9/E=;
        b=pR4+wdSB8ntoerDl2g3VBFybYm4f6dhbQp/XqeFBysmrzyAEGMoDH+DlSDLs64T0f6
         0UDU9p9ow4Ch9pdYIrDpH4FWt72+ZGAfiD6fUZoyJTAp2sn8HLpsv/7ZjrrhvU65dhAx
         jLTqKo0On6L22OSpIhjFYEvOfnEYSmcwMjVuXD6vb1164qe+cLRcHvYFWhlXMvkB9nx+
         vRocGC0rrGVUWdpYN0GvQ0rQJ5crqHfvsshK3SHvPP2EYRo5RhjgBtL0rb5pt18RGPMP
         2tWs+jrvD8Ve+fyI2f238RYNAZtXRHlA1RQ7n9UbvPhbI3LElTFOR8b4DNsJ2QuPE7bA
         DC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xEEPCFf52nRFBMVWAXi5MbnjwSQJGXQbdy342ERi9/E=;
        b=evnQ077SsiWbuVUXnJevM+oE0/ebAek1M3/JCAj5Z6ObXrbD7cmOkJP4/eyxV7tVje
         GZolZwWNB5aoN74jJcAlzXW5Ppb7+IdFKEGzJURH8CGCq+YZwELQ44Sp0hcc+4PdnoNJ
         4oFX0Bqup2Z06V0fBATaPq4jZFI4rxMNlHUjS68H0C1nSGSHWnce7OWvxyGpAL+va2LW
         VLZlADuenDtDsEsU3xgUOJ8hQfsogFWEPmjobUk0/K2damie1UODwL4UhZdWehBdbo+d
         7K9d6b/oXQdvumSNfq2FxEEnnMZ5povQ0GuqkCZzKT4Lp7ba/aJw2QchPNmtdzNvezl/
         OIuA==
X-Gm-Message-State: ABuFfohilVqxfIoaUf0BhHsnLY3ODLNGRpE7+xXVO2GfMA8RlENuI3vT
        iwe5EoIzXVXx4YCuchSe0ZBgvbz6PQPk8/HhIK8=
X-Google-Smtp-Source: ACcGV62jfh7Nf6P5T4BYKlpLfoClRmUGdWaOYEyBvkURe9KUgaJOO484/HEpgQoBDYxSXiReRjV6QUqgbvN4153Bd8g=
X-Received: by 2002:ac8:23ed:: with SMTP id r42-v6mr3063193qtr.89.1538604116927;
 Wed, 03 Oct 2018 15:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAPhKKr9vWJ4d8yV7N4=XqaEyKEjC_ZiPX_2RJSR9ZiR9k6yS1w@mail.gmail.com>
 <20181002202256.vchh4j5k2wfjqdry@oracle.com> <CA+1xoqc+aZkQ01oYwby9pvOv3rVh+Qm7t5iJZ1+iT+t19QY6oA@mail.gmail.com>
 <20181003191600.ocbplbxdtikltavo@oracle.com>
In-Reply-To: <20181003191600.ocbplbxdtikltavo@oracle.com>
From:   Sasha Levin <levinsasha928@gmail.com>
Date:   Wed, 3 Oct 2018 18:01:45 -0400
Message-ID: <CA+1xoqf67X54baE7VpXrB_oTqj5JP3gZaq0VRGa8bhQaR7v2Yg@mail.gmail.com>
Subject: Re: [Announce] LPC 2018: Testing and Fuzzing Microconference
To:     Dhaval Giani <dhaval.giani@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alice Ferrazzi <alice.ferrazzi@gmail.com>,
        khilman@baylibre.com, Tim Bird <tbird20d@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, labbott@redhat.com,
        Steven Rostedt <rostedt@goodmis.org>,
        gustavo.padovan@collabora.co.uk, dan.carpenter@oracle.com,
        willy@infradead.org, knut.omang@oracle.com
Cc:     Liam.Howlett@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 3:16 PM Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
>
> * Sasha Levin <levinsasha928@gmail.com> [181002 17:03]:
> > On Tue, Oct 2, 2018 at 4:44 PM Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
> > >
> > > * Dhaval Giani <dhaval.giani@gmail.com> [180919 13:15]:
> > > > Hi folks,
> > > >
> > > > Sasha and I are pleased to announce the Testing and Fuzzing track at
> > > > LPC [ 1 ]. We are planning to continue the discussions from last
> > > > year's microconference [2]. Many discussions from the Automated
> > > > Testing Summit [3] will also continue, and a final agenda will come up
> > > > only soon after that.
> > > >
> > > > Suggested Topics
> > > >
> > > > - Syzbot/syzkaller
> > > > - ATS
> > > > - Distro/stable testing
> > > > - kernelci
> > > > - kernelci auto bisection
> > > > - Unit testing framework
> > > >
> > > > We look forward to other interesting topics for this microconference
> > > > as a reply to this email.
> > > >
> > > > Thanks!
> > > > Dhaval and Sasha
> > > >
> > > > [1] https://blog.linuxplumbersconf.org/2018/testing-and-fuzzing-mc/
> > > > [2] https://lwn.net/Articles/735034/
> > > > [3] https://elinux.org/Automated_Testing_Summit
> > >
> > >
> > > Hello,
> > >
> > > I have a new way to analyze binaries to detect specific calls without
> > > the need for source.  I would like to discuss Machine Code Trace
> > > (MCTrace) at the Testing and Fuzzing LPC track.  MCTrace intercepts the
> > > application prior to execution and does not rely on a specific user
> > > input. It then decodes the machine instructions to follow all control
> > > flows to their natural conclusions.  This includes control flows that go
> > > beyond the boundaries of the static executable code into shared
> > > libraries. This new technique avoids false positives which could be
> > > produced by static analysis and includes paths that could be missed by
> > > dynamic tracing.  This type of analysis could be useful in both testing
> > > and fuzzing by providing a call graph to a given function.
> > >
> > > MCTrace was initially designed to help generate the seccomp() filter
> > > list, which is a whitelist/blacklist of system calls for a specific
> > > application. Seccomp filters easily become outdated when the application
> > > or shared library is updated. This can cause failures or security
> > > issues [ 1 ].  Other potential uses including examining binary blobs,
> > > vulnerability analysis, and debugging.
> >
> > Hi Liam,
> >
> > Is MCTrace available anywhere?
>
> Hello Sasha,
>
> I missed this email as I was not CC'ed.

Sorry about that, I must have messed something up.

> MCTrace is currently a proof-of-concept and the source is not available.

What is the reason behind it not being available?

> There are a number of instructions that need additional work, but I have
> some test applications that can be analyzed.  I'd like to explain the
> concept, why it is useful, and debate other potential uses.

I have 2 concerns here:

1. This is an interesting new field to explore but since no one is
familiar with how this works, nor anyone can actually play and tinker
with it, I suspect that the ~30 min you'll have to discuss it will be
spent on describing how it works and answering basic questions. This
seems like a better fit for a refereed track session rather than MC.

2. In general, I don't think we can or should discuss a closed source
project. Sure, we can discuss the concept itself, but in that case I
don't see how it will benefit the community.

--
Thanks,
Sasha
