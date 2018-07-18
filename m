Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0F9ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC3C20854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9UtoHoH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FC3C20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbeGRVAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 17:00:55 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:42374 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729776AbeGRVAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 17:00:55 -0400
Received: by mail-pf0-f196.google.com with SMTP id l9-v6so2717791pff.9;
        Wed, 18 Jul 2018 13:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2IGiSTg4sisXhemFX7mnlqH/H4JwXpYPnaegAY6cNAU=;
        b=b9UtoHoHi7Adh/Jp2bcPSyAnGhaHwDWarv6gJV1buRM7tPgBRWgsnIY3UrEPzkzQTR
         qsuU5jfwOzRpJnlqm5eO2TBJ5Q3enn9aHE8ZN97GARebx9McK3sKtT0iT9z1nKgRRdcr
         Ix21LOZfCrg5OL9ZhcOz6e+LYYmdmKfi8Z5D+hbwIfs0l1wmPT8+LVXDlnKEXWP974U9
         kqlKeqUwRCnljkTNTmXVFOavAWLepgKXNuDHb1Pui61ECFs917qih2KQjdwTiGZxKSfC
         7mPUBSlpLILsqMrw9YmSMT3r2Wh3vOwutfhpO4BVld/URx9zoAJWB8MrjoihGgcz1de/
         AHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2IGiSTg4sisXhemFX7mnlqH/H4JwXpYPnaegAY6cNAU=;
        b=VcpdakizCKhDYYnyK0MJx57dP+Jc3wH5KiPJJEeDnLAb5xVqUlk+7/E1vlNYviIx+h
         aVdruC12QcAQfaC/kxC8TRHA80laUfrx7TSG1KdN/YYHK9VVqDE/HIpi2fiijD/HGW1F
         Go6Az6bAeJMZMHKUhrW732yUMWFUwtgqXgSRyPITZVuoSnwRwmUKeUUTfZksY/IaPTU2
         gj6vPdGnO4xiJE27Ne8eyy6XTwjgEvYFPUwTUVnnyA/RNO8MGArzwQLrhm67FgFmayfu
         xFTqctndLgLZVtWNwyHjYC0XD89gVa04LuwolZk6QwiJfd2gqloigkR9IBOblm/xLTRu
         /XJg==
X-Gm-Message-State: AOUpUlFjc1vZUb5XpgGgxog2dpgIWGUpdR0WW41ltcQpUTpSE/6M3+Cy
        eZaqknvJ47OoIEW1/dutMGvB8v34qUyKWmLJpo4=
X-Google-Smtp-Source: AAOMgpdBccCBrVT3+fgOPYnEy/EllLvgnRyQcvxnd3EEApBI5YrTAbS0HpbUkhJIgtlVPTjQvLI1Olu1GK9GpTGff80=
X-Received: by 2002:a65:5a01:: with SMTP id y1-v6mr7131217pgs.125.1531945283429;
 Wed, 18 Jul 2018 13:21:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180716215101.4713-1-xiyou.wangcong@gmail.com> <20180718081905.GA13520@krava>
In-Reply-To: <20180718081905.GA13520@krava>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Wed, 18 Jul 2018 13:21:11 -0700
Message-ID: <CAM_iQpVX_9C42Wh+ydti=droRz_Xs_Cv4ovVcg4nqu+n1OScKg@mail.gmail.com>
Subject: Re: [PATCH] perf/core: fix a possible deadlock scenario
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 1:19 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Jul 16, 2018 at 02:51:01PM -0700, Cong Wang wrote:
> > hrtimer_cancel() busy-waits for the hrtimer callback to stop,
> > pretty much like del_timer_sync(). This creates a possible deadlock
> > scenario where we hold a spinlock before calling hrtimer_cancel()
> > while in trying to acquire the same spinlock in the callback.
> >
> > This kind of deadlock is already known and is catchable by lockdep,
> > like for del_timer_sync(), we can add lockdep annotations. However,
> > it is still missing for hrtimer_cancel(). (I have a WIP patch to make
> > it complete for hrtimer_cancel() but it breaks booting.)
> >
> > And there is such a deadlock scenario in kernel/events/core.c too,
> > well actually, it is a simpler version: the hrtimer callback waits
> > for itself to finish on the same CPU! It sounds stupid but it is
> > not obvious at all, it hides very deeply in the perf event code:
> >
> > cpu_clock_event_init():
> >   perf_swevent_init_hrtimer():
> >     hwc->hrtimer.function = perf_swevent_hrtimer;
> >
> > perf_swevent_hrtimer():
> >   __perf_event_overflow():
> >     __perf_event_account_interrupt():
> >       perf_adjust_period():
> >         pmu->stop():
> >         cpu_clock_event_stop():
> >           perf_swevent_cancel():
> >             hrtimer_cancel()
> >
> > Getting stuck in a timer doesn't sound very scary, however, in this
>
> sound scary enough for me ;-) were you able to hit it?

Yeah, we have seen hundreds of soft lockup's in smp function call
which is probably caused by this bug. It dates back to 3.10 kernel,
seriously. :) Unfortunately we don't have a reproducer, so we can't
verify if this patch really fixes those soft lockup's until we deploy
the fix to probably thousands of machines in data center.


>
> > case, its consequences are a disaster:
> >
> > perf_event_overflow() which calls __perf_event_overflow() is called
> > in NMI handler too, so it is racy with hrtimer callback as disabling
> > IRQ can't possibly disable NMI. This means this hrtimer callback
> > once interrupted by an NMI handler could deadlock within NMI!
>
> hum, the swevent pmu does not triger NMI, so that timer
> will never be touched in NMI context

Good to know! So I worry too much here.

But still, given hrtimer interrupt is called with IRQ disabled, getting
stuck in a hrtimer callback could also block IPI handler, therefore
causing soft lockups.

Let me know if you want me to adjust the changelog for this.

Thanks!
