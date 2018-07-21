Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F0CECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 20:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534FC20854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 20:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zqBIib/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 534FC20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbeGUVk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 17:40:56 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51944 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbeGUVk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 17:40:56 -0400
Received: by mail-wm0-f66.google.com with SMTP id h3-v6so11951041wmb.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 13:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ugJCCvwqMRhQ7YJEMV3exptme4nw/xVD44+Rlete6ac=;
        b=zqBIib/SbiO81gWimb1KaVev5FgT/GttAAuFClcOlkVAQb6AeBUlS+ZwX1sSjiFqd0
         OIauq/g6Awr+WzD7Ng6d1bChrBcg/It6seMql/Dy8SssTIDOZ/BffzM4nfhQMrIO4LhX
         Z2ty1segP60oN280a3NPQCnX+i1o69n6Cu/yidKBMWmoKsObpaiZFsTWFcAWSUDbQOAp
         2ipkZ4rnvIB/yX6BUUsT2MHDAQtafCXNHIirM0/4GUdtAXjalc299krG6Qa69OdTP0oA
         oAcdqGCZkpQNZwpo2qnxoO5IUDr0IOQr2xTxOsjiKs1rFdH5O1Rw2GUPXieK/QKP/+tf
         wYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ugJCCvwqMRhQ7YJEMV3exptme4nw/xVD44+Rlete6ac=;
        b=maIx4CKF3WbA6LbCufUb2TZf+jV86xJSVKegG7X55Z3IGiQ0U3du/56g2XC6VnOtXO
         jdr2BdBfVltG1gZk+y0PJelElQeEVZZZOUBO3NwdFHVZNuv7e3lea+T3iwL5/iX+l0Af
         nwT59CFp9Fw2sfyYUtoTfm+ysMubA7D1z1/oxRBYrRRTHk/ytAzj3jLquDWJ269aPqE2
         Mp8fJkXu7yGlJZUd562KY3xLZA3urMqJ7RaWgX/jMavPnG6xjxGhpCuzVyhr8x3nm6wS
         ZZZJsR4uAGUg8RNEmWMbD+0KWPSRuUrhQK4u34SgjxA2YxlXzlsPqBXhAqCyfPbvXY8z
         imzg==
X-Gm-Message-State: AOUpUlEAkeLngLz3aCmQtLRc9EjqEhisHWkWOMrT4DdFJdTtGDvknn7C
        8PCwHoC20sOXoPfk9ymqk1eI2A==
X-Google-Smtp-Source: AAOMgpcaG2hygnhI7WTZGEJa/KZIKq0AH/2t54vnOv+6aBX2HDvDQcrVos755PVjA3izAlR4/JCWLw==
X-Received: by 2002:a7b:c01a:: with SMTP id c26-v6mr4308531wmb.33.1532206012653;
        Sat, 21 Jul 2018 13:46:52 -0700 (PDT)
Received: from boomer (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id g125-v6sm5268842wmf.16.2018.07.21.13.46.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Jul 2018 13:46:52 -0700 (PDT)
Message-ID: <1532206010.26720.84.camel@baylibre.com>
Subject: Re: [PATCH 3/3] clk: meson: clk-pll: drop hard-coded rates from pll
 tables
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com
Date:   Sat, 21 Jul 2018 22:46:50 +0200
In-Reply-To: <CAFBinCBc_cFD2ACiSHVuRrXaqSyDnkJb2rem1_k2jwved=QXVw@mail.gmail.com>
References: <20180717095617.12240-1-jbrunet@baylibre.com>
         <20180717095617.12240-4-jbrunet@baylibre.com>
         <d4e5e35a-39e0-fe27-8d27-387c5312ca32@baylibre.com>
         <CAFBinCBc_cFD2ACiSHVuRrXaqSyDnkJb2rem1_k2jwved=QXVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-07-21 at 22:16 +0200, Martin Blumenstingl wrote:
> > We could even add ranges instead of table when we know the PLL supports a well-known continuous dividers range.
> 
> I had a look at the sys_pll settings on Meson8b, here's what
> Meson8/Meson8b/Meson8m2 support for sys_pll:
> - 50..74
> - 76
> - 78
> - 80
> - 82
> - 84
> - 86
> - 88
> - 90
> - 92
> - 94
> - 96
> - 98

Are those values with the same predivider (n) value ?
I suspect the ability of the DCO to lock might depends on its input rate and an
m range

So if n change, it might possible that the m range will be different.

... at least, that's my guess :)

> 
> (I'm providing this info because it may help finding a decision
> whether ranges are good or not. I have no preference)

