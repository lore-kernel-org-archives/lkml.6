Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13238C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D401E20870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="eAA+fV4Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfAWKmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 05:42:35 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44157 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbfAWKmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 05:42:35 -0500
Received: by mail-wr1-f67.google.com with SMTP id z5so1788711wrt.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 02:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version:content-transfer-encoding;
        bh=H25etrGNjxSODoOpRAcSl1GwwR0jQoxSTl7MkAQp0Lw=;
        b=eAA+fV4YKIrp3jwyK1x+hfX7JYQW+IVrfyoOQAJL2Gu3LET5L+6W4Bjv74DKFprQWp
         8apqegkRh0H/CpAahX1eT29AGzxOqKyEeOOdiaNAWBSRf/clsnV3/jP508MVOLx/8bIX
         neql5Xc8bw3diGkC9QSpbchHU9HgXiK6swI6itclCrK0XdCpX5nwYMgtX8/tVx3uWOiL
         89XpTC7E4Euu6K0xMdQbO0i1gS5g/+t+cU4+Ety7oBeOV4aXFynZny07IM3ZrQeyUd7z
         GNhkCqx1SD+U2V3PVFhZFE7fcAdmtqGsjVH0uHOEsJn3Nve7ytbtxpniNbM7DNT6JqNs
         kYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=H25etrGNjxSODoOpRAcSl1GwwR0jQoxSTl7MkAQp0Lw=;
        b=fieGV24JtSQ6zAxmCCVUk1XI2NokxCgTuHrgHg1mr1bxlgUv1yEHB8oY4o9Xqo4GZA
         Cz+7KCx+1s5pUuH1306XJZUmbo95pedAXlbhD2dHN10E1aTEhKfBI+GgFazFinzbMxca
         V/JLEHUfq+xF9+zLrP712WMf35oK4TPZaLXQDyt+nh8bnvPqCjtihLe5PXLtV0LQHZXB
         B452yxZWZT6LQhEJpCocPPyZebYvS36h2WQWt00x+JGXD3QwJJo8+CNReM4zMEHHUigE
         kKRUJyFQFA3Atw8hlUvEwp0IiJ/qkXeMCgh7Q8wtyNTyEbs+wLp0oYsirgj31dNTzLD6
         ZDOQ==
X-Gm-Message-State: AJcUukdoGFbzW7KgnFAiAFYwCsvtglboEjNFyOvMUSrhU+fT07rGNFbW
        zqfHPK5oRzSyMRHXc95DadCr1w==
X-Google-Smtp-Source: ALg8bN7pUoPkWMsOMCZyVFK77sAxZW3/UyzCQuPDTadSsK+YzevQF1uQh/1UUXZGYhJ5SptFvtzypQ==
X-Received: by 2002:adf:e5d0:: with SMTP id a16mr2083681wrn.89.1548240153595;
        Wed, 23 Jan 2019 02:42:33 -0800 (PST)
Received: from localhost (aputeaux-684-1-20-21.w90-86.abo.wanadoo.fr. [90.86.223.21])
        by smtp.googlemail.com with ESMTPSA id u204sm90668588wmu.30.2019.01.23.02.42.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 02:42:32 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 02/17] clocksource: davinci-timer: new driver
In-Reply-To: <CAMRc=McrT4KTW45=3CTBxspVb+z8k=DDjOvKi9NH0aA9eJ8=cQ@mail.gmail.com>
References: <20190111172134.30147-1-brgl@bgdev.pl> <20190111172134.30147-3-brgl@bgdev.pl> <08200de1-fde5-c525-c874-c7872259067b@ti.com> <CAMRc=McrT4KTW45=3CTBxspVb+z8k=DDjOvKi9NH0aA9eJ8=cQ@mail.gmail.com>
Date:   Tue, 22 Jan 2019 16:30:07 -0800
Message-ID: <7hef94z04w.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bartosz Golaszewski <brgl@bgdev.pl> writes:

> pon., 14 sty 2019 o 13:20 Sekhar Nori <nsekhar@ti.com> napisa=C5=82(a):
>>
>> Hi Bartosz,
>>
>> On 11/01/19 10:51 PM, Bartosz Golaszewski wrote:
>> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> >
>> > Currently the clocksource and clockevent support for davinci platforms
>> > lives in mach-davinci. It hard-codes many things, used global variable=
s,
>> > implements functionalities unused by any platform and has code fragmen=
ts
>> > scattered across many (often unrelated) files.
>> >
>> > Implement a new, modern and simplified timer driver and put it into
>> > drivers/clocksource. We still need to support legacy board files so
>> > export a config structure and a function that allows machine code to
>> > register the timer.
>> >
>> > We don't check the return values of regmap reads and writes since with
>> > mmio it's only likely to fail due to programmer's errors.
>> >
>> > We also don't bother freeing resources on errors in
>> > davinci_timer_register() as the system won't boot without a timer anyw=
ay.
>> >
>> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> With this series, DA830 fails to boot. Rest of the devices are okay from
>> boot perspective.
>>
>> DA830 is pretty unique because it uses the same timer-half for both
>> clocksource and clockevent. May be you can set the same configuration on
>> your DA850 to see the same issue? Else, I will enable low-level debug
>> and try to provide more debug data.
>>
>
> I can't boot da850 with the same config as da830 (0x60 compare
> register, compare irq 74) even with the old timer code. Just to make
> sure: does da830 boot fine with mainline v5.0-rc2?
>
>> Some minor comments below from quick look:
>>
>> > diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksource=
/timer-davinci.c
>> > new file mode 100644
>> > index 000000000000..7282a1fda80f
>> > --- /dev/null
>> > +++ b/drivers/clocksource/timer-davinci.c
>> > @@ -0,0 +1,415 @@
>> > +// SPDX-License-Identifier: GPL-2.0+
>> > +/*
>> > + * TI DaVinci clocksource driver
>> > + *
>> > + * Copyright (C) 2019 Texas Instruments
>> > + * Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> > + * (with some parts adopted from code by Kevin Hilman <khilman@baylib=
re.com>)
>>
>> Did you really intend GPL v2 or later? The original code referred to
>> above is marked 2.0 only.
>>
>
> I'm not sure. Should it be GPLv2 only? I'm not well versed with licensing.

I guess it's up to you since you're the author of this new, reworked
driver, but the original one I wrote was GPLv2 only.

Note however that that the choice of v2 only was not out of objection to
v2+ but because I wrote that in 2007, when there was no "+" ;)

Kevin

