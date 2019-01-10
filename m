Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1568FC43444
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88C0214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aUn4RN0k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfAJRAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:00:14 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41148 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbfAJRAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:00:12 -0500
Received: by mail-lf1-f65.google.com with SMTP id c16so8799686lfj.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eYkLzlnfprc1E19rgfszl7a3v0UTbwhsSbLwYFVGylM=;
        b=aUn4RN0k+5xejsvkFvXKKCADmXeMBnTGcQrHTXW73g3wImkJPmwGIWBzweHznVRxTm
         NxEwro69r2zPaC5HOx0ReBoLmrlPVhGTvACMvuL6qkiM8IADPK/5fK8nYRTOi+T/+qMF
         zZ3eNuxcsV6/lnklZ/cXcTtyQJRBqbsi3SpBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eYkLzlnfprc1E19rgfszl7a3v0UTbwhsSbLwYFVGylM=;
        b=XwsC5U8XIXjzAM23sKhMFJ+uQ6WWFK+pr+HAQCQAAlVa1KiyGOHdrgO9I9rGWdUuKF
         hsi99SUJFCp4yZGFOrzQIpgQUIl0uBXkF+2ywPQ95ZCQiT/Nxytp+LIqyhPFl7ECBklX
         cJ3X3lf1K6U8Kl1sI/4r0JQCefV+j7pdz1He4e8bijIcJHWKaoht7OIr9Uj6uLbH2ULv
         6zA3KoDlpujuPQUYUUYOqO+tfRg/UfiHnWdgpyct2OEVgVSgn3vPj35PjnkTv9ucYHK9
         zEPPswnD8Kgq3n6w/wM5nO0WPkxnETnl7KHVSeKTR0HZyJA6sG+EZXpf+W6os+rfcfr7
         8B2g==
X-Gm-Message-State: AJcUukeRDLfBA7182ToQtb/2Nh41YXll/eLmOY5igmUcMfB2/L4puIbw
        VVjtmyAHGDIvr1MxTj2zkIhbikjF1dY=
X-Google-Smtp-Source: ALg8bN4/q4tpRsPk8En4bO0TAHYglN1/zQn4bfjRdEXBAXfzIGEu/XVgpaICsknGjM4aGFCVc2a10g==
X-Received: by 2002:a19:1d0d:: with SMTP id d13mr6081400lfd.74.1547139608817;
        Thu, 10 Jan 2019 09:00:08 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id e14-v6sm15435211ljl.43.2019.01.10.09.00.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 09:00:07 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id n18so8818005lfh.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:00:07 -0800 (PST)
X-Received: by 2002:a19:c014:: with SMTP id q20mr5939141lff.16.1547139607220;
 Thu, 10 Jan 2019 09:00:07 -0800 (PST)
MIME-Version: 1.0
References: <20190110101232.9398-1-o.rempel@pengutronix.de>
 <20190110101232.9398-4-o.rempel@pengutronix.de> <CAADWXX_G7X6QkNuqnpMyr+MGP+nUhqPaifJrfC=m57mhJu2jdg@mail.gmail.com>
 <20190110151953.qpat4t7lat6plfk6@pengutronix.de>
In-Reply-To: <20190110151953.qpat4t7lat6plfk6@pengutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Jan 2019 08:59:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=whSbmZm8aZyoR9XjoLzotbXdxNuUpcxUTBo7svS77R6+A@mail.gmail.com>
Message-ID: <CAHk-=whSbmZm8aZyoR9XjoLzotbXdxNuUpcxUTBo7svS77R6+A@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] drivers/tty: increase priority for tty_buffer_worker
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 7:19 AM Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>
> It is for industrial low latency RS-422 based application. The loopback
> test is just easy way to test/reproduce it without additional hardware.
>
> What is good, mainlineable way to implement it?

I can easily see that for that specific use it might be the right
thing and the easiest way to give better latency guarantees. I just
don't think it's generally applicable, because of the reasons stated
(ie "giving one thread much higher priority can have some detrimental
effects on other cases").

And obviously for people who do *not* want this, the extra kthreads
for just tty flushing are just ugly overhead. We've tried to no longer
have a lot of special threads. At least yours isn't percpu..

I wonder if  you could get at least similar behavior by:

 - allocating your own workqueue

      tty_wq = alloc_workqueue("tty", WQ_HIGHPRI, 0);

 - and then instead of the current

     queue_work(system_unbound_wq, &buf->work);

   you'd queue it onto that WQ_HIGHPRI workqueue.

NOTE! The advantage of the above is that it should be much easier to
make conditional. It could be a small boot-time option to say "create
your own tty high-priority workqueue", and it would be off by default
- and the tty buffer code would just use the default
"system_unbound_wq" normally, but then with the special option to use
that HIGHPRI workqueue.

See what I'm saying? It shouldn't be all that different from what you
do in your patch-series, but at least this way it's an easy
conditional, and people who don't have your kind of special latency
issues would never see it (and the code would be maintainable).

And do explain in the commit messages what your real load is (the
loopback case can still be interesting to show numbers in a controlled
environment, but it's not very compelling from a "this is the _reason_
for the change", if you see what I mean).

How does that sound? I think it would be much more likely to be
acceptable, and it doesn't sound like a big change.

But I may have missed something.

             Linus
