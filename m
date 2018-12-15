Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504C6C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 00:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60578206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 00:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ptXf9+pl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730431AbeLOAUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 19:20:12 -0500
Received: from mail-lj1-f178.google.com ([209.85.208.178]:34890 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbeLOAUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 19:20:11 -0500
Received: by mail-lj1-f178.google.com with SMTP id x85-v6so6374953ljb.2;
        Fri, 14 Dec 2018 16:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I4+7ejWGoiQlIAGPhXiSAfZPZX5XSR2zx92c3JfbS0E=;
        b=ptXf9+plaxh19YkTfRYAaK7bJ+pLkmDo5iqlBYb7aml4g/rQxsxwEMLTfXh1WoINW/
         D9cEP0of/x7Tdrsxzp+3+krCMzpe//WduAaF19u7etYd0o789MG83w5NF0okAva/jQ52
         4ptLwEvdYKn1HHvjDFxvARvfVdT7H8j5pDxFGFtom5f1TkKOYZpi7rlSKBp6OohSJOIE
         hFVPhSACH4J6f6MEowE1E4JZ0lld1jJ8MtXEwSWMlUyWmT5Q/LP/DO9UhugGdKvq6h9/
         lkvZ0eDFZskLnPPx7mQeW3/JGAIAYAACJHjII3+L7+MHQ650bc5UBdgaYoqCr33OFQBW
         xV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I4+7ejWGoiQlIAGPhXiSAfZPZX5XSR2zx92c3JfbS0E=;
        b=kTn+jVHV0tz/9BsMQ/0QFeUoCGOVvSTJNeDBTfpJorYEFUsXD4OrLWOO/OtmAHYcRu
         URNe9Rv78qCuJcJst/GNLMoGWY4Yd26ABHSAXurHiS+fF//dNQ/la4GdFD5a7R5Qk+Tv
         Fgj6jgaef6RsYN8jV1R0+SLe23TacSpfKsR4uFxOmanrGwv7xUYHmCtsyYBXZs3W3PBH
         FKyGOss+FU73WqGCNOcQ/ghg7lC74pBErLL2Nk2vo9nMbDZr0018JfPSRc+wDbDOE3oa
         3fYKjjvWMrSCHmX8zmNkVd5VIQxuJLv73dk7pXI7Qlv0z8ogbma+OdTCIpyQv5TtRSMs
         6YeQ==
X-Gm-Message-State: AA+aEWaSzyG3/Q5nC3mG6l2dYJ0uZDOdzuuyuNEkEG+71Mw7dFYbX+4W
        cuMoZHIFOSN/9nqezA1oUFThpDqK2V5dyy2V9Io=
X-Google-Smtp-Source: AFSGD/VKD/p1vbSaPQCBFrWLx+oC52idLHw504YzLJ4TRFbbXLrHz83Sz8cgiT1OKozb7d+ik56NOdCG7ilqWtK6qx8=
X-Received: by 2002:a2e:9a16:: with SMTP id o22-v6mr2898367lji.112.1544833208095;
 Fri, 14 Dec 2018 16:20:08 -0800 (PST)
MIME-Version: 1.0
References: <20181214232437.GA8310@amd>
In-Reply-To: <20181214232437.GA8310@amd>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Fri, 14 Dec 2018 16:19:56 -0800
Message-ID: <CAKdAkRREmAu83Q97WQa2uJbnBKySjkN2HH4DMockFFzLeT3TiA@mail.gmail.com>
Subject: Re: [rfd] saving old mice -- button glitching/debouncing
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>, jikos@suse.cz,
        Vojtech Pavlik <vojtech@suse.cz>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Fri, Dec 14, 2018 at 3:24 PM Pavel Machek <pavel@ucw.cz> wrote:
>
>
> I believe I have hardware problem, but I'm kind of hoping software
> could help me...?
>
> Mouse wheel on my machine started glitching on my machine, generating
> double-clicks when I click it once. Which unfortunately is quite
> annoying: texts are pasted twice, two tabs are closed instead of one,
> ....
>
> Event: time 1544733054.903129, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90003
> Event: time 1544733054.903129, type 1 (EV_KEY), code 274 (BTN_MIDDLE), value 1
> Event: time 1544733054.903129, -------------- EV_SYN ------------
>             1544733054.967251, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90003
> Event: time 1544733054.967251, type 1 (EV_KEY), code 274 (BTN_MIDDLE), value 0
> Event: time 1544733054.967251, -------------- EV_SYN ------------
> Event: time 1544733054.975144, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90003
> Event: time 1544733054.975144, type 1 (EV_KEY), code 274 (BTN_MIDDLE), value 1
> Event: time 1544733054.975144, -------------- EV_SYN ------------
>      : time 1544733065.127190, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90003
> Event: time 1544733065.127190, type 1 (EV_KEY), code 274 (BTN_MIDDLE), value 0
> Event: time 1544733065.127190, -------------- EV_SYN ------------
>
> Now, I could just buy a new mouse, but it seems that most optical mice
> die like this... so maybe it would be nice to have an option to
> debounce the buttons, so that the useful life of mice is extended a
> bit?
>
> (So... I have two mice with that fault -- cheap to replace, but button
> in thinkpad X220 started doing that, too. That one will not be so
> cheap to fix :-( ).
>
> It is possible that some X versions already do something like this.
>
> Patch is obviously not ready; but:
>
> a) would it be useful to people
>
> b) would it be acceptable if done properly? (cmd line option to
> enable, avoiding duplicate/wrong events?)

I'd say if you are attached to failing hardware, solve it in
userspace. Have a utility/daemon that you run (from udev?) that:

- "grabs" input device with EVIOCGRAB
- does the debouncing/filtering/adjusting for the dirty sensor
- reinject events back into kernel with /dev/uinput

It will add some latency, but should be workable.

Thanks.

-- 
Dmitry
