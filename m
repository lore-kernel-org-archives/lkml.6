Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 655CEC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D470208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbU2HnfN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D470208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755374AbeFNPVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 11:21:00 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42241 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754927AbeFNPU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 11:20:58 -0400
Received: by mail-lf0-f65.google.com with SMTP id v135-v6so10015205lfa.9;
        Thu, 14 Jun 2018 08:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FKqUduuaQR3i+7FbLUPjITQGCJiuOOCM5WfqxHSpuDs=;
        b=YbU2HnfNZ0V0ewq7D4uuENi5yybe+p+Z6sGCtHLlUOeddhSPBWbvCHlg7+0FGHhL1Y
         HTvCtq/ySlLLScWpFOgL688aXjDGX68ysZCbW8KOVaBYoPvivxBmcv5qafzuYAAVG49h
         zkNTidl+uileR9aS1W1NDxom2SAI2qjLbNPilhI0HVFQN1BX/XScnuJduaBTodY9VYs0
         k/yvFBh4uIdz+AdShdGimZOm6H0hijVFrt9xIuiSzzSxIBAe9KdsLv3RNz/XTGbjng1D
         BUlJuX+U7EG+JAM/vfZn2YGgOjuMZYrxWsNrL8ogpM31zie/lZtDCpqFEzUF++dNWEtM
         lmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FKqUduuaQR3i+7FbLUPjITQGCJiuOOCM5WfqxHSpuDs=;
        b=MgzPnb77XRc/UsHG/6S7gNY9sy1m8PakKVoFcAmQpms+gJrn2tBYshJRKqHHk+dAS9
         Ajt4S685FXVChXDJBsTLmuCwuY625Z5Qj/KPCfFckwRDgdZM39HYjDbS+MtFGkQhlMfX
         RYq76Rud5JjjNMMAw0abEO2q93uY9S9R9RHuukHSkbiGPFeGLT/0wt03vRsDh+ZjM016
         9EVopU4cGHUUrr81dD94uKF9AJJDKhbBEO9TLq85R4zaL1XdlC2OPSNckMxJxO0SmUov
         7bPLTshNtqC9xErhUkNGVjRLpJZa1wmtuSBDubwHvKpHSpNrtb4bO4Pn0tD/ntf1g3fu
         ge9w==
X-Gm-Message-State: APt69E3vr9/4LO44rk8vhTxWsvRUfEP4fviJO6cN2fgyLwk85Yoj6pIe
        0j0k+69aXDUG1/jJ8HqTORPDeRDZHMqfm+m+fRQ=
X-Google-Smtp-Source: ADUXVKLLREF3jNQwRhe3NmSEdE7DGHEPVd5wDxnaNT9vAtcUFqp3wVxktMqY5TZayYsqNrEKc22YsTgf0WjJDTTzseY=
X-Received: by 2002:a19:9f95:: with SMTP id i143-v6mr6643978lfe.125.1528989657018;
 Thu, 14 Jun 2018 08:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
 <20180614104820.GC32411@localhost> <CAPybu_0TSdQFOL1ptv67-aKktAftYWPwnSnevmBd_b1T0W7LYg@mail.gmail.com>
 <20180614133341.GD32411@localhost> <CAPybu_3=KhPB_ymtRNSZfcyP57LPD2SbLUPoFO0YdjkzAsdaTA@mail.gmail.com>
 <20180614145531.GE32411@localhost>
In-Reply-To: <20180614145531.GE32411@localhost>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Thu, 14 Jun 2018 17:20:40 +0200
Message-ID: <CAPybu_1ps+tEr5W_uvMSeH4_gwbjgKHnz0MoSEJO=Ut0a4sx6Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/19] Dynamically load/remove serdev devices via sysfs*
To:     Johan Hovold <johan@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,
On Thu, Jun 14, 2018 at 4:55 PM Johan Hovold <johan@kernel.org> wrote:
>
> On Thu, Jun 14, 2018 at 04:06:18PM +0200, Ricardo Ribalda Delgado wrote:
> > Hi Johan,
> > On Thu, Jun 14, 2018 at 3:34 PM Johan Hovold <johan@kernel.org> wrote:
>
> > > And there are more issues with the series which are less apparent than
> > > the rx (and partial tx) regression.
> >
> > Any hints about this? What else should I change on the series?
>
> There are implementation issues and there's the more fundamental
> question about whether your approach to this is the right one.
>
> Like Rob, I'm not sure we want to have the device topology depend on a
> kernel config symbol (serdev and your ttydev driver). We may need to
> explore Rob's sibling-device idea further.

From my point of view, if the user enables serdev, then everything has
to be a serdev, because serdev does not provide the same functionality
as a core tty device I had to implement, serdev-ttydev.c. Which is
nothing more than a wrapper.

It is very hacky, but allows replacing the core tty device with another serdev.

>
> I also want to make sure that this can be used for discoverable buses
> (e.g. the USB CEC device the I've used as an example before).
>

I have tried your patch:

https://github.com/ribalda/linux/commit/5cb30b4ce6477132a23492c674d8b3dc81ecff86

the only issue is that the serdev device sometimes explotes (OOPS)
when the usb is unplugged :S.

And that might be quite tricy to solve

> As for the current implementation there are both larger and smaller
> issues, like for example:
>
>  - the fact that your sysfs and lookup interface does not use any
>    locking whatsoever and thus is susceptible to races

I thought that sysfs access where serialised. If that is not the case
yes, we need a lock.

>
>  - your ttyport driver currently breaks the sysfs interface for all
>    serial (core) devices by ignoring the attribute groups

Yep, you are right, I screwed up that one :).

>
>  - the ttyport driver is arguably a hack with layering issues (which
>    admittedly may be hard to avoid given the retrofitting of serdev into
>    the tty layer)
>
> Again, I suggest you submit a subset of your series (aim at 10 patches
> or so) as an RFC which can be used as a basis for further discussion. No
> point in discussing every implementation detail if the underlying
> approach needs to be revised.

Will do. Give me some time to give it a hand of paint.

Thanks for time reviewing my little moster

>
> > > It's legacy as in old, and to be used for one-off hacks and such. But
> > > sure, that is also what this series aims at even if that doesn't mean
> > > you *have to* copy the interface.
> >
> > It is not only one-off hack. It is the ONLY way to use i2c devices
> > that are not enumerated.
> >
> > The same way as today we do not have any way of using serdev on non
> > enumerated devices.
>
> You're missing the point: none of that means you have to copy the
> interface.
>
> Johan



-- 
Ricardo Ribalda
