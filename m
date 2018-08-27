Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0112AC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 13:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CBF7208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 13:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="HpwNJFJr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CBF7208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbeH0QrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 12:47:09 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40090 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbeH0QrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 12:47:09 -0400
Received: by mail-wm0-f67.google.com with SMTP id 207-v6so8183284wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 06:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sb4/AWzdKvM6iRbBBSj3/YDBYT2AMz9P/Ug3Zl18dZM=;
        b=HpwNJFJr4gkZxIjS6M1LLAdffaELLKRzVAPudHs7wgkWRTqx9AhtOeLycsNVvnQ+Fe
         HZ10s5H56k1+CUvtLQROtduvfcnMHlaaiZDUomwCGrmdnRaWFFXEh5f2JEa/EhdHEVr3
         uscRU0D9fTgxC0JU68qMtvah4IymFBrBP2mq5y/RKJ+/iciSWvlKOdAhqJJmcyojqBVz
         rX4rrp9oFvmF0XDEcmer43mUxGM6Org4a7qOY2nfqykMqYtf1dqP7Yd1JU8axC2R2xmO
         psIEr2C2n0V4mze1RkYqe/P3u3ffeX9Gp41T7CkB4GhrS2zTvI8c0aqJ29l9hUlFQ3wF
         ACAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sb4/AWzdKvM6iRbBBSj3/YDBYT2AMz9P/Ug3Zl18dZM=;
        b=quq67YjDyqh2iD1ygYH2U/R8xUMvIEjBPKwp/2aJczfVf83itC3QC8yrjjd3Dxy00u
         g52NsE6TXFPo9wM1bpI62Nrc3NsqefM1mTLYjqtxyr45FQKmkQ0Qj2E0goGUxzjBnLJQ
         e7UHw/3BE9828jwRzDvVgDAvyN4qmD/k7YO20uSjqtpRImyTj3hqQfDdHNUy1MozQRiZ
         3U/0t5FukTSe4E+ft1bXVqXjFskZJIyafPSyD1sXlntd4giDWFH2b9zDK6AcLAECS540
         DSW9+xi1NNFSSPCHXUiFtsSKzLVXUF0k8OaL/48DhLeMO00k5falR64DPw5dzZE8wuf7
         FFhw==
X-Gm-Message-State: APzg51BKNoaYm2VEelIzHQGcJ8Tdt04b4M/L1XUWBnqEb/5FOqSiJKis
        AeOpTl71Jzn+94qcdMsTwudvyA==
X-Google-Smtp-Source: ANB0VdYVlKOIcZu3zn65kJGRJm+japxkUNItOmkKrHJAS9zPax2zkt//i8YTCfi0F9IRe5STd89Wpg==
X-Received: by 2002:a1c:7915:: with SMTP id l21-v6mr6012418wme.136.1535374833878;
        Mon, 27 Aug 2018 06:00:33 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f132-v6sm8985829wme.24.2018.08.27.06.00.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 06:00:33 -0700 (PDT)
Message-ID: <fbdc7304e8864ce35f27de2d932ccdc661187dbe.camel@baylibre.com>
Subject: Re: [PATCH] clk: meson: axg: round audio system master clocks down
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>
Date:   Mon, 27 Aug 2018 15:00:32 +0200
In-Reply-To: <20180801140732.27671-1-jbrunet@baylibre.com>
References: <20180801140732.27671-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-01 at 16:07 +0200, Jerome Brunet wrote:
> Some of the master clocks provided by the axg audio clock controller are
> system clock (spdifin and pdm sysclk). They are used to clock an internal
> DSP of the related devices. Having them constantly rounded down instead
> of closest is preferable.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/clk/meson/axg-audio.c | 34 +++++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 11 deletions(-)

queued for 4.20

