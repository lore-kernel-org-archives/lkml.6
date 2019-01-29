Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014C1C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92B120857
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wU/63d3B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbfA2SSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:18:34 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38129 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbfA2SSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:18:34 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so23147798wrw.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 10:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+GxBm8s8C6x84ozFyjXoCsKwNqijbNBimqTvowaT6HA=;
        b=wU/63d3BqpbaETl1R60YuKHDVlM6oWOlycD365weCHPw8D4pDzyh2VmzYqavACHnQy
         2E0vBCvdlWBdD0etwek0HhdNqKvPtKLOAlQFgRzID0mB2cjaCZJAIigmbf1v4lWqUmwF
         JYp4Lm4pJN4DP1NeOojB4yAKbERZnHYyTY/xV0SnPKvVMxwa0YihtVntVY4dx1P0s7Xv
         4qCpYp2b+meS9qpg6uaMXpF6iwtg2kmE0QFWzaul4ag1gf7tCHOCDFeIDiSALdVR1tN1
         YAYiKWKxmIsV+dTX2MeLcYGkNN7xNy2V9BjAvc+Yg3lghhd8r0GW1PvEMaDY7CwEZJHL
         Tr5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+GxBm8s8C6x84ozFyjXoCsKwNqijbNBimqTvowaT6HA=;
        b=nRcGYEf1/E0/dG3WkZAZ/2UlSqF4dgH0fnFa9e06qJIV3d5ev0MoQbmRrn5CeFtxzX
         x0UPodYF5VPLSLnqJEleovIodxvr536iuEj/SolOZ3D9J4rdPYntoh9J+hvM1STu9bxp
         oighEO92BoE9nAgmE21ePCCGQYoVpd7EkAritxh/s/k+tOqk/R3PrdrPDmD85D0JGwef
         oh29na6bxjs+Uk/qwJ0bMU9Uv1OyksT76bRkmQcDfbw0uA/zp9Qf6NaLXc8WGCgkALK+
         U4SRLVK5dhfuFExPnvWpwGXckaLyyc7Cwaah+e5XhvymF+HAHfjiZS+SaJ13Tj6wLXfY
         97iA==
X-Gm-Message-State: AJcUukdxN6P+lgOuVMlHa5Ug6mxjjXNr3VxVi2zh72p4Fcexk008W+K/
        7ZI2W596Qj66ZylB50W8N77fwAhwtBarQp2s1i/baw==
X-Google-Smtp-Source: ALg8bN4cRFK+VVM41OOXWUgll/3WKZxT3SdKfFLzYyHoHPggY6R004Qc5iemMNf5Igp61Tl5EGthoyMNhU9XqAws9iQ=
X-Received: by 2002:a5d:4e82:: with SMTP id e2mr26340980wru.291.1548785911774;
 Tue, 29 Jan 2019 10:18:31 -0800 (PST)
MIME-Version: 1.0
References: <20190124211518.244221-1-surenb@google.com> <20190124211518.244221-6-surenb@google.com>
 <20190129123843.GK28467@hirez.programming.kicks-ass.net>
In-Reply-To: <20190129123843.GK28467@hirez.programming.kicks-ass.net>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 29 Jan 2019 10:18:20 -0800
Message-ID: <CAJuCfpGxtGHsow002nd8Ao8mo9MaZQqZau_NLTMrZ8=aypTkig@mail.gmail.com>
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

On Tue, Jan 29, 2019 at 4:38 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jan 24, 2019 at 01:15:18PM -0800, Suren Baghdasaryan wrote:
> > +                     atomic_set(&group->polling, polling);
> > +                     /*
> > +                      * Memory barrier is needed to order group->polling
> > +                      * write before times[] read in collect_percpu_times()
> > +                      */
> > +                     smp_mb__after_atomic();
>
> That's broken, smp_mb__{before,after}_atomic() can only be used on
> atomic RmW operations, something atomic_set() is _not_.

Oh, I didn't realize that. After reading the following example from
atomic_ops.txt I was under impression that smp_mb__after_atomic()
would make changes done by atomic_set() visible:

/* All memory operations before this call will
* be globally visible before the clear_bit().
*/
smp_mb__before_atomic();
clear_bit( ... );
/* The clear_bit() will be visible before all
* subsequent memory operations.
*/
smp_mb__after_atomic();

but I'm probably missing something. Is there a more detailed
description of these rules anywhere else?

Meanwhile I'll change smp_mb__after_atomic() into smp_mb(). Would that
fix the ordering?

> --
> You received this message because you are subscribed to the Google Groups "kernel-team" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
