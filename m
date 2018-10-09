Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94534C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4284C214DC
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmgruCnQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4284C214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbeJJD2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 23:28:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:39310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbeJJD2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 23:28:33 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51E572151C
        for <linux-kernel@vger.kernel.org>; Tue,  9 Oct 2018 20:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539115796;
        bh=EImMYQIQtriU1M+LjeP2cd8rj0C1xYjS3CeZrgu+T9I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GmgruCnQ9SGGkwBuvtliEKePrJCh0Uf0aYfAEaVlC8cZxEey24kq7odznhUYrz8bK
         w8tjsoCT2eUwtSQolq02BHUUiB9A9lDazs/fTybC5FfnjJiAGe06VXBm/GMOUIjmQp
         /Gh3+vZuN7hAXh0uyYUSWXHu1L35Q7L/5ZmYw25I=
Received: by mail-wm1-f42.google.com with SMTP id a8-v6so3319345wmf.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 13:09:56 -0700 (PDT)
X-Gm-Message-State: ABuFfohlJv+C+flVhmJhxWJxGaTjKYoMfVu0NVDEgEIBSLpfXZ9Wy+ok
        LFlPsTIKpRdzn96jUseCIWwDDPpPOhcuvB3iYqRm9g==
X-Google-Smtp-Source: ACcGV62+k8vg36s5QrOslltYstp9xd0BmXlUzncGiahsaIvk8s/24FUCHHgT09EoM38He7Sw6EGgfSUyctFPjgC9nE8=
X-Received: by 2002:a1c:f312:: with SMTP id q18-v6mr3074861wmq.14.1539115794622;
 Tue, 09 Oct 2018 13:09:54 -0700 (PDT)
MIME-Version: 1.0
References: <87k1mycfju.fsf@vitty.brq.redhat.com> <20181004081100.GI19272@hirez.programming.kicks-ass.net>
 <B8C05946-43BB-40A4-A564-53904FAF8CC0@amacapital.net> <20181004193150.GQ19272@hirez.programming.kicks-ass.net>
 <499807AB-E779-40C3-AA3F-E8C77A7770EC@amacapital.net> <CALCETrXNKCNZzUXj=2sp1vBd_o7HHzfW6RwyY5v3-wMfbVaZnQ@mail.gmail.com>
 <20181006202731.GC7129@amt.cnet> <CALCETrWqze2mifOdFc0GJYHtHGKiKX2Zdi5Kz87OyUogbqD15w@mail.gmail.com>
 <20181008152650.GB27822@amt.cnet> <CALCETrVY6VHPLs0GXZM4+VYraTa1+xs=iRJoRa++OHX9Wq+ieg@mail.gmail.com>
 <20181008193632.GA31729@amt.cnet>
In-Reply-To: <20181008193632.GA31729@amt.cnet>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 9 Oct 2018 13:09:42 -0700
X-Gmail-Original-Message-ID: <CALCETrW6b8=dU6vkXNS-rW1GPzJTbVxuVNsU4aoD_NwwobVQcg@mail.gmail.com>
Message-ID: <CALCETrW6b8=dU6vkXNS-rW1GPzJTbVxuVNsU4aoD_NwwobVQcg@mail.gmail.com>
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

On Tue, Oct 9, 2018 at 8:28 AM Marcelo Tosatti <mtosatti@redhat.com> wrote:
>
> On Mon, Oct 08, 2018 at 10:38:22AM -0700, Andy Lutomirski wrote:
> > On Mon, Oct 8, 2018 at 8:27 AM Marcelo Tosatti <mtosatti@redhat.com> wrote:

> > I read the comment three more times and even dug through the git
> > history.  It seems like what you're saying is that, under certain
> > conditions (which arguably would be bugs in the core Linux timing
> > code),
>
> I don't see that as a bug. Its just a side effect of reading two
> different clocks (one is CLOCK_MONOTONIC and the other is TSC),
> and using those two clocks to as a "base + offset".
>
> As the comment explains, if you do that, can't guarantee monotonicity.
>
> > actually calling ktime_get_boot_ns() could be non-monotonic
> > with respect to the kvmclock timing.  But get_kvmclock_ns() isn't used
> > for VM timing as such -- it's used for the IOCTL interfaces for
> > updating the time offset.  So can you explain how my patch is
> > incorrect?
>
> ktime_get_boot_ns() has frequency correction applied, while
> reading masterclock + TSC offset does not.
>
> So the clock reads differ.
>

Ah, okay, I finally think I see what's going on.  In the kvmclock data
exposed to the guest, tsc_shift and tsc_to_system_mul come from
tgt_tsc_khz, whereas master_kernel_ns and master_cycle_now come from
CLOCK_BOOTTIME.  So the kvmclock and kernel clock drift apart at a
rate given by the frequency shift and then suddenly agree again every
time the pvclock data is updated.

Is there a reason to do it this way?
