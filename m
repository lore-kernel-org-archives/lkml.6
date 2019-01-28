Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3A8C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA8912171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="M/W7On9k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfA1Udw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 15:33:52 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41493 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfA1Udw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 15:33:52 -0500
Received: by mail-lj1-f195.google.com with SMTP id k15-v6so15448278ljc.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 12:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dMmOedFj/7Q3TI4VMMpt0EBGy9rStjg4CcKUYXgvoqE=;
        b=M/W7On9kGy1cSdWDbPLwdguFqdpGEak5hvt7RyM8nAzUcCZqsU/T2hW1u8gC+EapMj
         YtXiw53RAPhBGENrObbGRmTWjIsHwA55DjxECgS24efxHDSmGDsiV9E/sLPjL1pLcyfJ
         HLuC52Evqz5PVRFtU1oFCLxEGPIwFwgLjh2TY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dMmOedFj/7Q3TI4VMMpt0EBGy9rStjg4CcKUYXgvoqE=;
        b=OWD9SvZXpHeQO6dwVsBr8B9Vxr3hbKZn5wPu+WRVaDKu1j29/2jFFiG821LfHzUNN7
         k6ni3S2r/3Vn9Vki/7G8YiEUEs8+H/KYFLs0DEghFiZDoR5QuTFS4FBYpW8Pu608uRCz
         5eIrtBGqob7Oh4t5xrIcZILKOaOy4ndLeFPzROVI4h/0gn+b3w+81IBb0CsoYzikqvHg
         UCJrReJLF7dNL1dnneijIy+mjKNnv55BisOxHBQRbjjVYdSYaCbRmH6auDhZC2+3jMvf
         DiKKIjtfd0zdJmLVuRauJ7TU0JzpS13mT7WUl+p4FFJSwRQuA905YEnX3bIoe5nJZg2V
         VZ9A==
X-Gm-Message-State: AJcUukeUo9B4VSnv3DAlcS6CvKmDLesmrEogctBZBPf0IvVPjWB2/RIb
        wCjmGYctdwl1VTzydiS9HnZdQgdaR38=
X-Google-Smtp-Source: ALg8bN4yun0RdiOaoCGyqCn+MLa/+db4oVDeNT3/01u/L4/+d7aVocIoERw36m1RSEY9ScfhzBw7SQ==
X-Received: by 2002:a2e:7e04:: with SMTP id z4-v6mr19260972ljc.97.1548707629773;
        Mon, 28 Jan 2019 12:33:49 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 6sm3443181lfa.27.2019.01.28.12.33.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 12:33:49 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id a16so12912201lfg.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 12:33:49 -0800 (PST)
X-Received: by 2002:a19:24c6:: with SMTP id k189mr17845874lfk.77.1548707239936;
 Mon, 28 Jan 2019 12:27:19 -0800 (PST)
MIME-Version: 1.0
References: <20190128182636.18420-1-mathieu.desnoyers@efficios.com>
In-Reply-To: <20190128182636.18420-1-mathieu.desnoyers@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Jan 2019 12:27:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjmpfXak0pQVu8dZrk2Oma3OxtEoBHfwCAruu0xpSMN4A@mail.gmail.com>
Message-ID: <CAHk-=wjmpfXak0pQVu8dZrk2Oma3OxtEoBHfwCAruu0xpSMN4A@mail.gmail.com>
Subject: Re: [RFC PATCH] Fix: membarrier: racy access to p->mm in membarrier_global_expedited()
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrea Parri <parri.andrea@gmail.com>,
        Andrew Hunter <ahh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Avi Kivity <avi@scylladb.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, David Sehr <sehr@google.com>,
        Greg Hackmann <ghackmann@google.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Maged Michael <maged.michael@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will.deacon@arm.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 10:27 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Jann Horn identified a racy access to p->mm in the global expedited
> command of the membarrier system call.
>
> The suggested fix is to hold the task_lock() around the accesses to
> p->mm and to the mm_struct membarrier_state field to guarantee the
> existence of the mm_struct.

Hmm. I think this is right. You shouldn't access another threads mm
pointer without proper locking.

That said, we *could* make the mm_cachep be SLAB_TYPESAFE_BY_RCU,
which would allow speculatively reading data off the mm pointer under
RCU. It might not be the *right* mm if somebody just did an exit, but
for things like this it shouldn't matter.

But if this is the only case that might care, it sounds like just
doing the proper locking is the right approach.

           Linus
