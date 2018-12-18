Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD0BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 01:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830322145D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 01:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="coXf01at"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbeLRBVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 20:21:20 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52722 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbeLRBVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 20:21:19 -0500
Received: by mail-wm1-f65.google.com with SMTP id m1so1027043wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 17:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mbu7X9AToTNe0+9pY+V/zik+z11jPPNgr5XbogPquck=;
        b=coXf01atRsTDqmB60HaGrMfJ9f0HsjrT+OHvDJEcfrJamR18DOV+C7fFynNk2ez9SJ
         BKSH1/oXnxflTvNhg+cGiL7yWVnj2Zg4e3QNNWlkYdCVMXHb43eZnhdyZOKXEi66v+RI
         HbljguhNMbi9EKkecWaukYVNcgrqph1g9k+fFNtG/EGhk9GizfS+fGgSN2p+Q+2PkFry
         kY20M9dCRj/bSHJZrgrAMFb/pnNcUyHC5iIWkM57w4hvflFBtOxRZhIvwdHzRUQ/kfLF
         JEPAfSUjM3ZhQK3CmnONs/7pVi7e5yHMB7jY8US8eK6M6y8iqmLkPsYLXVj7fTi8/b70
         BDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mbu7X9AToTNe0+9pY+V/zik+z11jPPNgr5XbogPquck=;
        b=bjDoaeqVH9F1n6UiMdVO8p0tAJ0v/pXiVBUMy1hMMO0zMLUFzm4Ka0a99XRoVTAol9
         E1BnTFGNxkljSE5mYIisTkqLqcw5G4k6QEQ8dNI+3eIfo4Db2xIgglbMUIKrGG68+klV
         V3qV9K9bu/o0Y/Q/fUmcQsm1XPtbgivwdIIMfXVpl+RnLuhC6/6dsD2n5n/qDDFVJqXu
         k0MqOc/YQxbURg6jr1qlROtCMMUF2fzsUeMSnSNxcCwKhmTFu4LzgFYdFaNk2aAcuvlh
         NiBbRpvqnA1hJqzjRcWwEDEuVlMFHvdUeschgyIG0bIaTOg1hamXy/eRy90Z1cwhRCsn
         pKgA==
X-Gm-Message-State: AA+aEWb9tK7AE9pFt0VYvBL5OzHzJCKlYTbaYz17SYT3n0ZL22WN8u2n
        iqrCVs5oPxtrGEe1qYRMjhjybLGQ3I60aoRI0w9X1g==
X-Google-Smtp-Source: AFSGD/WQuBWpqw5XM8CknRTpoZaVRCQwBcnTwgV479JuaazLh4ZFif6lnrHYvMV/ULcLIANihfc+ik9seRSZOwV0lTU=
X-Received: by 2002:a1c:1286:: with SMTP id 128mr1187179wms.70.1545096076972;
 Mon, 17 Dec 2018 17:21:16 -0800 (PST)
MIME-Version: 1.0
References: <20181214171508.7791-1-surenb@google.com> <20181214171508.7791-7-surenb@google.com>
 <20181217162223.GD2218@hirez.programming.kicks-ass.net>
In-Reply-To: <20181217162223.GD2218@hirez.programming.kicks-ass.net>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 17 Dec 2018 17:21:05 -0800
Message-ID: <CAJuCfpHGsDnE-eAHY1QnX949stA3cvNA=078q1swqVnz95aJfg@mail.gmail.com>
Subject: Re: [PATCH 6/6] psi: introduce psi monitor
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

On Mon, Dec 17, 2018 at 8:22 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Dec 14, 2018 at 09:15:08AM -0800, Suren Baghdasaryan wrote:
> > +ssize_t psi_trigger_parse(char *buf, size_t nbytes, enum psi_res res,
> > +     enum psi_states *state, u32 *threshold_us, u32 *win_sz_us)
> > +{
> > +     bool some;
> > +     bool threshold_pct;
> > +     u32 threshold;
> > +     u32 win_sz;
> > +     char *p;
> > +
> > +     p = strsep(&buf, " ");
> > +     if (p == NULL)
> > +             return -EINVAL;
> > +
> > +     /* parse type */
> > +     if (!strcmp(p, "some"))
> > +             some = true;
> > +     else if (!strcmp(p, "full"))
> > +             some = false;
> > +     else
> > +             return -EINVAL;
> > +
> > +     switch (res) {
> > +     case (PSI_IO):
> > +             *state = some ? PSI_IO_SOME : PSI_IO_FULL;
> > +             break;
> > +     case (PSI_MEM):
> > +             *state = some ? PSI_MEM_SOME : PSI_MEM_FULL;
> > +             break;
> > +     case (PSI_CPU):
> > +             if (!some)
> > +                     return -EINVAL;
> > +             *state = PSI_CPU_SOME;
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     while (isspace(*buf))
> > +             buf++;
> > +
> > +     p = strsep(&buf, "%");
> > +     if (p == NULL)
> > +             return -EINVAL;
> > +
> > +     if (buf == NULL) {
> > +             /* % sign was not found, threshold is specified in us */
> > +             buf = p;
> > +             p = strsep(&buf, " ");
> > +             if (p == NULL)
> > +                     return -EINVAL;
> > +
> > +             threshold_pct = false;
> > +     } else
> > +             threshold_pct = true;
> > +
> > +     /* parse threshold */
> > +     if (kstrtouint(p, 0, &threshold))
> > +             return -EINVAL;
> > +
> > +     while (isspace(*buf))
> > +             buf++;
> > +
> > +     p = strsep(&buf, " ");
> > +     if (p == NULL)
> > +             return -EINVAL;
> > +
> > +     /* Parse window size */
> > +     if (kstrtouint(p, 0, &win_sz))
> > +             return -EINVAL;
> > +
> > +     /* Check window size */
> > +     if (win_sz < PSI_TRIG_MIN_WIN_US || win_sz > PSI_TRIG_MAX_WIN_US)
> > +             return -EINVAL;
> > +
> > +     if (threshold_pct)
> > +             threshold = (threshold * win_sz) / 100;
> > +
> > +     /* Check threshold */
> > +     if (threshold == 0 || threshold > win_sz)
> > +             return -EINVAL;
> > +
> > +     *threshold_us = threshold;
> > +     *win_sz_us = win_sz;
> > +
> > +     return 0;
> > +}
>
> How well has this thing been fuzzed? Custom string parser, yay!

Honestly, not much. Normal cases and some obvious corner cases. Will
check if I can use some fuzzer to get more coverage or will write a
script.
I'm not thrilled about writing a custom parser, so if there is a
better way to handle this please advise.

> --
> You received this message because you are subscribed to the Google Groups "kernel-team" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
