Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB57C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8962206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="C9yVQ0Of"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8962206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbeLDXg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:36:26 -0500
Received: from mail-pf1-f171.google.com ([209.85.210.171]:41558 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbeLDXg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 18:36:26 -0500
Received: by mail-pf1-f171.google.com with SMTP id b7so9004108pfi.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 15:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=J8W6G8wiC+Bf49Cl/7FpgmNUuDAPGO3OR5gkvGfaxDU=;
        b=C9yVQ0Of/+fEBvuFBEgt3vD4dRfLGR0SGYfLp0urS/nkns7zTZEbzAlLCoMpgWPAYy
         8lAVP6FOSac0qCx0YUGr8ccLoAfx4/rh3AnCF8pR8kYoKDja7qrMpPAQfK/oxto3gmjL
         LIw7wm/yZ3icDo8Qewx4l6YfpLQj9WgIwAPAFRfvdRPeMjciYXVeJSMCxXhqkJAyhs0N
         KYkFx8rffM1k7gMNyy2gOyQOYEZZy3v0OsXDuTz+MityiLN1vXs+B4K1zPcHgq/zwxot
         VADGRnHSQK6xuCpkLe4iJv0VCLYp0mDMtkcNIXVlsDOsuV7Qw51V2d3E8XoXGRRDzQ3s
         6D+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=J8W6G8wiC+Bf49Cl/7FpgmNUuDAPGO3OR5gkvGfaxDU=;
        b=P3skQFBXYmOTKA6BtKO1Ya+JgfRcxHVFxdsbR+uSIH830yRocKO0/h9/BYeSu/vvV0
         0L+YzevNB6Zx11vj955UIQ7y4EZ4FBzNb+RU3PiGb5XiADHGFyKZ6jFjJZ4qHpJ7lifK
         kRUnZL3FFN0ETUInYjaFbYtOJCUJWzF6LpCK1GQJgNgVPtMTIoV89/6AjbVGTARPTnAB
         rySGBPI3b9ku2zqy8JEuh2QBzp50wRjdA1ioH/jVAXtwB2emzgQ+vH/tyxLsk5BBOmtI
         0Xk9I9hlXnEClKL8ywZtmEELXXrqydlECcf2Sqea5erfCXU0Bf16tol7YeiPfJQT3TXi
         YljQ==
X-Gm-Message-State: AA+aEWbl++2H90ynb2fTzLhJ6ZxGUEQ5YxXISA6L/9eRx5TbJiKWQGtA
        2JxKbBxFqv9ZX/zw292PY0bNRA==
X-Google-Smtp-Source: AFSGD/XOrS8nWPkP4rsy5eNT5jiuLtFIkgku5aQ6HhTPgEfrW2K4Wv4yJby5cR6f+/4Dou4rQTn5Ig==
X-Received: by 2002:a65:514c:: with SMTP id g12mr18328790pgq.169.1543966585069;
        Tue, 04 Dec 2018 15:36:25 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id t5sm27788513pfb.60.2018.12.04.15.36.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 15:36:24 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson-axg: remove alternate xtal
In-Reply-To: <20181129165451.21446-1-jbrunet@baylibre.com>
References: <20181129165451.21446-1-jbrunet@baylibre.com>
Date:   Tue, 04 Dec 2018 15:36:22 -0800
Message-ID: <7h5zw8dfux.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> There is actually no alternate xtal on any of the axg board I have
> seen so far. The 32k is actually generated internally, deriving from
> the 24MHz main xtal.
>
> Amlogic SoC also have the option to provide the 32k reference externally,
> through one of the AO pads, but no platform is using this ATM.
>
> Fixes: 5e395e146667 ("ARM64: dts: meson-axg: add an 32K alt aoclk")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Queued for v4.21 (branch: v4.21/dt64)

Thanks,

Kevin
