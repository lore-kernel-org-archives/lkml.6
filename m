Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB5AC5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63FA120693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=juliacomputing-com.20150623.gappssmtp.com header.i=@juliacomputing-com.20150623.gappssmtp.com header.b="WgXppqci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63FA120693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=juliacomputing.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935834AbeFRSQm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 14:16:42 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:37734 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935585AbeFRSQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 14:16:41 -0400
Received: by mail-it0-f68.google.com with SMTP id l6-v6so13362102iti.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 11:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VRpLW9SuN56Yw+NLzQXnYQDllLxPkFTwXJooYhx92lw=;
        b=WgXppqciBc6HDrsrncwIAw5Q3Qt/CjxK9s2V8xan756+dOmVPhUHoDVSaQzKfPUKiE
         Aoyf6ZeGG7Gt28jLONlIJucwqQZTQsL2MRWjHsQI2ZBVMb/cGS6kPhKX50fMG0VXRAnV
         E66d2bFWypykBcGywgk4xg8yBviCvU1yyvNs+8nmhB+992SJhsRO6xzCaSEMTGSR5Otw
         RTFluu++zXs1/I4pORgYe7s+jdvHgq+NIrCev6UqTD4E5Zhi8zCtlPKhhnuAL4EW7qTk
         2Sk2FMkE/qrowI/eY5RBg3StAvp/5DLNi+rtQVLFi6DEwh3LHqok6ZJwIyb3+55SiD6S
         irzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VRpLW9SuN56Yw+NLzQXnYQDllLxPkFTwXJooYhx92lw=;
        b=lKOFov47Ug/KjyB7e2sE0ZtR41sInk9LuREj8xWPctmsTuiUopi3nVAIgOnB7pkeM4
         3nlrDBVYWUBiUBYoYa/fbz6KpZQ5Q57HI7VRiJnOKywT4b4Rfv4Th1LA5yWfmbLMPuD4
         14OhWB9yCNqE98Vlvj7Xvg6nSbLVNQNHw5MdBNgfs2pAsVW6F1TBzTRYmJGN1eAXmhA6
         IQ7nZQD0m+PyIu7bc6uqWXdrVenIfXmFFnKYEoibabs6S7rIdAg6PjYKqvx0db+EtXO7
         98o7mWeH5/qMteqZjOjbhSu3ETz+99Y016MKhulGfhInrK06Jij1A4c+zhIoMVewS2W5
         eIPg==
X-Gm-Message-State: APt69E3GuQ2BfH1lqnVCLMKadnEe2deVyXopdgvBSLgTJ6jNgiB5AbDQ
        mtngmFz0TIECYTk65p3Xf6jd7yzsa8KBq1IgPjZzGw==
X-Google-Smtp-Source: ADUXVKLSF7I+6saKhmeFqG8zBt0fG1oPre5orncXm/aFjQAzFyIqbawWCqXFf6H+oFqAbqQjNsWbz9m0bu/o/v203qA=
X-Received: by 2002:a24:2f12:: with SMTP id j18-v6mr10834602itj.28.1529345800541;
 Mon, 18 Jun 2018 11:16:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:494a:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 11:16:00
 -0700 (PDT)
In-Reply-To: <06f44447-54eb-4644-a905-349cfc82f602@linux.intel.com>
References: <1529195582-64207-1-git-send-email-keno@alumni.harvard.edu>
 <d8503ac3-b6a4-d6cc-3db7-4e092724b79d@linux.intel.com> <CABV8kRwhrQ75g9y7v4Mq05CfZ9khhVQCwkp052jcNOvKs6-2Fg@mail.gmail.com>
 <06f44447-54eb-4644-a905-349cfc82f602@linux.intel.com>
From:   Keno Fischer <keno@juliacomputing.com>
Date:   Mon, 18 Jun 2018 14:16:00 -0400
Message-ID: <CABV8kRzDk7a6QP7mba0xq7da+H-ks=Py29ZtMP1uyDp9mUvutg@mail.gmail.com>
Subject: Re: [RFC PATCH] x86/arch_prctl: Add ARCH_SET_XCR0 to mask XCR0 per-thread
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        Andi Kleen <andi@firstfloor.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Kyle Huey <khuey@kylehuey.com>,
        "Robert O'Callahan" <robert@ocallahan.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So, to be useful, this interface needs to be called before an
> application can run XGETBV or XSAVE for the first time and caches a
> "bad" value.  I think that means that it might not be feasible to use
> outside of cases where you ptrace() something and inject things before
> it has a chance to run any real instructions.
>
> Fundamentally, I think that makes _this_ interface pretty useless in
> practice.  The only practical option is to have a _future_ XCR0 value
> set by the prctl() and then have it get made active by the kernel at
> execve().

Fair enough, but it don't see this as really fundamentally different
from the cpuid masking use case, which has the same problem and
the same interface. I'm also not convinced that there is *no* use case
where one may want to turn on certain XCR0 features while the process
is running and then turn them off again. To give a concrete example in
this context, it can useful to write a small program into the memory space
of the replayed program and use it to analyze the memory state of the
program (e.g. to checksum the memory - or in our case to perform a
GC state validation). Such implants may want to use the AVX512
registers for performance, so it would be nice if that was possible.

> IMNHO, if you haven't guessed yet, I think this whole exercise is a dead
> end.  Just boot an identical XCR0 VM on your new hardware and do replay
> there.  Done.

I had a hunch ;). However, there are a couple considerations that
make me still want this in the kernel proper:
1. The recording side application of this feature - getting our users
    to do everything in a VM to send us a recording is not easy. Part
    of the appeal of rr over VM-based record/replay techniques
    is that it "just works" on basically any linux hosts.
2. Starting a VM generally requires root permissions, which may
    not be available.
3. And probably the biggest from my perspective is performance. rr
    needs to do a lot twiddling with the performance counters, which
    I've seen have significant performance overhead in a virtualized
    environment. There's of course also a per-VM resource consumption,
    but presumably we could keep one VM per-XCR0 value and replay
    multiple traces per VM.
