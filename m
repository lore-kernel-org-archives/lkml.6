Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFBAC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1875C2170D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sQ9ceGhD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1875C2170D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389118AbeHGU1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 16:27:41 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34837 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbeHGU1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 16:27:41 -0400
Received: by mail-pl0-f65.google.com with SMTP id w3-v6so7450106plq.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 11:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SQEKNpO0hpT7bkNsy39qmGPaZqXhTg3NHgpJCyWd7t0=;
        b=sQ9ceGhD5Irswr2brHyLaP3Irv0yb21kZephA7POiLcuE1M8VQepYuH1MbvSjRgqqh
         6B+WHriQgX4k82udIXbQ/issdW858SyAuZtRLIw8JM1VvgZICYu3xmHs+8eR5sL/mwv5
         ZI2WqlYD1h1GOZ1bklZ0gNBFR9xImA04IpD5r4UepaVhK9g5/Q/NXmeUyZyD4RNKmAll
         cHLEjb91bGoidiilgGKx/LYH9eNfj4chaGUSvTVYDkKKTp533sCovHITHSFfdb8Z6PaV
         lGtQ0bAUNIntFfWOjxx67fGkNDdtyJY016oha1QAVU4ePcBsbj/rkN3eCaRX8TtC7tMW
         vLYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SQEKNpO0hpT7bkNsy39qmGPaZqXhTg3NHgpJCyWd7t0=;
        b=ZcfD6f7BdM/tksL74g0Za+hpbGt8G21F8P5Zcq9nc/3NBEtc495sizZPhK76wqnjD9
         RC2E0Y0AZj4MJiKh7G27UCqo1QRHMf98m61SPghzRtyyZcc7XPjctvQb8i2EVT0Ie8lb
         eMbFKtdBD09Ebkbg6JX5M4Lynx4+1pesnLvWuMfgVkq7j8WSQIsmg5h7HH1KawUx/N98
         tGlBkrhQ2UAPTdyWBsICHZ3bfsrVAnWjNair833ijO2A6bCOmju59wlp+Xbm0qZRakv9
         /toZsipv73oo2cvNtVjDCC9rDkE66jbrKRqp7lLcU7Z6CNhupuUZF8sgcWTMAp9lUakO
         ErZQ==
X-Gm-Message-State: AOUpUlEe6eGaBXvnY89ukyoWsVQZiSKMSu9797Vh7JKslH5GmpvX0FEj
        8mJBFYLSe1RhpiHTrNz6f7nr02eIIj1098F9VTEugw==
X-Google-Smtp-Source: AAOMgpey35cl6cMf4yCA3y+Gq6NDuaPMBLFsaYyG6qDGU7IkL/AA4a/7OK6BXMNlkK2agTxgbUx/Lmt7wq4GZhhdpKg=
X-Received: by 2002:a17:902:6b0b:: with SMTP id o11-v6mr18646295plk.214.1533665527406;
 Tue, 07 Aug 2018 11:12:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180801182258.17834-1-ndesaulniers@google.com>
 <78c667f9-5c8b-3835-83eb-4b59e27e4f7e@bell.net> <CAKwvOdmdrA+UvAWyqe8sNJt5nxHXHsSwf5Yxih9HYgVL+kovxQ@mail.gmail.com>
 <fe7b57d8-b586-a390-31d2-2274f69db3c0@bell.net> <CAKwvOd=CLBFZRQ4HQb_+VCydDEvsbC2w2gD4hTwvp_jm1zqN9Q@mail.gmail.com>
 <54b2139b-53d2-01c5-f240-93a692cdbc59@bell.net> <CAKwvOdktvrZL8T_5K2VtQtgt_mscS7kzVXYVy0O7CSuGX53Y5A@mail.gmail.com>
 <536ef1b1-cfa2-f66d-4261-fb8405964632@bell.net> <CAKwvOdmwj76aESZNKhzfPmhfzGKvrfDut7oD5KAwA+VR-JukSg@mail.gmail.com>
 <80743c1c-2a8c-7bce-2068-24c63790eba7@bell.net> <CAKwvOdmDwO1U1sk=3-6zXFrVw6by1e_9VBx1WWMCx_rMqYSw-A@mail.gmail.com>
 <81a7e33a-0403-b6d4-fcba-c2168a608ba6@bell.net> <CAKwvOdmXi_EY5=sOO9tRqeoFrHjLsF9L988cGC2yjnFYBxac4w@mail.gmail.com>
 <1d577675-c337-d433-f235-1e46e5d56d4c@gmx.de>
In-Reply-To: <1d577675-c337-d433-f235-1e46e5d56d4c@gmx.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 7 Aug 2018 11:11:56 -0700
Message-ID: <CAKwvOdkABF9cxFxrtYo_mMWAunLL_ifM8+=H0On7WWcFmoN0Og@mail.gmail.com>
Subject: Re: [PATCH] parisc: prefer _THIS_IP_ and _RET_IP_ statement expressions
To:     deller@gmx.de
Cc:     dave.anglin@bell.net, jejb@parisc-linux.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-parisc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Alistair Strachan <astrachan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 3, 2018 at 3:34 PM Helge Deller <deller@gmx.de> wrote:
>
> On 03.08.2018 22:33, Nick Desaulniers wrote:
> > On Fri, Aug 3, 2018 at 12:09 PM John David Anglin <dave.anglin@bell.net> wrote:
> >>
> >> On 2018-08-03 2:11 PM, Nick Desaulniers wrote:
> >>> But the kernel uses the generic_THIS_IP_  *everywhere*, not parisc's
> >>> custom current_text_addr().  So if this did actually break unwinding,
> >>> you should have noticed by now.
> >> The unwind problem was noticed.
> >
> > So parisc is currently broken (doesn't unwind) due to the pervasive
> > use of _THIS_IP_ (generic C) throughout the kernel?
>
> I tested it on the 32bit kernel.
> The answer is: No. Unwinding works (with and without your patch).
>
> > If no, that implies this patch (generic C) causes no unwinding problems.
>
> correct.
>
> > If yes, that implies that the diff I posted later in this thread
> > (inline assembly) is preferable, and that parisc has bigger problems
> > (and probably needs to do rewrite the unwinding code to handle these
> > extra labels everywhere).
> >
> >> Patches were recently applied to gcc and binutils to try and fix it.
> >> The gcc patch moved
> >> branch tables to rodata so that the label at the head of the table
> >> wasn't in text.
> >>
> >> https://gcc.gnu.org/ml/gcc-patches/2018-07/msg01804.html
> >> https://sourceware.org/ml/binutils/2018-07/msg00474.html
> >>
> >> When I saw your suggested change, I realized there was another source of
> >> text labels
> >> that need linker relocations.
> >
> > Thank you for the links.
> >
> > On Fri, Aug 3, 2018 at 10:57 AM John David Anglin <dave.anglin@bell.net> wrote:
> >> The label breaks the unwind data, not the unwind code.  So, localizing
> >> the use of
> >> current_text_addr() to the parisc unwind code doesn't help.
> >
> > Have you confirmed that applying my patch breaks *the ability to
> > unwind correctly*?
>
> I tested your patch (on 32bit).
> Your patch does not break anything.
>
> > It looks like return_address() is used in
> > ftrace_return_address(), so I assume you can boot a kernel with my
> > patch applied, and CONFIG_FTRACE=y, then run:
> >
> > $ sudo trace-cmd record -p function date
> > $ trace-cmd report | grep date- | less
> >
> > and see if the stacks aren't unwound or look messed up.
>
> I faced issues with trace-cmd, but calling ftracing functions manually worked.
>
> So, your patch is basically OK and doesn't break anything.
> But I agree with Dave that Andrew, that THIS_IP is ugly.

I don't disagree, and other maintainers have remarked on _THIS_IP_
being ugly, but renaming it en masse is a tree wide change, which I'm
trying to avoid at the moment.

It sounds like we have a working patch? Are there 64b parisc machines
to test on, or can this get merged?
--
Thanks,
~Nick Desaulniers
