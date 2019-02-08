Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD842C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C16620863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MkTQf5pY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfBHRm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:42:59 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41849 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbfBHRm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:42:58 -0500
Received: by mail-pg1-f194.google.com with SMTP id m1so1874481pgq.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 09:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=8qlp/xAnLxAOjV4wYTNej8P4AqA27Ps7vMX0JSJoLng=;
        b=MkTQf5pY+FM2kNGLWUDj92xIebBxnlOjXVjgquZYYNsfaX3ahhiBc48k/QjE0oorjR
         +Qhx/V3+sTFwZwhEjrpwvGCPIcWnFVo+/SdNOB5wlUUURsfdSDPoW4SGHvQHGuuqTX34
         xYEGFFk2wSYsTdF6uwwHx9OAsZFo04c7O5nd6pdQUlO0FxXM7K9nFYOWhlWO8PtlrVDr
         +nM0lyIWIHYEza751xg34Ud2fGbssXO9Yh9p9PAr4xw2PEDa1FQRJ8sSGhAm2zyencT2
         QLEy8IjGtzFrobWfD3EVdGCUtEJCFejSjCzjG29Ulkv+6uNSp8Z91vjaA3lr6TNrN3Px
         olDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=8qlp/xAnLxAOjV4wYTNej8P4AqA27Ps7vMX0JSJoLng=;
        b=cvJoyFkXgrFP5YH9RjiXADtE0xiYfYMUgq5N7GRvCBS3119ekVGMPrLX7Xh+TKGU8p
         vaJJoKasizUZz9QZzM7RKx2QxSjOJEv0+SE4XPn1U5unR+FAivDbguZL1yZN1bAZU6m5
         t57n4CpJWY6WZS1RpLS1E54QIUrJV9O5j+A2qxwDYUMvRdHevZIza97w94fENBdI9eLi
         h0k4uXCmunVacH61zmxej395T/de0C7tFPHn9hQhr+z7eTpCcFi4bbo+jNbQQmn40B9e
         g5xbtxpdjYGIYeBS6jmX9VhU+U0elNrvKlsJZVENTwdEUnA1ab0f+a/YeCDUWXUwTmx2
         51SA==
X-Gm-Message-State: AHQUAuZbCqqDwgtmkrQLzeyzcjG8MBJgx8Bu/iTwnxUTCRTKZs9+zk/P
        ccFbDdK5nKcKxZzyDom+R+p3Jw==
X-Google-Smtp-Source: AHgI3IbEMM+ggW03aYshu3UHusVMXPCZA+pNgaJy2Yeg2QaRHGd5A6XRwRSkf3NZE4Uho3P5QdJsxA==
X-Received: by 2002:a62:ca48:: with SMTP id n69mr17099411pfg.162.1549647778039;
        Fri, 08 Feb 2019 09:42:58 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:551b:c3ab:6b62:8b9f])
        by smtp.googlemail.com with ESMTPSA id b26sm3844333pfe.91.2019.02.08.09.42.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 09:42:57 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 2/2] arm64: dts: meson: g12a: add peripheral clock controller
In-Reply-To: <20190208101405.25699-3-jbrunet@baylibre.com>
References: <20190208101405.25699-1-jbrunet@baylibre.com> <20190208101405.25699-3-jbrunet@baylibre.com>
Date:   Fri, 08 Feb 2019 09:42:56 -0800
Message-ID: <7hh8defa73.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Add the peripheral clock controller to the g12a SoC DT
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Queued for v5.1 (branch: v5.1/dt64)

Kevin
