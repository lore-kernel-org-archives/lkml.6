Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7036DC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1D7208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsTbSqM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E1D7208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933334AbeFUMCG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 08:02:06 -0400
Received: from mail-ot0-f170.google.com ([74.125.82.170]:44563 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933246AbeFUMCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 08:02:02 -0400
Received: by mail-ot0-f170.google.com with SMTP id w13-v6so3235008ote.11;
        Thu, 21 Jun 2018 05:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=daUMxUaiDUchCogNJWd4xcUFk0Z92PNNNZMFNhR4ohM=;
        b=VsTbSqM6Q4KOxWH+HO8GFXUAy5ZD9aNPqjNnPnujWHLju0RB+S6fl+tERqRpmA+qal
         vO/twJdkbrH9hKM/hGAxQYnmFjIF+OlpfO+Zxv6Z3ybKOsGUL3LLO/cs/um8oleEr441
         fHECiRP6l47N8G/iDBpqX4HiTiagV0l+ksiiL/UedVYwoJOqfPmWl8jhq3uDf3fjbp4O
         7lDicyuHKaublv4nPPEDUXo2VOF4OHz8wKLOZ1224bjqgOlpzBYkCqqMZIE/lXeQQfzh
         9n7qUPCC3TQz+v9dpGILg4uf6RkTYo9l/PjEcCqRpLNXxqV8VwTFmvMP+apnLy+wF0jc
         Pm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=daUMxUaiDUchCogNJWd4xcUFk0Z92PNNNZMFNhR4ohM=;
        b=HxpIW5kYtn/tbFWKyHWUxsDqPBGP8w8w7/3C1Vt43Z9dCQo4mEXmctTitPoLIRL6tJ
         NTZpVLDrI+v9fXX2aMNe5hCOLi5t1UH8XrZt0Vxwx2XCqZ/T+oGa+/68cwyf6Hj9cKg9
         PvJ77nGxaYSkkyESo+T69Qzp2Y5b6YvMUHtV99SAv7WgiwPxbTY+o24qGMF25c3l0dYx
         6na11A+Zs2WQ887SOU4uznEyITOVYJhD6IG7D05B+oVCdGhwNgElcniA3PFg7NaF7jr5
         +8TkEDvSSabucB9bTubJOSOCA3IsmmpQOhWIK+VkZ0OhSX1A+k3IvmsN15g7TQeKpuEl
         u6fg==
X-Gm-Message-State: APt69E221BNM7SCbT47G9ti2P1HZMWd8vZ3Vu78zDoSIBHzgLd35AkHq
        CmJ2M4Mojw0aqF8XIi8ykY1NIcynoBOKiJUOBKc=
X-Google-Smtp-Source: ADUXVKIefPdvwPql1kkt0w+CV6Ft3meibkTL2aux221UBV5A7lCfr+H+Ivtk6aDrr8bRYWgcGDKSm5Bt6xMQYVkFgs0=
X-Received: by 2002:a9d:3e4c:: with SMTP id h12-v6mr14694311otg.150.1529582521746;
 Thu, 21 Jun 2018 05:02:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1429:0:0:0:0:0 with HTTP; Thu, 21 Jun 2018 05:02:00
 -0700 (PDT)
In-Reply-To: <6c15a753-c4a8-ff89-f5c0-0fd19c817c91@ti.com>
References: <CA+G9fYuKW_jCFZPqG4tz=QY9ROfHO38KiCp9XTA+KaDOFVtcqQ@mail.gmail.com>
 <20180620102904.GC112168@atomide.com> <d5d57b10-facb-d5f7-ad7f-34afae726756@ti.com>
 <CAFY_6qqDcG7+sp7jawhTjuWHizPR75=HUsRJfGPhEPzVE4f5kg@mail.gmail.com> <6c15a753-c4a8-ff89-f5c0-0fd19c817c91@ti.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Jun 2018 14:02:00 +0200
X-Google-Sender-Auth: VPxnSpSdPGv4OSJZXarI8FMlW74
Message-ID: <CAJZ5v0iU5Qqbm6LDNmm=vj_H_sXRasdFN9+xBGto_-eZG6tXrQ@mail.gmail.com>
Subject: Re: 4.18.0-rc1-next-20180619 boot failed on beagle board x15
To:     Roger Quadros <rogerq@ti.com>
Cc:     Samuel Morris <samorris@lexmark.com>,
        Tony Lindgren <tony@atomide.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Tejun Heo <tj@kernel.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Olof Johansson <olof@lixom.net>, Tero Kristo <t-kristo@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 9:58 AM, Roger Quadros <rogerq@ti.com> wrote:
> +Rafael
>
> On 20/06/18 18:30, Samuel Morris wrote:
>> On Wed, Jun 20, 2018 at 8:58 AM, Roger Quadros <rogerq@ti.com> wrote:
>>> Tony,
>>>
>>> On 20/06/18 13:29, Tony Lindgren wrote:
>>>> Hi,
>>>>
>>>> * Naresh Kamboju <naresh.kamboju@linaro.org> [180620 05:55]:
>>>>> Linux next (4.18.0-rc1-next-20180619) boot failed on beagle board x15.
>>>>
>>>> Bisect points to commit aece27a2f01b ("ata: ahci_platform: allow disabling of
>>>> hotplug to save power").
>>>>
>>>> Reverting the patch makes things work again. Any ideas what
>>>> might be going wrong here? Things clearly idle but then there
>>>> seems to be some register access with clocks disabled.
>>>
>>> The commit is doing this in probe.
>>>
>>> +       pm_runtime_set_active(dev);
>>>         pm_runtime_enable(dev);
>>> -       pm_runtime_get_sync(dev);
>>> +       pm_runtime_forbid(dev);
>>>
>>> On OMAP, the device is not guaranteed to be active at probe and so we can't
>>> say pm_runtime_set_active() and get rid of pm_runtime_get_sync().
>>
>> Okay, by calling set_active(), I'm preventing the rpm_resume from
>> completing that would normally happen in pm_runtime_forbid(). I assume
>> you mean that there are parent devices that need to be resumed before
>
> Actually, in the OMAP case, the AHCI controller device isn't active when probe is called.
> For other platforms this might not be the case. So we need to be careful here.
>
>> this device may be assumed active. I'm going to try removing the
>> set_active(), then move that clause to the end of
>> ahci_platform_init_host(). The pm_runtime_forbid() is effectively the
>> same as get_sync(), it just also sets the runtime_auto flag to false.
>> I don't think we should be saying the device is active until the host
>> is initialized, so that seems like a better, common place for the
>> pm_runtime init callbacks anyway. How does that sound?
>
> Device active and initialized are different things. If the device is powered up
> and can be accessed it is active, even if it is not yet initialized.
> I don't think we should club the two.
>
> Why do you need to call pm_runtime_set_active() at all in the probe sequence?
>
> Documentation for pm_runtime_set_active() says,
> "(it is only valid to use this function if 'power.runtime_error' is set
> or 'power.disable_depth' is greater than zero);"

I guess on some platforms the AHCI controller actually is active
initially and that's a matter of setting the initial status to reflect
the real situation.

If different things can happen on different platforms, there needs to
be a way to discover the initial state instead of making assumptions
on it.

Thanks,
Rafael
