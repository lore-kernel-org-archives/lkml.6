Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E592C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D47FA20867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YV73AhsX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D47FA20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbeLAK5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 05:57:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:34528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726679AbeLAK5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 05:57:37 -0500
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE478214D9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 23:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543621597;
        bh=YXKGWjogybj0QGFdppQvo2L5E407T2U7e9VGAFRjA0U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YV73AhsXx992YaeXJtw1cKSB/1KjAD3vCnrltIuhx+mEIBJM3cd5x2px4pYDQM+MZ
         G4/nWNCATZceTQLyf8F84zsQsrA5IyHWDB9xGkEjyutE8ccKIl4ftRyrk3e4GT7E+A
         wuNtaTxLLq+L1qFOTT+5vWiSdfpSuJ4YLBATkg+U=
Received: by mail-wm1-f50.google.com with SMTP id n133so525301wmd.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 15:46:36 -0800 (PST)
X-Gm-Message-State: AA+aEWY9f9jZGxC9q0P/P/62LbjGAAreQGih0Tk8KrGQnUw30O8VUqbo
        7rE+A/fAC/ZXr5Et+epyzOnqmSeinbTLGh4FBGwERw==
X-Google-Smtp-Source: AFSGD/V2lAVA7vJ2qt1jorjARebAX/gbIFI2iuua8SeAffRzKuXz10tJleBOt04NLSS7zgHsQNWQKjlw+udtGCmXiHw=
X-Received: by 2002:a1c:110b:: with SMTP id 11mr617855wmr.83.1543621595048;
 Fri, 30 Nov 2018 15:46:35 -0800 (PST)
MIME-Version: 1.0
References: <20181120105124.14733-1-christian@brauner.io> <87in0g5aqo.fsf@oldenburg.str.redhat.com>
 <36323361-90BD-41AF-AB5B-EE0D7BA02C21@amacapital.net> <993B98AC-51DF-4131-AF7F-7DA2A7F485F1@brauner.io>
 <CALCETrWnQNMQcCmFZrftVVYgAMW6DT3gyxvVb_v9_enUCUkHiw@mail.gmail.com>
 <20181129195551.woe2bl3z3yaysqb6@brauner.io> <6E21165F-2C76-4877-ABD9-0C86D55FD6AA@amacapital.net>
 <CAK8P3a2i9DFaS9-3A9V_pKwFfwVR0bDqgLosmivge3Cx2VyiuQ@mail.gmail.com>
 <87y39b2lm2.fsf@xmission.com> <20181130065606.kmilbbq46oeycjp5@brauner.io>
 <CAK8P3a0kqPii5TwFAo_JHLX=o_FDMFVKXxgzzbDjLFZ7OQ5QCQ@mail.gmail.com>
 <CALCETrW2aphWwEY4=hUwo_JBCvkQyMjxzxGd9FCW017kMLaMOQ@mail.gmail.com>
 <CAK8P3a1isSRCd-OLJK15C+gSJdpeR=zEXghc8+AMM5QYYw3Tyg@mail.gmail.com>
 <EC87B1BE-BDD0-414F-85F8-806C3CC4DD07@brauner.io> <CAKOZuesEPFnkd7YGbu82TRQwhR=KPwNW8GpYTw=719_xmJx9FA@mail.gmail.com>
 <CAK8P3a2x3nQKKvLBSH8G9R6w+sv=09y3h7gWdFYUMNAsB8aj6g@mail.gmail.com> <7C5B4CBD-6364-4DCE-9EFD-3657C67DACEB@brauner.io>
In-Reply-To: <7C5B4CBD-6364-4DCE-9EFD-3657C67DACEB@brauner.io>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 30 Nov 2018 15:46:22 -0800
X-Gmail-Original-Message-ID: <CALCETrWcUQC_aeHRwVF0yr8GATndRU9277rQQ+caOcR1uJ1W9g@mail.gmail.com>
Message-ID: <CALCETrWcUQC_aeHRwVF0yr8GATndRU9277rQQ+caOcR1uJ1W9g@mail.gmail.com>
Subject: Re: [PATCH v2] signal: add procfd_signal() syscall
To:     Christian Brauner <christian@brauner.io>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Daniel Colascione <dancol@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Florian Weimer <fweimer@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 3:40 PM Christian Brauner <christian@brauner.io> wrote:
>
> On December 1, 2018 12:12:53 PM GMT+13:00, Arnd Bergmann <arnd@arndb.de> wrote:
> >On Sat, Dec 1, 2018 at 12:05 AM Daniel Colascione <dancol@google.com>
> >wrote:
> >> On Fri, Nov 30, 2018 at 2:26 PM Christian Brauner
> ><christian@brauner.io> wrote:
> >> > On December 1, 2018 11:09:58 AM GMT+13:00, Arnd Bergmann
> ><arnd@arndb.de> wrote:
> >> >
> >> > One humble point I would like to make is that what I care about
> >most is a sensible way forward without having to redo essential parts
> >of how syscalls work.
> >> > I don't want to introduce a sane, small syscall that ends up
> >breaking all over the place because we decided to fix past mistakes
> >that technically have nothing to do with the patch itself.
> >> > However, I do sympathize and understand these concerns.
> >>
> >> IMHO, it's fine to just replicate all the splits we have for the
> >> existing signal system calls. It's ugly, but once it's done, it'll be
> >> done for a long time. I can't see a need to add even more signal
> >> system calls after this one.
> >
> >We definitely need waitid_time64() and rt_sigtimedwait_time64()
> >in the very near future.
>
> Right, I remember you pointing this out in a prior mail.
> Thanks for working on this for such a long time now, Arnd!
> Can we agree to move on with the procfd syscall given the current constraints?
> I just don't want to see the syscall being
> blocked by a generic problem whose
> ultimate solution is to get rid of weird
> architectural constraints.

Creating and using a copy_siginfo_from_user64() function would work
for everyone, no?
