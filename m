Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C997EC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3F92075D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sH3Mu2jO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A3F92075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbeJaBzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:55:51 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45615 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbeJaBzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 21:55:50 -0400
Received: by mail-qt1-f196.google.com with SMTP id l9-v6so14290778qtj.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 10:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qTygPDJw62/1J6VQccZp0xOGDtBguJPfsm6M86R4unk=;
        b=sH3Mu2jOpb+SQYjvm6JpEQFwIAYPlMofJ8byCw13dlvGR2xURIq0joQP1tSpEftHQ1
         XTuM9GVcXyCJmu9EqN76JjmplEOMZmKDoOArbqBGYwXAlItWz4sx7MzHoRBePP2gNH48
         cgMS3rDu956BjgyQ5Za/S/vwrYCWT1qXGnTB3ZZ1gZ6ehyTe2SlHV1q55LdGXlLKWBQQ
         TXM4LHliO8jtRuIoemDujtJU27pc1KBa6ds+4pLMM0KozepXBUTHdJIfmry3SsksGimd
         0yXNvoTfcn35rkvsmx0jj/zITIZS4Mqc7fK4nUSlELKwCvab5nNYP51Ft3bfY84P8+to
         NgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qTygPDJw62/1J6VQccZp0xOGDtBguJPfsm6M86R4unk=;
        b=FispebHLfRI0ufDASjBQqF8fqtW9p8iaCzWkPKsdenAgcX6LUKQCFxJoibdj5sOpfo
         8v0IzWUKxz058VxybSOTqVhWvtfl2Y/SgB4FGFSG0TtwtMEOJN8KWzSEuuvPPbdwj82W
         0T5h5jhN37jtlCCoVqwf4EjB8OqPrse8gdSJroLD/sqwIYgqk7h2C9gt6+JeP6utl0EE
         7Q8TCGTi9XjX4MPcV+P7uczznp3NJaTk9fUMn+2ei8Rgy9B/l4bNV31tFvg/OYygIIMH
         EkCb4KFkJuAPmHhwu5Z2aBuvH1uuVbz1QMuBUDbdJr/mEYEDyhuyVI8s1zmbLb+JKCMr
         j/uw==
X-Gm-Message-State: AGRZ1gLdIWJz9ZnE+rMMS9yHZPtrpTFWM62pXCIqbBo9V1Nn3rUqLEnA
        KnnSvwQKMRTl45sBYTwVa6GLzkVwZ99fd5skmz/JxQ==
X-Google-Smtp-Source: AJdET5cYMFIiybZkWH7WaRr6MDxZh/oI1/yOT/6Efwi2NhIBq7se/C4RGkUXVo5J7vecvbErDgcGbzSuMuXaHUwCd0Q=
X-Received: by 2002:a0c:ed4f:: with SMTP id v15mr11099669qvq.237.1540918889262;
 Tue, 30 Oct 2018 10:01:29 -0700 (PDT)
MIME-Version: 1.0
References: <20181029221037.87724-1-dancol@google.com> <CAJWu+oquh1RXz+1tD91NzvicYAL3GP0KVi7RLR2cgouSgHXjOw@mail.gmail.com>
 <CAKOZueub941EHifyf7zEk_yvf=2P+HV-8esE1QPFypRoxtt1qQ@mail.gmail.com>
In-Reply-To: <CAKOZueub941EHifyf7zEk_yvf=2P+HV-8esE1QPFypRoxtt1qQ@mail.gmail.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Tue, 30 Oct 2018 10:01:17 -0700
Message-ID: <CAJWu+or1X5nKEsXHNuB78oixQwBcHM=qS6ngN9sJ56wqwFFGOQ@mail.gmail.com>
Subject: Re: [RFC PATCH] Implement /proc/pid/kill
To:     Daniel Colascione <dancol@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 1:50 AM Daniel Colascione <dancol@google.com> wrote:
>
> On Tue, Oct 30, 2018 at 3:21 AM, Joel Fernandes <joelaf@google.com> wrote:
> > On Mon, Oct 29, 2018 at 3:11 PM Daniel Colascione <dancol@google.com> wrote:
> >>
> >> Add a simple proc-based kill interface. To use /proc/pid/kill, just
> >> write the signal number in base-10 ASCII to the kill file of the
> >> process to be killed: for example, 'echo 9 > /proc/$$/kill'.
> >>
> >> Semantically, /proc/pid/kill works like kill(2), except that the
> >> process ID comes from the proc filesystem context instead of from an
> >> explicit system call parameter. This way, it's possible to avoid races
> >> between inspecting some aspect of a process and that process's PID
> >> being reused for some other process.
> >>
> >> With /proc/pid/kill, it's possible to write a proper race-free and
> >> safe pkill(1). An approximation follows. A real program might use
> >> openat(2), having opened a process's /proc/pid directory explicitly,
> >> with the directory file descriptor serving as a sort of "process
> >> handle".
> >
> > How long does the 'inspection' procedure take? If its a short
> > duration, then is PID reuse really an issue, I mean the PIDs are not
> > reused until wrap around and the only reason this can be a problem is
> > if you have the wrap around while the 'inspecting some aspect'
> > procedure takes really long.
>
> It's a race. Would you make similar statements about a similar fix for
> a race condition involving a mutex and a double-free just because the
> race didn't crash most of the time? The issue I'm trying to fix here
> is the same problem, one level higher up in the abstraction hierarchy.

I was just curious that if this was a real issue you are hitting in a
production system, it wasn't clear from the commit message. When I
read your commit I thought "Does the inspection process take that long
that we wrap around an entire PID range?". So perhaps you should amend
your commit message to address that it is not really a problem you ARE
seeing, but rather something you anticipate and that this patch would
be a nice-to-have to avoid that. Typically there should be good
reasons/real-usecases to add a new interface to the kernel. Linus has
repeatedly rejected new interfaces on the grounds of non existent
use-cases or non real-world use cases. Again if I am missing something
here, then please improve the commit message so others don't have
similar questions :) Its completely upto you though..

> > IMO without a really good reason for this, it could really be a hard
> > sell but the RFC was worth it anyway to discuss it ;-)
>
> The traditional unix process API is down there at level -10 of Rusty
> Russel's old bad API scale: "It's impossible to get right". The races
> in the current API are unavoidable. That most programs don't hit these
> races most of the time doesn't mean that the race isn't present.
>
> We've moved to a model where we identify other system resources, like
> DRM fences, locks, sockets, and everything else via file descriptors.
> This change is a step toward using procfs file descriptors to work
> with processes, which makes the system more regular and easier to
> reason about. A clean API that's possible to use correctly is a
> worthwhile project.

Ok, agreed. thanks,

- Joel
