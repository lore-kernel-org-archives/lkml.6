Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31195C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E946020815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D1FcUMlz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbfACVr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 16:47:27 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42464 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfACVr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 16:47:27 -0500
Received: by mail-lf1-f65.google.com with SMTP id l10so24154860lfh.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 13:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MBD08zhzvB5LPpY9Ov/nSfzl5lVGnHKkJkBcitpK6ns=;
        b=D1FcUMlzknJw786isRsWTyTCe16h1FbeYRq2c0+cq5Lft5XSoArVihacusKcqL57Jt
         5FUdHRDjT4vgrq6LMT6WqyjpS3AQMJTHgE/o3NCfbzrQjbBVDMw+3Y9RxFBUnEeygGbi
         ksUbDNKq4qPVw1L1gcRBKol1Aralqg2VRws5qnx821RljKyX1e43DjO1K+Wj3fiRUOxc
         CkRfUT6xDk75NL90AH2zYX0wusaOBFO682pkO2nbxWNV5f2Mc0yVw86d5WbTo7NdSnCP
         9RJHJDtHQq5ZXqeZwwACKKQ+56sIFe/wAfk3x9KdJgQXdJCHriigPyO1ndYFfL2H5j4y
         UsBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MBD08zhzvB5LPpY9Ov/nSfzl5lVGnHKkJkBcitpK6ns=;
        b=CacKMaaihMIT3Noukjz3IextoaQ1GmlfrSNKYnF2wbuB2dY1034wv/EbEDFd5aJRA9
         nU06VAD6QmZfih1f8QKTQ/WZ35fThaR5inujVQ4wPOZr2fUwM47JNoHH81uydzOqHpRf
         Tnga8Dx0Rwkf2/hPgUZqvzW2W5iDr69pkK7kgc2IG20UNdJOga2AZtkVb80dHqeRSHvV
         7Yz1VRW+LP+R+6cUJd3+fF5E1F1DNoQLwE+FNyw16heysnut+gkGbQKSDvm9qoah1up1
         mO+QkvUEMQAYghnF30YvdOjGY0ACFyIHgc3iaHTYgtOzAMOV61FGOJj5dvTHRGua3gms
         UMAQ==
X-Gm-Message-State: AA+aEWZvn2KytktjKHF6DIY8xrBPnXbJBEk9REFnLijf2yBRUbLH2vOT
        NQgK1KMYEDwobxU3zFYGqaxMcpKwjZWGAeGUer1VUQ==
X-Google-Smtp-Source: AFSGD/Ub/R1YQXoXphmFuX3hdl6CiouXG3e0LOcjUi/kRhmmRMj7CLlG+Jqm6fInrENgq+jt7uKa8x+jROAcqGYPSzY=
X-Received: by 2002:a19:280f:: with SMTP id o15mr23553334lfo.0.1546552045011;
 Thu, 03 Jan 2019 13:47:25 -0800 (PST)
MIME-Version: 1.0
References: <20181223143550.10672-1-christian@brauner.io> <20181223143550.10672-2-christian@brauner.io>
 <CAHRSSEythiuV6HH9c-q5TwU=tDyZ-K5gjgF+uYZmd6pmAJTovw@mail.gmail.com> <20190103203418.rpx3wcs3ozncpnhu@brauner.io>
In-Reply-To: <20190103203418.rpx3wcs3ozncpnhu@brauner.io>
From:   Todd Kjos <tkjos@google.com>
Date:   Thu, 3 Jan 2019 13:47:13 -0800
Message-ID: <CAHRSSEz9pJY1gs5VuWs-R4dmWgME4ocQkVGcNvpX1TVUWpdE0w@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] binderfs: reserve devices for initial mount
To:     Christian Brauner <christian@brauner.io>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Todd Kjos <tkjos@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Martijn Coenen <maco@android.com>, joel@joelfernandes.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 3, 2019 at 12:34 PM Christian Brauner <christian@brauner.io> wrote:
>
> On Thu, Jan 03, 2019 at 12:25:24PM -0800, Todd Kjos wrote:
> > On Sun, Dec 23, 2018 at 6:36 AM Christian Brauner <christian@brauner.io> wrote:
> > >
> > > The binderfs instance in the initial ipc namespace will always have a
> > > reserve of 4 binder devices unless explicitly capped by specifying a lower
> > > value via the "max" mount option.
> > > This ensures when binder devices are removed (on accident or on purpose)
> > > they can always be recreated without risking that all minor numbers have
> > > already been used up.
> > >
> > > Cc: Todd Kjos <tkjos@google.com>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > > ---
> > > v1:
> > > - patch introduced
> > > v0:
> > > - patch not present
> > > ---
> > >  drivers/android/binderfs.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> > > index 873adda064ac..aa635c7ea727 100644
> > > --- a/drivers/android/binderfs.c
> > > +++ b/drivers/android/binderfs.c
> > > @@ -40,6 +40,8 @@
> > >  #define INODE_OFFSET 3
> > >  #define INTSTRLEN 21
> > >  #define BINDERFS_MAX_MINOR (1U << MINORBITS)
> > > +/* Ensure that the initial ipc namespace always has a devices available. */
> > > +#define BINDERFS_MAX_MINOR_CAPPED (BINDERFS_MAX_MINOR - 4)
> >
> > Why do you ever need more minors per instance than the number of
> > devices listed in CONFIG_ANDROID_BINDER_DEVICES?
>
> Are you asking asking why this is 4 and not 3? In that case we should
> probably parse CONFIG_ANDROID_BINDER_DEVICES once at init time and then
> reserve that many binder devices. Thoughts?

I'm asking why CONFIG_ANDROID_BINDER_DEVICES isn't the source of truth
for the number of devices (it normally specifies 3 devices, but could
be different). I can't think of a reason why you'd want
CONFIG_MAX_MINOR_CAPPED to be different than the number of devices
indicated by CONFIG_ANDROID_BINDER_DEVICES and having it specified in
two places seems error prone.

>
> Christian
