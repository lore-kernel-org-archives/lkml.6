Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E19C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1C920855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kov1pn6/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B1C920855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbeKISln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 13:41:43 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42083 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbeKISln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 13:41:43 -0500
Received: by mail-lf1-f66.google.com with SMTP id q6-v6so764976lfh.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 01:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=264ujzwr+J/SKU6gkcylBUY6L+m0G/NeEMDoaXo/bzo=;
        b=kov1pn6/CxhV/Gso7maKgc8ajA1VnDhlB8wl3zFwGWfjnxyIlJBA4K/DkD545F+1Qf
         28MXxveBNdbWk+V3qcKkX09zK9tXG6nN8cUDsd2fTZ7XLcNT0ZU9m3CYTZdahzpJnZJb
         iSIUY7mhZZWmdjoHk/jFxr5R+Z71UJmnoXrns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=264ujzwr+J/SKU6gkcylBUY6L+m0G/NeEMDoaXo/bzo=;
        b=ccsC7N7SEd+eyX7OeJlKqXzQpgn1tHM92pVHioT8nlW30tw8rPnJcEeJfBpjDCCJgO
         GF1zMdMgSw0CxQIY9XtI5i/yAJUSrmN+gGNAzvfEM6m9jpMJge1MAII5dKmD7BkJ3UEc
         9eOQa/6GW1DZ+RNmvZ1Iubq18FYmzuEcu4u/E4keLbiCG3v4IAfG9N9RbJkLIZdEyhFt
         eEAmDTPWBfaVqRBIcxD7QdLYDxTvfNfigs9PSUP8xY4BRpLfeGf3851imWRiQXP1Dqh5
         /Zn/8NnNo6UXPMfeTOqLeuvBi6nkasJ0+Clxe/C3J79Zn3DDAzorN4c1evkCv2VDV9C1
         jYfQ==
X-Gm-Message-State: AGRZ1gK31mJA1RObTDFGb3tcj2ei72vIbHzFJQevvxDMcj3GZH62IPEn
        krsvm23fiIgOpnUhn1srGbymRAdYQgzln4fQhluunQ==
X-Google-Smtp-Source: AJdET5d3biJLh1AXlkUwkhn3P5YP3eHpzqoLqWSxIEBF7O2D/uBF73EoLsSsOeRWNbrPrKlAx1dpU6jiGwSzP4Hw3dY=
X-Received: by 2002:a19:41c4:: with SMTP id o187mr4937552lfa.32.1541754124447;
 Fri, 09 Nov 2018 01:02:04 -0800 (PST)
MIME-Version: 1.0
References: <20181101005021.8393-1-natechancellor@gmail.com>
In-Reply-To: <20181101005021.8393-1-natechancellor@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 9 Nov 2018 10:01:53 +0100
Message-ID: <CACRpkdY0YnUCFYahabGr7GBetBHs++QygDs3KVB=hMRBv0fGZg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: max77620: Use define directive for
 max77620_pinconf_param values
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 1:51 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:

> Clang warns when one enumerated type is implicitly converted to another:
>
> drivers/pinctrl/pinctrl-max77620.c:56:12: warning: implicit conversion
> from enumeration type 'enum max77620_pinconf_param' to different
> enumeration type 'enum pin_config_param' [-Wenum-conversion]
>                 .param = MAX77620_ACTIVE_FPS_SOURCE,
>                          ^~~~~~~~~~~~~~~~~~~~~~~~~~
>
> It is expected that pinctrl drivers can extend pin_config_param because
> of the gap between PIN_CONFIG_END and PIN_CONFIG_MAX so this conversion
> isn't an issue. Most drivers that take advantage of this define the
> PIN_CONFIG variables as constants, rather than enumerated values. Do the
> same thing here so that Clang no longer warns.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/139
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Patch tentatively applied.

This seems to be the direction we need to be going with a lot
of CLANG business.

Laxman: you weren't CCed, so tell us if you dislike it for some
reason.

Yours,
Linus Walleij
