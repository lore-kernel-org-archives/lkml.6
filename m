Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015E8C04EBA
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 12:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17BB2086E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 12:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SY1vGsru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B17BB2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbeKYXjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 18:39:51 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41931 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbeKYXju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 18:39:50 -0500
Received: by mail-lj1-f196.google.com with SMTP id z80-v6so14095392ljb.8
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 04:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OTHNKStSlNnbHa+Ar5ZmoUbdiW/Nu6yGtTGXHQmuWkE=;
        b=SY1vGsrudf4v6JJ8Nj6V3fCtWK1dIihM88+QS7/Wvu5Wm43D4DQj2REI/XjqJ4fYrS
         /3M0M0t1YdRDCc67PPoxog6DHWRmxfAgr0U39ZKWrcmkVsDMHkW7G4JQ+kSe5F7BEHEc
         /o68gCd8+Fm6LtRderC9hr4r/skSnG1TZQbV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OTHNKStSlNnbHa+Ar5ZmoUbdiW/Nu6yGtTGXHQmuWkE=;
        b=EIH8OHAo1zIL1AVPEb8o0eU0TvGJHzzAZEWATIzX8346OZvkfRV7IjXj1ZfZVZxqbg
         AqYKQKIzu2cMaiCA/ZCJlJUN0CL4LF1WYOJljPr3byaH+RcnD/XUbDCv8CmuH53EE8l6
         CYosvA31HZQ8DxQox6q5Q+pQJmKJd20+wS5JdlYty6/DfCW4nMJiTGmsF94+15itxPqS
         qzbDXXYxUNKBDZCIET6p34RHekBlOmA2dV9C58g3endjWzkHnghR4qalTWa2R2pDaVNi
         BB5aisEnRr732gN12gfoahSZKZjfi0wz/rpHU5/8xgFef52uVAUmecgyYBa4O+xc7sce
         +HJQ==
X-Gm-Message-State: AA+aEWYIqNWWfA7hvae5fGgxogMkT3V39DgdKf/U60AON9TZ9lzd6pDE
        zvlJ2qV4ytHfv514ODZYf21J3lkAZ3dTTbX8X1YX3g==
X-Google-Smtp-Source: AFSGD/U2E1dOcCb6blA/Q+qvmMcx60UcdAjE5v7e4R4LCH7kmBTtQhE1XCC5s+++VMhzyBc+5ZclzoEkQPQgFf4RKEY=
X-Received: by 2002:a2e:9e03:: with SMTP id e3-v6mr14236673ljk.4.1543150128588;
 Sun, 25 Nov 2018 04:48:48 -0800 (PST)
MIME-Version: 1.0
References: <cover.1543131714.git.mesihkilinc@gmail.com> <ac8d900789e967650e0ab16eeadc04ec456fcf34.1543131714.git.mesihkilinc@gmail.com>
In-Reply-To: <ac8d900789e967650e0ab16eeadc04ec456fcf34.1543131714.git.mesihkilinc@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 25 Nov 2018 13:48:37 +0100
Message-ID: <CACRpkdZEZMsf_eHen_Mf6ag_iTmW48w4Oyyhs6m8tfmOcen76Q@mail.gmail.com>
Subject: Re: [RFC PATCH v4 10/17] dt-bindings: pinctrl: Add Allwinner suniv
 F1C100s pinctrl
To:     mesihkilinc@gmail.com
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-sunxi@googlegroups.com,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>, julian.calaby@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 8:44 AM Mesih Kilinc <mesihkilinc@gmail.com> wrote:

> Add compatible string for Allwinner suniv F1C100s SoC's pinctrl.
>
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Patch applied to the pin control tree for v4.21.

Yours,
Linus Walleij
