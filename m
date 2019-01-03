Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF741C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAFAD21874
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bWHMTnCl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbfACWxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 17:53:54 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42562 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfACWxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 17:53:54 -0500
Received: by mail-pf1-f194.google.com with SMTP id 64so17324022pfr.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 14:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:cc:to:in-reply-to
         :from:user-agent:references:message-id:date;
        bh=eKDkodU+bk+UX1mJmQHY5x4ZWScBEWFcctryf+ygKqc=;
        b=bWHMTnCl3K9JhTc2KDOM7bFwiA8OQSdp/WIwCi5WmdzADsf2tzrnbVzj4enGsjtDXf
         PiGgo/tTanO9JYYznwnbQV+KQd8qnnwph5anU/1ZjQM0NR2rvm7ZQl5nS2/eu6fFPHzl
         xmh32/kMxwlpa9HSj8dxThYpRfR4WzE/y/qEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :cc:to:in-reply-to:from:user-agent:references:message-id:date;
        bh=eKDkodU+bk+UX1mJmQHY5x4ZWScBEWFcctryf+ygKqc=;
        b=Vh+1VnzSi+OV30zZcuYkekmjRB6SidvJ+Zo/X2pQjxDC4eMsTz7bbr6mG7Y0Rjbc9l
         mv9OvPxQboDxD4LIUsEGrQQpO6XAjDBgq0qoYfypb5i3YiVIxR25Oj2llGOqBeCpHTj0
         eVRDvwmJU6wz4fKDqcCUBQTLaR6vc2Xi7dAkUqgPb8KCLzTifzM+eUHN7R4fes85wA9P
         z7Tjtzmx8ZNu+O0xfJQPvOrq7asA6vdJwdUKYeRUVVr53Z/Mvac/4YE4E/zqQrIfy7tW
         M8NGXAnuXHTiVBVO3wzB3LcZ9JxWlskxLZNERmQjy9mzOPUgh3VmLhEfPgs/iIHvk+61
         UUUw==
X-Gm-Message-State: AA+aEWY/rApl2Tic+7yJ53IZGtZ8XemvG9P9zHxZSqSjt3mCIyHU2wsZ
        m7/N/3i4UTSM/dUtuERcocMp7Q==
X-Google-Smtp-Source: AFSGD/VhbaBKgVs1eRgvU+zTaRV/g9X7rAPXVRAVbmLWrER2SOl7aWnQaxCCxDZtCkNYAG2dvqHj0Q==
X-Received: by 2002:a62:16d6:: with SMTP id 205mr49790444pfw.256.1546556033327;
        Thu, 03 Jan 2019 14:53:53 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id k129sm72651060pgk.29.2019.01.03.14.53.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 14:53:52 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC RESEND PATCH 0/7] Add driver for dvfsrc and add support for active state of scpsys on mt8183
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Fan Chen <fan.chen@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Kees Cook <keescook@chromium.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Henry Chen <henryc.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>
In-Reply-To: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
Message-ID: <154655603153.15366.7761694381359713995@swboyd.mtv.corp.google.com>
Date:   Thu, 03 Jan 2019 14:53:51 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Henry Chen (2019-01-02 06:09:51)
> The patchsets add support for MediaTek hardware module named DVFSRC
> (dynamic voltage and frequency scaling resource collector). The DVFSRC is
> a HW module which is used to collect all the requests from both software
> and hardware and turn into the decision of minimum operating voltage and
> minimum DRAM frequency to fulfill those requests.
>=20
> So, This series is to implement the dvfsrc driver to collect all the
> requests of operating voltage or DRAM bandwidth from other device drivers
> likes GPU/Camera through 2 frameworks basically:
>=20
> 1. PM_QOS_MEMORY_BANDWIDTH from PM QOS: to aggregate the bandwidth
>    requirements from different clients

Have you looked at using the interconnect framework for this instead of
using PM_QOS_MEMORY_BANDWIDTH? Qcom is pushing an interconnect framework
to do DRAM bandwidth requirement aggregation.

> 2. Active state management of power domains[1]: to handle the operating
>    voltage opp requirement from different power domains

Do you have any devices that aren't "OPP-ish" in how they use
frequencies and voltages? What I mean is devices such as i2c, SPI, UART
controllers that don't use the OPP library to set a frequency but want
to affect some voltage of their power domain when clk frequencies
change. The existing code works well for devices that naturally use the
OPP rate changing API, typically multimedia devices that churn through
data like a CPU and don't care about the frequency of their main clk
because it doesn't match physical link bit rates, etc. I haven't seen
any good solution for devices that don't fit well with the OPP API
though so I'm curious if Mediatek needs to solve that problem.=20

