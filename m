Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AD4C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E6320685
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dOElqr4m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E6320685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395473AbeKWBAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 20:00:24 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42436 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389042AbeKWBAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 20:00:23 -0500
Received: by mail-lj1-f193.google.com with SMTP id l15-v6so8124631lja.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 06:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wN64+oSdjtysDcFYKvZWZm5CBSpNKqqGBdQdfrWkSOY=;
        b=dOElqr4m22USh9Nhgv5ThnB2/EvMjkWRARlgoyddgu8jfVmskpvKSrxQNJmwFfnurj
         FZSNsTe263OpIvZ119MhUP9byGHBOK87JVWK0QZa2TZffQF4IX3nC1PmmPV3zi6cYZgC
         Fy129v666+fnX2pglo3GGm5WTWI+R1y+gcRTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wN64+oSdjtysDcFYKvZWZm5CBSpNKqqGBdQdfrWkSOY=;
        b=CiAesRpObf6gZG6L2bCNq5mpReKFarVmcdEbuF/kxHJW2ZPa4mSaGQFLeVix1sBl4Q
         7vFMGgA+qYYRk5T13LW4cKGBqh+1hvGY08ic4uxs3mk+/NF9f0BqGaluoagyAvR3KVSD
         gmT2yZn9KOEpojeIBvh6iGNEZO03vCM+q3PTgjRFlXwHrjlK9tnjHmBjI/s+x39MJzMK
         5B/DbOeFaHzzDtuthGdKsEUQrM1P1Bjcq+WWKNYwH8XVhr4T4CsZHPvm7EaDmDArHlJa
         Q0EPv3RQ0BupxWaCBw68f7/2sC6ar2sOnnqEhSB2o2pdk92sYSSGTKAjKLY8U9Q19CFQ
         D7Lg==
X-Gm-Message-State: AA+aEWYcJiWXfNqcTE5+50w1QMJMcr7X8aUioceY5wMs3BxSeUQzk6Z3
        8vUdQSXkqrsn8D+ZbjJjOsdfmMwZtB8astX1x6V6Tw==
X-Google-Smtp-Source: AFSGD/XjLY5Dp/hpthrL8wXRjQPwmssjHnxBS7Su71xyISQW5lZUI/WJjsXobKt/166tbtR+hMOcsfLxSi+/q1fuImw=
X-Received: by 2002:a2e:994:: with SMTP id 142-v6mr6343385ljj.120.1542896448233;
 Thu, 22 Nov 2018 06:20:48 -0800 (PST)
MIME-Version: 1.0
References: <CGME20181121101410epcas3p27a2a577c3b5a0608f7808ff733fab9d1@epcas3p2.samsung.com>
 <20181121101316.32194-1-ckeepax@opensource.cirrus.com> <c0a2d30d-b18e-e72a-f369-c8678f1854ff@samsung.com>
In-Reply-To: <c0a2d30d-b18e-e72a-f369-c8678f1854ff@samsung.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 22 Nov 2018 15:20:36 +0100
Message-ID: <CACRpkdYjhRUKJnZhSB7y7DzGwYAsZtwv9w339bYQm9VpU23ZZw@mail.gmail.com>
Subject: Re: [PATCH v2] regulator: wm8994: Don't use devres for enable GPIOs
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 11:42 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:

> Linus, Mark: Similar issue is probably in the other regulator drivers,
> which use enable GPIO allocated by devm_gpio_get*(). This driver is
> simply the first one, which we observed it. It would be great if one
> would take a look into regulator_register() error path, because for some
> cases the GPIO will be freed, for the other - not.

OK I am onto it!

Yours,
Linus Walleij
