Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92777C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 21:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 401A1223C7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 21:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UOpQj9hS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 401A1223C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbeHJXdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 19:33:19 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:46289 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbeHJXdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 19:33:19 -0400
Received: by mail-io0-f194.google.com with SMTP id i18-v6so8791205ioj.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 14:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cKuQdc55buToHxY4tUDYmNjIX5VdJXEWh/mm34D6a+c=;
        b=UOpQj9hSMlU+9B7VYaBMWVbeJhchb5o3Bl/e/3BvGByb1YLnm6PgjebPeFstno36q4
         uUJ1RAlJal5lpeROSqj8l17J+LRXq3WLQso6LjNkLqSOyZkEfYN020a452MtTg5SRg0Z
         9oaA4f7WpWhMnUZPe+yELP242u6u/lzLbPtDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cKuQdc55buToHxY4tUDYmNjIX5VdJXEWh/mm34D6a+c=;
        b=MXU2J4/OQhG/VUW35rhxSYq1xQ8/Hz7Re+N0kbX4L1fJRuuDk32hBxHZL0n+eFKHPq
         y0U1T7vppCjSVFb8eihvcb/dYdShJSmdsHCuhNTuczbZkLbH/BqWy/LslNrMpW+I72Kg
         QA/EDIdMGaIzrP1M6gMdv2UwOvFNU5QsEaOmzD6dJR989dnqJ0xjzabGWEBC6bl7qIPq
         saIyF5zRT3UajjR7tnIzKO24n8ldpkVL15eDClsab1aJ2sv3jhGaq4hWXCQEtdiuFAb/
         3BjILUa8nPTJUEdOR7fQtnEgvw/FyVyFEbfBM6yEJR3vfWlz7i3A8hxVBfmpvugzwgvK
         vREg==
X-Gm-Message-State: AOUpUlG3VzvWFR3JZorIcrWGRWhWc7/KB422FrJhpJB6X/DfWf3weIrW
        wTE5AuJ/0vAHfWLukKh0pr7K5QxKYi9yAm13DZqCAg==
X-Google-Smtp-Source: AA+uWPzG0GFf64zrLA8o3Ctqf+BRj0cnXqlHLal6ExzV/9HnGatOJUeI7VZ3hT8tgnpLnMMkl+m9k3RI9ClETdRpZBY=
X-Received: by 2002:a6b:4006:: with SMTP id k6-v6mr6384384ioa.277.1533934908947;
 Fri, 10 Aug 2018 14:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180806163340.27276-1-krzk@kernel.org>
In-Reply-To: <20180806163340.27276-1-krzk@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 10 Aug 2018 23:01:37 +0200
Message-ID: <CACRpkda_9NBKUggzBw5hYokpOEUV+9Zfx-BQg8MYaVTc0oBxiA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: samsung: Remove duplicated "wakeup" in printk
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 6, 2018 at 6:33 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> Double "wakeup" appears in printed message.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Patch applied.

Yours,
Linus Walleij
