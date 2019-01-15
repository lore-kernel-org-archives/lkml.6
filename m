Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467D1C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1480F20866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="PGFOt4XG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391354AbfAOXVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 18:21:43 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38129 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728858AbfAOXVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 18:21:43 -0500
Received: by mail-qt1-f196.google.com with SMTP id p17so5078159qtl.5;
        Tue, 15 Jan 2019 15:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uJY4lwOCQUNKRZERBYPlCOhWD3u8IjOlUrsRcWLxW8s=;
        b=PGFOt4XG7tkv/XzZ9jYKTv2a/Fs+ps/iGvjiA8tK0C9GG3H39SvV+A259P1YKKX+Gm
         HZ8p7WrykuuaO8FHP3hFGaTrdUPTXNUv70fqENF3cXj7yqH+fxUvSGrGKuH/mEcT1DpA
         507/DtU8+jooaMDLHsegqLpbeqrkGVnbBFlKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uJY4lwOCQUNKRZERBYPlCOhWD3u8IjOlUrsRcWLxW8s=;
        b=Gy1DQB8G2tlA9aHF8Vgz02AKRoGgZW2Z4CfmmFkvtxYhoB1g20iO6dTg4WYjG0sQi2
         kM3clLj71DaTekCEXrqTUHhBbjJV/CY99TEzTYpnfEs6SmmpZ+8kBxZL3vTZXFZPyRB2
         FPEg0+0xdNPsZgIKf5jQinp/oSFZXji5srO9rjJTec/3P21NbiSicm+5jpu5EA+ZS85T
         H7YewtDDeNs3nEjSQDBI+dJXnn2+c7uO47Uezmr5Ee5hTuHs1SOyYncv7pU1Ac9y9RAF
         LhZ2vQhKSHDriWLsEZ19hilWI4f3Ka8depyfmtdbwLQnL4COGE5OsgRaLzoCetY6Hvkx
         IMKQ==
X-Gm-Message-State: AJcUukd6o4fNZcL8B4ZRKzAaGFG7nTLoxvGnXvMBESgy6F/hki5BLmeT
        v4U59ZOpHD8nlLmambYrmL2ZGKSSxqhJ0HpqpKA=
X-Google-Smtp-Source: ALg8bN4J74fIT+l5wj9d3fnPDj1BYRvZ6aCu+KiVfjam3KMGNuiuhUyiwyQvgjFeZuKhNpJxyQqLPNk+GaiF3HvlbOs=
X-Received: by 2002:ac8:29b7:: with SMTP id 52mr4835382qts.266.1547594501921;
 Tue, 15 Jan 2019 15:21:41 -0800 (PST)
MIME-Version: 1.0
References: <20190109164343.164205-1-tmaimon77@gmail.com> <20190109164343.164205-2-tmaimon77@gmail.com>
In-Reply-To: <20190109164343.164205-2-tmaimon77@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 16 Jan 2019 10:21:30 +1100
Message-ID: <CACPK8XebHzVAO2TX25N24S0Pgg_0xA=7GN3j0oXhSyD4LmL4=w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-binding: iio: add NPCM ADC documentation
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nancy Yuen <yuenn@google.com>,
        Patrick Venture <venture@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Avi Fishman <avifishman70@gmail.com>,
        linux-iio@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019 at 03:44, Tomer Maimon <tmaimon77@gmail.com> wrote:

> +Required Node in the NPCM7xx BMC:
> +An additional register is present in the NPCM7xx SOC which is
> +assumed to be in the same device tree, with and marked as
> +compatible with "nuvoton,npcm750-rst".

Is there a reason you don't include a phandle to the reset node?

I think doing that would make more sense.

> +adc: adc@f000c000 {
> +       compatible = "nuvoton,npcm750-adc";
> +       reg = <0xf000c000 0x8>;
> +       interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
> +       clocks = <&clk NPCM7XX_CLK_ADC>;
> +};

> +
> +rst: rst@f0801000 {
> +       compatible = "nuvoton,npcm750-rst", "syscon",
> +       "simple-mfd";
> +       reg = <0xf0801000 0x6C>;
> +};
