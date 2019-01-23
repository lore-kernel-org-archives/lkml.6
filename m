Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E23CC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A0CA21019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HpZZAkXN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfAWJfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 04:35:46 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:42302 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfAWJfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 04:35:46 -0500
Received: by mail-vk1-f195.google.com with SMTP id y14so330272vky.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 01:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2iEak07s7cOtu8GQ5P5VLdJkfqjEUXbdtC/8fBIbA3c=;
        b=HpZZAkXN21uKjJvfwIkZToHvSe1BiWDEwXWJavqxI9cFKiJDKV3MA22Nymm3cScHfj
         MaODR9GQC7Xr/RPCJ5pgIRIAyAWZDeX6mbO2Mar1fSKFYW1AVJbghPsC6E538b60KgW2
         6Jmq3V00Qd5g1wtqW+yQV9umBLVCTXxTB9X9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2iEak07s7cOtu8GQ5P5VLdJkfqjEUXbdtC/8fBIbA3c=;
        b=Bz7SAQSzGveaN/yIGhw/oSSaVC0LfV84yFpgZ30f9ZHjY9bKD2AyzK4ko6b03fldrL
         cBOkHWq2fvOmVd1LXeiZ/OpVrTDWKLb/kc3vW8tP37NGcGBzUiI3lfvLi7HeG9qHiaE5
         QuZ4jws2zmzJgw/xN6woLllqlTDalWTbNrqi0KMsxydvdzPfiMRvMzCvjaOGeq13v2Ho
         xwr5w4KExJ6tGdnMwqqzKf43pDTSyAYfv4Tpt0n3XHErvwwkzgm6VEOiCZA9huEEEtet
         lLcjTTJx6VOyW5AI0OWKYvOOYBc+4FRHSaFjA+h3G8v+UpJ8neZZ2p/mybtnskj+mn/k
         KvVg==
X-Gm-Message-State: AJcUukf0kth0nEtRK3HOVtrnMT6j/1IafZef4e6PmaHN7TuT0vkryFJV
        oYeekseP3t2x9b0Z8rvBS6+vV91J/OFrS2M25mfH/w==
X-Google-Smtp-Source: ALg8bN5ld8V1v1uEFB0l1UfmCzo9blcwJBqABsNkDZnT1PHe9vqTL6iKtlsqnEspZF2hgV3UWApg4UWkmHLDhyxeKcI=
X-Received: by 2002:a1f:1c81:: with SMTP id c123mr545200vkc.52.1548236144887;
 Wed, 23 Jan 2019 01:35:44 -0800 (PST)
MIME-Version: 1.0
References: <1548167070-421-1-git-send-email-vincent.guittot@linaro.org>
 <1548167070-421-2-git-send-email-vincent.guittot@linaro.org>
 <CAPDyKFqeo1Yxso-iYF4Co-eRYXKDRmiFHi9i5wiZSCXGtgSdkQ@mail.gmail.com> <CAKfTPtDxWK-W-jP7Ak3Nk_zksCbVrY0CHT+OnWZgt1t17AYjFw@mail.gmail.com>
In-Reply-To: <CAKfTPtDxWK-W-jP7Ak3Nk_zksCbVrY0CHT+OnWZgt1t17AYjFw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 23 Jan 2019 10:35:08 +0100
Message-ID: <CAPDyKFqwXckw7CaSwA2WTxHMG6H0Bh5dnsZsvRUngHavB-+vfw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] PM-runtime: update accounting_timestamp only when enable
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2019 at 09:50, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Wed, 23 Jan 2019 at 09:14, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Tue, 22 Jan 2019 at 15:24, Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > Initializing accounting_timestamp to something different from 0 during
> > > pm_runtime_init() doesn't make sense and put useless ordering constraint between
> > > timekeeping_init() and pm_runtime_init().
> > > PM runtime should start accounting time only when it is enable and discard
> > > the period when disabled.
> > > Set accounting_timestamp to now when enabling PM runtime.
> >
> > Hmm, my first impression is that this sounds like a reasonable thing
> > to do. However, there are couple of more things to consider.
> >
> > 1) update_pm_runtime_accounting() is setting a new value of
> > dev->power.accounting_timestamp, no matter of whether runtime PM has
> > been enabled. That's seems wrong to me, at least from the perspective
> > of what we are trying to change here. So you probably needs to fix
> > that too.
>
> note that whatever is done before enabling pm runtime, this will be
> overwritten during the enablement.

Right. After this patch, but the original code seems wrong, doesn't it?

> I can add a clean up patch but this behavior is already there with jiffies.

That would be great, to get this sorted out.

>
> Or do you think that update_pm_runtime_accounting can be called before
> timekeeping_init() ?

No.

>
> >
> > 2) I don't think you explicitly need to set
> > dev->power.accounting_timestamp to zero at pm_runtime_init(). Just
> > leave it uninitialized, as we are anyways going to initialize it
> > before we make use of it.
>
> yes probably
>
> >
> > 3) How will this change affect accounting while being system
> > suspended? As you know, the PM core disables and re-enables runtime PM
>
> So the time in system suspended will not be accounted

Right. But, I am not sure the accounting is correctly done.

>
> > during a system suspend/resume sequence. It looks to me, that you
> > actually need to call update_pm_runtime_accounting() from
> > pm_runtime_enable|disable(), or something along those lines, as to get
> > the accounting correct, no?
>
> I thought that everything was already done for jiffies too. As soon as
> pm runtime is disable, we can't really account this time to
> suspended_time or active_time because we don't have control anymore

Correct.

However, my point is that during system suspend, sooner or later we
end up disabling runtime PM. Up until that point, we should account
for, but it seems like we don't do that correctly. As instead, we just
keep the old accounting timestamp during system suspend (until someone
changes the runtime PM status, but there is now guarantee that
happens).

>
> I think that we don't need any additional changes for
> pm_runtime_enable because we just init the accounting_timestamp and
> there is no active or suspend runtime to account yet

Right, after a second thought, this makes sense.

> For pm_runtime_disable(), I thought that everything was already there
> otherwise it means that we already didn't account the time correctly.
> I will have a deeper look at that

Great!

I think the accounting is simply based upon that the "time" is stopped
during system suspend and thus also the accounting.

Although, as the header of $subject patch indicates, we want to move
to a well defined situation. Therefore it sounds to me that we need to
care about accounting while disabling runtime PM.

Anyway, let's see what you find out from your deeper look. :-)

[...]

Kind regards
Uffe
