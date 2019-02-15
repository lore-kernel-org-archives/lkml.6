Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D37C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 04:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B987B21A80
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 04:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=quantonium-net.20150623.gappssmtp.com header.i=@quantonium-net.20150623.gappssmtp.com header.b="qTH2BLnO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731099AbfBOECK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 23:02:10 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33473 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbfBOECK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 23:02:10 -0500
Received: by mail-wr1-f65.google.com with SMTP id i12so8874217wrw.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 20:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quantonium-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QyeHskx0/vQ3UTHmBuASmrGmBn7fmPd/nmtJ95MQs4w=;
        b=qTH2BLnOMKO6xW1j9Uc3QVrLT6KjdjR5U7VdPj+mZJAFRRIVcXV8M2g+qRp9JEEzPg
         s05/tJydzNMUQ+C3MeIgyqvkCqeunyb8qCLPaQqsnLQWAe1L6FJCZxYqavlVOp/21/AJ
         yRhrVnzj/gAM1Ia6M7XIShUkzioisnNtQw1P+Q1NGaV3YZXtSxQPC8DEjvJctMgSGB26
         B/J6YcpeYQF8fKrd8B1xruFjlqfAJUZgycI1RHw35ytpW3JL+Gn1/ajyEMV9lJ+BSwp1
         r8JtuFmVV13ZjfOg+ZWDsqKddtWP9OakrrimIBL7XOp1b1g7JyBpaVWk1BXo7bSYnE3p
         rlng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QyeHskx0/vQ3UTHmBuASmrGmBn7fmPd/nmtJ95MQs4w=;
        b=FKhN+j6BV+qo7veiL2B/FgyS9EeFmIK0cKVCgqYW4U/lmqzSfZ0DwI/E/7pMFVeW6G
         LRUE3dkbyspn9/bInMED2M41l1/+bzGYTIw1A4aGqeegOqSwhme8UBiBt3hVmV7LEEYN
         XBeE3xG4k1GgXSPE/Fi9cRWB5d1h974sI07cs0ResGN1zT609J2cHrJlaFmXDxQDR87z
         8QQlRvCAMz4SZGCnXEhFc25xYUv6+7xge0gNrpxTf3QvI3tmdfDWXR6ca/7fOnUBk/wO
         0BwYlCgro1dxSNv/2r90spPxqU4Vhl6GDgZOICWvVu9YtEFkc+92cTEy6bfCmlyefUIm
         5Tug==
X-Gm-Message-State: AHQUAuZgW3SLzYJSOuZw+czDbt6Kz3LoI2fEdBOxYZf5f/dF7yLhKkfr
        26xRF61TWpBN0NZYmFX/xnqR0H33iledhD/l1Mw2Vg==
X-Google-Smtp-Source: AHgI3IbKWvMrCp2NYqTDmMGvnnhJXlB5B/Y42ym05OwqNc1znKAoeXbvE9ULWIXP02Lt+X1WBh4frRdmROjR6TgDqP8=
X-Received: by 2002:adf:eb07:: with SMTP id s7mr5292160wrn.158.1550203327797;
 Thu, 14 Feb 2019 20:02:07 -0800 (PST)
MIME-Version: 1.0
References: <1536657703-27577-1-git-send-email-asmadeus@codewreck.org>
 <20180912053642.GA2912@nautica> <20180917.184502.447385458615284933.davem@davemloft.net>
 <20180918015723.GA26300@nautica> <20181031025657.GA17861@nautica>
 <20190215010029.GA10899@nautica> <CALx6S35HBKgtYkFde_AhCMPRtZfcVYfCYf=mLKjWSLLAfhMHyQ@mail.gmail.com>
 <20190215015705.GA17974@nautica> <CALx6S37MZadJ=PaAd+SSv9hxSX9kFTmTUtijPGA39JCx3PYq1Q@mail.gmail.com>
 <20190215033102.GA3099@nautica>
In-Reply-To: <20190215033102.GA3099@nautica>
From:   Tom Herbert <tom@quantonium.net>
Date:   Thu, 14 Feb 2019 20:01:56 -0800
Message-ID: <CAPDqMeoJ7CCo1eGNBp_-crkxfVt_4f=XQqhEo7kmyCN-hf_EWQ@mail.gmail.com>
Subject: Re: [PATCH v2] kcm: remove any offset before parsing messages
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Tom Herbert <tom@herbertland.com>,
        David Miller <davem@davemloft.net>,
        Doron Roberts-Kedes <doronrk@fb.com>,
        Dave Watson <davejwatson@fb.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 7:31 PM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Tom Herbert wrote on Thu, Feb 14, 2019:
> > > This second patch[2] (the current thread) now does an extra clone if
> > > there is an offset, but the problem really isn't in the clone but the
> > > pull itself that can fail and return NULL when there is memory pressure.
> > > For some reason I hadn't been able to reproduce that behaviour with
> > > strparser doing the pull, but I assume it would also be possible to hit
> > > in extreme situations, I'm not sure...
> >
> > This option looks the best to me, at least as a way to fix the issue
> > without requiring a change to the API. If the pull fails, doesn't that
> > just mean that the parser fails? Is there some behavior with this
> > patch that is not being handled gracefully?
>
> Yes, the parser fails with -ENOMEM ; that is not handled gracefully at
> all: from a user point of view, the connection just hangs (recvmsg never
> returns), without so much as a message in dmesg either.
>
Dominique,

That's by design. Here is the description in kcm.txt:

"When a TCP socket is attached to a KCM multiplexor data ready
(POLLIN) and write space available (POLLOUT) events are handled by the
multiplexor. If there is a state change (disconnection) or other error
on a TCP socket, an error is posted on the TCP socket so that a
POLLERR event happens and KCM discontinues using the socket. When the
application gets the error notification for a TCP socket, it should
unattach the socket from KCM and then handle the error condition (the
typical response is to close the socket and create a new connection if
necessary)."

> It took me a while to figure out what failed exactly as I did indeed
> expect strparser/kcm to handle that better, but ultimately as things
> stand if the parser fails it calls strp_parser_err() with the error
> which ends up in strp_abort_strp that should call
> sk->sk_error_report(sk) but in kcm case sk is the csk and I guess
> failing csk does not make a pending recv on the kcm sock to fail...
>
> I'm not sure whether propagating the error to the upper socket is the
> right thing to do, kcm is meant to be able to work with multiple
> underlying sockets so I feel we must be cautious about that, but

Right, that's the motivation for the design.

> strparser might be able to retry somehow.

We could retry on -ENOMEM since it is potentially a transient error,
but generally for errors (like connection is simply broken) it seems
like it's working as intended. I suppose we could add a socket option
to fail the KCM socket when all attached lower sockets have failed,
but I not sure that would be a significant benefit for additional
complexity.

> This is what I said below:
> > > [,,,]
> > >  - the current patch, that I could only get to fail with KASAN, but does
> > > complexify kcm a bit; this also does not fix bpf sockmap at all.
> > > Would still require to fix the hang, so make strparser retry a few times
> > > if strp->cb.parse_msg failed maybe? Or at least get the error back to
> > > userspace somehow.

The error should be getting to userspace via the TCP socket.

Tom

>
> Thanks,
> --
> Dominique
