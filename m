Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B12C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6350321908
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YTpgQuvl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfBGO3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 09:29:45 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37741 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbfBGO3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 09:29:45 -0500
Received: by mail-vs1-f68.google.com with SMTP id s16so23042vsk.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 06:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6tRAw/d6CSlxguHM48f79ckVjUBHCFS8Ox7W77acMrM=;
        b=YTpgQuvl8x3AijLTE8s515zezphVGHIYimU5Rk6mtnnE97NAQFghG9j1kEQtTRXkAF
         hHF19mAJ1NvwIp7OY20XGqtIIhBmF+wrex156xCp8rbHhJSmCX367JCD4l1ukaqMJBZm
         QsIp9ESUyHCR3XIb85rNZ+j8yeIFSLP3+SloWETaXV7yuoTCrg86Nm7qKu2idLxwdl0y
         ZsJmpPjFM55tuERSauXps/NH7gtwGj06RHZ1LktOFt1p0gMhcXNlr29rNDRCRQXw+Fbu
         eWNXO5BPE6qldkl96RK6QT7qc7yrg1ZrEQm/Kxrn+OjKeU0hYynElQWs1mteBXoxCwD4
         FYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6tRAw/d6CSlxguHM48f79ckVjUBHCFS8Ox7W77acMrM=;
        b=osxgv0VQA7kfpnfLe2eUYjA6Mr1e/iY/RYK54sNA3hyKjVbgf9iUv+tkMq3n507hXz
         GJ298DF1sdOdbv1/P1a79OnaaJcp43LNw3jyKBeEz3njH2gI0xDtGYRz3wBM+MVoqpfd
         01dE8kTAlWuJeA1sgNtkI995s/hyBvEMnXJtPSmd58Fd+1t5m01kPaWNoRNsY90GQDWF
         OCIUbfjieShn8C7DnQ8lB3Bb8rxRcdhNAc+chEbKhsi0OCdFLV8mmgea+QAiNEGkzGju
         SalzLfBqsIShSj6q/UhnBmpOnEQnYYiRCPrc3aZcyINb86iE9R6FrgyGdwUE+n8QaAgF
         cZ8w==
X-Gm-Message-State: AHQUAuaAdIU8iMchAk7o5vOr8LLETU5qHYybOxpA3GqoPJ53nNx1Jepn
        TROS64qUCQPcVBl9/vwToKBwfdBpzKGvIIK2V0X9Zw==
X-Google-Smtp-Source: AHgI3IYQwNugy8UoWk45/2H8UpLWH1oDjLvPnrwupxLYAv6bVWi0DMf2AO6WM8KEo5dbrgUo1mfMqAxQb3aT07TcSfM=
X-Received: by 2002:a67:b245:: with SMTP id s5mr6517107vsh.200.1549549783637;
 Thu, 07 Feb 2019 06:29:43 -0800 (PST)
MIME-Version: 1.0
References: <20190206150935.12140-1-sudeep.holla@arm.com> <CAPDyKFr2qwXoOL3SRy7Crf-pg4FMn_qecPrw__BE+YpVAjAFZA@mail.gmail.com>
 <20190207103600.GA14464@e107155-lin>
In-Reply-To: <20190207103600.GA14464@e107155-lin>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 7 Feb 2019 15:29:07 +0100
Message-ID: <CAPDyKFpkiaP0J_LJxP6tRUOyz3QKtDgA+PuhL-9vew7-RfKyNA@mail.gmail.com>
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

On Thu, 7 Feb 2019 at 11:36, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Feb 07, 2019 at 10:53:56AM +0100, Ulf Hansson wrote:
> > On Wed, 6 Feb 2019 at 16:09, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > All device objects in the driver model contain fields that control the
> > > handling of various power management activities. However, it's not
> > > always useful. There are few instances where pseudo devices are added
> > > to the model just to take advantage of many other features like
> > > kobjects, udev events, and so on. One such example is cpu devices and
> > > their caches.
> > >
> > > The sysfs for the cpu caches are managed by adding devices with cpu
> > > as the parent in cpu_device_create() when secondary cpu is brought
> > > online. Generally when the secondary CPUs are hotplugged back in as part
> > > of resume from suspend-to-ram, we call cpu_device_create() from the cpu
> > > hotplug state machine while the cpu device associated with that CPU is
> > > not yet ready to be resumed as the device_resume() call happens bit
> > > later. It's not really needed to set the flag is_prepared for cpu
> > > devices as they are mostly pseudo device and hotplug framework deals
> > > with state machine and not managed through the cpu device.
> >
> > What's the point of removing and then re-adding the sysfs attributes
> > for the cpu caches, at each hotplug off/on sequence? To me that sounds
> > inefficient and unnecessary, no?
> >
>
> Oh well, you must look at PowerPC pHyp which can change cache nodes for
> suspend/resume operation too, let alone hotplug operations. So, we can't
> assume the same CPUs with exact same caches are always hotplugged back
> in. That's may happen in embedded and other static platforms but not
> everywhere. Anyway that's my understand as why it's done in hotplug
> patch. So it's not so simple to call it inefficient and unnecessary IMO.

Okay, I see.

>
> > If you avoid this, would that solve this problem?
> >
>
> May be, but as mentioned above we can't really. Also this change will
> help to avoid creating unnecessary power sysfs which is mainly runtime
> pm related for some of the devices created. CPU/caches was just one
> example which triggered this, but this can be more useful. We can avoid
> adding them to dpm list.

Well, to me the approach you suggest sounds prone to errors and I am
afraid people may abuse it. Moreover, I don't know if there is other
problems with it, let's see what Rafael thinks about it.

Instead I think we should make the PM core to deal with this scenario,
as all it boils down to, is to allow a device to be unregistered and
registered during system suspend/resume, with a parent device that is
"persistent" during the sequence.

Perhaps we could even just drop the corresponding printed warning,
"cache: parent cpu1 should not be sleeping", in device_pm_add() as I
wonder if it's really a necessary print.

Kind regards
Uffe
