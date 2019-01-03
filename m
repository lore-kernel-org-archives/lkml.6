Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CCEC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE8BD2184B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="A+wOVZrF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbfACWIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 17:08:46 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40784 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbfACWIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 17:08:46 -0500
Received: by mail-wm1-f65.google.com with SMTP id f188so31582829wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 14:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZpO9fjZ5UoUKm/cEGU4u8OQ6Ch0/CnqI6aOlT5gO5DU=;
        b=A+wOVZrFYG9dBv4KbhR1iInGPSXsUblWuiHPMgZCyKpPuTjsvyvw2HtVhBnZISNcMI
         aNF8qtEaoStagy+633JqojqcMhvqdsbu+MAaHzj80VXM//LQMxl1p/pDjYDV6EcNyIS0
         Mg6gXuxpC1lp28TZgdPO79akNOn/sS/7fVosjuCNVzH9UUgiiQWMhD3O8O0y4nTnCKDn
         gxRh9OdpYp6Yn3i6mOQ1eDpCqvnaB+cyAFY36jnbcrfbpe6rbPjHlrdKYh+vfiRzXOBQ
         Fn6M2fJWzK2YC8a9mQ9nJU35BEEapUNkJ+cOwrOk/YWZ93ZZYkpkfpjwpnC41J0EA/i5
         Tomg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZpO9fjZ5UoUKm/cEGU4u8OQ6Ch0/CnqI6aOlT5gO5DU=;
        b=VfMjJtfg8UC2PNU9Bi82kP75G8WjQeFczb3MCxZriPTACsT1gMKDTANLgbf4cpCMew
         ixvSciNv11N/Jtf/Onh+aI0EWBsEI7hJeBAU+N/E1Z8uWVopa28oigp8aekravPXDtF/
         ooASbtD1kJiHQGsETChCaRCkP3TJWNZAypZSeNcACU00tt/oh+4w7w8BFzzV/JNKY+iz
         Cz3S9dwLctZq86x9gLy2WFBeV31R61u0cjTU03YCflalJoVzw7/0agMArf6ZC8rVlqnz
         06EJMbcaWcaiu2TWu0IUaY6hI0W/yaKH2T9zyXODekuCpNdOayyUaJ++NiJin8uyAwd+
         9QTg==
X-Gm-Message-State: AJcUukeL/p+B9yoc4Sy+a9hxNK9Xka/RzaxCdWJDuWDFx9i2N8pbHv9O
        3JU88SLcF8ia3rYDMGrVWM0nwwFsMDbuqA==
X-Google-Smtp-Source: AFSGD/X4qUQw6C+ed8Wtr28sFcmR7ViBtCKzhAJeeXTvd6W44xdfM3lhCjbn1TUKOcWXvI6zTu0skQ==
X-Received: by 2002:a1c:5656:: with SMTP id k83mr39958110wmb.125.1546553324205;
        Thu, 03 Jan 2019 14:08:44 -0800 (PST)
Received: from brauner.io (p200300EA6F0B706E700BB2FADE8A175D.dip0.t-ipconnect.de. [2003:ea:6f0b:706e:700b:b2fa:de8a:175d])
        by smtp.gmail.com with ESMTPSA id w12sm40884910wrr.23.2019.01.03.14.08.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 14:08:43 -0800 (PST)
Date:   Thu, 3 Jan 2019 23:08:42 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Todd Kjos <tkjos@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Todd Kjos <tkjos@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Martijn Coenen <maco@android.com>, joel@joelfernandes.org
Subject: Re: [PATCH v1 2/2] binderfs: reserve devices for initial mount
Message-ID: <20190103220841.ycoavsqcbauayypl@brauner.io>
References: <20181223143550.10672-1-christian@brauner.io>
 <20181223143550.10672-2-christian@brauner.io>
 <CAHRSSEythiuV6HH9c-q5TwU=tDyZ-K5gjgF+uYZmd6pmAJTovw@mail.gmail.com>
 <20190103203418.rpx3wcs3ozncpnhu@brauner.io>
 <CAHRSSEz9pJY1gs5VuWs-R4dmWgME4ocQkVGcNvpX1TVUWpdE0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHRSSEz9pJY1gs5VuWs-R4dmWgME4ocQkVGcNvpX1TVUWpdE0w@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 01:47:13PM -0800, Todd Kjos wrote:
> On Thu, Jan 3, 2019 at 12:34 PM Christian Brauner <christian@brauner.io> wrote:
> >
> > On Thu, Jan 03, 2019 at 12:25:24PM -0800, Todd Kjos wrote:
> > > On Sun, Dec 23, 2018 at 6:36 AM Christian Brauner <christian@brauner.io> wrote:
> > > >
> > > > The binderfs instance in the initial ipc namespace will always have a
> > > > reserve of 4 binder devices unless explicitly capped by specifying a lower
> > > > value via the "max" mount option.
> > > > This ensures when binder devices are removed (on accident or on purpose)
> > > > they can always be recreated without risking that all minor numbers have
> > > > already been used up.
> > > >
> > > > Cc: Todd Kjos <tkjos@google.com>
> > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > > > ---
> > > > v1:
> > > > - patch introduced
> > > > v0:
> > > > - patch not present
> > > > ---
> > > >  drivers/android/binderfs.c | 7 ++++++-
> > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> > > > index 873adda064ac..aa635c7ea727 100644
> > > > --- a/drivers/android/binderfs.c
> > > > +++ b/drivers/android/binderfs.c
> > > > @@ -40,6 +40,8 @@
> > > >  #define INODE_OFFSET 3
> > > >  #define INTSTRLEN 21
> > > >  #define BINDERFS_MAX_MINOR (1U << MINORBITS)
> > > > +/* Ensure that the initial ipc namespace always has a devices available. */
> > > > +#define BINDERFS_MAX_MINOR_CAPPED (BINDERFS_MAX_MINOR - 4)
> > >
> > > Why do you ever need more minors per instance than the number of
> > > devices listed in CONFIG_ANDROID_BINDER_DEVICES?
> >
> > Are you asking asking why this is 4 and not 3? In that case we should
> > probably parse CONFIG_ANDROID_BINDER_DEVICES once at init time and then
> > reserve that many binder devices. Thoughts?
> 
> I'm asking why CONFIG_ANDROID_BINDER_DEVICES isn't the source of truth
> for the number of devices (it normally specifies 3 devices, but could
> be different). I can't think of a reason why you'd want
> CONFIG_MAX_MINOR_CAPPED to be different than the number of devices
> indicated by CONFIG_ANDROID_BINDER_DEVICES and having it specified in
> two places seems error prone.

I'm not following. The CONFIG_MAX_MINOR_CAPPED and
CONFIG_ANDROID_BINDER_DEVICES do not have a relation to each other just
like binder devices requested in CONFIG_ANDROID_BINDER_DEVICES do not
have a relation to binderfs binder devices as was requested for this
patchset.
I also don't know what you mean "appear in two places".

The fact is, binderfs binder devices are independent of binderfs binder
devices. So it is perfectly reasonable for someone to say
CONFIG_ANDROID_BINDER_DEVICES="" and *only* rely on binderfs itself.
Which absolutely need to be possible.
What I want in such scenarios is that people always have a number of
binderfs binder devices guaranteed to be available in the binderfs mount
in the initial ipc namespace no matter how many devices are allocated in
non-initial ipc namespace binderfs mounts. That's why allo non-initial
ipc namespace binderfs mounts will use the CONFIG_MAX_MINOR_CAPPED macro
which guarantees that there's number of devices reserved for the
binderfs instance in the initial ipc namespace.
