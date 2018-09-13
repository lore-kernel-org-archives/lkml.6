Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB70C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 05:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1812920882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 05:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="0tHkH5H6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1812920882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbeIMK7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 06:59:34 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:54039 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbeIMK7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 06:59:33 -0400
Received: by mail-it0-f66.google.com with SMTP id p79-v6so6317351itp.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 22:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=z4I1FPR79aavOXt4VkVcf5S0lHhXD6nCahBToOB20WU=;
        b=0tHkH5H6y8mNcymUQPij7b749SgxWbXSnG5y4/iRhykimtuViKnHE5lVzSECtD89lK
         WCjLakQ98R6g481SeaHKa7iyFDkqNcV79R2YoqcgSWNxor7EJzU3a6W0UgitJCUVL+RY
         HYP/qofnsszF4usZZAHlDpyna1oG3U1Hg+a0hp0FuMOR7nKnkDMzupwUUBrSCOGyqL8A
         6Rp0xuhQgh54qz01StmSFPrAQsSaG126wwA9CSJXgdej+zz4x7wVIWJPTZEAd2U9ybE/
         nf0HbE6ZhMTrcNU+SVTJ/nn+MHkTktAMYhDmzA5YcdrXgll5tV65zOi0xUpZioFN243c
         Qe/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=z4I1FPR79aavOXt4VkVcf5S0lHhXD6nCahBToOB20WU=;
        b=PY/zg3zCLDM2ZgGXKRC6hoxWgylz/D96DzjZ3TPZ2r0Hv9gDYhXmeu7hxBZcMIvbls
         4Zz831LgsPRUyU1cxsdhLuHFLoqagifrUzRfMoS5nv3wrCbLUGG8if/Sv2o83WVvM31O
         iwzj67EfNSZTrTzaTfU12S1V227unQ9FlPU6i0KMiJMvFI9G7nBhxFf8LuUwP52qmbab
         Y+a3BWHVU63Ef+OEH8kf2TK/rgOcNRT5LsShs42j33vdDXaXQOloZ24jI4/9smBD8szv
         8EHa0+4icreIRmIqX4AKOXNJFfWc/G4DXLLg4As/Dbt/+ACgkW7hB5GPUG2MVszEs33l
         mxaw==
X-Gm-Message-State: APzg51BFvY0cxvnAenPPj9Lo3rzm+U0ukEesASexWHZ4UQbNt5W5wHbY
        iOODA/brIiHp2xjtNZ6r4OW9gqo2RSIqdu7nO5jxig==
X-Google-Smtp-Source: ANB0VdaIYuei5zfsfRCKV3GoFOTCycGVQZNtPSsTV01QL2OFVk9xoRHguln/vJp0Rb4OXOBEAlQnixodOOGH0HFnwxY=
X-Received: by 2002:a02:8952:: with SMTP id u18-v6mr5189670jaj.13.1536817896113;
 Wed, 12 Sep 2018 22:51:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:1505:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 22:50:55
 -0700 (PDT)
In-Reply-To: <BF554FD5-17BA-4F16-9FDF-705D1FC76C12@canonical.com>
References: <5D685053-1A33-4553-8678-A50C542466FD@canonical.com>
 <alpine.DEB.2.21.1809120826310.1427@nanos.tec.linutronix.de> <BF554FD5-17BA-4F16-9FDF-705D1FC76C12@canonical.com>
From:   Jian-Hong Pan <jian-hong@endlessm.com>
Date:   Thu, 13 Sep 2018 13:50:55 +0800
Message-ID: <CAPpJ_edB_G5QPj-by9Y6Zjj36Xm9dmKXy8Kv5gXMf4YfybvuwA@mail.gmail.com>
Subject: Re: Regression caused by commit 7bb05b85bc2d ("r8169: don't use MSI-X
 on RTL8106e")
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Netdev List <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Daniel Drake <drake@endlessm.com>,
        Steve Dodd <steved424@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-09-12 16:19 GMT+08:00 Kai-Heng Feng <kai.heng.feng@canonical.com>:
> at 14:32, Thomas Gleixner <tglx@linutronix.de> wrote:
>
>> On Wed, 12 Sep 2018, Kai-Heng Feng wrote:
>>
>>> There's a Dell machine with RTL8106e stops to work after S3 since the
>>> commit introduced. So I am wondering if it's possible to revert the
>>> commit and use DMI/subsystem id based quirk table?
>>
>>
>> Probably.
>
>
> Hopefully Jian-Hong can cook up a quirk table for the issue.

Module r8169 gets nothing in the PCI BAR after system resumes which
makes MSI-X fail on some ASUS laptops equipped with RTL8106e chip.
https://www.spinics.net/lists/linux-pci/msg75598.html

Actually, I am waiting for the patch "PCI: Reprogram bridge prefetch
registers on resume" being merged.
https://marc.info/?l=linux-pm&m=153680987814299&w=2

It resolves the drivers which get nothing in PCI BAR after system resumes.

After that, I can remove the falling back code of RTL8106e.

Heiner, any comment?

Regards,
Jian-Hong Pan

>>
>>> It's because of commit bc976233a872 ("genirq/msi, x86/vector: Prevent
>>> reservation mode for non maskable MSI") cleared the reservation mode, and
>>> I
>>> can see this after S3:
>>>
>>> [   94.872838] do_IRQ: 3.33 No irq handler for vector
>>
>>
>> It's not because of that commit, really. There is a interrupt sent after
>> resume to the wrong vector for whatever reason. The MSI vector cannot be
>> masked it seems in the device, but the driver should quiescen the device
>> to
>> a point where it does not send interrupts.
>
>
> Understood.
>
>>
>>> If the device uses MSI-X instead of MSI, the issue doesn't happen because
>>> of
>>> reservation mode.
>>
>>
>> Reservation mode has absolutely nothing to do with that. What prevents the
>> issue is the fact that MSI-X can be masked by the IRQ core.
>
>
> So in this case I think keep the device using MSI-X is a better route, it's
> MSI-X capable anyway.
>
>>
>>> Is it something should be handled by x86 BIOS? Because I don't see this
>>> issue
>>> when I use Suspend-to-Idle, which doesn't use BIOS to do suspend.
>>
>>
>> Suspend to idle works completely different and I don't see the BIOS at
>> fault here. it's more an issue of MSI not being maskable on that device,
>> which can't be fixed in BIOS or it's some half quiescened state which is
>> used when suspending and that's a pure driver issue.
>
>
> Understood.
> Thanks for all the info!
>
> Kai-Heng
>
>>
>> Thanks,
>>
>>         tglx
>
>
>
