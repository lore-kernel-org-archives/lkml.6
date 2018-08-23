Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF42C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBACE20C07
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gfcuGE0P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBACE20C07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730754AbeHWON0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 10:13:26 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51941 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbeHWONZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 10:13:25 -0400
Received: by mail-it0-f65.google.com with SMTP id e14-v6so6921715itf.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 03:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pDsa1D0GHWImQiPClgu6fgdXGYxc9qb+28eAca3UEqw=;
        b=gfcuGE0Pr5fGtlkDQGCTMDzmze5NxV8uJIiHUWlkliiJ+6YBq7ZhkpSvt1W9NoZuLc
         2DmxJhRctb1/jgE/LntwsuAaW9CwrIxtRdUrGE0uEaw6icbmNRGB8uJ8+gCG/1Eza25o
         ct74tlfYD1RhCJZ1T3wvUx/i3/6EYfKlkw23w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pDsa1D0GHWImQiPClgu6fgdXGYxc9qb+28eAca3UEqw=;
        b=f5RKlnz6p/Kvpm5H9DuSBfxnpCPWb2YJ6QjQKxIxDdeuQqPITci6zvf7aaeh6qa3mt
         nTqiH/7A0Vhth7frXR25SIDZlw+K40wsqcPBkWa+Mv4KqOalSCrPl7NmN++jJABi0nFU
         teDF5o1AIy3PFdpXu/eRxqFCsGyFsVWEhn7Ozb4x9QK3CAzlPekaN+Kxp+9wLlM/Mpr2
         O9+bYoxok+yt0thCUkIWsL13uFNkQ70EazpxLIBDgEhr/HSlEcZ8YHQhAw9iidDNzzu2
         F+C2AKpWyNAAsbfQ/5ohZEGmDRTFT0LJ5lCBGuIwqUKUN/AGudFkJicdQYU9ys6M7QB5
         oAYQ==
X-Gm-Message-State: AOUpUlGgrunVR73uQj+KrpW8ib119zS26dQ2v6k7df579lJnDkzCt9FH
        VlnjGA8/8Go/4s2i5fBMWjTsXuwB0swq11qvcjboiQ==
X-Google-Smtp-Source: AA+uWPwKjp42MLammhehSmnhp8CxXGMRfmGZ2UJZk3jZGTifjeoa6Nh5DUroXd+Bzr2qCxCV99Kb3EauIXe3cjgg3j0=
X-Received: by 2002:a02:6c45:: with SMTP id w66-v6mr52171230jab.87.1535021058900;
 Thu, 23 Aug 2018 03:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180820181333.2527-1-jmkrzyszt@gmail.com> <20180820181333.2527-3-jmkrzyszt@gmail.com>
In-Reply-To: <20180820181333.2527-3-jmkrzyszt@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Aug 2018 12:44:06 +0200
Message-ID: <CACRpkdaEahLO=z4TxyNfUNOqnTvQWsTzvd-HEciZWX57tQ5-mQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] ARM: OMAP1: ams-delta: initialize latch2 pins to safe values
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     ext Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 8:12 PM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Latch2 pins control a number of on-board devices, namely LCD, NAND,
> MODEM and CODEC.  Those pins used to be initialized with safe values
> from init_machine before that operation was:
> 1) moved to late_initcall in preparation for conversion of latch2 to
> GPIO device - see commit f7519d8c8290 ("ARM: OMAP1: ams-delta: register
> latch dependent devices later"),
> 2) replaced with non-atomic initialization performed by means of
> gpio_request_array() - see commit 937eb4bb0058 ("ARM: OMAP1: ams-delta:
> convert latches to basic_mmio_gpio"),
> 3) made completely asynchronous by delegation of GPIO request
> operations performed on subsets of pins to respective device drivers in
> subsequent commits.
>
> One visible negative result of that disintegration was corrupt keyboard
> data reported by serio driver, recently fixed by commit 41f8fee385a0
> ("ARM: OMAP1: ams-delta: Hog "keybrd_dataout" GPIO pin").
>
> Moreover, initialization of LATCH2_PIN_MODEM_CODEC still performed with
> ams_delta_latch2_write() wrapper from late_init() is now done on not
> requested GPIO pin.
>
> Reintroduce atomic initialization of latch2 pins at machine_init to
> prevent from random values potentially corrupting NAND data or maybe
> even destroing other hardware.  Also take care of MODEM/CODEC related
> pins so MODEM device probe succeeds even if latch2 GPIO device or
> dependent regulator is not ready and CODEC can be reached over the
> MODEM even if audio driver doesn't take control over
> LATCH2_PIN_MODEM_CODEC.
>
> Once done, remove the no longer needed GPIO based implementation of
> ams_delta_latch_write() and its frontend macro.
>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

This should turn into a nice pin control driver some day.

But until then, this looks way better after than before the patch,
so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
