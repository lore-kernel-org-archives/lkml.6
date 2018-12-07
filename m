Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53BCC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 04:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78CA420892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 04:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Dj3/cZ/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78CA420892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbeLGEOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 23:14:31 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45539 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbeLGEOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 23:14:30 -0500
Received: by mail-pf1-f195.google.com with SMTP id g62so1258371pfd.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 20:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=P1bt02fANhFdAVD7g2rytmwCWGeqm8IJCrVWqQj7s78=;
        b=Dj3/cZ/iUTq1qZsvfJiGYeThnLz53HSQxl7LM3jpJxURSmG1u5sPjaV9hfMrnqQNDF
         OLIKasCBzpFunMGiD4M5Apc3+JDgzdcqhIZtzjn6lnHiX3/nrQXeBlwuyPPsDC7O/nSa
         wCdz7u/LKUjO/SDuFqlBJ8ZTg47DXRxmpfwIaEm/rjiOD7Y0OuLsump7dFGiRoI0EG2i
         kXteKiHgel3Ta4jIytsWtplWNS9Ds0b+OKvQFNR5RAKQunJAOvtPudKUPakF5P96Jg1k
         mwueBj7CBYLiMxTLA0AfRyQnQwL7cj5NvGzNAPFRQjszsye+mzXgs4iF+/2NgNmEgOiR
         o8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=P1bt02fANhFdAVD7g2rytmwCWGeqm8IJCrVWqQj7s78=;
        b=g+XQZ015F7jRdTv21cwaXRNiUC0szGKz5ND20VpnB+gcIhaK7xJKQI5ni2dFjU0A8I
         FYv50bnyqCMVUp8m9UtCr1Lz6TTU+VeryEDoXNUUIqCwjsuazNcFrxrbBBiyjcHOZ8WH
         Y4dbp1ezXONOQIaUcVmn1Z6Tae28SEGgbzrSM2p3O2F1DX2adl7+y7IOAeRBWosgfmH2
         gYAvi1+f7AvQclNlHDbLjf6d5Tzp9nhmpUee2NwOcRJYx+N94BYd3bDGymR0C9FKq75J
         QJEKvRH+Yn8n6brPpDwSKuYo8zFIKY04q25WuipMp04KkHKaXnkbTqWoyiQG9zScOX6V
         eS7Q==
X-Gm-Message-State: AA+aEWaUclyumhuJBZKGxQx7hBi78nuvR9SrotiDnLqivNMlf1pT1z/x
        NGW/2mE962JCw7KRL8AiPwMON0+kMAc=
X-Google-Smtp-Source: AFSGD/VybCz8JxQe9x0JmayjV9wGDDCoH50TreUVeMuNu6N3kDsDr4uLU4amPeZ2CPDYFfjXa99OdQ==
X-Received: by 2002:a63:4f20:: with SMTP id d32mr641015pgb.47.1544156069426;
        Thu, 06 Dec 2018 20:14:29 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id g5sm3009362pgu.57.2018.12.06.20.14.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 20:14:28 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] mmc: meson-gx: chained descriptor fixup and improvements
In-Reply-To: <20181206151828.24417-1-jbrunet@baylibre.com>
References: <20181206151828.24417-1-jbrunet@baylibre.com>
Date:   Thu, 06 Dec 2018 20:14:28 -0800
Message-ID: <7hva46x9az.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> The goal of the patchset was mainly to address the following warning:
>
> WARNING: CPU: 0 PID: 0 at /usr/src/kernel/drivers/mmc/host/meson-gx-mmc.c:1025 meson_mmc_irq+0xc0/0x1e0
> Modules linked in: crc32_ce crct10dif_ce ipv6 overlay
> CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         4.19.1 #1
> Hardware name: Some A113 Board (DT)
> pstate: 40000085 (nZcv daIf -PAN -UAO)
> pc : meson_mmc_irq+0xc0/0x1e0
> lr : __handle_irq_event_percpu+0x70/0x180
> sp : ffff000008003980
> x29: ffff000008003980 x28: 0000000000000000
> [...]
> x1 : ffff80001a71bd40 x0 : 0000000000000000
> Call trace:
>  meson_mmc_irq+0xc0/0x1e0
>  __handle_irq_event_percpu+0x70/0x180
>  handle_irq_event_percpu+0x34/0x88
>  handle_irq_event+0x48/0x78
>  handle_fasteoi_irq+0xa0/0x180
>  generic_handle_irq+0x24/0x38
>  __handle_domain_irq+0x5c/0xb8
>  gic_handle_irq+0x58/0xa8
>
> This happens when using the chained descriptor mode. If there is an
> error, we call mmc_request_done(), loosing any reference to the cmd. It
> turns out that the chained descriptor does really stops when we do so, at

I think you mean...

s/does really stops/does not really stop/

> least not completly. Most of the time, it can be seen with this harmless
> warning because the descriptor will raise another unexpected IRQ. On rare
> occasion, it will completly break the MMC.
>
> This is mostly adressed by patch #1.
> With this fixed, I took (yet) another look at the ultra-high speed modes
> and the tuning.
>
> I came up with new settings in patch 3 and 4. I've tested them on eMMC,
> sdcard and sdio on the following platforms:
>  * gxbb p200
>  * gxl p230, libretech (eMMC only), kvim.
>  * axg s400
>
> So far, these new settings seems to be working great but I think it
> would be nice if others could test this and provide their feedback.
> This why  patch 3 and 4 are RFT tagged.

For broader testing, I've added this to my v4.21/testing branch, which
is included in my integ branch which gets a spin through kernelCI.

Kevin

