Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFD6C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A608214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNm9EmV9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbfBLNM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:12:59 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36457 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbfBLNM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:12:59 -0500
Received: by mail-lj1-f193.google.com with SMTP id g11-v6so2182047ljk.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 05:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xd7iLG06kXL9hXq6eIVg+PxmQ+gPgCfbyDtdkNYHiF4=;
        b=RNm9EmV9wwnYkW8HTLSfjWOMbBCBbKXVnZEFNHsg/JIwkogRredIkO6HcNFhS2X+wr
         VWnuHo/GI7wAX9and6CFwWWuZxCR0S4O99P2gkQd9CjQkGKYqlAJGw8Yl5OBBVZ0SIih
         f5YRcMsFEyxa/NMwGSel4hEGxFuRkFvM/mJOYE2U2GxCfrMyln0X+G2UNKoCTr5fvLzV
         l/j8goWGnPx39h0a+wCiHt+ewGmbskyfRmbn/QOK/BLdh2QUH146H4k9koPJXjSAQzyC
         p2loN166BAc7XMtKpRyB1RHxDuIv1mMxeVCuQhAgAsjvZxXqevsoGoRKj4i4GTZzF0Kw
         5lww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xd7iLG06kXL9hXq6eIVg+PxmQ+gPgCfbyDtdkNYHiF4=;
        b=MCEDCNEHglpAnedDE79BxaJ/dGSsYWV4YeeyXbq+tiDWYpoQ5tRVICE9wBd9t9xloo
         qjrNaIXNd0PwD52VHb9SB0gBBgVdgUPYjjKripzG1BB7Es2J4cW2+JceJeypN/PiVfJZ
         IkvciHsZolyQM6sYNTgioeVCmLDtygFuNhlM9kTZYvjpW0A8TBc7yPsZOLwlyoEw3tSd
         CtjN1pLLGHZFUFDs0tP7GyJk35M5xCcL6N9aD8ZOK1pfBXfjOoLqTySrfu+BpwmvpjE0
         gzxx0Yv8/OMXgjxqxm+DHRYmMEpdtlyRg6D516YnYfMCoM1iatvlbE2m+kuxb2Z/6JCv
         L5Dw==
X-Gm-Message-State: AHQUAuYWtIqedLCVGnY1G/VuLbNgQBoTO+CRXTJk64XmwO3OL0+rGJga
        SBe78P95Lokdz+gieTOoEPQVQAq87hYgwMAYgwE=
X-Google-Smtp-Source: AHgI3IY7L1KOuGkUd1GfZVwnyu2SCT8PuIgn8ia/yt2Be5IIGwtvaQgQebcUyDhHT4snD5snTN7Wnt66dTX/bsDABYs=
X-Received: by 2002:a2e:884b:: with SMTP id z11-v6mr2280682ljj.68.1549977177111;
 Tue, 12 Feb 2019 05:12:57 -0800 (PST)
MIME-Version: 1.0
References: <20190211152602.GA5591@jordon-HP-15-Notebook-PC>
 <20190211154044.GA16105@kroah.com> <CAFqt6zYh2qxBKyOCH3xZmS_Jq5nU+nZyLhbmGOey4Y-VAk+ZoQ@mail.gmail.com>
 <20190211155734.GA18078@kroah.com> <CAFqt6zYTkUwU144+pzoLz7kcjQz=j9vQ-H2NLthA_3hOzCBfdw@mail.gmail.com>
 <20190211171130.GA13294@kroah.com> <CAHRSSEyjLkQvZjW83Vf3HqeEE1uKw2W1VDBg_78A07YzAFPjBA@mail.gmail.com>
 <CANDihLGRRNQNd1hpgJ8StC8EO=1MKbo8+N-TDd3Fcs77qpZU0w@mail.gmail.com>
In-Reply-To: <CANDihLGRRNQNd1hpgJ8StC8EO=1MKbo8+N-TDd3Fcs77qpZU0w@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 12 Feb 2019 18:42:45 +0530
Message-ID: <CAFqt6zZPGREcH5xLMUZ0AfAmtLu-vteGF-ohtrLKjZKLcqpmpw@mail.gmail.com>
Subject: Re: [PATCH] staging: android: vsoc: Remove VSOC_WAIT_FOR_INCOMING_INTERRUPT
To:     Alistair Strachan <astrachan@google.com>
Cc:     Todd Kjos <tkjos@google.com>, Greg KH <gregkh@linuxfoundation.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Todd Kjos <tkjos@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 12:28 AM Alistair Strachan <astrachan@google.com> wrote:
>
> On Mon, Feb 11, 2019 at 9:22 AM Todd Kjos <tkjos@google.com> wrote:
> >
> > +Alistair Strachan
> >
> > On Mon, Feb 11, 2019 at 9:11 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Feb 11, 2019 at 10:15:18PM +0530, Souptick Joarder wrote:
> > > > On Mon, Feb 11, 2019 at 9:27 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Mon, Feb 11, 2019 at 09:21:19PM +0530, Souptick Joarder wrote:
> > > > > > On Mon, Feb 11, 2019 at 9:10 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > > >
> > > > > > > On Mon, Feb 11, 2019 at 08:56:02PM +0530, Souptick Joarder wrote:
> > > > > > > > As mentioned in TODO list, Removed VSOC_WAIT_FOR_INCOMING_INTERRUPT
> > > > > > > > ioctl. This functionality has been superseded by the futex and is
> > > > > > > > there for legacy reasons.
> > > > > > > >
> > > > > > > > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > > > > > > > ---
> > > > > > > >  drivers/staging/android/uapi/vsoc_shm.h | 7 -------
> > > > > > > >  drivers/staging/android/vsoc.c          | 5 -----
> > > > > > > >  2 files changed, 12 deletions(-)
> > > > > > >
> > > > > > > So userspace is all fixed up now and this ioctl can be dropped?  Any
> > > > > > > pointers to the userspace commit that did this?
>
> The ioctl is still being used and cannot be removed.

I think, it's good to add this info in TODO file. I can edit it if you are ok.

>
> > > > > >
> > > > > > I am not sure about user space part.
> > > > >
> > > > > Then we can not just delete the ioctl :)
> > > >
> > > > Agree, but where to verify the user space commit ?
> > > > Any pointer to the source code path ?
>
> The userspace code using the Linux 'vsoc' staging driver can be cloned
> from here:
>
> https://android.googlesource.com/device/google/cuttlefish_common

Thanks.
>
> > >
> > > Please work with the android developers to solve this.  It should be in
> > > AOSP "somewhere" :(
>
> I'm working on documenting this better on source.android.com. Stay tuned.
>
> > >
> > > good luck,
> > >
> > > greg k-h
