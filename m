Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D75BC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E64852098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="GB93FSb/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E64852098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbeJEDAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 23:00:42 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46120 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeJEDAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 23:00:42 -0400
Received: by mail-pl1-f195.google.com with SMTP id v5-v6so5680461plz.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 13:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0noOyB/d0YIJyaZfGPSLOCEgOe+l0ChWQPXnaoXY3i0=;
        b=GB93FSb/zaRNdLeMsKLFY60oZ5OGn9MvG8GxLt6HSxti24Kpyv8GfdKZlcF9RiEPY7
         w88cjY3B99aaDdm02htbK/jjH9Y/UeUPS9vguVPIyWkb4YVYoRe+PBdYwl6T5pqHLx/v
         KR5ISVwdv49rYXR15WrMel0A34lcDi+8vD0stpSFL5XxSep6t6TpbAm1/Uq0LzWRHCJe
         xbox4XRHWn1ckDBdCLiWO0j+x0OTJXRsMExrRwg5pKkCvimbVt2H46JkCx80H4+WcXhI
         eZlu9bRRgR1cLfeUGL/ahodsIwPpAb91ATXOOdwy+cIypowffKmw4ydcVBjsiaz6LQAG
         YKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0noOyB/d0YIJyaZfGPSLOCEgOe+l0ChWQPXnaoXY3i0=;
        b=EBLhWLxXxG0cs+nbHHuhVVWA/ohUqzivrTQgXpx4QIhY+BBjHqsioRFWCMeaqTPOjz
         TcOaBA3CyjM1SDmCJwMfH+iui21rv5dlM/K1CfEHOF1SCK//qs7XsDM0gZpkKwNlSaX9
         BvrUnC3oaME+ZKvT/rt0LTeCQfvqLnL/DEELyDwixU/8An/TNqC9vwjUcWP6yUsMttFt
         1KCSWxw7k/3wJA/vEMfu/KpiXJ/Sjt79TYFEfyimfNurgh3NRkVbV7zqkbHpMOGiXkMq
         O/LD4Q1siNHQheaIfAe5RIa8o3P/ID4eoe5NXtefOvbKF2Xw02CPuTEXnqxLk5hYYVBs
         SxBA==
X-Gm-Message-State: ABuFfoiRobTbGM2QWbgFoMFRSYLrY4eRzxUD/lFZiIFQf1A4Rl4KJdUU
        SCrLLcISxbZtg65hxpwBQ014bA==
X-Google-Smtp-Source: ACcGV61moOA2zDEBrt73wzmy2yhm+hVD74ONL5SVdCyYwUQM3SLeOFp6Zicc5wFW5IiyAh7E2Z16eA==
X-Received: by 2002:a17:902:7207:: with SMTP id ba7-v6mr8159107plb.266.1538683553218;
        Thu, 04 Oct 2018 13:05:53 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:950e:67bb:f88c:b77f? ([2601:646:c200:7429:950e:67bb:f88c:b77f])
        by smtp.gmail.com with ESMTPSA id s85-v6sm9909101pfi.15.2018.10.04.13.05.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 13:05:52 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [patch 00/11] x86/vdso: Cleanups, simmplifications and CLOCK_TAI support
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <20181004193150.GQ19272@hirez.programming.kicks-ass.net>
Date:   Thu, 4 Oct 2018 13:05:50 -0700
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
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
Content-Transfer-Encoding: quoted-printable
Message-Id: <499807AB-E779-40C3-AA3F-E8C77A7770EC@amacapital.net>
References: <20180914125006.349747096@linutronix.de> <CALCETrU+jP2hPLoJWTYJKTvr7-=YLwtk1=cZ_uizHYQZ1z4P-w@mail.gmail.com> <87sh1ne64t.fsf@vitty.brq.redhat.com> <20181003190617.GC21381@amt.cnet> <87k1mycfju.fsf@vitty.brq.redhat.com> <20181004081100.GI19272@hirez.programming.kicks-ass.net> <B8C05946-43BB-40A4-A564-53904FAF8CC0@amacapital.net> <20181004193150.GQ19272@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 4, 2018, at 12:31 PM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Thu, Oct 04, 2018 at 07:00:45AM -0700, Andy Lutomirski wrote:
>>> On Oct 4, 2018, at 1:11 AM, Peter Zijlstra <peterz@infradead.org> wrote:=

>>>=20
>>>> On Thu, Oct 04, 2018 at 09:54:45AM +0200, Vitaly Kuznetsov wrote:
>>>> I was hoping to hear this from you :-) If I am to suggest how we can
>>>> move forward I'd propose:
>>>> - Check if pure TSC can be used on SkyLake+ systems (where TSC scaling
>>>> is supported).
>>>> - Check if non-masterclock mode is still needed. E.g. HyperV's TSC page=

>>>> clocksource is a single page for the whole VM, not a per-cpu thing. Can=

>>>> we think that all the buggy hardware is already gone?
>>>=20
>>> No, and it is not the hardware you have to worry about (mostly), it is
>>> the frigging PoS firmware people put on it.
>>>=20
>>> Ever since Nehalem TSC is stable (unless you get to >4 socket systems,
>>> after which it still can be, but bets are off). But even relatively
>>> recent systems fail the TSC sync test because firmware messes it up by
>>> writing to either MSR_TSC or MSR_TSC_ADJUST.
>>>=20
>>> But the thing is, if the TSC is not synced, you cannot use it for
>>> timekeeping, full stop. So having a single page is fine, it either
>>> contains a mult/shift that is valid, or it indicates TSC is messed up
>>> and you fall back to something else.
>>>=20
>>> There is no inbetween there.
>>>=20
>>> For sched_clock we can still use the global page, because the rate will
>>> still be the same for each cpu, it's just offset between CPUs and the
>>> code compensates for that.
>>=20
>> But if we=E2=80=99re in a KVM guest, then the clock will jump around on t=
he
>> same *vCPU* when the vCPU migrates.
>=20
> Urgh yes..
>=20
>> But I don=E2=80=99t see how kvmclock helps here, since I don=E2=80=99t th=
ink it=E2=80=99s used
>> for sched_clock.
>=20
> I get hits on kvm_sched_clock, but haven't looked further.

Ok, so KVM is using the per-vCPU pvclock data for sched_clock. Which hopeful=
ly does something intelligent.

Regardless of any TSC syncing issues, a paravirt clock should presumably be u=
sed for sched_clock to account for time that the vCPU was stopped.

It would be fantastic if this stuff were documented much better, both in ter=
ms of the data structures and the Linux code.

