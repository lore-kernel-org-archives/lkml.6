Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAC9C1B0F7
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83FCA20883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nlUyHR5x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbfARVE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 16:04:29 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44310 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729587AbfARVE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 16:04:28 -0500
Received: by mail-ed1-f67.google.com with SMTP id y56so12182583edd.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 13:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5QByEDELBxRUvxZKpacNujFAcACoIYllmifRxnqUMz8=;
        b=nlUyHR5xZQjUoA5+h5+sPpxvW7D4URdLNIbTZrlJ8fa0oArc/kQiEeC0BWnBq4n7Ev
         UWE2F2Uq41HzqjHd8h37XMjsUUcREOKNVyIXzTR2vaxnzDcpIATEhYQ4ui7kZGqShsIc
         KTkAYzLMJLgrOnl26eMBtmZkJALCuD8B/Cs+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5QByEDELBxRUvxZKpacNujFAcACoIYllmifRxnqUMz8=;
        b=dCJ9y96lm8lbncX5N3jb4mAEW4/EV8N9m9yt5f1vtASpqFzDx44Di4W2rySXsZcNXr
         s022j3VrLMZTra1Ln6YJUOYhE+LcUNxuSkLLkKn3u4CaoOHH6qX2lbAinPC5Xwroqsb8
         HtDdOixBTnKCLjBqFS/GMY8A45WCe8UuAEk7qydo3uymq00igtziLQQQl07mHs2rrpk+
         WD9zSetu/Bw2KyzHT0a0lGh/kvpzY82eyUxUb8czgB6TkJs4yYtq74aqGBONCX1GJDqp
         LSwBYRcBVPws0hi6OrvRjGJpPYLHIwWuzTLRvcXxdCVNoVaxm4bUKuPJoCYO5uYMACS7
         ZIQg==
X-Gm-Message-State: AJcUukfzE1VSnVYaxrAIYx6eEXYdBJEDiBpt92iPB584id/Ex1Mi0SmE
        7NKe57Dm/NpY92MJRUv4It/MkBspwsc=
X-Google-Smtp-Source: ALg8bN7xNhNmbyVjVwqM9Wn6Xm+3eKnmVwjbawxdCNWbBvpnMclRf2zg3NVcQq23ZBWu9m3S3VBUmA==
X-Received: by 2002:a50:88c1:: with SMTP id d59mr17554508edd.200.1547845465607;
        Fri, 18 Jan 2019 13:04:25 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id d5sm7243120edb.48.2019.01.18.13.04.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 13:04:24 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id o10so12185468edt.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 13:04:24 -0800 (PST)
X-Received: by 2002:a50:b487:: with SMTP id w7mr17576524edd.72.1547845464009;
 Fri, 18 Jan 2019 13:04:24 -0800 (PST)
MIME-Version: 1.0
References: <20180524192141.20323-1-ramon.fried@gmail.com> <20180529042047.GE2259@tuxbook-pro>
 <e554b7e525554d49d193ff1f8ca51359@codeaurora.org> <CA+ASDXNMS1n+zBDPi4zbyDYjuEs4n-oFH2QfytvzRpnbK5-_ZQ@mail.gmail.com>
 <31da3e8d35c2b47041536c996efe484c@codeaurora.org>
In-Reply-To: <31da3e8d35c2b47041536c996efe484c@codeaurora.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 18 Jan 2019 13:04:11 -0800
X-Gmail-Original-Message-ID: <CA+ASDXPAVfX=EiOKY_t-OoQFuKssbqiK4fAUstOdvO0=69kskg@mail.gmail.com>
Message-ID: <CA+ASDXPAVfX=EiOKY_t-OoQFuKssbqiK4fAUstOdvO0=69kskg@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: qcom_q6v5: don't auto boot remote processor
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ramon Fried <ramon.fried@gmail.com>,
        linux-remoteproc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-kernel-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sibi,

On Fri, Jan 18, 2019 at 11:46 AM Sibi Sankar <sibis@codeaurora.org> wrote:
> On 2019-01-19 00:05, Brian Norris wrote:
> > On Thu, Jan 17, 2019 at 11:04 PM Sibi Sankar <sibis@codeaurora.org>
> >> After experimenting with in kernel solutions for
> >> three revisions and observing problems on graceful
> >> shutdown usecase,
> >
> > What exactly were the problems again? e.g., what were the deficiencies
> > with having the remoteproc device listen for the REMOTEFS_QMI_SVC_ID
> > service again? Sorry, but I sort of dropped off on reviewing that
> > stuff, and now I see this. I'd mildly prefer something that is
> > actually automatic, but if I'm missing some aspects, I'd like to hear
> > that. (And, I'd like to see them explained in the commit message, if
> > this is ever to be merged.)
>
> bringing down the modem after the RMTFS server
> goes down leaves the modem in limbo (It has a few
> pending rmtfs transactions that cannot go through)
> which results in sysmon graceful shutdown failing.

Makes sense. Probably should be described in a re-send of this patch,
if we're going with that.

> And we have to do a modem force-stop to proceed
> which we want to avoid in graceful shutdown cases.

Shouldn't you do the "force-stop" in the kernel too? e.g., if rmtfs
daemon dies without doing a properly-timed stop, then we should still
force a stop in the kernel, no? Basically, why not do both mechanisms:
REMOTEFS_QMI_SVC-activated start/stop in the kernel, and manual stop
(and start? this likely might still be redundant) in the daemon?

> This is overcome by starting rproc mss from rmtfs
> after REMOTEFS_QMI service is up and stopping
> rproc mss from rmtfs on SIGKILL/SIGINT and other
> program error signals before bringing down the
> RMTFS_QMI service i.e before exiting the rmtfs
> server loop.

That's still not really a sure-fire way of doing things. For one, you
can't catch SIGKILL. Similarly, you can't really clean up from OOM,
segfault, etc. So it would still be helpful to hook into the QMI
service notifications in the kernel, I think.

> >> switching to controlling the
> >> remoteproc mss through rmtfs seems to solve all
> >> the known issues.
> >
> > How so? It explicitly does NOT help at all if RMTFS crashes.
> > Because...who's going to stop the modem in that case? (It works if you
> > automatically respawn a new RMTFS daemon, to toggle the modem. But
> > that's kind of cheating, and you can do that anyway, even without this
> > patch.) On the contrary, your patch *would* resolve that, since the
> > modem would notice when the RMTFS server goes away, and it would stop
> > itself.
>
> yeah we would want to mimic what the kernel
> patch did with the exception of stopping modem
> before bringing down the rmtfs server (not toggle
> rproc state but start on rmtfs service up and stop
> before rmtfs server exit). So in that case we would
> not want the modem to auto-boot.

See above. You can't really mimic what the kernel patch was doing
completely. You can try (which is probably a good idea), but you
should still have some fallback in the kernel, I expect.

> >> https://patchwork.kernel.org/patch/10662395/
> >>
> >> we should probably get this merged in, now that
> >> we are planning to start/stop mss through
> >> rmtfs.
> >
> > Sorry, who's planning to stop mss through rmtfs? Did I miss something?
>
> I have a working patch which I'll soon send
> upstream for review, after it clears the internal
> reviews/processes

OK.

Brian
