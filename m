Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7E2C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526912082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tAQsFzPy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 526912082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbeLEAxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 19:53:04 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45488 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeLEAxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 19:53:03 -0500
Received: by mail-pl1-f193.google.com with SMTP id a14so9147892plm.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 16:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=ATCg9fvTUzVSYrKq8MWA0GV6b6vl2SbhBcgVyZ2mmJs=;
        b=tAQsFzPya0J+e2ukEg4itkrdH8qkWF0z9Gp/TYbIQt0/6MXiT016uFFucX6OrgqwOZ
         J9DImptrsXJ6CAU8ywDio9+/5utflAcvrPBgCCdOMZJUSPRqtmFRozv2cj3e8lMwf4xv
         Eb8jHkb5aaoOT7unz3jUEwFP+wNyJEotQ3OHWKrUgwJv35mMJoh5OlGY7JSZCCsWssMY
         Wpy0K/fvyi9PhG/Zm9SLKxrg44tNKtEAFmf35z0Upmd4yDrbztHpMb1DkMGQ4x4PVgER
         hJxRnhMHqDI3Vzeww6ZaCM3NYZDEfFhjmCpttc44D5KT4/+rAyAU0VAPJ5aHsXxrmiFU
         xzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ATCg9fvTUzVSYrKq8MWA0GV6b6vl2SbhBcgVyZ2mmJs=;
        b=f2bhQtwx/S5bC5heaFpKCeKkcSMgrK/b7KSWlg98SPlb0g8RHZigz6CcrJZ/8vqPFu
         fpnuXJVRYdEz/1rGFCaz8gF3jD64FRHHG4rB7zRUp7dLlmleSckxWUYSIg+TRgW/MPGP
         8lMMJ8v+hwSXducuBbeehjc/hUMT2eOnoSgbX+N1HCmUo7sZxvXOeV5c4891Nc1JV66X
         L8D3O1Td08unZYY+PcOxX1pFGOk3k0lU7bCYMWlJgWIP4o8CjWD0I+E/BuWAbLHKq7iy
         ej8sALBkgKs8FAeZtUHvrVhV4DCgTIxaMTL9GlhAmrRJ43pS8J+YSejT+qOHYFNB7Xl3
         0ihg==
X-Gm-Message-State: AA+aEWZIKhmo20Q8sQqzCQZADOehYXkHerISXNzfLFYRDWhF4r7+cv38
        zzQbuu2Sr3JcFjErDKOm3IVEJQ==
X-Google-Smtp-Source: AFSGD/U+vln/sVxNumAskd/VD/c9RRfiNGiP38FroUtKg1M+ksNzRjyECAPyB+q7y7lBh+sGHxQP+A==
X-Received: by 2002:a17:902:2862:: with SMTP id e89mr22501733plb.158.1543971182845;
        Tue, 04 Dec 2018 16:53:02 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id 6sm25011955pfv.30.2018.12.04.16.53.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 16:53:02 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, carlo@caione.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 0/2] ARM: dts: enable CPU frequency scaling on Meson8/Meson8b
In-Reply-To: <20181129230044.21358-1-martin.blumenstingl@googlemail.com>
References: <20181129230044.21358-1-martin.blumenstingl@googlemail.com>
Date:   Tue, 04 Dec 2018 16:53:01 -0800
Message-ID: <7htvjsbxqq.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> This series enables CPU frequency scaling on Meson8 and Meson8b. On
> these SoCs all CPU cores are using the same clock, so all cores will
> always run at the same frequency.
>
> On Meson8b this is pretty straight-forward by taking the frequency and
> voltage table from Amlogic's 3.10 vendor kernel and converting it to
> "operating-points-v2".
>
> Meson8 (which is inherited by Meson8m2) is not so straight forward:
> The 3.10 vendor kernel contains two frequency and voltage tables with
> different voltages for the same frequency. It turns out that this is
> due to the design of a specific reference board where the output
> voltage of the regulator is limited. This has nothing to do with the
> recommended voltages of the chip so this adds the "operating-points-v2"
> which are used by all boards in the vendor kernel except the special
> case.
> The two fastest (clock rates: 1.8GHz and 1.992GHz) operating points are
> causing my Meson8m2 "M8S" (not upstream yet) board to lock up hard with
> instruction errors. I'm not sure if this is due to the poor design of
> the PCB (the LED is getting darker when I switch to 1.8GHz and soon
> after that it will crash). Thus I decided to play safe and disabled
> these two frequencies for now.
>
> Special thanks to Jianxin from Amlogic who patiently replied to all of
> my questions about the CPU clocks (without his hints I would still be
> looking at why I'm seeing random lockups when running the CPU off
> cpu_in_div3 or why the udelay is not working properly)!
>
> This is successfully tested on:
> - Meson8b: Odroid-C1 and EC-100
> - Meson8m2: MXIII-Plus and my "M8S" board (the latter is not upstream
>   yet) with frequencies up to 1.608GHz
>
> Dependencies of this series:
> - these patches are based on my other series: [0] "32-bit Meson: add
>   the ARM TWD and Global Timers"
> - when not running linux-next this requires the the clock driver
>   patches which are queued for v4.21: [1] "[GIT PULL] clk: meson:
>   updates for v4.21"
> - when not running linux-next there is a runtime dependency on the
>   meson6_timer from [2] "clocksource/meson6_timer: implement ARM
>   delay timer" because changing the CPU clock requires a small udelay
>   which only works properly when using a timer as clocksource (instead
>   of running a jiffies based delay loop where the timing changes with
>   the CPU frequency)

Thanks for the detailed description of dependencies.

Applied to v4.21/dt,

Kevin
