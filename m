Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE5AC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CADE320878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="atG+wfkN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CADE320878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbeLEAvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 19:51:36 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45898 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbeLEAvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 19:51:36 -0500
Received: by mail-pf1-f195.google.com with SMTP id g62so9083197pfd.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 16:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=/UOZRCzp8o93LV/zBJgnh/YA7nPwCovq44EnVRi0VQY=;
        b=atG+wfkNdf+yFgbTamkezUr5E/3chGK32+6EPmHxG/HvbfrJLvroV9tPEcVOgDQsdm
         SQPCymQuZucruHUujK9LHSXCHnR2wLoaCUf2zC7f1iDuz5O4vDSHZddVYs3CZVEoTTtt
         Y9SQ4YA3Lu40lr8gCbYYPn4KUXCS4KTKI3qEYSfbF7tRQ53Cg2JaUpdYYqF8RhTmBzUZ
         5gdiw3kfQMtlX25h1z49bgBCNX7JuPe7NkoYGjj0/7l+ZXX3lw5s/3wNtwujqNJvzaEJ
         mQJPsTYZEhqygYetY7AW1D1WVwjAp3pqMPxlXGrymvypOP+px9ATqxGhK8C3lIa80TyX
         H1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=/UOZRCzp8o93LV/zBJgnh/YA7nPwCovq44EnVRi0VQY=;
        b=IzOnJuPFD5Tn9/bte2ZyE9pqqiJ9ozv80Hr2SIb5yd1YqtGGgVF/BAQqWwMPgXfrrh
         IujjWbn4jX7sj/B3GNTLZvyi90oor7HCgHO/U/irAsoLo5TTLOei9zjmZGEGalNruJ7r
         XAVtYEzF/uGff1IBEWNVAtGiOfAqSiPMKG3QJp4rjYD5M8G68GqLYwnmh58FUsOktTQV
         HiV0JYr/boVAwTJTUdefjdmi65Q/g7y/718I6HglvDps1ui/FuiET7wT3mTrArPzZD+4
         dx26Q5OOcXphRcrXrV7x/I6wY0A2ulEqcD1bmsLPx7BhH9ZpZI4OH/qZc6xow6JNT/Ut
         ggdw==
X-Gm-Message-State: AA+aEWbXZiSLldeuL8la+ZizKVkmy2PifntboQmLKxGchVaEu9fcvn19
        bkkKJbrxdtX3ADzKuo/LE1MsJw==
X-Google-Smtp-Source: AFSGD/Xqk7EtQdo6NJyHGtu0xUA/IzsmeksJ8+xYl7i6kJxHa6KU71T1CpLnd0HHoWdqrPHaN2jLlA==
X-Received: by 2002:a62:d0c1:: with SMTP id p184mr22113582pfg.245.1543971095199;
        Tue, 04 Dec 2018 16:51:35 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id r12sm18045914pgv.83.2018.12.04.16.51.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 16:51:34 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        carlo@caione.org, linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 0/6] 32-bit Meson: add the ARM TWD and Global Timers
In-Reply-To: <20181123195311.4578-1-martin.blumenstingl@googlemail.com>
References: <20181123195311.4578-1-martin.blumenstingl@googlemail.com>
Date:   Tue, 04 Dec 2018 16:51:33 -0800
Message-ID: <7hwooobxt6.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> The 32-bit Meson SoCs use Cortex-A9 or Cortex-A5 cores. These come
> with the ARM TWD ("Timer Watchdog") which contains a timer and a
> watchdog as well as the ARM Global Timer.
>
> This enables the corresponding configs for the 32-bit Meson target.
> Additionally this adds and enables the ARM TWD timer. The Global
> Timer is added but currently disabled because it's clock input is
> the PERIPH clock which is derived from the CPU clock. Thus the rate
> of the PERIPH clock will change when changing the CPU frequency.
> Unfortunately the Global Timer driver doesn't handle clocks with
> changing rates yet (unlike the TWD timer), thus we keep it disabled
> for now.
>
> The whole series is inspired by an almost 3 year old patch from
> Carlo: [0]
>
>
> Dependencies:
> - I build this on top of my other series "ARM: dts: meson: add the
>   timer interrupts and clocks" from [1]
> - CLKID_PERIPH requires updated clock driver headers. Neil provided
>   a tag which includes the updated headers: [2]

I pulled this branch into v4.21/dt

> - There is no runtime dependency on the PERIPH clock as we don't
>   have CPU frequency scaling support enabled yet. In case the TWD
>   timer driver can't find the clock it falls back to auto-detecting
>   the clock rate at boot time. This is safe as long as we don't have
>   .dts patches in place which allow changing the CPU clock rate. Once
>   we enable CPU frequency scaling support for the PERIPH clock becomes
>   mandatory so the TWD timer driver knows about changes to the PERIPH
>   clock (which is derived from the CPU clock).
>
>
> [0] https://patchwork.kernel.org/patch/7797581/
> [1] https://patchwork.kernel.org/cover/10687005/
> [2] http://lists.infradead.org/pipermail/linux-amlogic/2018-November/009136.html
>
>
> Martin Blumenstingl (6):
>   ARM: meson: select HAVE_ARM_TWD and ARM_GLOBAL_TIMER

Applied to v4.21/defconfig

>   ARM: dts: meson: group the Cortex-A5 / Cortex-A9 peripherals
>   ARM: dts: meson8: add the ARM TWD timer
>   ARM: dts: meson8: add the Cortex-A9 global timer
>   ARM: dts: meson8b: add the ARM TWD timer
>   ARM: dts: meson8b: add the Cortex-A5 global timer

Applied to v4.21/dt

Kevin
