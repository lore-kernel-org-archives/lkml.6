Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFD8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C614F20671
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RjumsxrL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C614F20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbeKTAUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 19:20:21 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35524 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728463AbeKTAUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 19:20:21 -0500
Received: by mail-lj1-f196.google.com with SMTP id x85-v6so26217443ljb.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 05:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nyJMFeKzGUajjEfX/wpcatSc3xPHqoA9cxdS91griN8=;
        b=RjumsxrLbK4I8T83QbPe0YwKlC1MkDY0U8+SWd6knUBvqbEKL0zH1zosn9kTJQJ/IC
         SwaZa7BLnAV18HCMoiPiupGGUZooJ6GtOXjF7ppurWSkhpmJ/O8h0gtAeKdBiAEql+VR
         AyHMyZoOQGuC4nBShXvnhkFqw9wJrX8kJHWgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nyJMFeKzGUajjEfX/wpcatSc3xPHqoA9cxdS91griN8=;
        b=NVmyanFGXJhZ31I4f/ANC45EaT8F4G96CQ5o7ILl32eB/BGpNKqKoC4KRH4i49Ow8n
         5fmFvAbpqTKGzPWv3FUEb6v5UVYWsuh0faNyCtrAMHhG0FYZr+UGcY5GOdoUq/C2wTEx
         gYoay5cGK7Z45b0QWM+9J+OnSpKCMvhxPrtNLpiK9AJM6qNSsYRbXZhfC5DiprkXFMGa
         EGjSVT65+myBSigepPnCYMH2IFcR83MMJvtn5AJDayzHABrmwVDRmVHhO7/7t3GUHw94
         JQ8BmftJ91v+ZmVNUVxWWHH5G5TCgjtz2yW5h9NpOmu14Bh7wKWh7TvOnXbY32cb86DS
         ovAQ==
X-Gm-Message-State: AGRZ1gJ+A7FBzXQx4/B8atLGjMTYPeHLrGU1tU1Zfrls5rhCwKkFtSfZ
        31KBEa3uWCdgXGJGAGKIGRqEiT0arBoNSSc49jdIfA==
X-Google-Smtp-Source: AJdET5ddwKlvaPJt7UHZUXX5S1boRy4+mXpnUT8mR40Oa22AEOReWOHpWWfMKNQ7WdYluLcykz8k+E/KeVEuIF3i8Kk=
X-Received: by 2002:a2e:994:: with SMTP id 142-v6mr9973052ljj.120.1542635798139;
 Mon, 19 Nov 2018 05:56:38 -0800 (PST)
MIME-Version: 1.0
References: <20181115100659.18256-1-geert+renesas@glider.be>
In-Reply-To: <20181115100659.18256-1-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 19 Nov 2018 14:56:26 +0100
Message-ID: <CACRpkdY9ZPj0h5ZHnZsdMBe4o4aQ7dRanU=m6Q+r=5tP-oqYgg@mail.gmail.com>
Subject: Re: [PATCH] ARM: smp_twd: Remove legacy TWD registration
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        viresh kumar <viresh.kumar@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 12:24 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> As of commit 7484c727b636a838 ("ARM: realview: delete the RealView board
> files"), the ARM Timer and Watchdog Unit is instantiated from DT only.
> Moreover, the driver is selected from ARCH_MULTIPLATFORM platforms only,
> which implies OF, TIMER_OF, and COMMON_CLK.
>
> Hence remove all unused legacy infrastructure from the driver.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Good riddance.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

>  arch/arm/kernel/smp_twd.c      | 66 ----------------------------------

Does this driver have some intimate relationship to the arch
or can we move it to drivers/clocksource?

Yours,
Linus Walleij
