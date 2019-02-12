Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D38EC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9441222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549997991;
	bh=SCUU0UbiaJ6fXeu8zCEe26tPKGXEP5M/CgOZC5cl7p8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BJ/cVPfLWehbNy651xyOCvZhbYrBopFsOflwy8LbC3mGekFaW5sWcZStY+8WO9sgu
	 0hzdEdxhPWDrZRardSxo9BqCekNrRqtG2EoRwCv+JFWCJaXqQOUc0tqCWnbqxP/M5w
	 AOye6KckzOw8qH5nZd9lxqL6/HwsUxxMNMOv/5eg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731210AbfBLS7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:59:50 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39648 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728353AbfBLS7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:59:50 -0500
Received: by mail-ot1-f66.google.com with SMTP id n8so6270074otl.6;
        Tue, 12 Feb 2019 10:59:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SCUU0UbiaJ6fXeu8zCEe26tPKGXEP5M/CgOZC5cl7p8=;
        b=tTbTpGKm/qcwVl/d07/sFJZlSK+dSdlxO9VZt0Ih+uLbKBm4txJLBZtTtGHupW568J
         Dns2gGnbUeeu3wC4w+h/eS9XvtECYicBSx6McgYOzY+m7kAMiI2MMFoZ+mPdwQAH1LmB
         +7Uxchwj/7RaOopKxQShHe5bgO20UrWF4f/M9ZiNu2cgF275KBKndxuhETZ51f9PhZ3f
         iDhnMlyznTWV5fcTXKBhbmtpHuV3qn12PwoHm/ZkQTPRuxp2ZpjoRUWxWgWlDNibv0Un
         nNIeGb/ySgDuTFfPe6mwF5wp0KY82BybDsvPYzJ332GEeKh5KTIvkquFi0j9yGkQ+kLu
         lNnA==
X-Gm-Message-State: AHQUAubn5VEgF23HyFSqhn2qkabkdEJzjHByqea3XWFK+OxKZCS0H+Dq
        rt+SKd5rf0VsTbYcXtaIpswbTAxonostzfIvbsI=
X-Google-Smtp-Source: AHgI3IazJP0f7qdFrQRTcom2UyynRnmrIgMPdqcJRNCOefQMsFnmAlxzjzAakFosY7CSjPYfpC6A7YGJgBLZd4w5/Ow=
X-Received: by 2002:a9d:718d:: with SMTP id o13mr4973817otj.119.1549997988850;
 Tue, 12 Feb 2019 10:59:48 -0800 (PST)
MIME-Version: 1.0
References: <20190206150935.12140-1-sudeep.holla@arm.com> <CAPDyKFr2qwXoOL3SRy7Crf-pg4FMn_qecPrw__BE+YpVAjAFZA@mail.gmail.com>
 <20190207103600.GA14464@e107155-lin> <CAPDyKFpkiaP0J_LJxP6tRUOyz3QKtDgA+PuhL-9vew7-RfKyNA@mail.gmail.com>
 <20190207150638.GB14464@e107155-lin> <CAPDyKFoenSDhYk_xNLFn6kB+rqvQQ+p71F27Mvevu-H9Nhxhuw@mail.gmail.com>
 <20190207152908.GC14464@e107155-lin> <CAPDyKFrV7XpKK-Pds=BNgJm9EC50C0wB_f99DK-6N7+K8aZXZw@mail.gmail.com>
 <20190212174937.GA19095@e107155-lin> <CAJZ5v0hQ=M1mtoMTSHnO3E2XSP4eC8SH+_WWXafk7ZVCG__MJg@mail.gmail.com>
 <20190212182041.GB19095@e107155-lin>
In-Reply-To: <20190212182041.GB19095@e107155-lin>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Feb 2019 19:59:37 +0100
Message-ID: <CAJZ5v0gH7Q1ZaM_DFcg4DVY6NU-QYmeOOzoXZj50UiuydZisDA@mail.gmail.com>
Subject: Re: [PATCH] drivers: base: add support to skip power management in
 device/driver model
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jisheng Zhang <jszhang@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Joshua Frkuska <joshua_frkuska@mentor.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 7:20 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Tue, Feb 12, 2019 at 07:07:31PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Feb 12, 2019 at 6:49 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > On Mon, Feb 11, 2019 at 05:20:20PM +0100, Ulf Hansson wrote:
> > > > On Thu, 7 Feb 2019 at 16:29, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > > >
> > > > > On Thu, Feb 07, 2019 at 04:18:57PM +0100, Ulf Hansson wrote:
> > > > > > On Thu, 7 Feb 2019 at 16:06, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > > >
> > > > > [...]
> > > > >
> > > > > > > Indeed, I was ignoring knowing that it's harmless. But more people
> > > > > > > started to complain, and Rafael suggested this which I agree as we
> > > > > > > have several pseudo devices created in the kernel that we can bypass
> > > > > > > some of these pm handling knowing we won't need it.
> > > > > >
> > > > > > Okay, I see.
> > > > > >
> > > > > > Anyway, I will likely need to restore part of this change, via my
> > > > > > cluster idling series then. As from that point, the cpu device that
> > > > > > you call device_set_pm_not_required() for, starts to be used from both
> > > > > > PM core and runtime PM point of view. But I guess that's okay then.
> > > > > >
> > > > >
> > > > > Ah I see. I can drop for CPU devices then. Since I didn't see any use for
> > > > > them, I set the flag, but I can drop it now or you can do that as part
> > > > > of that series.
> > > >
> > > > Well, I prefer if you drop it for CPU devices, as least for now.
> > > >
> > > > > There are quite a few devices(especially the ones
> > > > > registered under system subsys can set this but I would take it separate
> > > > > once we settle on this). Also Rafael may have seen use for few more
> > > > > devices when he suggested this.
> > > >
> > > > Yep, let's find another first user of this.
> > > >
> > > > Additionally, it seems like we should drop the print in device_pm_add().
> > > >
> > >
> > > Hi Rafael,
> > >
> > > Do you prefer to drop the error message or retain it as is ?
> >
> > Do you mean the one in device_pm_add()?
> >
>
> Yes, the warning "parent should not be sleeping" in device_pm_add(). I
> would prefer to keep it as is for now.

OK, do that, then. :-)
