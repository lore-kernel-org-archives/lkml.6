Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7E6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4113D2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="OKXttpWb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4113D2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbeKPGf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:35:29 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42434 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbeKPGf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 01:35:29 -0500
Received: by mail-pl1-f196.google.com with SMTP id x21-v6so7280511pln.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 12:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=hFHmqlOhwEXPiteLEEZz3I5geyjml97w+xJAC4X39BA=;
        b=OKXttpWbM9r+W2rjhvoxqEbspYMmoG7kYBrjW4fQQy1hCrN9jW8K2h5G2RT0jLmzx/
         CB13IiDn33McFfpGns/ff6XPa8Mnehqb5LAgew1tPi6L56+eUgHBEJR4ZhjDty36JKI7
         l+K3kxtaO6Ao5pzJ7PqbvEgQ4xvXjV/6D4YH/P99ykxxX2sha0/KGcz7QVYsSqljCw+t
         FaPlav3rI2qnani71IgiWFfvb3XInAIXNq9ebfOCsAB+S/XdJ3ZqqVX/0sFxVG+mzxZf
         +7QGtkNI6rgNK92b3YIcRLgPbmyir3oqRfSLukSi4AOjAWZ4UvjlqQMGk3GdXsm+HcMg
         QFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=hFHmqlOhwEXPiteLEEZz3I5geyjml97w+xJAC4X39BA=;
        b=okUBsLtiNCNCU+2GGGr/rBrykhnMLnjRxrrecFBZuPBRxj325P+mrwLCYjfssqQb/K
         aXNDT4bbZ/DteT13Iwcag9veny/McaeuTc27Y6W9SEkA16zajuZP6obyTtGe9eOZ7p8E
         w6O2XhxPQU6ZD23GCc0cAw6IpKzo2AUKjDA2pFP3Qpr72zP+VsnKfo0zp7iyKZdilZ/R
         qXnKLbt7W9q0w9QWJ3vOukrrSPX2IN1SgszlksBRmJ7VWIAWEAigsOusWHc0mImP/Ti/
         LqwMDVN35LVPkK9p40Z+vyQaXHqelc03VI4UH2jUWJP73mkzC2yN6F0e9l72C5LHWpCq
         3VtA==
X-Gm-Message-State: AGRZ1gJKXygmx5c6Jyo3Xe4kG9rEPRcu90lkcyKu3bhz6EAZ76WpInJ1
        4zHOmoeKM/OIb2ThqtzZ5vQ+fA==
X-Google-Smtp-Source: AJdET5eX8kHkouoanTpYetZu/uqdjbiWJgS1FL48Vw2CnYyJDQZgZi7o2m5WO7isJqnKUATgY7CP+Q==
X-Received: by 2002:a17:902:6bc9:: with SMTP id m9-v6mr7944951plt.106.1542313569714;
        Thu, 15 Nov 2018 12:26:09 -0800 (PST)
Received: from localhost ([107.181.189.87])
        by smtp.googlemail.com with ESMTPSA id p11sm21415480pgn.60.2018.11.15.12.26.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 12:26:08 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Maxime Jourdan <mjourdan@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH] drivers: soc: Allow building the amlogic drivers without ARCH_MESON
In-Reply-To: <20181112164654.28594-1-mjourdan@baylibre.com>
References: <20181112164654.28594-1-mjourdan@baylibre.com>
Date:   Thu, 15 Nov 2018 12:26:07 -0800
Message-ID: <7h7ehedr4w.fsf@eze.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxime Jourdan <mjourdan@baylibre.com> writes:

> The current condition makes it difficult to compile the amlogic/
> drivers with COMPILE_TEST, or without ARCH_MESON in general.
>
> Fixes kbuild errors with patch series that depend on drivers in that
> directory, for instance the meson video decoder.
>
> Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>

Queued for v4.21 (drivers: v4.21/drivers)

Kevin
