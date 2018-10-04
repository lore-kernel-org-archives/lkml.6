Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD3AC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 531182082A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="nyRa8nkw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 531182082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbeJDUyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:54:15 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35228 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbeJDUyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:54:15 -0400
Received: by mail-pg1-f195.google.com with SMTP id v133-v6so3219939pgb.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 07:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gUGhARdpwe+ATcLUWJmAL1KRH7spZpd+3Pv9D624hcQ=;
        b=nyRa8nkwuzMfBMc9ax1Ep4v7EvyCS4pc1L308IxHFY3hgaiUXUSVBarzcIlTwU7rAC
         aXCnTyJmxqaOE30lmiuWy3rAsm8dOCkKUZghdekwvB9uJ97L7+UAoVHA0Ac/hhyvSQCS
         QY9XOji0mnIvlJV1hQG2dCb5ThG0uO3SB3jLGxsbxTzu1EyROn9TYHKIY4sdomJ/yF4D
         vty3jCgd6gaa2R8gZMleEexzG76POkd/xh5gdlpP3K3hPVz/62D3bjzuSGoOVpqkfDB/
         ZRnJbKnTEDqMTfFMTWXr2D7lqDhJC6l11C6I+zr7R+BRB1H7Zwkys4Yi7+iRzv18nFCT
         +piQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gUGhARdpwe+ATcLUWJmAL1KRH7spZpd+3Pv9D624hcQ=;
        b=LY/XcwKQ3d3QRuD1Py43UOz6HfHYzUEuMDFCE3nn28Lgjo9Hm09Z29dQ5CvTKWx+3g
         0myOkkB+9hphGt+8g6W1+CcLSl4wJe6PRjv2fTPwOAbc3KLiXLmOYLljbhKXJUmM9DUK
         jKB2O5E87cINvbKeD72RAFPVGlBrctoqsDGHgp6q1H0g+FJePJyD/jEyYtop8W3vfhqy
         mNQDcF26KN1mAbTvCIP375KufGCkOUHscbVWTowL+n+Brv2ouuxiOq/QE2NO24vYdwgm
         RDBey9uD5++GMtPHVxwI2sm8E2zVWHEfrHGd9ZxtsNc/sTxBJR3pTwPRLbEcCjYmIov4
         79Xg==
X-Gm-Message-State: ABuFfogtlASbEEx+C3jvOijp47cwT2xN90X0yvWKthGRYZ5y8QAqhseT
        twKDJx8ZY+dTBpfV8rQtXpYn4g==
X-Google-Smtp-Source: ACcGV63q0x9P3qDXvFMKbWToItT/ckLjR31ZyRFNk/NlFNBLCI7B0dKjqoQS02w+KkTHQ9UJ6MSm4w==
X-Received: by 2002:a63:1148:: with SMTP id 8-v6mr5990896pgr.172.1538661648014;
        Thu, 04 Oct 2018 07:00:48 -0700 (PDT)
Received: from ?IPv6:2600:1010:b02c:cbf4:5532:1d8f:efe5:8aa? ([2600:1010:b02c:cbf4:5532:1d8f:efe5:8aa])
        by smtp.gmail.com with ESMTPSA id o2-v6sm14351380pfj.57.2018.10.04.07.00.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 07:00:46 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [patch 00/11] x86/vdso: Cleanups, simmplifications and CLOCK_TAI support
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <20181004081100.GI19272@hirez.programming.kicks-ass.net>
Date:   Thu, 4 Oct 2018 07:00:45 -0700
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
Message-Id: <B8C05946-43BB-40A4-A564-53904FAF8CC0@amacapital.net>
References: <20180914125006.349747096@linutronix.de> <CALCETrU+jP2hPLoJWTYJKTvr7-=YLwtk1=cZ_uizHYQZ1z4P-w@mail.gmail.com> <87sh1ne64t.fsf@vitty.brq.redhat.com> <20181003190617.GC21381@amt.cnet> <87k1mycfju.fsf@vitty.brq.redhat.com> <20181004081100.GI19272@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 4, 2018, at 1:11 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
>> On Thu, Oct 04, 2018 at 09:54:45AM +0200, Vitaly Kuznetsov wrote:
>> I was hoping to hear this from you :-) If I am to suggest how we can
>> move forward I'd propose:
>> - Check if pure TSC can be used on SkyLake+ systems (where TSC scaling
>> is supported).
>> - Check if non-masterclock mode is still needed. E.g. HyperV's TSC page
>> clocksource is a single page for the whole VM, not a per-cpu thing. Can
>> we think that all the buggy hardware is already gone?
>=20
> No, and it is not the hardware you have to worry about (mostly), it is
> the frigging PoS firmware people put on it.
>=20
> Ever since Nehalem TSC is stable (unless you get to >4 socket systems,
> after which it still can be, but bets are off). But even relatively
> recent systems fail the TSC sync test because firmware messes it up by
> writing to either MSR_TSC or MSR_TSC_ADJUST.
>=20
> But the thing is, if the TSC is not synced, you cannot use it for
> timekeeping, full stop. So having a single page is fine, it either
> contains a mult/shift that is valid, or it indicates TSC is messed up
> and you fall back to something else.
>=20
> There is no inbetween there.
>=20
> For sched_clock we can still use the global page, because the rate will
> still be the same for each cpu, it's just offset between CPUs and the
> code compensates for that.

But if we=E2=80=99re in a KVM guest, then the clock will jump around on the s=
ame *vCPU* when the vCPU migrates.

But I don=E2=80=99t see how kvmclock helps here, since I don=E2=80=99t think=
 it=E2=80=99s used for sched_clock.

