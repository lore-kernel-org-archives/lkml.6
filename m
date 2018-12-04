Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC20C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4059220878
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BwF4cBH6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4059220878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbeLDMoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 07:44:46 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43395 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbeLDMop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 07:44:45 -0500
Received: by mail-lf1-f67.google.com with SMTP id u18so11834038lff.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 04:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L5Hzb6QsBrQAfqrIo1HlcaC9gcG+3D712ZJiFspxuz8=;
        b=BwF4cBH69EO7ZU/dG1VzCxfD0uL7S7+fwZjCFPLGqFW4InnQBElWNlC8qlXLbPdjy/
         2znRIr0cVcYAFqSlt1FwI5QIiSg+aXifzPq7CEcB2sCBWXpaUX7M5URbewQo28ajTdmB
         3dDb5nP8hKPl4eqsHgFGiG+0Roa4Rluo+YoyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L5Hzb6QsBrQAfqrIo1HlcaC9gcG+3D712ZJiFspxuz8=;
        b=qfLZsxhMLt0P/9clTVYEq4aHRxoVm0nKQ5tti1S1HQkI6NyZBvVXrcs0o6gMD76NGJ
         ajFlPZwlaW1UjDF4d0Duc/b+85SeACmcBtXIvXYOW5Mj4DGU0b/l/MdS44F6UwLVEe/E
         TnEU8YQaxa/ugjdaqA/MynkwFa4u+v67bKOZ8oM4iKDyZza9b73rwOz8fi/wmR2JeSt1
         4pDNkcu1wTqvqppzwza1xqFd67Wdgnx3Zd9d9iv37tWmc6AUGcyUPywWPyo4dF3vc+Av
         9krsZf+lceMKVA8h9Re/nXoMQi16XLsyG4uquUkROZlxkiPYdiWQyJJH/LUaurptjZ3Q
         vHSg==
X-Gm-Message-State: AA+aEWZaP1JPeb7GtUPUN4zMVy/mtO/GKcSB2G1HVw10v5/q1wF1XGrG
        ILIHI4a79qO8c0KMLnen6OM1MWxqy0hlBnWXFg2FPg==
X-Google-Smtp-Source: AFSGD/UueUXI7ReJMt4pdG+httEB7HLCsqN1XPJpZRAYt33mtHwXqafp1BQHPrOv6+CXxjsiuGitU7nZRmRljwiC2gI=
X-Received: by 2002:a19:f813:: with SMTP id a19mr11207810lff.67.1543927482386;
 Tue, 04 Dec 2018 04:44:42 -0800 (PST)
MIME-Version: 1.0
References: <CGME20181201154428epcas4p3a1a5c9c576027b1c56f8dd1510b32187@epcas4p3.samsung.com>
 <20181201154151.14890-1-linus.walleij@linaro.org> <d6b5f384-51aa-0e99-7e88-a1debcf5eca3@samsung.com>
 <CACRpkdYQ5cy1-8wu--deF0kdzrRGVJ_teNh2LRF7tr9vyh+oHw@mail.gmail.com> <455ced52-e444-66f2-7dec-9d37bdd5116c@samsung.com>
In-Reply-To: <455ced52-e444-66f2-7dec-9d37bdd5116c@samsung.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 4 Dec 2018 13:44:30 +0100
Message-ID: <CACRpkdbVSEYJpSb6Uzji158gL7WHu_Bfpw2gK-qo2s66dWjY7Q@mail.gmail.com>
Subject: Re: [PATCH 00/13 v2] Regulator ena_gpiod fixups
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 11:33 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:

> >> Artik5 evaluation board (arch/arm/boot/dts/exynos3250-artik5-eval.dtb):
> >> s2mps11-pmic s2mps14-regulator: Failed to get control GPIO for 11/LDO12
> > Question: this is supposed to fail, right? It is something
> > like a probe deferral or nonexisting GPIO controller?
>
> It looks that the issue has been introduced earlier, but I didn't notice it.

Sorry :(

> gpiod_get_from_of_node() doesn't handle GPIOD_FLAGS_BIT_NONEXCLUSIVE
> flag, the rest is just a result of it.

OK I see.

> Here we have a case, where 2 regulators provided by s2mps11 driver have
> a common gpio enable line (by PMIC design), so s2mps11 calls
> devm_gpiod_get_from_of_node() 2 times for exactly the same gpio descriptor.
>
> Fixing gpiod_get_from_of_node() for GPIOD_FLAGS_BIT_NONEXCLUSIVE is trivial:

I will add a patch like this to the series!

> With the above fix I still however get 2 warnings from devres functions,
> but this is probably caused by adding the same entry 2 times to the list
> without proper refcounting... I will check that later.

Ah I see this regulator driver really excercise all corner cases of
these nonexclusive GPIO lines. (Which is good!)

Indeed devres is not going to like adding the same thing twice.

I just sent a fix for that, subject:
"gpio: devres: Handle nonexclusive GPIOs"
you could perhaps try it on top of this
series? I intend to merge that separately as a fix for current,
as it is a bug.

Yours,
Linus Walleij
