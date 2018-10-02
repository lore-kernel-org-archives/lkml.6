Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC10C64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF172089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbEts0t9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FF172089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbeJCDun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 23:50:43 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39325 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbeJCDun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 23:50:43 -0400
Received: by mail-it1-f195.google.com with SMTP id w200-v6so5779864itc.4;
        Tue, 02 Oct 2018 14:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2nknQ83sC6v2CzepqGr/V2tQe3WbPDlGBca7BLfJpXQ=;
        b=EbEts0t9AHeLCRExNdnoCWcM2oiyuBSqoLADigpZAD753jlm5mlJMb/oPMcVCeqGZ/
         Nel63uqKgMdsZcksC7XALUNw+527vtYGuRbWbz/GFNcSfq4wszwieKvb74YjxGZXH7F8
         9bAH6SLDkmpdk+qviemYMGqrWWud8f/4NRfrBbP3ZFhCoTRqrk4Mnq8TiBtFqjmr0KM8
         Z0M2Rv+6Fw3/QPZT4Rvou6YjYbb/cor9O7N2vc+STFz6C8sM7o6FIlBlxjpxq7a1SyQk
         kopN+Z3qp1eh7gv0nzBbfCXgjkipPyjQ4mJXf1LhY8iiBD93H0ptgfH6FNXBZvJG0AQ7
         umWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2nknQ83sC6v2CzepqGr/V2tQe3WbPDlGBca7BLfJpXQ=;
        b=YtheH3gWl3ZaGnhUNKUgWq5P3Tn/IljUkZuu52+CdzEZLG5EQ6G0aynYY8AWxAi+jj
         wBOyJ6PKQ13eg4RxNiMzhdQmariiXyzxqyb48hcUOt8U3G2UDdUkY+i9RXU1SLrVHCqi
         6GrREPu2g6Pi/O78DD8OSJq6ZHX92MksSY8ZhfjpSUAuwjqNVyxadEo3q7zDTHCBtKz+
         Ha/r3fvzBRfW+s3HRd1g0/QNVveTDZO6EWx78NSCKPhwzEDt66oAdo5RiFAn2fnatHsL
         pcRFmjBJhOatkmJf5whnCCLy4O3nPjr9OainbZ6uJPqrHk04xhCAwFUsavGVhbDC468s
         aQfQ==
X-Gm-Message-State: ABuFfoiZ+BxXbmmK8HQX1m6kSMwClRKPjVGILt0HpwhmtscXPpL6B8hc
        eu68AURHUTaQF+XzKjgwCMRc4HlwX7U6Pr/wBrg=
X-Google-Smtp-Source: ACcGV631hwKAkcKQ/AJsBn0p1QEIIr3pZWK3WHI2+7r3yr2W2RfGRLsLSwSvrDTsLQUieG7xKoXATdF5oz3UOjACM4U=
X-Received: by 2002:a24:a343:: with SMTP id p64-v6mr3440800ite.10.1538514327054;
 Tue, 02 Oct 2018 14:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180919205037.9574-1-dima@arista.com> <874lej6nny.fsf@xmission.com>
 <20180924205119.GA14833@outlook.office365.com> <874leezh8n.fsf@xmission.com>
 <20180925014150.GA6302@outlook.office365.com> <87zhw4rwiq.fsf@xmission.com>
 <alpine.DEB.2.21.1809272247270.8118@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1809272335430.8118@nanos.tec.linutronix.de>
 <20181001232033.GA31324@outlook.office365.com> <alpine.DEB.2.21.1810020811290.32062@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1810020811290.32062@nanos.tec.linutronix.de>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Date:   Tue, 2 Oct 2018 22:05:15 +0100
Message-ID: <CAJwJo6a+WWpAxVAUuYt8TrCF+1a=BdoFQjU9vto0iiUN5vygsA@mail.gmail.com>
Subject: Re: [RFC 00/20] ns: Introduce Time Namespace
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrei Vagin <avagin@virtuozzo.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dmitry Safonov <dima@arista.com>,
        open list <linux-kernel@vger.kernel.org>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        containers@lists.linux-foundation.org, crml <criu@openvz.org>,
        Linux API <linux-api@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas, Andrei, Eric,

On Tue, 2 Oct 2018 at 07:15, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Mon, 1 Oct 2018, Andrey Vagin wrote:
>
> > On Thu, Sep 27, 2018 at 11:41:49PM +0200, Thomas Gleixner wrote:
> > > On Thu, 27 Sep 2018, Thomas Gleixner wrote:
> > > > Add time skew via NTP/PTP into the picture and you might have to adjust
> > > > timers as well, because you need to guarantee that they are not expiring
> > > > early.
> > > >
> > > > I haven't looked through Dimitry's patches yet, but I don't see how this
> > > > can work at all without introducing subtle issues all over the place.
> > >
> > > And just a quick scan tells me that this is broken. Timers will expire
> > > early or late. The latter is acceptible to some extent, but larger delays
> > > might come with surprise. Expiring early is an absolute nono.
> >
> > Do you mean that we have to adjust all timers after changing offset for
> > CLOCK_MONOTONIC or CLOCK_BOOTTIME? Our idea is that offsets for
> > monotonic and boot times will be set immediately after creating a time
> > namespace before using any timers.
>
> I explained that in detail in this thread, but it's not about the initial
> setting of clock mono/boot before any timers have been armed.
>
> It's about setting the offset or clock realtime (via settimeofday) when
> timers are already armed. Also having a entirely different time domain,
> e.g. separate NTP adjustments, makes that necessary.

It looks like, there is a bit of misunderstanding each other:
Andrei was talking about the current RFC version, where we haven't
introduced offsets for clock realtime. While Thomas IIUC, is looking
how-to expand time namespace over realtime.

As CLOCK_REALTIME virtualization raises so many complex questions
like a different length of the second or list of realtime timers in ns we
haven't added any realization for it.

It seems like an initial introduction for timens can be expanded after to cover
realtime clocks too. While it may seem incomplete, it solves issues for
restoring/migration of real-world applications like nodejs, Oracle DB server
which fails after being restored if there is a leap in monotonic time.

While solving the mentioned issues, it doesn't bring overhead.
(well, Andy noted that cmp for zero-offsets on vdso can be optimized too,
which will be done in v1).

Thomas, thanks much for your input - now we know that we'll need to
introduce list for timers in namespace when we'll add realtime clocks.
Do you believe that CLOCK_MONOTONIC_SYNC would be an easier
concept than offsets per-namespace?

Thanks,
             Dmitry
