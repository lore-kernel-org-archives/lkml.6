Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3248C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34E021B25
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KobmJM8t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733203AbfBKS6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:58:09 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:38510 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732146AbfBKS6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 13:58:08 -0500
Received: by mail-it1-f196.google.com with SMTP id z20so865858itc.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 10:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LNHAYc5Sb/8J/dqS84/9Ku9YjLhmJsbc0lpdCRFdYS8=;
        b=KobmJM8tOqVbmileMBQq3TdEGtzFnmrXNS7VSLS0HVEhlgMj6q3D19rU35GASoNHRX
         tjY9axXfoqjWFu7h76C/QcA0hsEULcnsLehycV948nSZx0er2rktHAKAipxU8B2Afn62
         0hFKyWmzj0hm/DjB5IjhCLi2XbHnRf3FHwx2RuYJvgVn5abN5kc8EeTHcSXB4GAgiibk
         nzmOGbXKHoLvqtLonMeY11BakC1J32ZSsUkgHbcE2eSnin30l4K71VLhJLleUXviqC22
         vchRT+wOo0URJuztxJqNoTb69ZaZBlpChCEIX0V7qSjJY3BfGX1aUs2wycdq7StHgXBe
         3YsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LNHAYc5Sb/8J/dqS84/9Ku9YjLhmJsbc0lpdCRFdYS8=;
        b=WhBIKgN0eot/hZ7DZVD44lKXsQm+zsOaZuMGopkVEI2sx9pSCuNPidvzcIGmFf1M+P
         5dTNytUVjk1rnK1PqzVitFw8glkWCkHFttDEkAETVcBWitvLqQ7GHzHNslNaWT3vckjn
         Yf1RAgOCB2/Op9N+PZPFG1j87Ol8JN6v+4c2KuGy6/zdCzKkHO4qsa8PCl8Zi72JffZa
         Ub0llJBQlj81YU4wPbSJTy5iQqlj2/J+OEI7vNTsk2kyYFur/TkK9vKKJkHMdJBTOzQ9
         p/Q1PLYvTFtUXLu61l6UHjwORTfzb4EdE6ljFvWzgZdNlVDCUKZPArJYWL28IbR0jqbA
         GxWA==
X-Gm-Message-State: AHQUAubKVRu+/xxEeWJdiDz04rLxL7wVqGTj7/E8cjQd41YPVaXJgxYj
        zuF1KplWIPjJteOoNLXzMBOzN5jsZRSMd1zWgIAu/Q==
X-Google-Smtp-Source: AHgI3IbXWB07KljvM2LnAdOjOe+pM4LZ6mtdpqxrebzkf+aU/XLG5KZyGydKdUJh/HtBDRJq6YsTsGpgbo6maQfoYXc=
X-Received: by 2002:a6b:fd02:: with SMTP id c2mr18951784ioi.156.1549911487721;
 Mon, 11 Feb 2019 10:58:07 -0800 (PST)
MIME-Version: 1.0
References: <20190211152602.GA5591@jordon-HP-15-Notebook-PC>
 <20190211154044.GA16105@kroah.com> <CAFqt6zYh2qxBKyOCH3xZmS_Jq5nU+nZyLhbmGOey4Y-VAk+ZoQ@mail.gmail.com>
 <20190211155734.GA18078@kroah.com> <CAFqt6zYTkUwU144+pzoLz7kcjQz=j9vQ-H2NLthA_3hOzCBfdw@mail.gmail.com>
 <20190211171130.GA13294@kroah.com> <CAHRSSEyjLkQvZjW83Vf3HqeEE1uKw2W1VDBg_78A07YzAFPjBA@mail.gmail.com>
In-Reply-To: <CAHRSSEyjLkQvZjW83Vf3HqeEE1uKw2W1VDBg_78A07YzAFPjBA@mail.gmail.com>
From:   Alistair Strachan <astrachan@google.com>
Date:   Mon, 11 Feb 2019 10:57:56 -0800
Message-ID: <CANDihLGRRNQNd1hpgJ8StC8EO=1MKbo8+N-TDd3Fcs77qpZU0w@mail.gmail.com>
Subject: Re: [PATCH] staging: android: vsoc: Remove VSOC_WAIT_FOR_INCOMING_INTERRUPT
To:     Todd Kjos <tkjos@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
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

On Mon, Feb 11, 2019 at 9:22 AM Todd Kjos <tkjos@google.com> wrote:
>
> +Alistair Strachan
>
> On Mon, Feb 11, 2019 at 9:11 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Feb 11, 2019 at 10:15:18PM +0530, Souptick Joarder wrote:
> > > On Mon, Feb 11, 2019 at 9:27 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Mon, Feb 11, 2019 at 09:21:19PM +0530, Souptick Joarder wrote:
> > > > > On Mon, Feb 11, 2019 at 9:10 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > On Mon, Feb 11, 2019 at 08:56:02PM +0530, Souptick Joarder wrote:
> > > > > > > As mentioned in TODO list, Removed VSOC_WAIT_FOR_INCOMING_INTERRUPT
> > > > > > > ioctl. This functionality has been superseded by the futex and is
> > > > > > > there for legacy reasons.
> > > > > > >
> > > > > > > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > > > > > > ---
> > > > > > >  drivers/staging/android/uapi/vsoc_shm.h | 7 -------
> > > > > > >  drivers/staging/android/vsoc.c          | 5 -----
> > > > > > >  2 files changed, 12 deletions(-)
> > > > > >
> > > > > > So userspace is all fixed up now and this ioctl can be dropped?  Any
> > > > > > pointers to the userspace commit that did this?

The ioctl is still being used and cannot be removed.

> > > > >
> > > > > I am not sure about user space part.
> > > >
> > > > Then we can not just delete the ioctl :)
> > >
> > > Agree, but where to verify the user space commit ?
> > > Any pointer to the source code path ?

The userspace code using the Linux 'vsoc' staging driver can be cloned
from here:

https://android.googlesource.com/device/google/cuttlefish_common

> >
> > Please work with the android developers to solve this.  It should be in
> > AOSP "somewhere" :(

I'm working on documenting this better on source.android.com. Stay tuned.

> >
> > good luck,
> >
> > greg k-h
