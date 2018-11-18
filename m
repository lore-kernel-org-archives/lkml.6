Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2197CC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 20:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1A52080C
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 20:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wo3uqXtn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF1A52080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbeKSGms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 01:42:48 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:45446 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727671AbeKSGms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 01:42:48 -0500
Received: by mail-vs1-f66.google.com with SMTP id v10so9217837vsv.12
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 12:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DGFDQgKhh1QSPF8UQGe0rotLIIhZZoECh1I7MoF7v6o=;
        b=Wo3uqXtn1CWKiLdfQaPdgacv7+w4aEgolG7oYeStI2vhxX8AsKXBErrdeqlfoTyKIN
         jC4Rta4vR2b4NZ0u42EM5A1gOigXbHKb5ENn+YPzfi8+cV95pddfxZhzmoyLL0b7r4hR
         XPn7TlfJfx/W6EYutmz1Ro2ZBOXBWaRWkW/emkrsWXfspGc7SiqrpDzkl6akMBb0eT8u
         SRYO8yqBgXuBHmmXbNsuOQ93ia7rCa5RvjD55FIAIPJqUxmk9SCw2BVbZajbE2pLeh1V
         jEZL7k4SywLxQCmcE3LTKsyRZ996NK6BPHy2STkXneRkSmRC+6aJ2wXD+92364hTvzjj
         zqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DGFDQgKhh1QSPF8UQGe0rotLIIhZZoECh1I7MoF7v6o=;
        b=JwoETwEBEvt4vbYsA7T5CCfCWxT93nFCEYz1etE3qBExq//qfpsCvAKADq3fTFlxB9
         ibGGpbIOwynvRO05E+6aXI6cNN3S0JkgvCKJstsu8ca6SZmukF4KBHWQ1xZkQrpFbN/L
         pGwMkNBrlDTqgyki5WAVzOpQE00sAfOHfYe4bHT53zSzyCSKlGFUw/BprCXH9W+eGtbB
         nP7vKQTZhC7W0KRU7CX3vUMe6k+sg5ZodmJY1JlX4+ZUyBMssJdLpXghj6VB/GE8yGV8
         RGGV0cpUoGWrtidCdcdD4umRRznXF2HBeLM4uOLyfFW3vfQEh8MAdCcJIgbr7dgln4Yi
         UF5Q==
X-Gm-Message-State: AGRZ1gLBR0Rm4g+edQPz8AUlEAwjBnTm1I15dK+Y2aIc1+M8Y2oIO57C
        bznrFc6PLB1BmOiMg/uXdZkyPm0yj+jNQh/PwG0Dcg==
X-Google-Smtp-Source: AJdET5fYZJ13dVyOLn+6McqPG6SK0mnln5sW7z8vNQujZbOk+VuMWvclwNRIvpH2YImD1z92vHkFz82cBKp+xAWNbPI=
X-Received: by 2002:a67:105:: with SMTP id 5mr7854171vsb.183.1542572492639;
 Sun, 18 Nov 2018 12:21:32 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Sun, 18 Nov 2018 12:21:31
 -0800 (PST)
In-Reply-To: <20181118201514.c5ujdjav6ccodyff@brauner.io>
References: <a7f50692-667c-4efe-a2d0-fa324eebb90b@infradead.org>
 <CAKOZueutLc8d0Fe+7dNWiZKnALhTSST8+kCnOrL+OmB6coUmtA@mail.gmail.com>
 <CALCETrVg71XBv-gMOtL-m0Dd0HNz8_oXOUDSWin5LeViAL0UYA@mail.gmail.com>
 <CAKOZuesCKo4GH9fdum2EUFLrtTWam3aizcDQUn3-vCYg4T1P8w@mail.gmail.com>
 <CALCETrUeNZPfrSYa9vH5Ukrk1Y+Kb9GkZOh6LkqG6Z9NpK5P0w@mail.gmail.com>
 <CAKOZuevVk_aH_2TuiNcmxgMa+gHXMBXz6Uu5a6TDjoxjhaE36g@mail.gmail.com>
 <CALCETrVscRwQG55-j1SKc2TmSb1-=5861804ojUuviNzdyDOrA@mail.gmail.com>
 <CAKOZuevRq-igh06zS_nsGG400zXrKFCtajpEG9-xgU2+Rtb2Pw@mail.gmail.com>
 <20181118190504.ixglsqbn6mxkcdzu@yavin> <CAKOZuetfqvn1uVqKJ=16iEzG4g449YOjC_tLM60eKBSkv9u+bQ@mail.gmail.com>
 <20181118201514.c5ujdjav6ccodyff@brauner.io>
From:   Daniel Colascione <dancol@google.com>
Date:   Sun, 18 Nov 2018 12:21:31 -0800
Message-ID: <CAKOZuesXN1qBYKvkTt2StX-07vM0msGvmgqiRvh-+=aaTX4A8Q@mail.gmail.com>
Subject: Re: [PATCH] proc: allow killing processes via file descriptors
To:     Christian Brauner <christian@brauner.io>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jan Engelhardt <jengelh@inai.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 12:15 PM, Christian Brauner
<christian@brauner.io> wrote:
>> That is, I'm proposing an API that looks like this:
>>
>> int process_kill(int procfs_dfd, int signo, const union sigval value)
>
> I've started a second tree with process_signal(int procpid_dfd, int sig)

Thanks.

> instead of an ioctl(). Why do you want sigval too?

API completeness. The sigqueue interface is a superset of kill, and I
don't want process_kill to do less than any PID-based kill. Maybe
taking a siginfo_t, like rt_sigqueueinfo does, would be even better in
that respect, come to think of it.
