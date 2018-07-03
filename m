Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF17DC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78CDD20BED
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rTZHyiHV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78CDD20BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933267AbeGCPEv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:04:51 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:39706 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932234AbeGCPEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:04:49 -0400
Received: by mail-oi0-f65.google.com with SMTP id d189-v6so4437718oib.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 08:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D3rO9IzeHYIgPj/easfdgiGqgtlLz8XRb+sXgFciWhI=;
        b=rTZHyiHVQZbYhUpknL/A8azCrHGmunESjFqulRQavaeenveZ7kB5S7n2rFWvfFd0rE
         +smGZAxB1EDEVGtH9lJqXKhQeW6mjPTxoBZGpCRqwXn0XTUt87dLcO1AxOtQX71/vNlV
         dnzJr9qRyESAxkJr1QTlpC/lGeYsgqKRtLxiFXGPyenI/SDNNCx1iTfsHqeCi98j6XcJ
         667cQEwLFzXd8uNYZZSO+RQmtyVvb6yC76W7vMhTUnNnUdsZRv3A8EAbHgQ3SVMf0QH2
         AHgQRviubHs0aQufAUijpvp+qmIIZcqfB3B85+kd73A0yfBcghUhdhiwUzofzv9exvfP
         bxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D3rO9IzeHYIgPj/easfdgiGqgtlLz8XRb+sXgFciWhI=;
        b=Lq81hORLmpnbRO1eDHlgq394Dp1THWtvhUWOdL1G2xLpdjash+1dw6syhJqaVoqorq
         fMff+7ibz9WN2tNC6uzIjGBh5GljlrAGoB0GhC1ifac8vm6/aDQFt4J6By+OSTo9/smT
         uhEH8Jh2Xssl8eX/7jISlp/32r/BViXKf65GXEQzaJjh4puh7D6uCzsqvcx7aLvfzXm3
         ZlSYXqGTjfp99pMkY4DsLqNJEaJMbvM5YuEHKTQSENWSljaVPwJbhJxsBB4HzWMbTIdW
         e4Nrb/P1zHuz86aNx9Zlfv8yfXHp95aayFItScnRYP2EV3T+8rDA0br+PTlqfLSIoHLD
         Zqfg==
X-Gm-Message-State: APt69E3bvTfgpc7T/VBGDLfEI+tB6kB6ywZIJLoudqLD8FJqbu73l7QR
        PKJHw0ZumrThefa1OwPaF6SZvzoViHNGHsExoAw3d6S1
X-Google-Smtp-Source: AAOMgpf/nz8MF00NyVyV9pZVv+r0QvZeoMndL9QmLZx3gO5tC0z98xdBPbuY8WqeveW2udzm1N/MArUmZIk1GXXzw0Y=
X-Received: by 2002:aca:4914:: with SMTP id w20-v6mr6407653oia.5.1530630288958;
 Tue, 03 Jul 2018 08:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <1525881728-4858-1-git-send-email-sudeep.holla@arm.com>
 <CAOi56cUiPX9JYZzZD5isPF3wZwVDenYY-5J39Ch9CFp-eXXtQQ@mail.gmail.com> <20180703105357.GC1715@e107155-lin>
In-Reply-To: <20180703105357.GC1715@e107155-lin>
From:   Kevin Hilman <khilman@baylibre.com>
Date:   Tue, 3 Jul 2018 08:04:37 -0700
Message-ID: <CAOi56cW-QsL9gmyF-R9iscZ1M-zM-gJPxcvG=dvB=zrDioZJgA@mail.gmail.com>
Subject: Re: [PATCH] tick: prefer a lower rating device only if it's CPU local device
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, fweisbec@gmail.com,
        Arnd Bergmann <arnd@arndb.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 3:54 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Mon, Jul 02, 2018 at 04:44:33PM -0700, Kevin Hilman wrote:
> > Hi Sudeep,
> >
> > On Wed, May 9, 2018 at 9:02 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > Checking the equality of cpumask for both new and old tick device doesn't
> > > ensure that it's CPU local device. This will cause issue if a low rating
> > > clockevent tick device is registered first followed by the registration
> > > of higher rating clockevent tick device.
> > >
> > > In such case, clockevents_released list will never get emptied as both
> > > the devices get selected as preferred one and we will loop forever in
> > > clockevents_notify_released.
> > >
> > > Cc: Frederic Weisbecker <fweisbec@gmail.com>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >
> > I've got a arm32 board (meson8b-odroidc1) that's been failing in
> > kernelCI.org since the merge window (boot log[1]), and I finally got
> > around to bisecting it[2].  Unfortunately, the bisect pointed at a
> > merge commit, but with some trial and error (and a suggestion by Arnd)
> > I was able to test that revering $SUBJECT commit[3], my problem goes
> > away.
> >
>
> Interesting. Sorry for causing the regression.
>
> > Another interesting data point is that disabling SMP (either by
> > "nosmp" on the command-line or CONFIG_SMP=n) also makes the problem go
> > away, without needing to revert this patch.
> >
>
> I am not sure of nosmp, but with CONFIG_SMP=n, TICK_BROADCAST also gets
> disabled. dummy_timer won't be registered I assume.
>
> I am not sure if dummy_timer is selected as it's per_cpu but the rating
> is low anyways.

> > AFAICT, this platform, is using a single timer as a clocksource
> > ("amlogic,meson6-timer") which is not a per-CPU timer.
> >
>
> Yes that's what I could gather from DT. But this is A5 right ? It may
> have per CPU TWD(watchdof timer) but DT doesn't specify it, so should be
> fine.
>
> > I ran out of time to keep digging on this issue, and I'm still not
> > sure exactly what's going on, but I wanted to report it in case anyone
> > else has any ideas, and so we can hopefully get it fixed during the
> > -rc cycle.
> >
>
> From the log, it looks like the platform has booted to userspace. Any chance
> we can have a look at:
> $ grep "" /sys/devices/system/clock*/{broadcast,clock*}/{available,current}_*

In the failing case, it doesn't boot to a shell, so I can't do that,
but after I revert the patch, I have this:

/ # ls -l /sys/devices/system/clocksource
total 0
drwxr-xr-x    3 root     root             0 Jan  1 00:00 clocksource0
drwxr-xr-x    2 root     root             0 Jan  1 00:00 power
-rw-r--r--    1 root     root          4096 Jan  1 00:00 uevent
/ # cat /sys/devices/system/clocksource/clocksource0/available_clocksource
timer jiffies
/ # cat /sys/devices/system/clocksource/clocksource0/current_clocksource
timer

/ # cat /sys/devices/system/clockevents/broadcast/current_device
meson6_tick
/ # cat /sys/devices/system/clockevents/clockevent0/current_device
dummy_timer
/ # cat /sys/devices/system/clockevents/clockevent1/current_device
dummy_timer
/ # cat /sys/devices/system/clockevents/clockevent2/current_device
dummy_timer

Kevin
