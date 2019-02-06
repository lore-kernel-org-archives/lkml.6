Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F58EC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C73218D9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549493064;
	bh=QY38C0NHmZDXmcPVJRrePA44YpxWWRBq+fq5AIfHafQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LivUkIKFOdLGKoCZctQMIHT7WQRPuqlvMsd3Y7JMers5wxdQnIIBKZl1DsNiYKFtU
	 oW4KIqHWGEEpd74QMVX2uyXEC/Dh9mMwupSJueEShdIYpENNj2rHKbI6aQX0e7Krrd
	 rYxfoy6maDoMiCCVIeb+OcpUjitcUiE/CAgZ7Wco=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfBFWoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 17:44:23 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36484 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfBFWoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 17:44:22 -0500
Received: by mail-ot1-f65.google.com with SMTP id k98so15029478otk.3;
        Wed, 06 Feb 2019 14:44:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NMaO2sJclU3Iyqh8z9gsn93/QQsgHtWX1hiaWEI6VnY=;
        b=ChCiyfbwf7/CGAkjU264GbWCQ7DzI0bggvx8n5MVQ+nfOJzd+oWHKjZQyerNKs3Tms
         5fgUWJQPr72xnpiRF8o3oZprFx0PKc49LhIhpkLwVvkKRoCxTvxXy7jP2cd22Ko+8Jiv
         B7SDXovlrQHz8899tSLAHX/r7YCz+0s87UIeioH+/1uJQTmEOdL/ExGCOFD1pKdQ773I
         Z/mvcOMOQLJQQGXj/f1w+tsmf8qS08mxNkA2yvYRkmHTcmZln26VcJNzHU6B81PwIq5u
         wtsk4S3ag/7fPWutFQyvuY14dInOW+w1SE6jjEUwHPfMaMm0RKTEahlxK22jgGs3dYJD
         l7Sg==
X-Gm-Message-State: AHQUAub335QbkoF2Y6A0cXniNfV9WPtuA5TMDcbQFt/IzlgCzvLc9zvd
        AMD8MLF1oEBb6dlp/SbhmsNuOtxyrWMO3Mm+ZIQ=
X-Google-Smtp-Source: AHgI3IbBeHZKMTknCQVy35eYZ0fwoYTdW2MGjgM2r0MB/heI8jlsGzTx/AOFm4z5dB/W+WBWq2nWhVnCaH9hxV0M6jU=
X-Received: by 2002:a9d:5e8c:: with SMTP id f12mr7354393otl.343.1549493061578;
 Wed, 06 Feb 2019 14:44:21 -0800 (PST)
MIME-Version: 1.0
References: <CAAuoowhNsaXjBSHM9ZGeO_uwGVXprc8TS0SENGA3fKbg1xCWMQ@mail.gmail.com>
 <20190206212023.GA5353@amd> <CAJZ5v0gZmSfN2pk50sKYr-exbJy8m3dY4Xnz6pcKMcbAX92yfA@mail.gmail.com>
 <20190206223231.GA13324@amd>
In-Reply-To: <20190206223231.GA13324@amd>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 6 Feb 2019 23:44:10 +0100
Message-ID: <CAJZ5v0iTu7nq9cR3iDsmf2=Nn7Z8YcvCLjvehKee+zMbV+iA7w@mail.gmail.com>
Subject: Re: REGRESSION - System does not resume from suspend
To:     Pavel Machek <pavel@ucw.cz>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        =?UTF-8?B?0K/RgNC+0YHQu9Cw0LIg0KHQtdC80YfQtdC90LrQvg==?= 
        <ukrkyi@gmail.com>, Greg KH <greg@kroah.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Thomas Martitz <kugel@rockbox.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 6, 2019 at 11:32 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Wed 2019-02-06 23:19:18, Rafael J. Wysocki wrote:
> > On Wed, Feb 6, 2019 at 10:20 PM Pavel Machek <pavel@ucw.cz> wrote:
> > >
> > > Hi!
> > >
> > > > Since kernel version 4.19, my computer is unable to resume from suspend to
> > > > RAM. I've run git bisect and filed bug report at
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=201519
> > > > three months ago, however, I received no reaction. Bug is still present in
> > > > 5.0-rc5 kernel version. Is there any possibility to fix this?
> > >
> > > Thanks for all the work bisecting / etc... Note that you can get patch
> > > reverted if it causes regression, but it needs to be done over
> > > email. (If maintainer does not reply, up-to Linus).
> > >
> > > For the record, patch is:
> > >
> > > git bisect output:
> > > c62ec4610c40bcc44f2d3d5ed1c312737279e2f3 is the first bad commit
> > > commit c62ec4610c40bcc44f2d3d5ed1c312737279e2f3
> > > Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Date:   Tue May 22 13:02:17 2018 +0200
> > >
> > >     PM / core: Fix direct_complete handling for devices with no
> > >     callbacks
> > > ...
> > >     Link: https://bugzilla.kernel.org/show_bug.cgi?id=199693
> > >         Fixes: 08810a4119aa (PM / core: Add NEVER_SKIP and
> > >         SMART_PREPARE driver flags)
> > >  Reported-by: Thomas Martitz <kugel@rockbox.org>
> > >  Tested-by: Thomas Martitz <kugel@rockbox.org>
> > >                     Cc: 4.15+ <stable@vger.kernel.org> # 4.15+
> > >  Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >  Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > >  Reviewed-by: Johan Hovold <johan@kernel.org>
> > >
> > > And the patch was tagged for stable, which sounds like a lot of fun.
> >
> > Not really.  This just restored previous behavior as the commit log says.
> >
> > If the system breaks after this one, it most likely didn't work before
> > commit 08810a4119aa which was in 4.15 and c62ec4610c40bcc44f2 first
> > appeared in 4.17-rc1.
> >
> > Unfortunately, it cannot be reverted without breaking other systems
> > that used to work before commit 08810a4119aa.
>
> So what is going on there?
>
> If some devices need one behaviour and other devices need second
> behaviour, we can just add the flag for the driver, right?

Yes.

> Because we know that Jaroslav's system can suspend, so this is fixable.
>
> Jaroslav -- can you find out which device has problem?

I have followed up in the BZ, we'll try to find the problematic device.
