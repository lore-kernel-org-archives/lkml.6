Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92E0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A6021479
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BrH2hIb6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A6021479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbeJJQHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 12:07:04 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:50878 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbeJJQHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 12:07:04 -0400
Received: by mail-it1-f196.google.com with SMTP id k206-v6so773074ite.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 01:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f6C6VfVSp5sz2Cj5uAi33BG0XGOYtZCu21hskrBNk8I=;
        b=BrH2hIb6KJdaCMh4evE3sPbExwtKJ9KKbad6i+OxFXQJsiVclSLHc0R4lemSPhSoC2
         AgsvJVx0WwgUZ2N84uACXWF1AxyoQOaRHA+MJvJxcNTRp+yQHBW+p6TubF0dRNCIXP70
         diImL4FChP2s/ufBqf531iXDuTaut87CxLreM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f6C6VfVSp5sz2Cj5uAi33BG0XGOYtZCu21hskrBNk8I=;
        b=hijtGQYhXt0i2ZM1bGLzeISLfD304gZbRPiCrNnwvtuer1K7hodB8PcepBYlwQQMc2
         lz2QhbDFgMsrejWFNPO5aciA9muVIeQG4SXUsPDE7Y/x9J8F+TmYqiHU6KrSm4+lO0Fq
         76gl5wcDDvnNOvegutn3eMp2Ez1CbMURB3wIfNo06fAdNG2Dur0L5RDthuKIhIHclpLA
         /Sw04HMVwCkjwujVKndrqmJFL4O5yTnIfwNeqPlqVVq8VD0bofSq8mBhxFNylK0ZBSdN
         rPYofVuC0UdWp5KqCnN9YD5MElG+14kOnUzmWrI4aeudLgV/UcucB9Qw61Ka9rhv2tM/
         2GTQ==
X-Gm-Message-State: ABuFfog+TD0nMtPl2nyDsBF2kAP8mgVbl3+U8NFlPo9oUcz0rqIn3dNQ
        n2uBGC6HQqjd2F2DKvNYB/pCd9bFHLtJlg3YwrHpMQ==
X-Google-Smtp-Source: ACcGV61UDEnsXtvz42/jd80nmxrJ0YCx222F9AXtVeu1w0rh6w6bIPWF2RDW34M64f8wgAIw+aJ5T8kijRf/hXpi+fw=
X-Received: by 2002:a24:7b50:: with SMTP id q77-v6mr28326itc.154.1539161155235;
 Wed, 10 Oct 2018 01:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <20181008211205.2900-1-vz@mleia.com> <20181008211205.2900-4-vz@mleia.com>
In-Reply-To: <20181008211205.2900-4-vz@mleia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 10 Oct 2018 10:45:43 +0200
Message-ID: <CACRpkdZJMPYWHBUXohjxo12XZpLdz7OzcWRBrrkcB8YLLd5StA@mail.gmail.com>
Subject: Re: [PATCH 3/7] dt-bindings: pinctrl: ds90ux9xx: add description of
 TI DS90Ux9xx pinmux
To:     Vladimir Zapolskiy <vz@mleia.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Vasut <marek.vasut@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-media@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

thanks for your patch!

Can we change the subject to something like "add DT bindings" rather than
"add description" as it is more specific and makes it easier for me as
maintainer.

On Mon, Oct 8, 2018 at 11:12 PM Vladimir Zapolskiy <vz@mleia.com> wrote:

> From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
>
> TI DS90Ux9xx de-/serializers have a capability to multiplex pin functions,
> in particular a pin may have selectable functions of GPIO, GPIO line
> transmitter, one of I2S lines, one of RGB24 video signal lines and so on.
>
> The change adds a description of DS90Ux9xx pin multiplexers and GPIO
> controllers.
>
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
(...)
> +- gpio-ranges: Mapping to pin controller pins (as described in
> +       Documentation/devicetree/bindings/gpio/gpio.txt)
> +
> +Optional properties:
> +- ti,video-depth-18bit: Sets video bridge pins to RGB 18-bit mode.
> +
> +Available pins, groups and functions (reference to device datasheets):

Please reference the generic binding you're using here:
Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt

Apart from these small nitpicks it looks very standard and good.

Yours,
Linus Walleij
