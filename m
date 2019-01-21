Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C3CC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEFAD20861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DCqnMUG4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731459AbfAUOMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:12:09 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33057 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731342AbfAUNxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:53:51 -0500
Received: by mail-lj1-f193.google.com with SMTP id v1-v6so17631571ljd.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 05:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uvwMtOBefKiecEgPN1K7+ULAO0f6k62sCRvhuaU6xuM=;
        b=DCqnMUG4+mbnEDH0/k1Z6kvK1k4vJqR+bOsS49uTMViKUyoDwi0ImRcd6gSttUECOz
         +sM81lipbfjY96pbhqwImnHK3OtbqtRueVpGkJ6+lTF2fFsuCbAe+NxcKFoNYtpKOO+S
         YhjUH3GhZVXrOLMoRusrUnEzBp6YPGVFGipy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uvwMtOBefKiecEgPN1K7+ULAO0f6k62sCRvhuaU6xuM=;
        b=F8ufb/SAh1m3+v3mcVklJrWJkI3/vLVLiaPOZPnfku/qVnWMFY9hKtsHYY5DWwUXui
         l5xvRUuefuLA1cXHMen4/SKjAB7mf4vx9hf+g9aH1eyDDL4gVSU68JsC2WjALrV+0Dj8
         QcQEW2rEUCDkaEymMXBmY6ojq2CoLfjQ0CoH2MsVqKt67CdqzcuSyas1a4345V8uX4Dx
         l1dKsnexlqIgHbL+aQP7MAdCnEetiRZlhxGJpMc2T122AU2GCZMIXjst9fCiLw/Ve7TM
         CEo/SqV8bucHT+VbC8Xl6uzgKS9vzFdcJv6hZOLTiVLZw5VhVXJiA8w4NXlFcdYfIIpb
         B82A==
X-Gm-Message-State: AJcUukfw/LiJ7mUtihZMnTw33F3kcs97HLc/dPipu58rLXqwoEGXarHI
        i5sO0XrFOkeoGFlifmZ61zEtMEPCVJi1JK05SRpJDQ==
X-Google-Smtp-Source: ALg8bN6b3YwuAKS/hc20afqCPVNjhr7x2aAiaervwjhERUz4wesjKyMNmb5iyooHGBwtMC5W+kYqfh6gsHkZIiC9pds=
X-Received: by 2002:a2e:9e16:: with SMTP id e22-v6mr17858162ljk.4.1548078829175;
 Mon, 21 Jan 2019 05:53:49 -0800 (PST)
MIME-Version: 1.0
References: <20190117102315.1833-1-jbrunet@baylibre.com>
In-Reply-To: <20190117102315.1833-1-jbrunet@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 21 Jan 2019 14:53:36 +0100
Message-ID: <CACRpkdb7pje9mrgOQoiWTRxGQC8xsOvJ9a8PCguM807unPtpCg@mail.gmail.com>
Subject: Re: [PATCH 0/3] pinctrl: meson: g12a fixes
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 11:23 AM Jerome Brunet <jbrunet@baylibre.com> wrote:

> This patchset fixes the initial pinctrl support added for th g12a SoC
> family, which is mainly around the register regions claimed by the
> driver.
>
> Linus, would it possible for you to provide a tag with these changes to
> Kevin ?

https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=ib-meson-fixes

> ATM, we can only use the devices for which the pinmux is already set by
> the bootloader. Enabling the broken pinctrl driver could cause regressions
> in kernelCI. Having a tag, would allow us to start using pinctrl on this
> SoC in this cycle, w/o regression. It would be nice :)

When you say "this cycle" do you mean I should target fixes (v5.0-rcN)
or next (v5.1) with these patches?

Yours,
Linus Walleij
