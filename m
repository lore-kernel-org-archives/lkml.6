Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7E5C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002C1218A4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jtYFEZ3N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfBKUnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:43:40 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:37657 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfBKUne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 15:43:34 -0500
Received: by mail-vk1-f193.google.com with SMTP id 197so73124vkf.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 12:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3cMNEJp8FIVlNz588OWfBZxhVehQjYTqZ3vLLL4zPk8=;
        b=jtYFEZ3NBXuWT5F2o1RL8G8oPhHMkT7Zi2FFAcUcAe2GfP4Zko/3kbba9wC8Ixg1Ud
         mG4wN+YrrNjAvT38Yba2d2aq54AIww1heqecXCOh8sZvZ5TSG5DxLMqTYV4lWnFW8iSK
         vy3V2CgTC+r3k74HXBh3cm4M3JG0WNPpfGMWVcFo0fbw8sflInhttctu6aCNE89tmQqa
         +R9IJxyw9Htsu78cDsO0dNLTwMcOzBambuayd0xm72Xu8NWwybgGJSmgVRQkthzoDsAx
         bYSPFcmegFgIz24epPzIV7bLKym5H0s9lCqgmpDeLpJEAW42uXN+Vy3CuPDSu3nIrTEB
         LikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3cMNEJp8FIVlNz588OWfBZxhVehQjYTqZ3vLLL4zPk8=;
        b=hiSEUoh/+W0oAbRLVeoNLc8Pcl4JOyoM0/7Axd5yy8oaHkhJPSJiWsrshOF486F65z
         QV0LtdqBrvWpPkgrFDBJTZsJJMyIBZdnTqFMSh3OxDKoZmckdcELBrA8m27+4YJoZUNF
         UxQX5qjTVhXmrtSBqRlPFzjVvbzFz0mL+EC7Uqw8MmFA7ZaRL+zWJOmt5HjM8YfuF1o9
         3MpJ1ENhkAHkwVPn6tSBO4cWV+jrkw0wZVCMJBBJfq+VBjymzZ26Ac2dLc4zmfPoQkg4
         fhRut3WR8fZQ1ywuNVMPf9cHbZXPZmYKPad92keUdDzacGKpU+A5gyy+E+RrENkn6uVH
         sjuA==
X-Gm-Message-State: AHQUAuag1PeJritLTiGeAOawRLtqDgcYmHn/ROXipruE0EAU7t8bug+J
        uEKzlgoFKnmzRAoVJf5BlLBB1TcowB2oAoDWmJsIYQ==
X-Google-Smtp-Source: AHgI3IY993flKSqaPva5JvGe863oAPvYT2EORnynoZVToilne9DN2XrTDo6n1rus2PuSRydnUgh1uRty1faxWMcqn3Y=
X-Received: by 2002:a1f:a147:: with SMTP id k68mr54329vke.1.1549917813273;
 Mon, 11 Feb 2019 12:43:33 -0800 (PST)
MIME-Version: 1.0
References: <CABPqkBQpQX67NOysim7s-R84nAYipXJ+DgR=xYPi6zWQWgq4Zg@mail.gmail.com>
 <20190204192721.GI5593@kernel.org> <CABPqkBTcxkKkxBwLfToenAk0ubp-o08xVq=XqpkfzYHTNqgBkQ@mail.gmail.com>
 <20190204202818.GC4794@krava> <CABPqkBQTpt0dhinJZc+mJ-JNvkU2M9DVx1G65ngWxZxk-eGBVA@mail.gmail.com>
 <20190205133727.GF4794@krava> <20190211101957.GB14253@krava>
 <CABPqkBSkyHRaXN-oVLuJJ=aPEBfqOAunRUReHsxESnC=KKQuPg@mail.gmail.com>
 <20190211185306.GD5046@krava> <20190211193202.GG3269@kernel.org> <20190211201831.GE5046@krava>
In-Reply-To: <20190211201831.GE5046@krava>
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 11 Feb 2019 12:43:22 -0800
Message-ID: <CABPqkBRdmfOde793id4GEuwD=eYL8TLKe1p8k07xWAh1MPD3AQ@mail.gmail.com>
Subject: Re: [RFC/PATCH 00/14] perf record: Add support to store data in directory
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 12:18 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Feb 11, 2019 at 04:32:02PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Feb 11, 2019 at 07:53:06PM +0100, Jiri Olsa escreveu:
> > > On Mon, Feb 11, 2019 at 10:34:16AM -0800, Stephane Eranian wrote:
> > > > On Mon, Feb 11, 2019 at 2:20 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > > > > On Tue, Feb 05, 2019 at 02:37:27PM +0100, Jiri Olsa wrote:
> > > > > I think all could be added and worked around with exception
> > > > > of BUILD_ID, which we store at the end (after processing
> > > > > all data) and we need it early in the report phase
> >
> > > > Buildids are injected after the fact via perf inject when in pipe mode.
> >
> > > > > maybe it's time to re-think that buildid -> mmap event
> > > > > association again, because it's pain in current implementation
> > > > > as well
> >
> > > > Sure, but what do you propose?
> >
> > > this:
> > >
> > > > > looks like bpf code is actualy getting build ids and storing
> > > > > it for the callchains in kernel.. we can check if we can do
> > > > > something similar for mmap events
> >
> > kernel/bpf/stackmap.c
> >
> > /* Parse build ID from 64-bit ELF */
> > static int stack_map_get_build_id_64(void *page_addr,
> >                                      unsigned char *build_id)
> >
> > yeah, wasn't aware of that, good thing doing backports, huh? :-)
> >
> > So do you thing about having a PERF_SAMPLE_BUILDID in sample_type and go
> > and stash that thing in PERF_RECORD_MMAP2?
>
That would be special processing. Normally the sample_type go into
each RECORD_SAMPLE.
So I would not recommend this approach.

> I thought having new MMAP3 event version with buildid field in it
> if available and/or enabled by bit in perf_event_attr
>
I think MMAP3 is a cleaner approach, though it adds yet another MMAP event.

> jirka
