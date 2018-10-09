Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5006C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85CE52086D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z4az3kTb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85CE52086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbeJIOva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 10:51:30 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36213 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbeJIOv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 10:51:29 -0400
Received: by mail-io1-f67.google.com with SMTP id p4-v6so440974iom.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 00:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=p+9dCYLtSmGIiW5613XyqdLDzMzwv+oi/bR453rINUE=;
        b=Z4az3kTbI8EaHEx1TD5p+BgO3pD8zvwEdN21mDroL2jAK9ZLVs6ggvlMocNJG7T9Lx
         ViuoEQRF/s6tq85DmL3sv3rpZ7AR7NytY+CMTcOMEZ+Q3lGyzEl4CGPdbxX0RxvnYepQ
         JHnAgKsv8VVKF4fG9KIPuYNpLHWa1C1+QVPe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=p+9dCYLtSmGIiW5613XyqdLDzMzwv+oi/bR453rINUE=;
        b=IQIU8Z+lPPXKS52AhLAEdMg2xleRzChhO4wFE57qCabsnnj+Zq0yLabjbvvCCmYZbO
         Phdw0j36Rjtlq6IO6WpCWIP5jL5SfkyXbtHCxs0W0Vm3jyLCmH5wVI/I+OBsW0pe+VyW
         XElibJknEksv1eZZQ0MBf+k38k+ajR4dbHKO/kCE/4bDio7UJcWXL1vd1/AkHT5DrGlD
         gdGWI2jpw7E/6Y1cYUCRg6vMJBG3kc3kh+tojE/h/uz3B6+KuRzAIGMXZnK8lX7Sk5e0
         iJ9CeT0pk3NqIbjwWcM9Fw/tU3PM2XCYbTq58ObQMaJ2UYlFFlFE4f4tJahdIfOGrh1+
         oF+Q==
X-Gm-Message-State: ABuFfoj3sHuHld2zh6faBglObK7mCEdNpe7iXUk9HnFSOxOB46VPAy8D
        LtvKPfTqGLMpwr2WEpOeIAPgqqE8cR1Rpah60rXBtA==
X-Google-Smtp-Source: ACcGV60ipdTlp4trebdszgb7S92D9G6lWhAqH36qAxLEPZh89sfDuyMPvKgWH+IBEHZ5qs/9uNhsatbhyXpXuOUntyI=
X-Received: by 2002:a6b:203:: with SMTP id 3-v6mr17670870ioc.131.1539070554226;
 Tue, 09 Oct 2018 00:35:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Tue, 9 Oct 2018 00:35:13 -0700 (PDT)
In-Reply-To: <f1979ee5-404b-4397-8acb-837fbda83eec@ti.com>
References: <20181004111451.9539-1-faiz_abbas@ti.com> <20181004111451.9539-6-faiz_abbas@ti.com>
 <CAPDyKFpRU1bQB6LMt30c8hGhTYnYp7FBVOz092TEzkiXfoDdgQ@mail.gmail.com> <f1979ee5-404b-4397-8acb-837fbda83eec@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 9 Oct 2018 09:35:13 +0200
Message-ID: <CAPDyKFrt=6da_r3EwX0UxmHkHU0wLN9BME1XTsapU8YjBXpdsQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] mmc: sdhci-of-arasan: Add Support for AM654 MMC and PHY
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Kishon <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 October 2018 at 09:35, Faiz Abbas <faiz_abbas@ti.com> wrote:
> Hi Uffe,
>
> On Tuesday 09 October 2018 01:00 PM, Ulf Hansson wrote:
>> On 4 October 2018 at 13:14, Faiz Abbas <faiz_abbas@ti.com> wrote:
>>> The current arasan sdhci PHY configuration isn't compatible
>>> with the PHY on TI's AM654 devices.
>>>
>>> Therefore, add a new compatible, AM654 specific quirks
>>> and a new AM654 specific set_clock function which
>>> configures the PHY in a sane way.
>>>
>>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>>
>> Applied for next, thanks!
>>
>
> Do I need to repost these in the v2 ?

No. It's okay if you drop them from the series.

Kind regards
Uffe
