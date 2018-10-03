Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7630CC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4002089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsvrAnlE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D4002089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeJDBLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 21:11:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40433 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbeJDBLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 21:11:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id d2-v6so2768245wro.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 11:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kk6pF6vcdMqM3FfRiqhJiIfyAADPhETGUP1KO+Kfo+o=;
        b=QsvrAnlEGimipSS5uc807shIQVdB4gLTLpVVhcvPJl/DkC3mphRMA7/RjoWxQtJ8t2
         bEyyP9P0nBZkUpRybi5AAOP9xxtTpZM1wmvsMtuJdKVstMqAxCbqH2PPGiV/VpEmGlXy
         ykELLPwvCiX0bV4WG7hzZ88WzpkIMW0Fk+/Fu6o3HxW0rt1XoyKAHnxmNvJal2p4B8zB
         e3tO39hM9tY1h1VLQSl1V911loDzuQNU5K5pjIud9OTTJitVbI6J3Z05woxTUdZNs0FS
         nduROiIwoelIqDAs1Sl6kWF2zCQvlllDA7C03c0gc3ND6c8gpLKAQwb7vcz8IigQqUz6
         7Q7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kk6pF6vcdMqM3FfRiqhJiIfyAADPhETGUP1KO+Kfo+o=;
        b=naMJqU/0ncW0+1fqVtL1y0zOeSF21JNQPzzOe1SzCiqih9XziWqTmIfLksl9kIi603
         wjxeVIw8pNQgqo4wmBcVjowCpZ5bPBCByAYJlrHSMRLcYpmzXkEdB2M33ZWXHizQ6By3
         lZG1EyaQ95Hi1HGF54RcIIhHsc3eiSGDCY8nAWEPStRJFazs/7K7+OxF1/rKBSTLK8W+
         ZAmb/VFVcSuYSdepHQkw5YTJdb0AoOifZ9cfrh3N3s3Z7p90zdqQ8Yj/nS0HDmAZ6VWM
         XNPZSkcT1t7pz/GTptBXJu0o0Rp449SddSlw15V4qOMlycg4/lY06BDE2RmdMixn7RW8
         9jeg==
X-Gm-Message-State: ABuFfohz2C74WJRbGW880kzqASKgqpE7ceeDNJ5j6no3wUaS1blLKRNK
        XolJXGrMWmyNhFBXrqFcfMHUyl3Z4e1bi98T34kzKiuz
X-Google-Smtp-Source: ACcGV635G1cVxPdTu9x75QBA4aDaxjWJ39Es+1lrpjbMZ1od2rbLBZEOFxqzZkiqTYNCBKzBatEVXeLQNGUyUSg4IxY=
X-Received: by 2002:a5d:4c90:: with SMTP id z16-v6mr2066941wrs.239.1538590889747;
 Wed, 03 Oct 2018 11:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAPhKKr9vWJ4d8yV7N4=XqaEyKEjC_ZiPX_2RJSR9ZiR9k6yS1w@mail.gmail.com>
 <20181002202256.vchh4j5k2wfjqdry@oracle.com> <CA+1xoqc+aZkQ01oYwby9pvOv3rVh+Qm7t5iJZ1+iT+t19QY6oA@mail.gmail.com>
In-Reply-To: <CA+1xoqc+aZkQ01oYwby9pvOv3rVh+Qm7t5iJZ1+iT+t19QY6oA@mail.gmail.com>
From:   Dhaval Giani <dhaval.giani@gmail.com>
Date:   Wed, 3 Oct 2018 11:21:17 -0700
Message-ID: <CAPhKKr-qsWL55EbMd4BWnrf86cuhyt=t_onsHYekeN+iADpY3A@mail.gmail.com>
Subject: Re: [Announce] LPC 2018: Testing and Fuzzing Microconference
To:     levinsasha928@gmail.com, "Howlett,Liam" <liam.howlett@oracle.com>
Cc:     alexander.levin@microsoft.com, LKML <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org,
        Alice Ferrazzi <alice.ferrazzi@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Tim Bird <tbird20d@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Laura Abbott <labbott@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        gustavo.padovan@collabora.co.uk,
        "Carpenter,Dan" <dan.carpenter@oracle.com>, willy@infradead.org,
        knut.omang@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 2, 2018 at 2:03 PM Sasha Levin <levinsasha928@gmail.com> wrote:
>
> On Tue, Oct 2, 2018 at 4:44 PM Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
> >
> > * Dhaval Giani <dhaval.giani@gmail.com> [180919 13:15]:
> > > Hi folks,
> > >
> > > Sasha and I are pleased to announce the Testing and Fuzzing track at
> > > LPC [ 1 ]. We are planning to continue the discussions from last
> > > year's microconference [2]. Many discussions from the Automated
> > > Testing Summit [3] will also continue, and a final agenda will come up
> > > only soon after that.
> > >
> > > Suggested Topics
> > >
> > > - Syzbot/syzkaller
> > > - ATS
> > > - Distro/stable testing
> > > - kernelci
> > > - kernelci auto bisection
> > > - Unit testing framework
> > >
> > > We look forward to other interesting topics for this microconference
> > > as a reply to this email.
> > >
> > > Thanks!
> > > Dhaval and Sasha
> > >
> > > [1] https://blog.linuxplumbersconf.org/2018/testing-and-fuzzing-mc/
> > > [2] https://lwn.net/Articles/735034/
> > > [3] https://elinux.org/Automated_Testing_Summit
> >
> >
> > Hello,
> >
> > I have a new way to analyze binaries to detect specific calls without
> > the need for source.  I would like to discuss Machine Code Trace
> > (MCTrace) at the Testing and Fuzzing LPC track.  MCTrace intercepts the
> > application prior to execution and does not rely on a specific user
> > input. It then decodes the machine instructions to follow all control
> > flows to their natural conclusions.  This includes control flows that go
> > beyond the boundaries of the static executable code into shared
> > libraries. This new technique avoids false positives which could be
> > produced by static analysis and includes paths that could be missed by
> > dynamic tracing.  This type of analysis could be useful in both testing
> > and fuzzing by providing a call graph to a given function.
> >
> > MCTrace was initially designed to help generate the seccomp() filter
> > list, which is a whitelist/blacklist of system calls for a specific
> > application. Seccomp filters easily become outdated when the application
> > or shared library is updated. This can cause failures or security
> > issues [ 1 ].  Other potential uses including examining binary blobs,
> > vulnerability analysis, and debugging.
>
> Hi Liam,
>
> Is MCTrace available anywhere?
>

Sasha,

McTrace is an early prototype, really needing a lot of feedback. I
will let Liam send more details (some how he got dropped from the cc)

Dhavla

>
> --
> Thanks,
> Sasha
