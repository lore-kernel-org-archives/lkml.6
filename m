Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EF8C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1741220840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jBrYoCR9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1741220840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbeKITBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:01:42 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45714 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbeKITBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:01:42 -0500
Received: by mail-lf1-f67.google.com with SMTP id b20so795576lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 01:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NmPN+Owu6GiPAiCLF13e0L5saaFnuoWUktMMf+tJwsQ=;
        b=jBrYoCR9Ut9yKMYUSJBx/MGK1qVtU3ETkar3uG9jKsffkcNDlzEQUf699GBJi1Gf0x
         4MCsv/OyeWzPuB0DUrPdqvj8UKIKC9NuNhS5K1mLpzRYQZ51UL1/299LvjFlxGMmMFbT
         cL4NxekgAA4oF3maV9qYfMhmZWyqLifi/EDdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NmPN+Owu6GiPAiCLF13e0L5saaFnuoWUktMMf+tJwsQ=;
        b=WwQiKc5IWUBlS0ePWx+9O57mXKapidcib8NVgu5abry3+w8jhV3V3FO/DGwHIAvEpY
         Qifj3Kq01qSqQ+5aqZpF6bLV6n4quGOPicMU2ofKkMKchI5tjXrAK3jXCe5pklG47AKN
         0quc9czEIh73GSkwubsr5eGw7kZRg2R3IYY4648imFf83p/3LMYAOoaJlXoETH7qGVJ3
         /ppCId+4qRDNGmGt3sHpBOaMKtz34dvm/31NosxR9rMa/BJ7Rrl6iBd+l8YpuChbzXES
         hLry6NpQ3j9OJGNYV6Id9BUzCAjwu4vpX29WZbIs+HZH8UUUIH8Q+2AjyA/vR+mEy3Vr
         bbQA==
X-Gm-Message-State: AGRZ1gJbgpUn7nwKVYL10RB/Nn3czSr+MxWIlAV5CQ7mWOvGgq1lIpdH
        RGErvD8pfcTXhJeUCCSOk9Lcxd4RAX0OwH3abkYLNw==
X-Google-Smtp-Source: AJdET5ePGaVXf7n73hMAAqCJV3P34IgoZ9lE0NqXNXNQmRVlNgANstBFZmgIkn/c18urY5U9yPjyRAPHtzgC2K7njes=
X-Received: by 2002:a19:8d01:: with SMTP id p1mr4498871lfd.149.1541755319158;
 Fri, 09 Nov 2018 01:21:59 -0800 (PST)
MIME-Version: 1.0
References: <20181101004410.6893-1-natechancellor@gmail.com>
In-Reply-To: <20181101004410.6893-1-natechancellor@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 9 Nov 2018 10:21:47 +0100
Message-ID: <CACRpkdb_zHuTshzaHYUbkEnSdYhk1Moyu1QWTRzwXOELLNoV1A@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: sprd: Use define directive for
 sprd_pinconf_params values
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 1:44 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:

> Clang warns when one enumerated type is implicitly converted to another:
>
> drivers/pinctrl/sprd/pinctrl-sprd.c:845:19: warning: implicit conversion
> from enumeration type 'enum sprd_pinconf_params' to different
> enumeration type 'enum pin_config_param' [-Wenum-conversion]
>         {"sprd,control", SPRD_PIN_CONFIG_CONTROL, 0},
>         ~                ^~~~~~~~~~~~~~~~~~~~~~~
> drivers/pinctrl/sprd/pinctrl-sprd.c:846:22: warning: implicit conversion
> from enumeration type 'enum sprd_pinconf_params' to different
> enumeration type 'enum pin_config_param' [-Wenum-conversion]
>         {"sprd,sleep-mode", SPRD_PIN_CONFIG_SLEEP_MODE, 0},
>         ~                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
>
> It is expected that pinctrl drivers can extend pin_config_param because
> of the gap between PIN_CONFIG_END and PIN_CONFIG_MAX so this conversion
> isn't an issue. Most drivers that take advantage of this define the
> PIN_CONFIG variables as constants, rather than enumerated values. Do the
> same thing here so that Clang no longer warns.

Patch applied with Baolin's review tag.

Yours,
Linus Walleij
