Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AE5C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CDEC23D7E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="EHC04OyI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CDEC23D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753756AbeGBXoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 19:44:46 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:37437 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753312AbeGBXop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 19:44:45 -0400
Received: by mail-oi0-f67.google.com with SMTP id k81-v6so252877oib.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 16:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nYuXsUxFjXui5wUWE8LvRIsawB4YWZQpfOhJCZMfeeE=;
        b=EHC04OyIVrTlAULcz8DnzWi9652nN0Tw2IKiC3d0tUvc1paqU8W0ECgah586CJW1DN
         d7yXenRh3NKyvweJPNOVq+pqD5XnH91H6+HOhw/goPFp6UGJ4QHpeGd1mm7R3pMqCzXQ
         96+ZFksBj1J0TmpmX65UQgDO26hkSBkA6tOU40qTmj9hqeldYh4tPdZvWhxPysGs2obC
         hSgZn10rYD3xH0Yb4RXR4xX/ZKqIys2K+sDzFbA9iprCqxsY+vumo8RobvkOrxR+hLJz
         U6xtb1tdmlbRlBi8Uji9L8Uhyr72pdx16siB0f0R7WZMXreACVUBVbyAFsyyts/qxkD7
         RKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nYuXsUxFjXui5wUWE8LvRIsawB4YWZQpfOhJCZMfeeE=;
        b=O+MyYkgATmqtSnNAJoXNdi3x4veAXaoQ9uDJYcsmU9dlqTa7OGRDF84o1p1xzD4u2j
         7lW/vWqmyZbzvku93PuAsbK5sikR5ZdkY4sBV7dt1m/7kg7P9grOH1kaPxSMZiUzgd3N
         Qnhuvoqdf1RxPP1Yq5B2w00c2XLBM49REP/+0mgoOfrMe1HPL05gzuLzo5+RR08Nhmt+
         XIJgPUE+w/e2nWtxEbp5vUEOOpBBwA985ZxkYl7K5UQZQnLGpvYwgxKmHaE6HOA14aqZ
         YiuaIadEodLsUCpCySuSDFTnCR5OflzRkHulJ386y7BTzK1T6xD/dJWNc392PZSHnFe+
         GGjA==
X-Gm-Message-State: APt69E2bBYBb9/PzwM4pptI/y1fT1890gngUoKUqRmHxPm7yzj1+bXVk
        fv340PAfub26vUaY9my9JdgOXDheXhvx1GwTuk8mgQ==
X-Google-Smtp-Source: AAOMgpfG1yvkVXaVMX+5HFIBb6FbR7D+rYVQ9VAlJC8fIDoP0Osg3rYPCJncZzjQ1EdFKjV3NSeQqEEdM8FiP6IzlL0=
X-Received: by 2002:aca:4914:: with SMTP id w20-v6mr3611279oia.5.1530575084751;
 Mon, 02 Jul 2018 16:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <1525881728-4858-1-git-send-email-sudeep.holla@arm.com>
In-Reply-To: <1525881728-4858-1-git-send-email-sudeep.holla@arm.com>
From:   Kevin Hilman <khilman@baylibre.com>
Date:   Mon, 2 Jul 2018 16:44:33 -0700
Message-ID: <CAOi56cUiPX9JYZzZD5isPF3wZwVDenYY-5J39Ch9CFp-eXXtQQ@mail.gmail.com>
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

Hi Sudeep,

On Wed, May 9, 2018 at 9:02 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Checking the equality of cpumask for both new and old tick device doesn't
> ensure that it's CPU local device. This will cause issue if a low rating
> clockevent tick device is registered first followed by the registration
> of higher rating clockevent tick device.
>
> In such case, clockevents_released list will never get emptied as both
> the devices get selected as preferred one and we will loop forever in
> clockevents_notify_released.
>
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

I've got a arm32 board (meson8b-odroidc1) that's been failing in
kernelCI.org since the merge window (boot log[1]), and I finally got
around to bisecting it[2].  Unfortunately, the bisect pointed at a
merge commit, but with some trial and error (and a suggestion by Arnd)
I was able to test that revering $SUBJECT commit[3], my problem goes
away.

Another interesting data point is that disabling SMP (either by
"nosmp" on the command-line or CONFIG_SMP=n) also makes the problem go
away, without needing to revert this patch.

AFAICT, this platform, is using a single timer as a clocksource
("amlogic,meson6-timer") which is not a per-CPU timer.

I ran out of time to keep digging on this issue, and I'm still not
sure exactly what's going on, but I wanted to report it in case anyone
else has any ideas, and so we can hopefully get it fixed during the
-rc cycle.

Kevin

[1] https://storage.kernelci.org/mainline/master/v4.18-rc2-357-gd3bc0e67f852/arm/multi_v7_defconfig/lab-baylibre-seattle/boot-meson8b-odroidc1.html
[2] http://termbin.com/mk07
[3] in mainline as: 1332a9055801 tick: Prefer a lower rating device
only if it's CPU local device

> ---
>  kernel/time/tick-common.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> Hi Thomas,
>
> I am seeing this issue on my Juno devboard, where system wide timers
> with rating 300 and 400 are registered in same order and we get stuck in
> a loop in clockevents_notify_released. Let me know if this looks sane or
> you have any suggestions that I can try out.
>
> Regards,
> Sudeep
>
> diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
> index 49edc1c4f3e6..78e598334007 100644
> --- a/kernel/time/tick-common.c
> +++ b/kernel/time/tick-common.c
> @@ -277,7 +277,8 @@ static bool tick_check_preferred(struct clock_event_device *curdev,
>          */
>         return !curdev ||
>                 newdev->rating > curdev->rating ||
> -              !cpumask_equal(curdev->cpumask, newdev->cpumask);
> +              (!cpumask_equal(curdev->cpumask, newdev->cpumask) &&
> +               !tick_check_percpu(curdev, newdev, smp_processor_id()));
>  }
>
>  /*
> --
> 2.7.4
>
