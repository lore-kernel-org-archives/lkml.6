Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D688AC46464
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 13:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8960C219D1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 13:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFvr0sWW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8960C219D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbeHLQD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 12:03:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbeHLQD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 12:03:58 -0400
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22BC3219E1;
        Sun, 12 Aug 2018 13:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534080355;
        bh=xbd5h2uwqz8c75Caeg17HBQhGz89NCx15Ls0w3wi7DA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=ZFvr0sWWpiauOwlUZGilHwXkCIgDoyQZjHCqTCWX8NMa1ZMBcIjTQ8Mm6MGBGUSdu
         llY8JROCzoTr2SE2IXAQam6s/uXTYFTtTVUFt1/v7a7Xj9qpjsZDpHy31OCf/G3Jge
         jRXu7Fo5V+5A+w/cT7STLigIa5grm5n224GpUml8=
Received: by mail-wm0-f44.google.com with SMTP id o18-v6so6255048wmc.0;
        Sun, 12 Aug 2018 06:25:55 -0700 (PDT)
X-Gm-Message-State: AOUpUlEudJIlbfzWB8ZND9kw8mtkQSxUIuYKm0fO3fZhlgLp0C0/ngC0
        DJ8mGsyQvgfO0siNcBqI3hjiz/2XhqB/aljyYR0=
X-Google-Smtp-Source: AA+uWPxbzQLPXbtq9rLydHfJd5pFoxWmcUNrIusvDgLfV1cWP/8Z/z/YyGYrS0iUWfGsECAx+g5eWwL0oAxgsgpc36k=
X-Received: by 2002:a1c:588d:: with SMTP id m135-v6mr5575364wmb.118.1534080353650;
 Sun, 12 Aug 2018 06:25:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Sun, 12 Aug 2018 06:25:53
 -0700 (PDT)
In-Reply-To: <CANAwSgTYviRnLjVU50w_o5k6=iMjxqU5qQ+7RW9K43KrrqRKPA@mail.gmail.com>
References: <20180806160933.6578-1-krzk@kernel.org> <CANAwSgTYviRnLjVU50w_o5k6=iMjxqU5qQ+7RW9K43KrrqRKPA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Sun, 12 Aug 2018 15:25:53 +0200
X-Gmail-Original-Message-ID: <CAJKOXPds5s8omeR7UOB4u4HrYCZBTJX3t4YU4PSWBGb-9MG7iw@mail.gmail.com>
Message-ID: <CAJKOXPds5s8omeR7UOB4u4HrYCZBTJX3t4YU4PSWBGb-9MG7iw@mail.gmail.com>
Subject: Re: [PATCH 1/4] ARM: dts: exynos: Add missing used PMIC regulators on
 Exynos5422 Odroid boards
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 August 2018 at 08:39, Anand Moon <linux.amoon@gmail.com> wrote:
> Hi Krzysztof,
>
> These patches should also be ported to u-boot to enable PMIC.
>
> I was just looking into S2MPS11B data sheet
> According to the 1.2 Key Features of  S2MPS11
>
> BUCK1, BUCK2, BUCK3, BUCK4, BUCK6 have (0.65 V to 1.6 V) min /max range.
> BUCK5 have (0.65 V to 2.0 V) min /max range.
> BUCK7 have (1.2 V to 1.5 V) min / max range.
> BUCK8 have (1.8 V to 2.1 V) min / max range.
> BUCK10 have (0.75 V to 1.4 V) min / max range.
>
> BUCKBOST9 (3.0 V to 3.75 V) min / max range.
>
> LDO1, LDO6, LDO11, LDO22, LDO23, LDO27, LDO35 (0.8 V to 2.375 V) min / max range
>
> LDO2, LDO3, LDO5, LDO7, LDO9, LDO10, LD012, LDO13, LDO14, LDO15,
> LDO16, LDO17, LDO18, LDO19, LDO20, LD021, LDO24, LDO25, LDO26,
> LDO28, LDO29, LDO30, LDO31, LDO32, LDO33, LDO34, LDO36, LDO37, LDO38
> (0.8 V to 3.95 V) min / max range
>
> I am aware off we have configures the min/max range as per board schematics.
> but each regulator support dynamic voltage scale and have different
> turn on/off voltage and current rating.
>
> So why are we not setting the regulator-min-microvolt /
> regulator-max-microvolt as per datasheets.
> Please correct me if I am wrong.

Which regulators are not configured as in datasheet?

Best regards,
Krzysztof
