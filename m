Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393D6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5D520645
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="13YBk+uc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC5D520645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbeK2MA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 07:00:59 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44924 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbeK2MA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 07:00:59 -0500
Received: by mail-pf1-f193.google.com with SMTP id u6so110013pfh.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 16:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=THBTvBGq/5r8v7mz77f8959rFZORCPCYNlrfbnJ5iD4=;
        b=13YBk+ucYtoyc51+Ap0JsI6pM4R47eXaQclgr0Pe6OeqE2i/i1VWPhfOYHdKFCMRbT
         PB62Ap9Snw9H8vDBjZZtA0/TBEVSFw6EloLY8q3lRaud18hM3MyRjlIF6TmAKNyPl8Vt
         K+kQI7ZaZMR4lUJAIDkWYXDi8eA0eHa1y7ja0sjOsgetssddbdWkv432thtKdOTCPlU4
         s2bDZOsIWVephuexexP6E0BhFzmNau7GOokJNmWlOsH2eABhSfdK0cyXXSV6amDsZLQE
         sSPbIFQAan8vCijLcOsQn5TIRGj2l4bWNXWWC7zcqfeTHrGkTnb3a4QbvqI6MOGzEGS8
         eUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=THBTvBGq/5r8v7mz77f8959rFZORCPCYNlrfbnJ5iD4=;
        b=Uyur3KRq+QH5YDeUWkNWVON7XefhQk2+mQE+QmDFXMv4W13L4xN3lDlkh7pLUFr+Q0
         weJwN6fPeZL/UgYV4v82+biPbC0pwuroD8leJsPtsUjKwGn7SUQRgDy7d8twFw2oO9ZZ
         TxV0ZEA0PeEBg3O+tBDgTqZfYehdnZ/MY4zd9Vdxk7fP5MXRg553eQmXr5PKtjTW7WYr
         LLatkPbo1PQTyyVRFET4hb0lNQ2oeHtxAbUecS+XWF6vN1UtwUH687dc+FSNE0/MgWgZ
         OIlgXN4lt7siXQ9t8A0LLZZlR4IwQ5CV4kFasJ6NThpjSlUj9LsuZKXSgauTQglJS71n
         ivjA==
X-Gm-Message-State: AA+aEWZL9iz5yk7wkI9jS8AXsd4oO296WyD4soKspxo3VAUiWqgC+SMJ
        mCQpiZLnMaOM3dmtLpI5TopjSw==
X-Google-Smtp-Source: AFSGD/XElQVP3UUnnX9bIqpoMiRuGJmy9WVSQ+Gh3BxlhABYAfGjhVK9+jXmYah7SIKK3ogvDniSIQ==
X-Received: by 2002:a63:6cc8:: with SMTP id h191mr33812697pgc.366.1543453047593;
        Wed, 28 Nov 2018 16:57:27 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id h10sm168822pgn.11.2018.11.28.16.57.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 16:57:26 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Add Amlogic Meson GX SoC Clock Measure Driver
In-Reply-To: <20181118135024.30720-1-narmstrong@baylibre.com>
References: <20181118135024.30720-1-narmstrong@baylibre.com>
Date:   Wed, 28 Nov 2018 16:57:26 -0800
Message-ID: <7htvk0bszt.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> The Amlogic Meson GX SoCs embeds a clock measurer IP to measure the internal
> clocks frequencies.
> The precision is determined by stepping into the duration until the counter
> overflows.
> The debugfs shows a pretty summary and each clock can be measured
> individually aswell.
>
> This patchset includes the dt-bindings, driver and the DT node added to the
> meson-gx dtsi.

Queued for v4.21...

[...]

> Neil Armstrong (3):
>   dt-bindings: amlogic: Add Internal Clock Measurer bindings
>   soc: amlogic: Add Meson Clock Measure driver

...on branch v4.21/drivers and...

>   ARM64: dts: meson-gx: Add Internal Clock Measurer node

...on branch v4.21/dt64,

Thanks,

Kevin
