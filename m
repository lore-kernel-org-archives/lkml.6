Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB71C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3BE21939
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntOtFr5p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbfAaU1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 15:27:53 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36635 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbfAaU1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 15:27:51 -0500
Received: by mail-pf1-f194.google.com with SMTP id b85so2009625pfc.3;
        Thu, 31 Jan 2019 12:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0+R+sOwjvxkktDI2qKjnNKh9P8mjjTi1aFLaDo5oF34=;
        b=ntOtFr5pHOK82wNoRRayr4kI3bstk2BPoo9oLa2aEXnR0hjtxzezx/OWTVRyIXfkJG
         nAMJa0ylrLAkdEteuazt5xBHMoH/BFbWcaBF0estTf3z7YCQEllcMZDqIA/KREUJh7fx
         wwOrpkh+sW7k+RBGjVl32jeo4ZMjM4AnOIstddQzuEdUTVhI//7qoNInS3bxDVfkW8qc
         88ppGNiMjM/EmhbIgTkEroiYoX/kO7ErgPsEcf5TyWZjkz238EtNW1yqGR5Daag5yKYz
         e6QlnBA2jJNpyV/5yAi+WWM+AyN5wAWuhrtw4GhUGnJcapxX4/ZDhxviXsRP7tCDQn0q
         FBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0+R+sOwjvxkktDI2qKjnNKh9P8mjjTi1aFLaDo5oF34=;
        b=E5o6iHS3SrZM/zE0XjsaZjWU3wfdG6v6ABUgQrUdr3hVdy3RYypd9ShpYbnMh1Ihys
         bP5lCvxPsUMQN8Xd8uvnLXQ7p0vOiEq8rAmkyxDkhvurQ+JpTicmwBeoenYS3FrfTgYL
         H952/b0fBP56U5yct9JrNfBcAnE7JdgB0mxvd95jS/u6ZYIKyud0MboOAy5edSumZrkM
         hHW86CIhb87pJPoNDXTz6FTFmHikk7E4UbHj7PUVfxmc1nTuoZn/iHehMg/pyCgL/k6J
         WO9dYQ+UhwZEFMlIYt/sS7To0Z90e8jLCQlPh/Vqshfzp5vBaoyCZQRtJtKxuanHVCak
         vDyw==
X-Gm-Message-State: AJcUukdZOgmeZwAhlx4rX6DrciqAcwV/4tHYfpXQMEAnl8wwWsVhI2Tt
        gmU5ujMiX2cnl/OeHRqeXpwJDawaQMRzaUHnqM0=
X-Google-Smtp-Source: ALg8bN5v60lbXDq1i3BnkNTVGOsq0Ou0Gn2no84jla8i7tgqTaZ3LkrL5fXAtPqili7PWaFZkRe38rIKrvKvcbFwy4I=
X-Received: by 2002:a63:5026:: with SMTP id e38mr32931296pgb.123.1548966470114;
 Thu, 31 Jan 2019 12:27:50 -0800 (PST)
MIME-Version: 1.0
References: <7c7ec3d9-9af6-8a1d-515d-64dcf8e89b78@linux.ibm.com> <20190125160056.GG6118@tassilo.jf.intel.com>
In-Reply-To: <20190125160056.GG6118@tassilo.jf.intel.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Thu, 31 Jan 2019 12:27:38 -0800
Message-ID: <CAM_iQpVtyCR=BTBkpDtbEFJ8REczpvYRTGPQnBsV=8rznXn6fg@mail.gmail.com>
Subject: Re: System crash with perf_fuzzer (kernel: 5.0.0-rc3)
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        eranian@google.com, vincent.weaver@maine.edu,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 8:02 AM Andi Kleen <ak@linux.intel.com> wrote:
>
> > [Fri Jan 25 10:28:53 2019] perf: interrupt took too long (2501 > 2500), lowering kernel.perf_event_max_sample_rate to 79750
> > [Fri Jan 25 10:29:08 2019] perf: interrupt took too long (3136 > 3126), lowering kernel.perf_event_max_sample_rate to 63750
> > [Fri Jan 25 10:29:11 2019] perf: interrupt took too long (4140 > 3920), lowering kernel.perf_event_max_sample_rate to 48250
> > [Fri Jan 25 10:29:11 2019] perf: interrupt took too long (5231 > 5175), lowering kernel.perf_event_max_sample_rate to 38000
> > [Fri Jan 25 10:29:11 2019] perf: interrupt took too long (6736 > 6538), lowering kernel.perf_event_max_sample_rate to 29500
>
> These are fairly normal.
>
> > [Fri Jan 25 10:32:44 2019] ------------[ cut here ]------------
> > [Fri Jan 25 10:32:44 2019] perfevents: irq loop stuck!
>
> I believe it's always possible to cause an irq loop. This happens when
> the PMU is programmed to cause PMIs on multiple counters
> too quickly. Maybe should just recover from it without printing such
> scary messages.

Yeah, a loop stuck looks really scary inside an NMI handler.
Should I just go ahead to send a patch to remove this warning?
Or probably turn it into a pr_info()?

>
> Right now the scary message is justified because it resets the complete
> PMU. Perhaps need to be a bit more selective resetting on only
> the events that loop.
>
> > [Fri Jan 25 10:32:44 2019] WARNING: CPU: 1 PID: 0 at arch/x86/events/intel/core.c:2440 intel_pmu_handle_irq+0x158/0x170
>
> This looks independent.
>
> I would apply the following patch (cut'n'pasted, so may need manual apply)
> and then run with
>

I would like to help as we keep seeing this warning for a rather long time,
but unfortunately the reproducer provided by Ravi doesn't trigger any warning
or crash here. Maybe I don't use a right hardware to trigger it?

[    0.132136] Performance Events: PEBS fmt2+, Broadwell events,
16-deep LBR, full-width counters, Intel PMU driver.
[    0.133003] ... version:                3
[    0.134001] ... bit width:              48
[    0.135001] ... generic registers:      4
[    0.136001] ... value mask:             0000ffffffffffff
[    0.137001] ... max period:             00007fffffffffff
[    0.138001] ... fixed-purpose events:   3
[    0.139001] ... event mask:             000000070000000f


Thanks!
