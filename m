Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95ADC28CF8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 23:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64ADE20644
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 23:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vyOVeUh6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64ADE20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbeJLGaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 02:30:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbeJLGaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 02:30:11 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 686D9214C4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 23:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539298844;
        bh=jeNCpfa8w1IQM3+VGFadd6JfiNb1m/3VN3xklLz3EPc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vyOVeUh6/8ls2ZXmmIOnF9CAyJYfEqSZqgughSIj1xg5Dsg0IdTiO5gUebhkbUHfs
         Kdmwmw66zxNRJU//ZV1MXRzOAMEsh3ocY8+sHNpywNLCeuAp/DCUmZj8vGFGCVapfq
         Mtq3rTsBiUwfDo8VoKPSo0EaXTflLkmAB7l5i4es=
Received: by mail-wm1-f54.google.com with SMTP id y140-v6so16766627wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 16:00:44 -0700 (PDT)
X-Gm-Message-State: ABuFfogFi3uYi3u0KZxjIbBiCgjoVgBMuf7SbKwaJNVIXlxcG/IeXVti
        LYn3vP6g+y1bbxoM8jlPp1cvHJ20OY4MdX4gobk1TQ==
X-Google-Smtp-Source: ACcGV60F1CujrTnuEe/nXnXQ2a2dIxvg6TOv4JtQtLIUwd9tgyxuekhnAUvbsZFcZJzL+HzBl6vADIBNIfCaEY0a4yc=
X-Received: by 2002:a1c:4054:: with SMTP id n81-v6mr3330398wma.82.1539298842721;
 Thu, 11 Oct 2018 16:00:42 -0700 (PDT)
MIME-Version: 1.0
References: <B8C05946-43BB-40A4-A564-53904FAF8CC0@amacapital.net>
 <20181004193150.GQ19272@hirez.programming.kicks-ass.net> <499807AB-E779-40C3-AA3F-E8C77A7770EC@amacapital.net>
 <CALCETrXNKCNZzUXj=2sp1vBd_o7HHzfW6RwyY5v3-wMfbVaZnQ@mail.gmail.com>
 <20181006202731.GC7129@amt.cnet> <CALCETrWqze2mifOdFc0GJYHtHGKiKX2Zdi5Kz87OyUogbqD15w@mail.gmail.com>
 <20181008152650.GB27822@amt.cnet> <CALCETrVY6VHPLs0GXZM4+VYraTa1+xs=iRJoRa++OHX9Wq+ieg@mail.gmail.com>
 <20181008193632.GA31729@amt.cnet> <CALCETrW6b8=dU6vkXNS-rW1GPzJTbVxuVNsU4aoD_NwwobVQcg@mail.gmail.com>
 <20181011222744.GA17955@amt.cnet>
In-Reply-To: <20181011222744.GA17955@amt.cnet>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 11 Oct 2018 16:00:29 -0700
X-Gmail-Original-Message-ID: <CALCETrXMEqHOa-8s51gGE_gxWVzTWY5eLiZrGLhMUkWKZkfmDw@mail.gmail.com>
Message-ID: <CALCETrXMEqHOa-8s51gGE_gxWVzTWY5eLiZrGLhMUkWKZkfmDw@mail.gmail.com>
Subject: Re: [patch 00/11] x86/vdso: Cleanups, simmplifications and CLOCK_TAI support
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Matt Rickard <matt@softrans.com.au>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        devel@linuxdriverproject.org,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 3:28 PM Marcelo Tosatti <mtosatti@redhat.com> wrote:
>
> On Tue, Oct 09, 2018 at 01:09:42PM -0700, Andy Lutomirski wrote:
> > On Tue, Oct 9, 2018 at 8:28 AM Marcelo Tosatti <mtosatti@redhat.com> wrote:
> > >
> > > On Mon, Oct 08, 2018 at 10:38:22AM -0700, Andy Lutomirski wrote:
> > > > On Mon, Oct 8, 2018 at 8:27 AM Marcelo Tosatti <mtosatti@redhat.com> wrote:
> >
> > > > I read the comment three more times and even dug through the git
> > > > history.  It seems like what you're saying is that, under certain
> > > > conditions (which arguably would be bugs in the core Linux timing
> > > > code),
> > >
> > > I don't see that as a bug. Its just a side effect of reading two
> > > different clocks (one is CLOCK_MONOTONIC and the other is TSC),
> > > and using those two clocks to as a "base + offset".
> > >
> > > As the comment explains, if you do that, can't guarantee monotonicity.
> > >
> > > > actually calling ktime_get_boot_ns() could be non-monotonic
> > > > with respect to the kvmclock timing.  But get_kvmclock_ns() isn't used
> > > > for VM timing as such -- it's used for the IOCTL interfaces for
> > > > updating the time offset.  So can you explain how my patch is
> > > > incorrect?
> > >
> > > ktime_get_boot_ns() has frequency correction applied, while
> > > reading masterclock + TSC offset does not.
> > >
> > > So the clock reads differ.
> > >
> >
> > Ah, okay, I finally think I see what's going on.  In the kvmclock data
> > exposed to the guest, tsc_shift and tsc_to_system_mul come from
> > tgt_tsc_khz, whereas master_kernel_ns and master_cycle_now come from
> > CLOCK_BOOTTIME.  So the kvmclock and kernel clock drift apart at a
> > rate given by the frequency shift and then suddenly agree again every
> > time the pvclock data is updated.
>
> Yes.
>
> > Is there a reason to do it this way?
>
> Since pvclock updates which update system_timestamp are expensive (must stop all vcpus),
> they should be avoided.
>

Fair enough.

> So only HW TSC counts

makes sense.

>, and used as offset against vcpu's tsc_timestamp.
>

Why don't you just expose CLOCK_MONTONIC_RAW or CLOCK_MONOTONIC_RAW
plus suspend time, though?  Then you would actually be tracking a real
kernel timekeeping mode, and you wouldn't need all this complicated
offsetting work to avoid accidentally going backwards.
