Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652BCC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C4D321841
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LbLALWqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfBIAJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:09:16 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43716 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfBIAJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 19:09:12 -0500
Received: by mail-lj1-f196.google.com with SMTP id q2-v6so4417215lji.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 16:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=esUN0eAUy4YWkP+bozuSr/XyV8kG31d8rYJRedvgykU=;
        b=LbLALWqmuur3vFRa25JFyrgBoAdC34KiufM5BZY6FVjl/WYfmGblutfsjwJLgcnL2s
         7WfLx0BMAxPDJUxhk3YWwQvooGaab1y8eWCVbR4BtrKqYJ8QmykyrhzkiPDRsWkCWKX2
         tpgX9WKhMrvACLp3JH8Bq642be3K34aaxe+NA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=esUN0eAUy4YWkP+bozuSr/XyV8kG31d8rYJRedvgykU=;
        b=GJbZgKEwAxqWvgUxSWUCuhmw13btSfmtG8LBxFEphg9x6TRz+gQufP7G0Lb7DOqJQE
         IPpLjufts6+0vMbvpO++jAT7LeNtR65z//BYfhMipc+yj2KCK8cBNfPPC5Gs2aXec59S
         zNFBJX8zhS3qXuMMrGpvwaaJxJYkJwKvZ4gSo9HCIgXMWtGzAMmqQeTJ7ErlnH9sb84n
         SVmvmo6Ypo1VB6+lU8weQ3Qiqkko3hMxzj4s0fOJLXSjUHxOEu3H4dCycd2KN5bydG3F
         EkvGTzu+E6lubEeoCv+HZ7HrA3bVP05VVD6MeS7kWSZliuP2WGPSdgay+q8XstpGZZvt
         WmNw==
X-Gm-Message-State: AHQUAubuprEpCVcEZHnmHNTaVVe/ghGxd+WPGX4S+KWDimOXNgGpSfvA
        2435LNP5JdIMX9X6erROPteSQOEbIUA=
X-Google-Smtp-Source: AHgI3IZr6sbNXb7CASIr2Cp6sdak20k0mfknrl2UsIAhHRg2IZKEqnSzFj8EoZQJQJ34Hza1c7m8Ow==
X-Received: by 2002:a2e:908b:: with SMTP id l11-v6mr15029345ljg.150.1549670949366;
        Fri, 08 Feb 2019 16:09:09 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id y14-v6sm709757ljj.55.2019.02.08.16.09.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 16:09:09 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id z13so3801023lfe.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 16:09:08 -0800 (PST)
X-Received: by 2002:ac2:4191:: with SMTP id z17mr14867539lfh.117.1549670639775;
 Fri, 08 Feb 2019 16:03:59 -0800 (PST)
MIME-Version: 1.0
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
 <CAHk-=wjfyrFBjifzmgMVrkrvEePEPaBTDq7D=f2i5kD2E=SqRQ@mail.gmail.com> <d7476dfb-1653-747b-b865-5597ba5fc1c1@redhat.com>
In-Reply-To: <d7476dfb-1653-747b-b865-5597ba5fc1c1@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Feb 2019 16:03:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=whzAGRJQE43NHaC8sCECLr-QnpHYst+TJq-qhfp9eK-Qw@mail.gmail.com>
Message-ID: <CAHk-=whzAGRJQE43NHaC8sCECLr-QnpHYst+TJq-qhfp9eK-Qw@mail.gmail.com>
Subject: Re: [PATCH-tip 00/22] locking/rwsem: Rework rwsem-xadd & enable new
 rwsem features
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch <linux-arch@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 12:31 PM Waiman Long <longman@redhat.com> wrote:
>
> >  (b) what's the new fastpath case
>
> The only change in the fastpath is the use of cmpxchg for writer lock.

.. since a big deal here was about using the generic atomic accessor
functions, I really was looking forward to seeing the *actual* fast
path code generation.

In other words, right now I have very little visibility in how it
actually affects the code. Looking at the patches themselves doesn't
make it obvious. I was hoping for the overview to really explain the
whole "before and after" situation, and it didn't. Not at the high
level, and not at a low level. And no performance numbers in the
overview either.

And yes, I see the numbers in the patches, but what I really hoped for
was some real load numbers. In particular, I would have loved to see
numbers from th ekernel test robot "will-it-scale.per_thread_ops"
case, which is the one that had a 65% regression due to the lack of
reader spinning.

So I was kind of hoping to hear whether that regression is basically
entirely gone with this patch series, or if we still have a regression
due to the extra downgrade, or what?

                 Linus
