Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB46C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41482086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="aMvA2PGH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41482086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388888AbeKPGcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:32:02 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33385 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbeKPGcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 01:32:02 -0500
Received: by mail-pl1-f193.google.com with SMTP id w22-v6so10011451plk.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 12:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=96sTjbYBTtt5innt0PBQlmAAPysherF0n+PRPWm7R3c=;
        b=aMvA2PGHm8NbAjoJ0y0KO2jvcTamv0+/Syk3kdZRsk5H6vS8fplYK1ohzK1MRLuM7L
         AkVDruuObmL2HKkJAFGKVu8pUUp6pU4mebgT2Kid7EjkaE2YWWw3+ivoH1+5TqhD4FvK
         JcS20La7FohNh+1sSOqHwF07cSFR3Kdnt/L7ezRcmlZPKCJcQlmplPCrdqgbptaG83Yb
         ZC8aq3hunGRtwbUj5kBcOWTSrZQGpC13nJ4rOpB/msof6CcI/+oaNwgxwNywaoolbI2/
         6RunKteZGi7fMyuU7gtGY6Aj+aDajB4x6PPKT7kyekS58ca9NwLzjKKkXs//3ZeBDtSR
         /0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=96sTjbYBTtt5innt0PBQlmAAPysherF0n+PRPWm7R3c=;
        b=pq849iQdCDRzsQpzLnQ9w15XBUyxxkGs3FIaPPPEAl+FufEqCinLCesSW/kwQxHgnq
         yWsMd1CTohaL96xfWHMHKXKeCsnEBLquz1emzslSlwQ2ps6J3cvbEZjZHzm5J0Oh6DmZ
         EO5blh4yk/zcJbJ/wPkcOlw7fEuUFAI+Ux3u6CP39lpMFC2arqAJ41bI7Y5GeioWeZmz
         k9PWFyCxRKvnMh37P9QMkionvi43ElHDU677rz7DrWBl+OIEaA4iHuwAg/X8CXRT1l4I
         FhwH6DJlMSvB60W86V1jOgdDxMeICvbScFy4O2PYi8AFHB7yf6vobBzb1rWvYlFhPL10
         OJzA==
X-Gm-Message-State: AGRZ1gJvZsw64bs8bWeNYhsSHUp5koImnjWKfS3GVwNbjeGBsUYmSxa7
        1km7PQj6CZxock+4f8sPfU6CfQ==
X-Google-Smtp-Source: AJdET5cjMV+fba8UL8n5h059qg4O75+sZY6YvoiQnt4YDExwbVc/1uxuiTMrWvWLXdC5r7MW6Fx42g==
X-Received: by 2002:a17:902:2ec1:: with SMTP id r59-v6mr7793672plb.61.1542313363029;
        Thu, 15 Nov 2018 12:22:43 -0800 (PST)
Received: from localhost ([107.181.189.87])
        by smtp.googlemail.com with ESMTPSA id g64-v6sm32062694pfe.37.2018.11.15.12.22.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 12:22:42 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] ARM: dts: meson: set pinmux bias
In-Reply-To: <20181109140445.17795-1-jbrunet@baylibre.com>
References: <20181109140445.17795-1-jbrunet@baylibre.com>
Date:   Thu, 15 Nov 2018 12:22:41 -0800
Message-ID: <7hbm6qdram.fsf@eze.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> On Amlogic chipsets, the bias set through pinconf applies to the pad
> itself, not only the GPIO function. This means that even when we change
> the function of the pad from GPIO to anything else, the bias previously
> set still applies.
>
> While trying to boot from SPI, I noticed the eMMC was not working anymore.
> Even if the related eMMC pad are not used by the SPI, the ROM code sets a
> pull-down on the eMMC pad and leaves it that way. This breaks the eMMC
> later on, in both u-boot and Linux.
>
> The underlying issue is that we inherit whatever was left by previous user
> of the pad (pinconf, u-boot or the ROM code). As a consequence, the actual
> setup we get is undefined.
>
> There is nothing mentioned in the documentation about pad bias and pinmux
> function, however leaving it undefined is not an option.
>
> This patchset consistently disable the pad bias for every pinmux functions.
> It seems to work well, we can only assume that the necessary bias (if any)
> is already provided by the pin function itself.
>
> I can't really test every pinmux configuration and it is fairly possible
> I missed something so it would be nice if more people could confirm if
> nothing (new) is broken after applying this series.

I'll queue this up for v4.21/dt64 branch for a bit broader testing.

> One things could be the i2c. Usually the i2c pull-ups are physically
> present on the board but, if they are missing on platform, we may define
> a special pinmux setting with pull-up enabled.
>
> One last gotcha, I recently posted fixups around bias setting to pinctrl
> which have been merged: [0] [1]. These must be applied before applying this
> series, otherwise when requesting 'bias-disable' you'll probably get a
> pull-down instead.

OK, I'll include pinctrl/for-next branch in my 'integ' branch.

Kevin
