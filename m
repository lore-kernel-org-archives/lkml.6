Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2785C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507E120841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cuvrot/9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 507E120841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbeGaWhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:37:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33060 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbeGaWhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:37:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id r5-v6so9672466pgv.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 13:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PZbbiHCCogz+M+rcb6KX4ER9Aw/u8t1micIGGcN/aKQ=;
        b=Cuvrot/9IuzTZpfH0QZeKoCWwvDQYtueZxBkS8rknX+hRa8/W8IfCzFop+CgulvEKm
         /reQxGbiD8JW+3ja+o+xF4mETDk+CUFxJGItpe0U88mZjO00YgX/23zMBesA5TJBAA71
         9NmgG9XxBRTKswINNs+jF17jhVtyy9HRY62OL2EBDU5LIVQsplbqfGWUlwRpbUovgAUf
         csGhwxoBDP3lExnyzhzzVhUcjTt86ll3V5MwEeE+t2SdCdZB+ig5AHC2LWf/SQ152mRf
         fcwwXhr9eydM3IDux48xRUfSSCcglVUyMJd8++K1Fv7EkEwluFRymNQmZ2ksafOF7d+I
         X2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PZbbiHCCogz+M+rcb6KX4ER9Aw/u8t1micIGGcN/aKQ=;
        b=Kf6MR8skDXSFBdT4rghYsjR3N+F4MzEHMbjNEMI41sqH353OxAgYFnDRZs2RejEi+n
         Sw4guZUtjlCtxBPE4gzigLMfJCbIEhVTBL6zX/ThAstYKB49H9xoJ3pwhtPaxZjWznMP
         WSsrKYusGTMdsZArWx4h/BLghSf36/sqxM+9lQKdmy41QIBMcjshOLuJC05BcMxym+83
         4LhmtlcoZ/ffRSEYXH8cAbM/bPCEOCeCG2hYAixRrM6DdAKmAHHGcV2wboA8MEil9rSX
         tJSKQq5OFoUD56VWKKSPybIV2dYppCB6C/yDSokla4ERI8QgeO7D/Ji2RHzzoI1mb6St
         e4Hg==
X-Gm-Message-State: AOUpUlEFn/yFo+8JRexJ2a5Zdt04drXQVamm7TMLvUvQaqnVMDVxooWo
        O86RnXdLZGVCawkXBkJ54NFpo/xetjzh710Rtz4=
X-Google-Smtp-Source: AAOMgpfa1Ws5xOFbfsVRe7NAHYnucETDlIprYt8ZK2ef86qx5BQD138rbVwoSe1yPfjh6RorJH4RWpXBr3kBHHexRg8=
X-Received: by 2002:a62:9683:: with SMTP id s3-v6mr23834364pfk.191.1533070535605;
 Tue, 31 Jul 2018 13:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180728002409.5781-1-xiyou.wangcong@gmail.com>
 <ef0e1185-51d6-0707-cda4-6f2ea987b651@linux.alibaba.com> <CAM_iQpVeK2VQDuahreZC2-L4eEzx0WtD8Bz=oHH68VSAiMqLGQ@mail.gmail.com>
 <fad5ebe6-ec49-c67b-7b4f-78a413723aa8@linux.alibaba.com> <xm26ftzz8h0r.fsf@bsegall-linux.svl.corp.google.com>
In-Reply-To: <xm26ftzz8h0r.fsf@bsegall-linux.svl.corp.google.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 31 Jul 2018 13:55:23 -0700
Message-ID: <CAM_iQpXGCqo9AAp2kpSKk9sHx0ZRK7JU_c07sWh4vR9kFQ+LxA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: sync expires_seq in distribute_cfs_runtime()
To:     Ben Segall <bsegall@google.com>
Cc:     Xunlei Pang <xlpang@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 10:13 AM <bsegall@google.com> wrote:
>
> Xunlei Pang <xlpang@linux.alibaba.com> writes:
>
> > On 7/31/18 1:55 AM, Cong Wang wrote:
> >> On Sun, Jul 29, 2018 at 10:29 PM Xunlei Pang <xlpang@linux.alibaba.com> wrote:
> >>>
> >>> Hi Cong,
> >>>
> >>> On 7/28/18 8:24 AM, Cong Wang wrote:
> >>>> Each time we sync cfs_rq->runtime_expires with cfs_b->runtime_expires,
> >>>> we should sync its ->expires_seq too. However it is missing
> >>>> for distribute_cfs_runtime(), especially the slack timer call path.
> >>>
> >>> I don't think it's a problem, as expires_seq will get synced in
> >>> assign_cfs_rq_runtime().
> >>
> >> Sure, but there is a small window during which they are not synced.
> >> Why do you want to wait until the next assign_cfs_rq_runtime() when
> >> you already know runtime_expires is synced?
> >>
> >> Also, expire_cfs_rq_runtime() is called before assign_cfs_rq_runtime()
> >> inside __account_cfs_rq_runtime(), which means the check of
> >> cfs_rq->expires_seq is not accurate for unthrottling case if the clock
> >> drift happens soon enough?
> >>
> >
> > expire_cfs_rq_runtime():
> >     if (cfs_rq->expires_seq == cfs_b->expires_seq) {
> >         /* extend local deadline, drift is bounded above by 2 ticks */
> >         cfs_rq->runtime_expires += TICK_NSEC;
> >     } else {
> >         /* global deadline is ahead, expiration has passed */
> >         cfs_rq->runtime_remaining = 0;
> >     }
> >
> > So if clock drift happens soon, then expires_seq decides the correct
> > thing we should do: if cfs_b->expires_seq advanced, then clear the stale
> > cfs_rq->runtime_remaining from the slack timer of the past period, then
> > assign_cfs_rq_runtime() will refresh them afterwards, otherwise it is a
> > real clock drift. I am still not getting where the race is?

But expires_seq is supposed to be the same here, after
distribute_cfs_runtime(), therefore runtime_remaining is not supposed
to be cleared.

Which part do I misunderstand? expires_seq should not be same here?
Or you are saying a wrongly clear of runtime_remaning is fine?


>
> Nothing /important/ goes wrong because distribute_cfs_runtime only fills
> runtime_remaining up to 1, not a real amount.

No, runtime_remaining is updated right before expire_cfs_rq_runtime():

static void __account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec)
{
        /* dock delta_exec before expiring quota (as it could span periods) */
        cfs_rq->runtime_remaining -= delta_exec;
        expire_cfs_rq_runtime(cfs_rq);

so almost certainly it can't be 1.

Which means the following check could be passed:

 4655         if (cfs_rq->runtime_remaining < 0)
 4656                 return;

therefore we are reaching the clock drift logic code inside
expire_cfs_rq_runtime()
where expires_seq is supposed to be same as they should be sync'ed.
Therefore without patch, we wrongly clear the runtime_remainng?

Thanks.
