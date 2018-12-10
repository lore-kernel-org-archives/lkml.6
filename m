Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711E1C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E3E20672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="q2NWIpH5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31E3E20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbeLJVRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:17:40 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37593 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbeLJVRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:17:40 -0500
Received: by mail-pg1-f194.google.com with SMTP id 80so5562416pge.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 13:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=C94QuNa+7VK3Rf2ToYyYT9nrOJ5ofXPZR4RoJw4IVnk=;
        b=q2NWIpH5UM7rq5CcdQ+mPXlrvpsOD20YoycBO2qjFVy2HmACw02Yy3HwIo461Ls9Tl
         n59zFfYtZkX0SHAiHEe2vocOsR3GQfZjgAL25lqEkbH0/W3MXymlsMo9PRD079F5z5Y+
         2MWUIXa528ti6U4oH9MPXjdZFfu5YQITl2jy296nM11FIxYeIfEt+tL18OxWlnTXKYos
         QRYdXMHpAIln1MuUT5bB3ngCanFjTJ1sdDOSli2+YcxQP9tnLu2U75yo4Jlygci9in7a
         Y4NK5ptBS8kd2JnR2+WPn5knS1BnHGptOlJWvAQqLStHgwt9Jdi+4KkiFOnwPn49cllt
         GwlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=C94QuNa+7VK3Rf2ToYyYT9nrOJ5ofXPZR4RoJw4IVnk=;
        b=XCRGd6sFa0tlc2oFVLMlY+rUcHiTLfFVGLpc4wlfRnsKamTjGrQvvOyFt/0Z8XnR2V
         yFYTXKImwKtcsWEtlCusPCHN9fi20miCFKXD4Wt0SLv+0E+OzKWSKjeW+tKhSjY/+F/d
         m6Hxzvm2DJv2QCoIwuBoMpmeOklUovY1g8k3LzObhgyDJBUxgnHO7wUT8f2OdfHfUNEd
         Y7lGcGN7wLCEt7HufaQeRuHXRGxJYC7OlZzKaYyLYI1+h+7m0oxycwmiemniUJQqEjHP
         kMgSMjrvpNTM34m7LNWgxbD6+N3P1SCH0f8caCcY6OrZiBtR+8dVgzSB9inxR3Q5uIgl
         GV5w==
X-Gm-Message-State: AA+aEWaDnnXlT7eh5M7dEBN+8KBezu0LuzzH0/WQ1Mt6btIOg+vpVGQI
        bXNKlcJI9C8I2+Ek6n6dMUz3vw==
X-Google-Smtp-Source: AFSGD/VnBAoBo97r9FRQJg3EcpzMiSTg/VC/2UkFQ+BeeoDoH8wctLqdqrauv95QEjAvRU2P8abXhg==
X-Received: by 2002:a63:3d03:: with SMTP id k3mr12254348pga.191.1544476659770;
        Mon, 10 Dec 2018 13:17:39 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id h128sm14691064pgc.15.2018.12.10.13.17.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 13:17:39 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: Re: [PATCH 2/2] soc: amlogic: meson-clk-measure: Add missing REGMAP_MMIO dependency
In-Reply-To: <1544471155-26661-2-git-send-email-clabbe@baylibre.com>
References: <1544471155-26661-1-git-send-email-clabbe@baylibre.com> <1544471155-26661-2-git-send-email-clabbe@baylibre.com>
Date:   Mon, 10 Dec 2018 13:17:38 -0800
Message-ID: <7hr2epuln1.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Corentin Labbe <clabbe@baylibre.com> writes:

> This patchs adds a missing dependency on REGMAP_MMIO.
> This cause the following build failure on SPARC:
> drivers/soc/amlogic/meson-clk-measure.o: In function `meson_msr_probe':
> meson-clk-measure.c:(.text+0xc4): undefined reference to `__devm_regmap_init_mmio_clk'
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

now queued for v4.21 (branch drivers)

Kevin
