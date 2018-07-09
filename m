Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A8CC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594BD2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KDZPvNwN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 594BD2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932998AbeGILSE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:18:04 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:53000 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932867AbeGILSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:18:00 -0400
Received: by mail-it0-f65.google.com with SMTP id p4-v6so24845078itf.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 04:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F9vfwCzygLX6ewOOiILd1MOZNvitAZqAg32Y3nEUIX0=;
        b=KDZPvNwNADmtUFE7E6sLhFlo5/K4UYQhK5UNwT6KWB1hCrPyVOGRRpOb64wIfYGzZ/
         5C8z79ELjHGen8m6Z5QO6GW+Ksts8KZuf+7By0S76mgxFlnn8m/bD+DT2D+e8zXABZWl
         YCeqaStYEe6A2XgrLl564oKEEJSa3PeMPENzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F9vfwCzygLX6ewOOiILd1MOZNvitAZqAg32Y3nEUIX0=;
        b=j9kQSN/Z7tcbfi4b6AnTNunRLaO7HNFGXULAX3LjEi50OODOpUpXbgdqm5XCmGPhJN
         Q5EhlpIaGtAdfCF8h8ca8eNyfL/YVtbpTs4AImR2jixlSorer+iqdnaXwoA9uh7wbDfx
         4vPCsBZ9F+Q1nR9Z2sKb4gLe6XImY1qDIINssB49qQUm7tma7WorwaZZATajOwv/lj4P
         BVtdlU8YiKuYQ164NQiXD3jYWDrwqDN56S2aQumFvAsCkZLNpTqx9EAs244cL9QCkwXp
         q+FPJQi8yhraNGYb/eEz3IXXQVxSjr67REFO9UZP1XUV+VsOovTK2akDh6a7esQ00X0a
         g8Tg==
X-Gm-Message-State: APt69E1cHN+UG8T2budueWIp9kKtF2w4Sq6PD0KpXWvZyimgnCgSqnwf
        +mDKYbrOxSYcbPUTxeJhkWMVZeqGN8XPBIImVHzryQ==
X-Google-Smtp-Source: AAOMgpfHFV9FWQT9LJZ1N3o3/OAOlYQktwL3PyERW2IubgOwOKQJRGSutsa9xCuDBwchi5j0W7cgaoFXnOlpNwkRTWw=
X-Received: by 2002:a02:597:: with SMTP id 23-v6mr16541722jal.112.1531135079796;
 Mon, 09 Jul 2018 04:17:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180702225939.109169-1-dianders@chromium.org>
 <20180702225939.109169-3-dianders@chromium.org> <153059814703.143105.275831530209187562@swboyd.mtv.corp.google.com>
In-Reply-To: <153059814703.143105.275831530209187562@swboyd.mtv.corp.google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 9 Jul 2018 13:17:48 +0200
Message-ID: <CACRpkdY6zShFajBv=yhgxk7NRP8WBbM=m16fSiuL6xqsYdP6Dg@mail.gmail.com>
Subject: Re: [PATCH 3/3] pinctrl: qcom: spmi-gpio: Fix pmic_gpio_config_get()
 to be compliant
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        "Ivan T. Ivanov" <iivanov@mm-sol.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 8:09 AM Stephen Boyd <swboyd@chromium.org> wrote:

> > Fixes: eadff3024472 ("pinctrl: Qualcomm SPMI PMIC GPIO pin controller driver")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> We should fix the ssbi-gpio/mpp and spmi-mpp drivers too. All those
> drivers are designed on the same buggy original driver.

Agreed. Looking forward to the patches :D

Yours,
Linus Walleij
