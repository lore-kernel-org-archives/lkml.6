Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613FAECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 14:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A7262089F
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 14:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="s+kjpG9F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A7262089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbeGNPHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 11:07:00 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33940 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbeGNPHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 11:07:00 -0400
Received: by mail-oi0-f65.google.com with SMTP id 13-v6so67312978ois.1;
        Sat, 14 Jul 2018 07:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6TfOVYF4dMf4D21RyF0oRb6GwdJd8ohMXa0R2lSb4Dg=;
        b=s+kjpG9FspbOnVsZpJQ31izj9/5vuOLPfLkHn5v/SPEK1fKfma/uReiWdSSpTBZ6lW
         IOh9mszLA0srByqKJdDuMatGUxo/0yR/EaMuB3jhureuK7qx8L9mHFOCBkbx6ft+X9RM
         9EqawCtY4JPraXpKJY2DfrcipK9+2M62FmguBXQcn6YugZhii6R/bbGd8pzYW24/0V6J
         oLZtWoEvUnmdJ76Q2O59mPG22h2cP8RNl04nl+PInraKDEPrzfTBuhp0eGcjqP1WAe3b
         tdnFhzZqp5qafPgWJB1NjYQkEnQFOCqW7bod9jSO7WSO23IaNF5H7pyfEqo8PFX37kcj
         lS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6TfOVYF4dMf4D21RyF0oRb6GwdJd8ohMXa0R2lSb4Dg=;
        b=iZQ9z3IxVMKRH3GafFdy9aPe21p2dsUiqJpOIrYro8l8DsyCqvr+bo+5+UAiVBKvhY
         D7NE/KzGBk/sy33X8PGDjgmVUKGH5ziU8qligXHLGbCxWt5sHdzyExIL3CcZRMxQXUDO
         VW+X6psLdBaRXjJSgRjryqI+xOxXmweES1lHmS7Uegccd9aPypLwod62ZZUmtwJ+P5Wg
         TAvj4p/54nMRhVHSJhuPbo0RKkU+511TBX7zcPY+TZErzV+7heV/4XP58MweYZ060nPV
         +b72z/0FukXFRxbqXdr6+xp5BpsHFx9eaJ3LjIf8xVCAntrAPmgBDMhTctD1FLKdF2Jl
         sizQ==
X-Gm-Message-State: AOUpUlHJwrquv2hYj+ho/94f9NxfBrjAjy6NJjr5Cfnq8MtUWi3CELmT
        axbvMOZ+SCceCaXuFfGcrl1dKJFep7StyxUy+dw/52EL
X-Google-Smtp-Source: AAOMgpfgmR5RN7LZSqLiUsC7ono6ILXHjDJAWjD7wsn6MAMKQ1OH+AC2A3pLEmAHjdZomQBQ86qX05L2EA0PnXwGc9k=
X-Received: by 2002:aca:68a2:: with SMTP id o34-v6mr12048264oik.267.1531579661307;
 Sat, 14 Jul 2018 07:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180704224511.29350-1-yixun.lan@amlogic.com> <20180704224511.29350-3-yixun.lan@amlogic.com>
In-Reply-To: <20180704224511.29350-3-yixun.lan@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 14 Jul 2018 16:47:30 +0200
Message-ID: <CAFBinCBcsg8CFkTfx1CrZYHrTk0Yz=auDzAxoen4SzneELjgSQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: pinctrl: meson-g12a: document pin name
To:     yixun.lan@amlogic.com
Cc:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        robh@kernel.org, Neil Armstrong <narmstrong@baylibre.com>,
        khilman@baylibre.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        carlo@caione.org, linux-amlogic@lists.infradead.org,
        xingyu.chen@amlogic.com, jbrunet@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yixun,

On Wed, Jul 4, 2018 at 4:49 PM Yixun Lan <yixun.lan@amlogic.com> wrote:
>
> Document the pins for Amlogic's Meson-G12A SoC.
I suggest to combine patch 1 (adding the compatible string) and 2 (this one)

as discussed in the cover letter: it would be great if you could add a
comment (at least to the commit message) stating that GPIOE is
actually located (checked with the ASIC / hardware team) in the AO
bank

> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
with that:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> ---
>  include/dt-bindings/gpio/meson-g12a-gpio.h | 114 +++++++++++++++++++++
>  1 file changed, 114 insertions(+)
>  create mode 100644 include/dt-bindings/gpio/meson-g12a-gpio.h
>
> diff --git a/include/dt-bindings/gpio/meson-g12a-gpio.h b/include/dt-bindings/gpio/meson-g12a-gpio.h
> new file mode 100644
> index 000000000000..f7bd69350d18
> --- /dev/null
> +++ b/include/dt-bindings/gpio/meson-g12a-gpio.h
> @@ -0,0 +1,114 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
> +/*
> + * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
> + * Author: Xingyu Chen <xingyu.chen@amlogic.com>
(since I'm not sure about all the licensing bits:) do we also need a
"Signed-off-by" from Xingyu Chen?


Regards
Martin
