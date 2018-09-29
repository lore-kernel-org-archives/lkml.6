Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10162C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 06:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE440206B2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 06:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE440206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeI2NAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 09:00:14 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55513 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbeI2NAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 09:00:13 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g68oB-0001N5-RJ; Sat, 29 Sep 2018 08:32:56 +0200
Date:   Sat, 29 Sep 2018 08:32:55 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Max Filippov <jcmvbkbc@gmail.com>
cc:     Andy Lutomirski <luto@amacapital.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        fthain@telegraphics.com.au
Subject: Re: [PATCH] futex: Set USER_DS for the futex_detect_cmpxchg() test
In-Reply-To: <CAMo8Bf+mfK72DPehvphfJnvLc=ne-0bn52drOnMawp1oKjYsig@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1809290832360.1432@nanos.tec.linutronix.de>
References: <74fb6ce22f62e0fb48b91ca9918b74cedbcecaf1.1538096323.git.luto@kernel.org> <alpine.DEB.2.21.1809280819040.8118@nanos.tec.linutronix.de> <CAMuHMdWWxgvo0a+8UvesiVikWS_45yOXRhM39F31Vn17kN+Ptg@mail.gmail.com> <20180928103726.07761672@mschwideX1>
 <alpine.DEB.2.21.1809281041420.2004@nanos.tec.linutronix.de> <0B38810F-3E22-45A8-9D5D-EDEABD214148@amacapital.net> <20180928165321.0ddaf948@mschwideX1> <CALCETrXm_-YVVw4YQVn8E+hHGAQ6tv+ie8Sfq=h72R5U8=hf-g@mail.gmail.com> <CAMo8BfJ7t-qPWzGPb6JzqEhPm9JBzvAX0a2paBXeQt-RCeHe_w@mail.gmail.com>
 <alpine.DEB.2.21.1809282224090.1432@nanos.tec.linutronix.de> <A3EEA386-DC02-432B-8B53-F1ECD035F431@amacapital.net> <CAMo8Bf+mfK72DPehvphfJnvLc=ne-0bn52drOnMawp1oKjYsig@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1766059854-1538202775=:1432"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1766059854-1538202775=:1432
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 28 Sep 2018, Max Filippov wrote:
> On Fri, Sep 28, 2018 at 2:08 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> >> On Sep 28, 2018, at 1:26 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> >>
> >>> On Fri, 28 Sep 2018, Max Filippov wrote:
> >>>
> >>>> On Fri, Sep 28, 2018 at 11:02 AM, Andy Lutomirski <luto@amacapital.net> wrote:
> >>>> There may be a much nicer solution.  Unless I missed something, only
> >>>> mips and xtensa even have the possibility of cmpxchg being missing.
> >>>> We could just make those arches supply a futex-detecting helper.
> >>>
> >>> In case of xtensa availability of cmpxchg is known at build time.
> >>
> >> That makes it even simpler. Could you provide a patch which selects
> >> CONFIG_HAVE_FUTEX_CMPXCHG for the right set of CPUs please?
> >>
> >>
> >
> > I think that’s the wrong approach, since it won’t cover mips. How about adding this to mips and xtensa only:
> >
> > static inline void arch_have_futex_cmpxchg(void) {...};
> > #define arch_have_futex_cmpxchg arch_have_futex_cmpxchg
> >
> > And getting rid of the config option.
> 
> I'd rather do that, given that defining Kconfig entries that describe
> parts of xtensa configuration is somewhat awkward and redundant.

Fair enough.

Thanks,

	tglx
--8323329-1766059854-1538202775=:1432--
