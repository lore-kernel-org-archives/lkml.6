Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB046C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802962098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 802962098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeJCV7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:59:04 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34033 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbeJCV7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:59:04 -0400
Received: from tmo-096-48.customers.d1-online.com ([80.187.96.48] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g7imw-0005gw-2H; Wed, 03 Oct 2018 17:10:10 +0200
Date:   Wed, 3 Oct 2018 17:10:08 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@amacapital.net>
cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
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
Subject: Re: [patch 00/11] x86/vdso: Cleanups, simmplifications and CLOCK_TAI
 support
In-Reply-To: <8C316427-8BEC-4979-8AB2-5E385066BB6F@amacapital.net>
Message-ID: <alpine.DEB.2.21.1810031704480.23677@nanos.tec.linutronix.de>
References: <20180914125006.349747096@linutronix.de> <CALCETrU+jP2hPLoJWTYJKTvr7-=YLwtk1=cZ_uizHYQZ1z4P-w@mail.gmail.com> <87sh1ne64t.fsf@vitty.brq.redhat.com> <4B6A97E1-17E6-40F2-A7A0-87731668A07C@amacapital.net> <87murvdysd.fsf@vitty.brq.redhat.com>
 <8C316427-8BEC-4979-8AB2-5E385066BB6F@amacapital.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-391363870-1538579410=:23677"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-391363870-1538579410=:23677
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 3 Oct 2018, Andy Lutomirski wrote:
> > On Oct 3, 2018, at 5:01 AM, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> > Not all Hyper-V hosts support reenlightenment notifications (and, if I'm
> > not mistaken, you need to enable nesting for the VM to get the feature -
> > and most VMs don't have this) so I think we'll have to keep Hyper-V
> > vclock for the time being.
> > 
> But this does suggest that the correct way to pass a clock through to an
> L2 guest where L0 is HV is to make L1 use the “tsc” clock and L2 use
> kvmclock (or something newer and better).  This would require adding
> support for atomic frequency changes all the way through the timekeeping
> and arch code.
>
> John, tglx, would that be okay or crazy?

Not sure what you mean. I think I lost you somewhere on the way.

Thanks,

	tglx
--8323329-391363870-1538579410=:23677--
