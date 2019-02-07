Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22BCC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A175A2175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mYsLlert"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfBGPTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:19:35 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34334 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfBGPTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:19:35 -0500
Received: by mail-vs1-f65.google.com with SMTP id f20so144668vsr.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 07:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hvFOUlYnYvqbOLiOOKtYelv9vQ0EelbZd0NKjx1Co50=;
        b=mYsLlertE/S8oZ2nwH5o5sv0rktO4BDDrBXcGg66yGmtCWVWWLLceqSyb9+WLartJ0
         pxRh6CVIIURZ4Dm2A48OhYRbsaXf0q3PzqdL6kqOCThQOMGarf72cioNwAuaQ4ijXvSs
         9m7hnP1BEvNRQNxTGnw9sYcx66srUOXrKQn42/GGvhE/XjoYW4w+RopZ7MJPdKcULE0t
         uWz3RHsoihK8iABsSO05nxy1XLERG2RV8iW4Q+JdbmfqDGLyhE94qMNIojeXl+A/Mh5s
         E9MZvO3XSuCIJ3lHQqkH4Y8pOswXBimuLdaeNq1aZ0sfZkrXJvK3l1hwdsmD3yi7QK6a
         PULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hvFOUlYnYvqbOLiOOKtYelv9vQ0EelbZd0NKjx1Co50=;
        b=Y0dYQLhrdFCqCzg0KitrytURGELgpKLcScj/c82M/c4EZHejMOSNSAvB69kPIUgvka
         4IXraPim6w5VJzG7RyC/uVfLn38HmujvN6Q9Yb1qTVd3Z6WxH3LzkAvHGIhdlGuVML2k
         IOyssBh9dy42/pUredW4R9oaBhMgkjnbCcSRmXAbZf2iaO4KUvdbCRKeSb57xkwI0Ga/
         iMTRyHMNBRetrxgnMzJsdAfiTw2ExaPBXJD2IOIGAowqP550tsgpCnB5Ccd6RRENipVH
         7RhuazJOpI7Vz/XcD1Iq2a5lFcajOqv+7DhWExCelQTvzXimwYqstY5d1QgjfQWYxbav
         ZmfA==
X-Gm-Message-State: AHQUAub1J8ZMHlrRxri90bFoWQOrcMn78360M6TKMMqR8RNROrRr6Owq
        UQ31f6038+Fj1GDkHZ51vdqs1RHHPhvvIbJwKgJXvw==
X-Google-Smtp-Source: AHgI3IZj7BtR1TsnFrLp3BSi7HKG939fWfZ/yyMhE2PZldxTcP/fGwmayaKONPYqWnBgnBul33qxdJm1BirQgHgoszM=
X-Received: by 2002:a67:7685:: with SMTP id r127mr6812260vsc.35.1549552774342;
 Thu, 07 Feb 2019 07:19:34 -0800 (PST)
MIME-Version: 1.0
References: <20190206150935.12140-1-sudeep.holla@arm.com> <CAPDyKFr2qwXoOL3SRy7Crf-pg4FMn_qecPrw__BE+YpVAjAFZA@mail.gmail.com>
 <20190207103600.GA14464@e107155-lin> <CAPDyKFpkiaP0J_LJxP6tRUOyz3QKtDgA+PuhL-9vew7-RfKyNA@mail.gmail.com>
 <20190207150638.GB14464@e107155-lin>
In-Reply-To: <20190207150638.GB14464@e107155-lin>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 7 Feb 2019 16:18:57 +0100
Message-ID: <CAPDyKFoenSDhYk_xNLFn6kB+rqvQQ+p71F27Mvevu-H9Nhxhuw@mail.gmail.com>
Subject: Re: [PATCH] drivers: base: add support to skip power management in
 device/driver model
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jisheng Zhang <jszhang@marvell.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Joshua Frkuska <joshua_frkuska@mentor.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2019 at 16:06, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Feb 07, 2019 at 03:29:07PM +0100, Ulf Hansson wrote:
> > On Thu, 7 Feb 2019 at 11:36, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> [..]
>
> > >
> > > May be, but as mentioned above we can't really. Also this change will
> > > help to avoid creating unnecessary power sysfs which is mainly runtime
> > > pm related for some of the devices created. CPU/caches was just one
> > > example which triggered this, but this can be more useful. We can avoid
> > > adding them to dpm list.
> >
> > Well, to me the approach you suggest sounds prone to errors and I am
> > afraid people may abuse it. Moreover, I don't know if there is other
> > problems with it, let's see what Rafael thinks about it.
> >
>
> Sorry, I should have put reference to earlier discussion that led to this
> patch. For your reference: [1]

Yeah, that would have been nice. :-)

>
> > Instead I think we should make the PM core to deal with this scenario,
> > as all it boils down to, is to allow a device to be unregistered and
> > registered during system suspend/resume, with a parent device that is
> > "persistent" during the sequence.
> >
>
> OK
>
> > Perhaps we could even just drop the corresponding printed warning,
> > "cache: parent cpu1 should not be sleeping", in device_pm_add() as I
> > wonder if it's really a necessary print.
> >
> Indeed, I was ignoring knowing that it's harmless. But more people
> started to complain, and Rafael suggested this which I agree as we
> have several pseudo devices created in the kernel that we can bypass
> some of these pm handling knowing we won't need it.

Okay, I see.

Anyway, I will likely need to restore part of this change, via my
cluster idling series then. As from that point, the cpu device that
you call device_set_pm_not_required() for, starts to be used from both
PM core and runtime PM point of view. But I guess that's okay then.

Kind regards
Uffe
