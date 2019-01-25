Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4912DC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140BC218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="HN7e32Ts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbfAYRNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 12:13:18 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:38191 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbfAYRNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 12:13:17 -0500
Received: by mail-it1-f194.google.com with SMTP id z20so10612274itc.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 09:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0RF4f1Mp3YIzRbSEusHXgG5NVQ9EsFPWAz0T/wquLg8=;
        b=HN7e32Tss9ateg3vrYM/qGm505jRNLs8/dnc/h/B3HsMxJ6Np3GoaQeDlRernVF+IJ
         9GyRuui5Oi2Y7lCA2JinhA/zyBzoyHr6g/hQMPQJ/puRvkbSX+ieZv4IKe5XmWAmYqPZ
         9YVCjbRY5dG17x3WyIkO0CwMEN/cRveLOo2ngHSINvBOP/PhT+K+cHb1x0aqyuZ8WYfD
         +yzk1EXQ33HAUU83iNnNbg42ukrx6P1l/wpJ+AC1WCB3Ld9q6AWFRZPKgxKcSe4nNDg8
         owAXp11eqK79aLPQeTxaPg0ETq+QDEmfh4VhER2AIvD63FoiowNjNIM7p8C101BMaG5l
         /+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0RF4f1Mp3YIzRbSEusHXgG5NVQ9EsFPWAz0T/wquLg8=;
        b=gMFsoCp4jW+4qxPBbx4mfXzQPCC29jYhUxu04hL81980CDXvh4Gw5W2KsomzoRBqu0
         cc2kbL0KZNh6XffWCvpmbJUAd9uNsQ9NDQLBQHn1UW8wJApAZvrB789xSxjHhNkm9wp7
         6LO26Wjv1WuVhDacJOP7Tf9sBjcqQ8+K4YYvE5OFwhkPXacISbI0o2CT+MLgYea6/qzA
         tek8fLI3cYs6HS4ljlklSsAM9KiX9GfDNJis+3om5OjY7m1SjpN/RTK98dFMV2SVHRBr
         r0Gwj2FJJdkvZ65tjhiKH1nF6FvhHB3cC7tVkf6ZlccQCVLxZOCCrUPxCaGuqtN7i5PP
         pinA==
X-Gm-Message-State: AJcUukfW7l4nIx6w11jwo943y3sVb/SE3jhpUX51cHgE2LDTzemeHlTq
        syVsoIp2Xq4tiDJNLAk8JkEV4YmHCV+8nP2o1RZQBw==
X-Google-Smtp-Source: ALg8bN5U5LbA9d0jhhe4EIIerCiNEtCzKYaZB9f81j8XceQpxiENmmBRdlm00j6i09VmNdYM98MHhCCJVvXdqDFhvg4=
X-Received: by 2002:a24:6e88:: with SMTP id w130mr4367718itc.103.1548436396346;
 Fri, 25 Jan 2019 09:13:16 -0800 (PST)
MIME-Version: 1.0
References: <20190123000057.31477-1-oded.gabbay@gmail.com> <CAOesGMjU0tjJwAqCADaAv6XrCGbjB8G2oT=4LxOgSQBHO7Gptw@mail.gmail.com>
 <ba543301-9953-4dcd-f744-2aa66746a874@au1.ibm.com>
In-Reply-To: <ba543301-9953-4dcd-f744-2aa66746a874@au1.ibm.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Fri, 25 Jan 2019 09:13:04 -0800
Message-ID: <CAOesGMiWqRSxaCQ3nn_Y3Ujan_60dvoiGZ3goBmxXfmOa=yR2Q@mail.gmail.com>
Subject: Re: [PATCH 00/15] Habana Labs kernel driver
To:     Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc:     Oded Gabbay <oded.gabbay@gmail.com>,
        Dave Airlie <airlied@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ogabbay@habana.ai, Arnd Bergmann <arnd@arndb.de>,
        fbarrat@linux.ibm.com, linux-accelerators@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 5:03 PM Andrew Donnellan
<andrew.donnellan@au1.ibm.com> wrote:
>
> On 24/1/19 8:52 am, Olof Johansson wrote:
> > But, I think the largest question I have (for a broader audience) is:
> >
> > I predict that we will see a handful of these kind of devices over the
> > upcoming future -- definitely from ML accelerators but maybe also for
> > other kinds of processing, where there's a command-based, buffer-based
> > setup sending workloads to an offload engine and getting results back.
> > While the first waves will all look different due to design trade-offs
> > made in isolation, I think it makes sense to group them in one bucket
> > instead of merging them through drivers/misc, if nothing else to
> > encourage more cross-collaboration over time. First steps in figuring
> > out long-term suitable frameworks is to get a survey of a few
> > non-shared implementations.
> >
> > So, I'd like to propose a drivers/accel drivers subtree, and I'd be
> > happy to bootstrap it with a small group (@Dave Airlie: I think your
> > input from GPU land be very useful, want to join in?). Individual
> > drivers maintained by existing maintainers, of course.
> >
> > I think it might make sense to move the CAPI/OpenCAPI drivers over as
> > well -- not necessarily to change those drivers, but to group them
> > with the rest as more show up.
>
> For cxl/ocxl, I have no objection to moving to this new subtree if
> that's what we all agree to do. (what do people do about UAPI headers in
> this situation? keep them where they are in misc/?)

How about moving them but keeping a stub in misc that just includes
the moved file?

> If we do go ahead and set up this new subtree, perhaps we can use the
> mailing list I set up at linux-accelerators@lists.ozlabs.org but we
> haven't really started using...

I've lost all lists.ozlabs.org muscle memory these days, but that
seems reasonable to me.



-Olof
