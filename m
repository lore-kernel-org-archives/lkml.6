Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5F3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF76A20675
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZvnbnsVu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfBVS3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:29:11 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44453 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfBVS3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:29:11 -0500
Received: by mail-lf1-f66.google.com with SMTP id g2so2431035lfh.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 10:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=q5KIu6uaZFDkSQO3L2AywLVJH2PitpHesmtfdq5kDzY=;
        b=ZvnbnsVujoVnt26B73/aPofP3igWVEUzWwij7xMfMH+SrEH/8mTQwMzdZXGc3OgM5Q
         BwRWwbEqbeQBng5HiGQZ6/arq50S0+6RZaYKooZIvRfFCIKzmrg5HW6gIZvJQFYhVqBh
         zzyKkUY0kmtHunuYMVqDFf+WcSLgXZ48FdOdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q5KIu6uaZFDkSQO3L2AywLVJH2PitpHesmtfdq5kDzY=;
        b=il77sRYjB9ADuQVo1ExuAZH8LqJtskEQpkTLoT/fqd/E79iJzlEKVxjJBCGM/70bXi
         7SKNp76H93cIo0hUJS0Nt2mcZHOW02RGjjXBGdErInfkYX0SqjkgEMn5ybqoHrCCKl6z
         6SQwWuYyqJJ9jZikAPFawwGdomtqD8rDsNilctXmT/7tesTi62EgjB7EBX1EV/lYVfTe
         uYBGjQo75DuRtMhYU0Dt8y3iIx4B//NWxo2O9jDAX9yiRDbgYVmALZL6BwpBlMHx98t7
         06TA0Nb47N/k8opBv+eQhUNOKcBQwn0UD3DoWf6yJeuXPXDlyoWBkQ8Hhomt9rQB9I4n
         4kQw==
X-Gm-Message-State: AHQUAuYi+5l2e17evaFb6T6cDOTx0n++WVKNivInAYZHJB4nK9cNkoug
        PJx/IQ5SHN4SaYKP5BlPD88eLuZ9TB4=
X-Google-Smtp-Source: AHgI3IYhuhZ1VpbV1Xq/8Lw4BFD3hLmZhTTxQCkH7s3FQHZRbLa9lPFQUqzXTt+g1KnAbSHKtG5lig==
X-Received: by 2002:a19:cbc6:: with SMTP id b189mr372241lfg.34.1550860148057;
        Fri, 22 Feb 2019 10:29:08 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id e23sm642486ljj.3.2019.02.22.10.29.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 10:29:06 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id d24so2165303ljc.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 10:29:06 -0800 (PST)
X-Received: by 2002:a2e:6e09:: with SMTP id j9-v6mr3045055ljc.118.1550860146100;
 Fri, 22 Feb 2019 10:29:06 -0800 (PST)
MIME-Version: 1.0
References: <20190215174712.372898450@goodmis.org> <20190215174945.557218316@goodmis.org>
 <CAHk-=wjP4bEYCFaKZVG4kLWmYBctyfsW9jjhC91tiTk9WwB8Rg@mail.gmail.com>
 <20190215171539.4682f0b4@gandalf.local.home> <300C4516-A093-43AE-8707-1C42486807A4@amacapital.net>
 <20190215191949.04604191@gandalf.local.home> <CAHk-=wgJzNp0R3cVhjBPHTR4X9sOvHdqK4UVFfbsOKQ6L=A_eQ@mail.gmail.com>
 <CAHk-=wh9XrOykA5J9RQ7zaBio-S_D+1AE+rGnBYWSd==pCXh+w@mail.gmail.com>
 <20190219111802.1d6dbaa3@gandalf.local.home> <CAHk-=wgTuK3kAduP-gr10vykT1uG=B2VpdffvmyBuTQ1UxPpMg@mail.gmail.com>
 <20190219140330.5dd9e876@gandalf.local.home> <20190220171019.5e81a4946b56982f324f7c45@kernel.org>
 <20190220094926.0ab575b3@gandalf.local.home> <20190222172745.2c7205d62003c0a858e33278@kernel.org>
 <20190222173509.88489b7c5d1bf0e2ec2382ee@kernel.org> <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com>
 <AD9148E4-00CC-4711-82D3-957D28497057@amacapital.net>
In-Reply-To: <AD9148E4-00CC-4711-82D3-957D28497057@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Feb 2019 10:28:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=whX6LLVn_q2DC0K37iQgZ4S0LX6mR46+O2TNufJuR-K6Q@mail.gmail.com>
Message-ID: <CAHk-=whX6LLVn_q2DC0K37iQgZ4S0LX6mR46+O2TNufJuR-K6Q@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 9:48 AM Andy Lutomirski <luto@amacapital.net> wrote=
:
>
> > On Feb 22, 2019, at 9:43 AM, Linus Torvalds <torvalds@linux-foundation.=
org> wrote:
> >
> > Then we should still probably fix up "__probe_kernel_read()" to not
> > allow user accesses. The easiest way to do that is actually likely to
> > use the "unsafe_get_user()" functions *without* doing a
> > uaccess_begin(), which will mean that modern CPU's will simply fault
> > on a kernel access to user space.
> >
> > The nice thing about that is that usually developers will have access
> > to exactly those modern boxes, so the people who notice that it
> > doesn't work are the right people.
>
> We use probe_kernel_read() from oops code. I=E2=80=99d rather it return -=
EFAULT than oops harder and kill the first oops.

It would still do that.

Using the unsafe_get_user() macros doesn't remove the exception
handling, and we wouldn't remove the whole "pagefault_disable()"
either. So it would work exactly the same way it does now, except on a
modern CPU it would return -EFAULT for a user space access due to AC
not being set.

So no "oops harder", only "safer accesses".

                Linus
