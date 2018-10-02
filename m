Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC28CC64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B242082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5xL3CzO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B242082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbeJCDs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 23:48:28 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:34633 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbeJCDs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 23:48:27 -0400
Received: by mail-qt1-f182.google.com with SMTP id x23-v6so3655076qtr.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 14:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=VkoZ2yIxG8GAmnBDQGn45SRBeniN7Mu+biD4yjafnO4=;
        b=E5xL3CzO5vaHlLWPCC4NQ2qSBp2VoJHV5TdhWkW8/oPYQEzrFPfdmiplq/FgIB2rNa
         oLofU1aYLM0XxQXxsmPxeYknH1S9brcfy9VHznoha53/05UqxEs4sMundvXWov57RCrS
         CLtnEpcZI4hVXvdEf7pj4fodjM6JXxV+P0L5JMb6uLVblK0+zL3TCAnfXsjaoN+vgrwG
         BJKz0yvwq66duChTggZQ2fOhhfc2B8UL2FnQlJ1bQb4SuizT3ZOJhqNJ4g5xlFTwNnub
         vjeuT0AzZqhlX9JORudqr1jmeWZJtHtQoOwfvtvkLR/QxBciDyMKVsfNrCt0xj+Qxjb1
         dacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=VkoZ2yIxG8GAmnBDQGn45SRBeniN7Mu+biD4yjafnO4=;
        b=DfHiTIGArnadDzvHrpmSW9hlqY4az040PAMRb7w8vyQuBHz3uKmI2tIWg9wAyQgvul
         yez8jL/6xjKtGSom7jSSGZNWp6CmYclSGM/y6FNaBtv1c2SVsH4ASnEAXhEgaHTwJ/oc
         bwmBYaQP81f2JbGAJdStabemzS/KlF+Aju4440W47d8605GJYo5ld/v5ksWFuP/HwEVa
         9NRqeNjMaetzBbGo8IEmeEIQ4Fgj+lf2NCQvmlxtmUK/OzW01s791A1YjiNXOUj0COhM
         onGAhIBqmihM1BcBnWdkN8BSroK8IQ74S1176Zso5v1O7j/4sY2O60RS28D9/H/eRxBh
         FjgA==
X-Gm-Message-State: ABuFfohumS7R8OPXXjYlfYG8qLB+I03SF98qcs98KjTbgVJPMVoF4XKi
        B+kx50FWqGxmrNHSkTzeyaOSR4SO7XctAgXWCsQ=
X-Google-Smtp-Source: ACcGV63gSIzkazymglukuXsIhgPGwIswjoTLByyOMOElw2yZYXEAW9mWdyDj6Q4NaaLLFslc3d5zKmm0EgwK01NE7l4=
X-Received: by 2002:a0c:d212:: with SMTP id m18-v6mr14099034qvh.195.1538514192214;
 Tue, 02 Oct 2018 14:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAPhKKr9vWJ4d8yV7N4=XqaEyKEjC_ZiPX_2RJSR9ZiR9k6yS1w@mail.gmail.com>
 <20181002202256.vchh4j5k2wfjqdry@oracle.com>
In-Reply-To: <20181002202256.vchh4j5k2wfjqdry@oracle.com>
From:   Sasha Levin <levinsasha928@gmail.com>
Date:   Tue, 2 Oct 2018 17:03:01 -0400
Message-ID: <CA+1xoqc+aZkQ01oYwby9pvOv3rVh+Qm7t5iJZ1+iT+t19QY6oA@mail.gmail.com>
Subject: Re: [Announce] LPC 2018: Testing and Fuzzing Microconference
To:     dhaval.giani@gmail.com,
        Sasha Levin <alexander.levin@microsoft.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, alice.ferrazzi@gmail.com,
        khilman@baylibre.com, tbird20d@gmail.com,
        Dmitry Vyukov <dvyukov@google.com>, labbott@redhat.com,
        Steven Rostedt <rostedt@goodmis.org>,
        gustavo.padovan@collabora.co.uk, dan.carpenter@oracle.com,
        willy@infradead.org, knut.omang@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 2, 2018 at 4:44 PM Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
>
> * Dhaval Giani <dhaval.giani@gmail.com> [180919 13:15]:
> > Hi folks,
> >
> > Sasha and I are pleased to announce the Testing and Fuzzing track at
> > LPC [ 1 ]. We are planning to continue the discussions from last
> > year's microconference [2]. Many discussions from the Automated
> > Testing Summit [3] will also continue, and a final agenda will come up
> > only soon after that.
> >
> > Suggested Topics
> >
> > - Syzbot/syzkaller
> > - ATS
> > - Distro/stable testing
> > - kernelci
> > - kernelci auto bisection
> > - Unit testing framework
> >
> > We look forward to other interesting topics for this microconference
> > as a reply to this email.
> >
> > Thanks!
> > Dhaval and Sasha
> >
> > [1] https://blog.linuxplumbersconf.org/2018/testing-and-fuzzing-mc/
> > [2] https://lwn.net/Articles/735034/
> > [3] https://elinux.org/Automated_Testing_Summit
>
>
> Hello,
>
> I have a new way to analyze binaries to detect specific calls without
> the need for source.  I would like to discuss Machine Code Trace
> (MCTrace) at the Testing and Fuzzing LPC track.  MCTrace intercepts the
> application prior to execution and does not rely on a specific user
> input. It then decodes the machine instructions to follow all control
> flows to their natural conclusions.  This includes control flows that go
> beyond the boundaries of the static executable code into shared
> libraries. This new technique avoids false positives which could be
> produced by static analysis and includes paths that could be missed by
> dynamic tracing.  This type of analysis could be useful in both testing
> and fuzzing by providing a call graph to a given function.
>
> MCTrace was initially designed to help generate the seccomp() filter
> list, which is a whitelist/blacklist of system calls for a specific
> application. Seccomp filters easily become outdated when the application
> or shared library is updated. This can cause failures or security
> issues [ 1 ].  Other potential uses including examining binary blobs,
> vulnerability analysis, and debugging.

Hi Liam,

Is MCTrace available anywhere?


--
Thanks,
Sasha
