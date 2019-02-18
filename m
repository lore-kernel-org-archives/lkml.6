Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75208C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 22:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F33D2176F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 22:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exIcXJgk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731679AbfBRWVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 17:21:36 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40370 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731463AbfBRWVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 17:21:36 -0500
Received: by mail-wm1-f65.google.com with SMTP id t15so581079wmi.5;
        Mon, 18 Feb 2019 14:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XW+Fv8E9Qv33fcIB9T8YY/X+/h5Ev0pCBO2DNfkqUOQ=;
        b=exIcXJgkrLDilYFNUDciFfAoJO1uugKndGd9mLrVZ0YphaNv7DKrXtNchQk0/znRzn
         IOiM6UeFG70d0HmEHgg/Te6M+toZZJs6190CMRBDTeqR4tHcWchovL6qvFMDMAAS4mOQ
         5/xDj1o6Y3ukJ30iJVHtZqdaByJCrKglnyjvsoEE3kAkiCx8eoyyYi+sBX9xjq3ba22g
         aVy1lR26QzE+SAHQSc5q8wkqBEmxepB1aQ8/DvG73IcTlLEh4ABsfblG4+TxR5IFLtx8
         q/2HZLgPlt9MjcZ/isk9Nx2ZWJYS8KBh4tJjuCCoTCgmsAxxgNtAW2o/2KaQ6EWBvpc1
         hX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XW+Fv8E9Qv33fcIB9T8YY/X+/h5Ev0pCBO2DNfkqUOQ=;
        b=qpwte6axDzzeuR73s8MLnvFI5Jk3zAXTG8LIb3fzpJES0lgSQ7jDFak28YqIwWVZHz
         ygGV8nt2Dt13uHhD/yAjteF+S5+RuZD4zXJFKfRHFIh45hOlAU56luEPusJpg3xInktZ
         n5IU82xmRhs0oK6mA8cGEvQWd99f0n31rRdHMOQWNWJ2JmtZ0iXfwoBzA5oti2UQXauI
         PaOzVV7rX10Qtc/52UceIKhWszCeZ989OmCsUeHeYcIexNjduWwrd1xIyVBi1WDSXc7y
         +ReBLODWBMiT6rnW6sh59xHLNAib2jU04LhiduZvvAOsDJsp/LRfr7p3StVikAU6MqeK
         pQbA==
X-Gm-Message-State: AHQUAubyi5Jdxs7LN23dMAHI4JBY08Ub8hI10ns+7PM9qbfG6TC0FQEQ
        i99anvC/bOx3b3W7wECw/7aGsTsFeCCFnR0GWLM=
X-Google-Smtp-Source: AHgI3IZMWUDNiMwq0nEg6oYEQ2yA3A7ORjiODImfumnSb3tVqS4TSpC7DuB9hfK1CkTN8hLbaadPzh76iWx0YA61M8c=
X-Received: by 2002:a1c:47:: with SMTP id 68mr552681wma.89.1550528493993; Mon,
 18 Feb 2019 14:21:33 -0800 (PST)
MIME-Version: 1.0
References: <2281684.8tZHfIXjiu@aspire.rjw.lan> <CADnq5_NmDYzZZPUh5Wp+a8bycRWFDt3Lhzf0AKx9BECJ_U-Kyg@mail.gmail.com>
 <20190216060058.gsiddsmj3f27e6v7@wunner.de> <CADnq5_OqaQA2HNcy+ZZvsN5MTEWLXoFEuirX4f4nzEOJ6NrdVA@mail.gmail.com>
 <CAJZ5v0g8-+cqQFspwYytTbzptZrt+GhT2RUX_nQnFD-rDbA7sA@mail.gmail.com>
In-Reply-To: <CAJZ5v0g8-+cqQFspwYytTbzptZrt+GhT2RUX_nQnFD-rDbA7sA@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 18 Feb 2019 17:21:19 -0500
Message-ID: <CADnq5_O+2i5jC_0DRQvfkMtmfMGLgMzRDo+aSZHXeewhDPVhOg@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: radeon: Set DPM_FLAG_NEVER_SKIP when enabling PM-runtime
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "?????????????? ????????????????" <ukrkyi@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 17, 2019 at 4:26 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Sun, Feb 17, 2019 at 12:37 AM Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > On Sat, Feb 16, 2019 at 1:01 AM Lukas Wunner <lukas@wunner.de> wrote:
> > >
> > > On Fri, Feb 15, 2019 at 11:01:04AM -0500, Alex Deucher wrote:
> > > > On Fri, Feb 15, 2019 at 10:39 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > > > On HP ProBook 4540s, if PM-runtime is enabled in the radeon driver
> > > > > and the direct-complete optimization is used for the radeon device
> > > > > during system-wide suspend, the system doesn't resume.
> > > > >
> > > > > Preventing direct-complete from being used with the radeon device by
> > > > > setting the DPM_FLAG_NEVER_SKIP driver flag for it makes the problem
> > > > > go away, which indicates that direct-complete is not safe for the
> > > > > radeon driver in general and should not be used with it (at least
> > > > > for now).
> > > > >
> > > > > This fixes a regression introduced by commit c62ec4610c40
> > > > > ("PM / core: Fix direct_complete handling for devices with no
> > > > > callbacks") which allowed direct-complete to be applied to
> > > > > devices without PM callbacks (again) which in turn unlocked
> > > > > direct-complete for radeon on HP ProBook 4540s.
> > > >
> > > > Do other similar drivers like amdgpu and nouveau need the same fix?
> > > > I'm not too familiar with the direct_complete feature in general.
> > >
> > > direct_complete means that a discrete GPU which is in D3cold upon
> > > entering system sleep is left as is, i.e. it is not woken.  It is
> > > also expected to still be in D3cold when resuming from system sleep
> > > from the PM core's point of view.  (If it is in D0uninitialized, the
> > > GPU's driver needs to ensure it is transitioned to D3cold again.)
> > >
> > > I know for a fact that resuming the discrete GPU is not necessary
> > > on my MacBook Pro with Nvidia GPU.  I'd expect those with AMD GPUs
> > > to behave the same.  The apple-gmux driver takes care of putting
> > > the GPU into D3cold on resume from system sleep if it was in D3cold
> > > when entering system sleep (see drivers/platform/x86/apple-gmux.c,
> > > gmux_resume()).
> > >
> > > I think it is desirable to use direct_complete because it saves power
> > > (no need to gratuitously wake the GPU upon entering system sleep,
> > > only to immediately cut its power) and it also speeds up the suspend
> > > process by about half a second.
> >
> > Thanks for the info.  It sounds like we need a similar patch for
> > amdgpu.  With dGPUs controlled by the ACPI ATPX method, I believe the
> > dGPU is powered by automatically on resume from S3/S4.  I think there
> > may be a way to change that behavior in some revisions of ATPX (i.e.,
> > to keep the state across suspend cycles), but it's not the default.
> > I'm not sure about the newer _PR3 stuff in Hybrid Graphics laptops.  I
> > think it retains state.  In both radeon and amdgpu we probably need to
> > check if the system is using ATPX or _PR3 and disable direct complete
> > for ATPX at least.
>
> I would disable direct-complete entirely for them then and possibly
> consider using DPM_FLAG_SMART_SUSPEND in the cases when that would be
> safe.
>
> Anyway, I posted this patch for radeon, because it addresses a
> specific regression and I'm not super-familiar with GPU drivers in
> general.

Thanks.  I've applied this patch and sent out a patch for amdgpu.

Alex
