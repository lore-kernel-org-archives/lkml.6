Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E19C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4518B21532
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bsr1CF9V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4518B21532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390541AbeIUVGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 17:06:46 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:52029 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390337AbeIUVGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 17:06:46 -0400
Received: by mail-it1-f193.google.com with SMTP id e14-v6so2343029itf.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 08:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x6eAUIgNab0k/Q9xXDDkBXzMjrapMC/rfJODkTmEaWs=;
        b=Bsr1CF9VW/a4Cn6GzpBkiOUYBOYOiftCdsuW2WKlEwMLm88LI09x6Lt7JCKr3nkHiK
         dNlIBQnRdmG+qqn2HmEINcNU24j1m5pU1seFFb9V43hFJUHn4PWdpz+n1Rh0PPANTVBy
         lTFBNiukGnpZkH13y0MqQ7edXd5sylgrzzSao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x6eAUIgNab0k/Q9xXDDkBXzMjrapMC/rfJODkTmEaWs=;
        b=G+sDUP1iAfZBAWGmN3tP7OgpWD2D0/3BOeab3fJ9l/eBU5fD8XZfpcFZHTvC3lHjq+
         5qABpSjMUI1dqHfjaUjk4qYfxn/qdbunJPOQi4/iGo0EqQTl/8kRrecnsyTxah0CLF2a
         x19Sk0Vvd7YYMLZCXVdRi/TkuaGaZJdxklRa8UzEgcvqEuHqnux1GSnxXbxx/CLZ+c46
         vEmGn/T680dvEEeGbRCU2OzsOStYwhZtBOIlu89RU2eccWzjxPhTjMM2TNzf8Hz/IANZ
         pJ0CfH0x57vWWpTEwjFgZO9TSVUfby1KzE/PlYSTM3XNArkotO26lIo8OzqOJgtvluUN
         uzkA==
X-Gm-Message-State: APzg51BA72qifP46KtasUkL8NWzn6hjKWwNnz5CUQeqFKVbNg93DwJ/H
        7TXEPYxALnnmQM4uKTrJjCTtPwoXhKCYsU6hmCJkmFk1
X-Google-Smtp-Source: ANB0VdaXQBFFmuJb7gQesqUh9FcQWNRCcsznNqd/uwJ4c442cQDerxwDAc9fMsdxwTHP0fbHb3D04f98WK2ruDu2lfo=
X-Received: by 2002:a24:6b0d:: with SMTP id v13-v6mr6493078itc.16.1537543045676;
 Fri, 21 Sep 2018 08:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180920013712.2361-1-bjorn.andersson@linaro.org>
In-Reply-To: <20180920013712.2361-1-bjorn.andersson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Sep 2018 08:17:13 -0700
Message-ID: <CACRpkdYxh+cSKPO4JUF2uJZ=xVuNsNHe5eSWjy2N+qibGaDfSA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Qualcomm QCS404 TLMM pinctrl driver
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 6:34 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:

> This series introduces register accessor functions and a level of indirection
> for these, in order to handle dispersed tiles. It then adds the TLMM binder and
> driver for the QCS404 platform.
>
> Avaneesh Kumar Dwivedi (1):
>   pinctrl: qcom: Add qcs404 pinctrl driver
>
> Bjorn Andersson (3):
>   pinctrl: qcom: Introduce readl/writel accessors
>   pinctrl: qcom: Support dispersed tiles
>   dt-bindings: pinctrl: qcom: Add QCS404 pinctrl binding

I tested to apply the patches but they don't apply cleanly on my
pin control devel branch, proably because some other qcom
pinctrl fuzz.

When resending, it'd be great if you could just rebase it on top
of whatever is in the pinctrl "devel" branch and it'll likely apply
cleanly.

Yours,
Linus Walleij
