Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6A5C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A40241A3
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SUf+njXG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A40241A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753192AbeGDVkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 17:40:04 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33875 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753156AbeGDVkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 17:40:02 -0400
Received: by mail-ed1-f65.google.com with SMTP id d3-v6so4913829edi.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 14:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AOMYHORIWXq5FbCaTxAiVlYkKL2K7MrrnNKtKFyJXjQ=;
        b=SUf+njXG7xADoU5E+f/EuBZbVcEE4GTCMFVAkjRaxsd8Lr39qoFsYIEfhfh9psmaK5
         wwT4A48bINrSSUxlydtid/3hDQ1hQ+/zIq3vm6J8HbdWlVFAasMK7KmynjX2uYSNQuep
         smY8Z0e/YHt+9Ux18IDp592s50lSZUE31dMRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AOMYHORIWXq5FbCaTxAiVlYkKL2K7MrrnNKtKFyJXjQ=;
        b=NSt8W1JHRggqBTbGmwdCep+T3JWtp62hjxCyQci438qU4N3TJiYhyjSiRDrtGHzYZb
         omBgSut9maeBzy9oxBeR6neCXNK60dVCNUkxAsP+wB+P2GrlvD1WpOiHfV6P0s0m+qXD
         +LqT/GWGRvt2YmPcHcgGUrZ2Nr8giaTJZtjavXOMoRYyKfnI4kZaH5Rj9IGTrCkk4Ncy
         0dfWVpYZr6pzII9cLaCTCDGRfgjoXi+GfaQ3vUCVaTxWaQQFL3FKZDI379hvsbChT1wf
         AtkR6skGa2HcPVMHsvbBbeU6ybou9bWSfiLM5QyMolhyxAArnlScVvEgw0th4v+gp58r
         yzzw==
X-Gm-Message-State: APt69E2f0bUgH+w5IqrNPhHO638nrVhZRcmeWWbMfPMRxMOJ8Izw/Sj5
        Afbv3wqZaKs0NcVmyEbhJlVZ7DucdK2KDNobW+a5lw==
X-Google-Smtp-Source: AAOMgpfNh1vKLE3vQdfsP6JEQlcS/TjAg7KznBlHcjVqfvYTMwtycd5C90PTjd8jq3Z1fuP/Jsjk0npOKrzruWjNzpM=
X-Received: by 2002:a50:b505:: with SMTP id y5-v6mr4176559edd.195.1530740401374;
 Wed, 04 Jul 2018 14:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <1530570810-28929-1-git-send-email-mathieu.poirier@linaro.org>
 <1530570810-28929-6-git-send-email-mathieu.poirier@linaro.org>
 <20180703100348.fy43f4fosw3fdc6i@um.fi.intel.com> <20180703105652.psjq5cq4t7o2j6zk@um.fi.intel.com>
 <CANLsYkw4w-zRczcb2uddO4UsxXrCCoXCSkPko2it-OJX2H0ecA@mail.gmail.com> <87fu0z70hq.fsf@ashishki-desk.ger.corp.intel.com>
In-Reply-To: <87fu0z70hq.fsf@ashishki-desk.ger.corp.intel.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 4 Jul 2018 15:39:50 -0600
Message-ID: <CANLsYkxU4MaN9MDKvWKuLN4-W-hpj=fH_56yGs+Y3_4ffNfPLQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] perf/core: Use ioctl to communicate driver
 configuration to kernel
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>, ast@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-s390@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jul 2018 at 04:35, Alexander Shishkin
<alexander.shishkin@linux.intel.com> wrote:
>
> Mathieu Poirier <mathieu.poirier@linaro.org> writes:
>
> > On Tue, 3 Jul 2018 at 04:57, Alexander Shishkin
> > <alexander.shishkin@linux.intel.com> wrote:
> >>
> >> On Tue, Jul 03, 2018 at 01:03:48PM +0300, Alexander Shishkin wrote:
> >> > On Mon, Jul 02, 2018 at 04:33:29PM -0600, Mathieu Poirier wrote:
> >> > > +/*
> >> > > + * PMU driver configuration works the same way as filter management above,
> >> > > + * but without the need to deal with memory mapping.  Driver configuration
> >> > > + * arrives through the SET_DRV_CONFIG ioctl() where it is validated and applied
> >> > > + * to the event.  When the PMU is ready it calls perf_event_drv_config_sync() to
> >> > > + * bring the configuration information within reach of the PMU.
> >> >
> >> > Wait a second. The reason why we dance around with the generations of filters
> >> > is the locking order of ctx::mutex vs mmap_sem. In an mmap path, where we're
> >> > notified about mapping changes, we're called under the latter, and we'd need
> >> > to grab the former to update the event configuration. In your case, the
> >> > update comes in via perf_ioctl(), where we're already holding the ctx::mutex,
> >> > so you can just kick the PMU right there, via an event_function_call() or
> >> > perf_event_stop(restart=1). In the latter case, your pmu::start() would just
> >> > grab the new configuration. Should also be about 90% less code. :)
> >>
> >> Also, since it affects the AUX buffer configuration, it is probably a one
> >> time ioctl command that you issue before you mmap the buffer. If that's
> >> the case, you don't even have to worry about stopping the event, as it
> >> shouldn't be running, because without the buffer perf_aux_output_begin()
> >> should fail and so should the pmu::add() iirc.
> >>
> >
> > The idea behind the current approach was to make the SET_DRV_CONFIG
> > ioctl() usable by other drivers where multiple ioctl() calls could be
> > performed while a session in ongoing.  I also opted to introduce a
> > _sync() function to let the PMU refresh its configuration at the time
> > of its own choosing rather than having to interrupt the session.
>
> Yes, but the times of PMU's own choosing would still be more or less
> limited to ->start()/->stop().
>
> You can also do an event_function_call(), which would call
> ->config_sync(), which would be free to decide what to do with the new
> information, up to and including doing a ->stop()/->start() sequence. My
> guess is that you'd want to do either of the following:
>  * decide to apply the new configuration immediately, and do the
>  start-stop thing,
>  * decide to defer the new configuration until the next ->start().
>
> Both should work via cross call directly from the ioctl() call.

Other than doing a cross call, do you see any advantage of using
event_function_call()?  For what I currently need the cross call is
not necessary.

>
> > But all I need for coresight is to have available the sink information
> > and PMU configuration (in an upcoming patchset) by the time
> > setup_aux() is called.  You are correct, this is a one time
> > configuration and since the event isn't running there is no need for
> > locking - I should be able to access the PMU when the ioctl is called.
> >
> > If you are fine with this bare-bone scenario and don't care much about
> > usability in different situation, I'll do a respin with minimal
> > functionality that cover my needs.
>
> It doesn't have to be bare-bones, what I'm saying is that you shouldn't
> need the event->drv_config, as you can directly call
> pmu::config(new_config) (or config_sync(), but I'm guessing the _sync
> part is redundant if you don't keep the configuration in 2 parts) from
> the ioctl() and it should cover all your bases.

I think I get your point - I will do another respin and we can go from there.

Thanks,
Mathieu

>
> Regards,
> --
> Alex
