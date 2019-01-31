Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1544C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BE22087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548935229;
	bh=5ucqiXbjhs+izz145ZJqGpx/18hgZwFqsHM5/H66Jco=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sbvcwoR9Zi7UbbmH7PawA5WkPhjJ9746knN6EWwWhRkXY4NIfDpihVVVT4jWiLsgq
	 bC8Soe5t7g7RBvvCy/RYxQKJkW0SouQA0f7YgaB/ndN8oAm5akV/25JGwH9QwDOY1d
	 AuDRwhwMfDsrmKD9gYCvMWZHAuI1hp3S5MeosOk8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732323AbfAaLrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 06:47:07 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42540 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbfAaLrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 06:47:07 -0500
Received: by mail-oi1-f194.google.com with SMTP id w13so2440423oiw.9;
        Thu, 31 Jan 2019 03:47:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mCxIq+0h/pKoS2oVEcpuljzWqFkn6kG+fh6ULECbGQM=;
        b=SHMz0ycW/xcre4G8u8AK88DHPkglyUwAgzNFBSSPAJf9Qpwexu9VK3W/xKu3B1+/QM
         t7roNwZmO9ldQvzMwgZgFjc/O+9h1DymyeDhV/qead3FOy06s4M03CVwKPHEixgFoHuK
         d3NcUsffoFzTe4j2cyHpwwE8iCv2urtHQW6g95LprUqLR2fG2hRQvwZanNBud6/vPnTk
         3iw9M2MCQuyWXz1PCTYjladGtTb0nXc1tFOPM/bvjUiijcrIjOqp4/k3kMhSVMG7UxGL
         kyMhFi2CAr1MysJQbheqYg0sN8Ioufq6fShk6KpjH0ScxHVjnFRdOcpLkZvYwAQVbpDR
         9Gfg==
X-Gm-Message-State: AJcUukdk/qv1XHFELcwB5yNknQT1SdOl2+XqPgm3jVlxnCjDmVQPok25
        pt9PoF8hRDTE6m/W4a7oZd/qDG/FiLVeHz4Fm1M=
X-Google-Smtp-Source: ALg8bN669fKGKZJ+To3whx5lJSGrByw6YnAtp02xzHrZxzY2j1dGOXnRAWddkgxdvsz9++1xUpn7r3kHWJyIdJUe1UI=
X-Received: by 2002:aca:6c8b:: with SMTP id h133mr15274552oic.33.1548935225963;
 Thu, 31 Jan 2019 03:47:05 -0800 (PST)
MIME-Version: 1.0
References: <1548414418-5785-1-git-send-email-spujar@nvidia.com>
 <b631310f-93fa-ef4b-7014-d97fcfb2dcdf@nvidia.com> <s5ha7jicd4l.wl-tiwai@suse.de>
 <20190131110530.GA23438@ulmo> <s5htvhpax8s.wl-tiwai@suse.de>
In-Reply-To: <s5htvhpax8s.wl-tiwai@suse.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 31 Jan 2019 12:46:54 +0100
Message-ID: <CAJZ5v0i_G36Cw3ZvDxyU2F+pBpiw9i=3_wfQ3tDh3_JgOAb3zw@mail.gmail.com>
Subject: Re: [PATCH v2] ALSA: hda/tegra: enable clock during probe
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jon Hunter <jonathanh@nvidia.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sameer Pujar <spujar@nvidia.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, mkumard@nvidia.com,
        rlokhande@nvidia.com, sharadg@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 12:21 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Thu, 31 Jan 2019 12:05:30 +0100,
> Thierry Reding wrote:
> >
> > On Wed, Jan 30, 2019 at 05:40:42PM +0100, Takashi Iwai wrote:

[cut]

> > > If I understand correctly the code, the pm domain is already activated
> > > at calling driver's probe callback.
> >
> > As far as I can tell, the domain will also be powered off again after
> > probe finished, unless the device grabs a runtime PM reference. This is
> > what happens via the dev->pm_domain->sync() call after successful probe
> > of a driver.
>
> Ah, a good point.  This can be a problem with a probe work like this
> case.
>
> > It seems to me like it's not a very well defined case what to do when a
> > device needs to be powered up but runtime PM is not enabled.
> >
> > Adding Rafael and linux-pm, maybe they can provide some guidance on what
> > to do in these situations.
> >
> > To summarize, what we're debating here is how to handle powering up a
> > device if the pm_runtime infrastructure doesn't take care of it. Jon's
> > proposal here was, and we use this elsewhere, to do something like this:
> >
> >       pm_runtime_enable(dev);
> >       if (!pm_runtime_enabled(dev)) {
> >               err = foo_runtime_resume(dev);
> >               if (err < 0)
> >                       goto fail;
> >       }
> >
> > So basically when runtime PM is not available, we explicitly "resume"
> > the device to power it up.
> >
> > It seems to me like that's a fairly common problem, so I'm wondering if
> > there's something that the runtime PM core could do to help with this.
> > Or perhaps there's already a way to achieve this that we're all
> > overlooking?
> >
> > Rafael, any suggestions?
>
> If any, a common helper would be appreciated, indeed.

I'm not sure that I understand the problem correctly, so let me
restate it the way I understand it.

What we're talking about is a driver ->probe() callback.  Runtime PM
is disabled initially and the device is off.  It needs to be powered
up, but the way to do that depends on some configuration of the board
etc., so ideally

pm_runtime_enable(dev);
ret = pm_runtime_resume(dev);

should just work, but the question is what to do if runtime PM doesn't
work as expected.  That is, CONFIG_PM_RUNTIME is unset?  Or something
else?
