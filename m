Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BADEC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 21:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 019CE20846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 21:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BbbkrOl3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 019CE20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731610AbeGZW4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 18:56:53 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:36573 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730701AbeGZW4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 18:56:53 -0400
Received: by mail-it0-f65.google.com with SMTP id p81-v6so4735851itp.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 14:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=PSBPX7CaML4andwkgo8gxRGjI2EvdpddWXcO9glUro0=;
        b=BbbkrOl3dQRmhzejkvop42/aXmS0AJhvFApiUlVMotUDItLk1vFKyGMCafi3bO76Nj
         xqo5NeKUNB3syOTSHufykGmjF8NkRFRlRvdOaqYR6fgRfnfL05EGfHO5nkix3IFkmbhy
         wUmRrJ/8n/NzQDolEZxyDiAHr1RJKw8XpPUDffSQ1bA5YVAPtkyFFP8n6X8eJv0eVPrS
         3Lza5OKn7nJ6xYv1TalmFXFLIDyQ3o7YX8tr8CoGG1ag7L7c0hEnFloZZj6vdS2pXrYr
         1UOPvV366XEbY3bjR4Ye087JSyX033+3F5x4P1b6UUNbxPTQOQfGtCzZNdfcX5lcS19r
         i8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PSBPX7CaML4andwkgo8gxRGjI2EvdpddWXcO9glUro0=;
        b=YCjieJyIkf3ugJNM4ht5XT+FSeatG6JF6eivpyZcBPBRDYCsY8EWaZrd2ry8MpdMDD
         e8Xv/5LMc9Mmj8FIctNMCDtPunno5OX5av93j7IG88/FWu86YHkgzz4keq8ftgNVfq8a
         cUX88if1D5qAPao52+itXFW5zHixoEnNN+GrdtPYbpbYdYlKBywLFPaZn8ErdD7AslgJ
         52Hcy24HG8+Lu+OZ1JvTj3lMQjhANKa5fmV/VbwJ0rWBNgjgNR+dNiinuEWlc1bvpqrV
         qy55dFzfO5DsCAJNnMrlzIKgDKLUFMfh5y+fVm4TmqanNQlAXiEuqGZphMXx0FDv3pxT
         DaQg==
X-Gm-Message-State: AOUpUlGuQRPSCyi7WK+sYWkBVcEB6vJk9bc9iNFN+Okglxh2GaVuG49C
        p++E6jVd3lM0zlm6WkvFNaT1Og==
X-Google-Smtp-Source: AAOMgpeF7ucoTBlii8crsHTmqgi026nA6mZHDQwW9+/d2kCyo8dPNxRhcR8nClnqRkg/Ugzm40g9CA==
X-Received: by 2002:a24:17c7:: with SMTP id 190-v6mr3139209ith.99.1532641091195;
        Thu, 26 Jul 2018 14:38:11 -0700 (PDT)
Received: from localhost (c-24-118-241-30.hsd1.mn.comcast.net. [24.118.241.30])
        by smtp.googlemail.com with ESMTPSA id m140-v6sm1368691itb.11.2018.07.26.14.38.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 14:38:10 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     jbrunet@baylibre.com, carlo@caione.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/14] arm64: dts: meson-axg: add audio support
Organization: BayLibre
References: <20180724125238.14567-1-jbrunet@baylibre.com>
        <CAFBinCBh-b=ie4hBMWdHG8KoLQ7qiRfo8vXfJ1PRcN4UPtg+uA@mail.gmail.com>
        <705e31bf0d978b7d356b2f077179ab0e3db6f092.camel@baylibre.com>
        <CAFBinCB_fULnmrpyzNwnfAiL9QGco_6QW957Wroj8o6ZhNwmWA@mail.gmail.com>
Date:   Thu, 26 Jul 2018 16:38:10 -0500
In-Reply-To: <CAFBinCB_fULnmrpyzNwnfAiL9QGco_6QW957Wroj8o6ZhNwmWA@mail.gmail.com>
        (Martin Blumenstingl's message of "Wed, 25 Jul 2018 23:26:27 +0200")
Message-ID: <7hfu051xvh.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> Hi Jerome,
>
> On Wed, Jul 25, 2018 at 11:19 PM <jbrunet@baylibre.com> wrote:
>>
>> On Wed, 2018-07-25 at 21:11 +0200, Martin Blumenstingl wrote:
>> > nit-pick: one patch uses "arm64: dts: meson-axg: s400" in the subject
>> > while other patches that are touching the s400 board aren't
>> > if you have to re-send this series: can you please use the "arm64:
>> > dts: meson-axg: s400:" prefix for all patches touching the s400 board?
>>
>> hum, do we really have such rule, or do you think we should add one ?
> looking at the git history in arch/arm64/boot/dts/amlogic: it seems
> that we don't have a rule yet, even though some (some of
> your's/Neil's/my) patches were using that naming schema in the past
>
>> Kevin, do you have opinion ?
>>
>> Not that I really mind either way, but prefixes rules are usually there to help
>> maintainer filter the patches. Will such rule help in any way ?
> maybe it's just a problem of a false initial impression
> I read "arm64: dts: meson-axg: add usb power regulator" in the
> cover-letter and came to the conclusion that this patch must be wrong
> since meson-axg.dtsi should not have any regulators (unless they're
> built into the SoC). only when looking at the patch itself I realized
> that it's fine because it patches the s400.dts

I actually had the same first impression problem.  At first glance, it
looks like all the patches are AXG-generic, and only the 2 that mention
s400 apply to the board.

So, if this needs a respin, I'd prefer the board name where appropriate,
but it's not something I'm going to be picky about.

Kevin
