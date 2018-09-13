Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB64C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 04:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A04DA2133F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 04:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="N0wbS42/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A04DA2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbeIMJyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 05:54:01 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45646 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbeIMJyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 05:54:01 -0400
Received: by mail-pf1-f193.google.com with SMTP id i26-v6so2068385pfo.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 21:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=v679wEkTWuw1bDkM38sFovCouTCeI23ukEc4xMtgolc=;
        b=N0wbS42/4DQIuFxPvjl63n1YUcu7s2VIWbPrR7Wwb2qBNsYZpcvnJpl4Ymwf20sQ5q
         5ZpotMi/cE7T4xfZYuBigd4KoekuynYKxkAGJW9dytjlwc13OcCCuG2WydyiXfkkus6R
         kLPB5QsQB7SvcgA048S/nbtMNcd+dz4juNfsIyOEcfOJC88nKbykTaPeVZacskDrawqk
         tOzqdLVPrU1iENGmh6JI3AbXfBwwp34L5U1SyNQaLS69YEAQbftXy/RKUOz7x5240XE8
         6y7xqYlNhueJEJl8zko/NZhINTDkPI9GgEgMZivJoMAe/tr01B8lJfOMVp7RbeefHKBQ
         tv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=v679wEkTWuw1bDkM38sFovCouTCeI23ukEc4xMtgolc=;
        b=OypXA8gGhxXuSlLrBGZiI7REHNsGiWuUN71unQibRV5crFdB551nqNuiexBpytraYN
         avRmaXUb5zskUHpy5xduhYHD5+vBQS5cZsjsOyBoBkV9HYt3VnbCJHNAhdJJ44in7Hwv
         vOVW3WTZg5rl0M7b4A4dgUROO/LgmzpG7wyRYbXMlxfW1oFpQoUUgHUEwFaA1tCHRp4D
         AnrYfi/GJEjkkbgNbHoSl1GbrDAI0HAqhECUaKzinTU4hHUrPsWJcpp2500AWXcqWVLl
         lCWcDx6COv73I4Nn/x0l0HOjO0rYDzeygIUTdiRxGso1habugwXIzpW5tOltaETmSATf
         RaBw==
X-Gm-Message-State: APzg51CYyeUGfMJX84apojNNCFPhmDp4ROoKQ9icvnFoH7mmFoZMUh8/
        LHHSZ/yWX1UliDc7qn10McMBCw==
X-Google-Smtp-Source: ANB0VdZMzXyp6Xkf4zwvFeiCvn9nn7tp1yqCBUQVlO/5w2wv8nuBPNS/gtfr/EYQ2sTyPdvF6TFpSQ==
X-Received: by 2002:a62:455b:: with SMTP id s88-v6mr5436349pfa.203.1536813975787;
        Wed, 12 Sep 2018 21:46:15 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id q25-v6sm3657417pfk.96.2018.09.12.21.46.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 21:46:15 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Maxime Jourdan <mjourdan@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] soc: amlogic: add meson-canvas driver
Organization: BayLibre
References: <20180823114954.30704-1-mjourdan@baylibre.com>
        <20180823114954.30704-3-mjourdan@baylibre.com>
Date:   Wed, 12 Sep 2018 21:46:14 -0700
In-Reply-To: <20180823114954.30704-3-mjourdan@baylibre.com> (Maxime Jourdan's
        message of "Thu, 23 Aug 2018 13:49:53 +0200")
Message-ID: <7hr2hyvwbt.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxime Jourdan <mjourdan@baylibre.com> writes:

> Amlogic SoCs have a repository of 256 canvas which they use to
> describe pixel buffers.
>
> They contain metadata like width, height, block mode, endianness [..]
>
> Many IPs within those SoCs like vdec/vpu rely on those canvas to read/write
> pixels.
>
> Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
> Tested-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>

Applied patches 1,2 to v4.20/drivers and added an
"amlogic-drivers-canvas" tag as requested.

Kevin
