Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FADBC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524A22087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BXh7n98B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbfA2S0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:26:13 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46103 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbfA2S0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:26:13 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so23138091wrt.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 10:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ADwM0lszvaqhduF5I3DNeFvWPeUQTXjMtjOQKUDAPJ8=;
        b=BXh7n98B5xjbeB+aql7MNs/6BjRNZglzr66LB5d1zE4A4IXStoeq7g7volggkOR0jm
         Zw4Ew6E/Mn8x9yOekTa6e3ZeVuRcso8aX3m5+bpoW/SbRmwVAh7PW5CHhPa3QjTpqSWI
         uLYmSvffhC1lccnslt+fRVgCkeoPzinyOXdqCHzx03/tGID0YwW0bRIT+fsW57P472hY
         dIksMeGK073m5vEA30nAIeiNKStj7FtgFsaObHsW4CFEy8wMXyPrYI4K27+VKVl2sh9y
         MmAVuYcOhROvZCyChKdV3QsAE741Ix5ZmCqCkX3aa2Jdi2RMb+Cwe5vou1Ftliov/taq
         +Hdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ADwM0lszvaqhduF5I3DNeFvWPeUQTXjMtjOQKUDAPJ8=;
        b=YHzVJ1c6IIGmWbqgKiJK7iGfzYniNpwO+/MnN6yY6gdilGvx1apKHlcwz/V+CSbfGV
         I0bGph5Qxc9ogf2UCDN0TAx+aiJ14lFh44KtziUZVOnD8XWVnyNpmjtS29F4LWJB651U
         Zzao5a5bgNmWoR7UE4KAx5KReIKMnKCrLprs9D9nP6dt4VRfT4M2L6hAiQKcdNIhCn5s
         HR+kknddAjODX/+fiZFLqniY65enTxh9uoougsa/6FbCuHTrrLARIv5na1MpX5O3VNgR
         XPUFLSiReWzdEBWUidlYAUkMPF7LuHu+W0Fss3moDnJNw3ATfP+phGg43HMVnevL7lRB
         +35A==
X-Gm-Message-State: AHQUAubA08FghZMKpXI/NJ8W6RDqsoYZImdp0IsD9mub0WbhG7GLkrXV
        claXhJDL2PzsKIQebnYRphMrn86IYdtw2c+PmiLCAQ==
X-Google-Smtp-Source: AHgI3IbJXcwKzyDgm1JDGoKVL5g4uCwu2Dk74NNLxZkW+r/uERASibjooWGTvyTUxd2OI6Moz27ryN1VdshIkuPqAI8=
X-Received: by 2002:adf:dc4e:: with SMTP id m14mr7274623wrj.107.1548786371209;
 Tue, 29 Jan 2019 10:26:11 -0800 (PST)
MIME-Version: 1.0
References: <20190124211518.244221-1-surenb@google.com> <20190124211518.244221-6-surenb@google.com>
 <20190129123843.GK28467@hirez.programming.kicks-ass.net> <20190129151649.GA2997@hirez.programming.kicks-ass.net>
In-Reply-To: <20190129151649.GA2997@hirez.programming.kicks-ass.net>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 29 Jan 2019 10:25:58 -0800
Message-ID: <CAJuCfpHyuY89Aw3YpQpaor2hKvdqJOH5sMoXNZ-yNAnAb+tY6A@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] psi: introduce psi monitor
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, lizefan@huawei.com,
        Johannes Weiner <hannes@cmpxchg.org>, axboe@kernel.dk,
        dennis@kernel.org, Dennis Zhou <dennisszhou@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 7:16 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jan 29, 2019 at 01:38:43PM +0100, Peter Zijlstra wrote:
> > On Thu, Jan 24, 2019 at 01:15:18PM -0800, Suren Baghdasaryan wrote:
> > > +                   atomic_set(&group->polling, polling);
> > > +                   /*
> > > +                    * Memory barrier is needed to order group->polling
> > > +                    * write before times[] read in collect_percpu_times()
> > > +                    */
> > > +                   smp_mb__after_atomic();
> >
> > That's broken, smp_mb__{before,after}_atomic() can only be used on
> > atomic RmW operations, something atomic_set() is _not_.
>
> Also; the comment should explain _why_ not only what.

Got it. Will change the comment to something like:

Order group->polling=0 before reading times[] in
collect_percpu_times() to detect possible race with hotpath that
modifies times[] before it sets group->polling=1 (see Race #1 in the
comments at the top).

> --
> You received this message because you are subscribed to the Google Groups "kernel-team" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
