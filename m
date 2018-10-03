Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86914C64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB002082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="ormPE0a5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB002082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbeJCXHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 19:07:40 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40945 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbeJCXHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 19:07:40 -0400
Received: by mail-wm1-f67.google.com with SMTP id z204-v6so5418962wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 09:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Fgfs7hB159s2vjbesYMqH67gZg2mYYtmdd8JOIAtM4M=;
        b=ormPE0a5h8cMhMZ0e8VWFlyyibu7qh98zkPXVppd7bAIFnOZ+Vqg3XpHhDq+746rbC
         I8tQ5Cf1KBk4YjxH4gSusJ0QJHpVNvOYpAoRcxxCuZ4faZJf5dfe0mD7i8YoQqUDiwsO
         MvcgW0zgfglchJWJwhE4wu84Kx982dVp7H33/P0125W2kiod7JwFSB0iUcMOfj8Jbdh0
         uiR7paobAxFhBfd4Hesq8FOYQnO4INRrWPjQ89tP2rCGyVf49SAbgh93t6q1Ki99sivg
         7fa35JGFS3LeoNKL5yHlPMGkNXM6izcF6nfdl2s6wdeYD8XaRFqXoLwGTcTCWfp/0U+F
         sKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Fgfs7hB159s2vjbesYMqH67gZg2mYYtmdd8JOIAtM4M=;
        b=Ftx2sCfdqY229RPwrotdPwFQAxwYdEU4j5fcCOeD3zn3/1JCGdPJr9fTlIKiUOhx30
         7ctqzZJe++iJFRpFDh6xlt6MsT1oyWe95iclGAcjBQgyDU+MKJUk/0R2oCmxrxNQf8PC
         d1cw8Nmt7A2pacCvInYp1/wgUVYIUP4MSaX85A47tfkpsyAXsfggyuaZb+v4TciqfKzQ
         p7IwJdSmNQy5kY3IN5zINNUWWMKKxcSkKH5kiVwrZeEWOH0R/32wF4p1MtlCPCKKMF63
         Tuxo48nQRL8SWdv2bLEBj3EJCTzenCWNHEMARsU+8hIplhmMNZtuAk4Pk46mdbsDZ2GD
         0QDg==
X-Gm-Message-State: ABuFfojmDGl5AeRZkDhNKIVBmx1O71wtvmIGiCP4s9BRYuBCJTOy2a42
        SyAAP6fCgELvOwvw19YWtqSj/6YhFm8zeSRk0Ro5Vw==
X-Google-Smtp-Source: ACcGV62QAXCLyBVoQ99Iy0zMFMRecSTEAzRGiPFAHCl8BRXuBDHVD7RPF2UD+ypV102ufL2FK+XP37EQNdqsVgAEj5s=
X-Received: by 2002:a1c:f312:: with SMTP id q18-v6mr2005692wmq.14.1538583514763;
 Wed, 03 Oct 2018 09:18:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180914125006.349747096@linutronix.de> <CALCETrU+jP2hPLoJWTYJKTvr7-=YLwtk1=cZ_uizHYQZ1z4P-w@mail.gmail.com>
 <87sh1ne64t.fsf@vitty.brq.redhat.com> <4B6A97E1-17E6-40F2-A7A0-87731668A07C@amacapital.net>
 <87murvdysd.fsf@vitty.brq.redhat.com> <8C316427-8BEC-4979-8AB2-5E385066BB6F@amacapital.net>
 <alpine.DEB.2.21.1810031704480.23677@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1810031704480.23677@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 3 Oct 2018 09:18:23 -0700
Message-ID: <CALCETrWHkrzADjRw=_SqC0Q0urJNppwT+pCSV0yMJ97ZFB20_w@mail.gmail.com>
Subject: Re: [patch 00/11] x86/vdso: Cleanups, simmplifications and CLOCK_TAI support
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Matt Rickard <matt@softrans.com.au>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        devel@linuxdriverproject.org,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 8:10 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Wed, 3 Oct 2018, Andy Lutomirski wrote:
> > > On Oct 3, 2018, at 5:01 AM, Vitaly Kuznetsov <vkuznets@redhat.com> wr=
ote:
> > > Not all Hyper-V hosts support reenlightenment notifications (and, if =
I'm
> > > not mistaken, you need to enable nesting for the VM to get the featur=
e -
> > > and most VMs don't have this) so I think we'll have to keep Hyper-V
> > > vclock for the time being.
> > >
> > But this does suggest that the correct way to pass a clock through to a=
n
> > L2 guest where L0 is HV is to make L1 use the =E2=80=9Ctsc=E2=80=9D clo=
ck and L2 use
> > kvmclock (or something newer and better).  This would require adding
> > support for atomic frequency changes all the way through the timekeepin=
g
> > and arch code.
> >
> > John, tglx, would that be okay or crazy?
>
> Not sure what you mean. I think I lost you somewhere on the way.
>

What I mean is: currently we have a clocksource called
""hyperv_clocksource_tsc_page".  Reading it does:

static u64 read_hv_clock_tsc(struct clocksource *arg)
{
    u64 current_tick =3D hv_read_tsc_page(tsc_pg);

    if (current_tick =3D=3D U64_MAX)
        rdmsrl(HV_X64_MSR_TIME_REF_COUNT, current_tick);

    return current_tick;
}

From Vitaly's email, it sounds like, on most (all?) hyperv systems
with nesting enabled, this clock is better behaved than it appears.
It sounds like the read behavior is that current_tick will never be
U64_MAX -- instead, the clock always works and, more importantly, the
actual scaling factor and offset only change observably on *guest*
request.

So why don't we we improve the actual "tsc" clocksource to understand
this?  ISTM the best model would be where the
__clocksource_update_freq_xyz() mechanism gets called so we can use it
like this:

clocksource_begin_update();
clocksource_update_mult_shift();
tell_hv_that_we_reenlightened();
clocksource_end_update();

Where clocksource_begin_update() bumps the seqcount for the vDSO and
takes all the locks, clocksource_update_mult_shift() updates
everything, and clocksource_end_update() makes the updated parameters
usable.

(AFAICT there are currently no clocksources at all in the entire
kernel that update their frequency on the fly using
__clocksource_update_xyz().  Unless I'm missing something, the x86 tsc
cpufreq hooks don't call into the core timekeeping at all, so I'm
assuming that the tsc clocksource is just unusable as a clocksource on
systems that change its frequency.)

Or we could keep the hyperv_clocksource_tsc_page clocksource but make
it use VCLOCK_TSC and a similar update mechanism.

I don't personally want to do this, because the timekeeping code is
subtle and I'm unfamiliar with it.  And I don't have *that* many spare
cycles :)
