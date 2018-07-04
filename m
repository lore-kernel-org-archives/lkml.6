Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C2DC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFEDA2098B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpS2EQ9O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFEDA2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753313AbeGDPKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 11:10:24 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35952 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752528AbeGDPKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 11:10:20 -0400
Received: by mail-oi0-f66.google.com with SMTP id r16-v6so11332148oie.3;
        Wed, 04 Jul 2018 08:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UDIi2tn/jW45JlzLwka+iMgd0+6GUIxvFhMsFDelJOM=;
        b=FpS2EQ9O+MgZZfFUHuFPiYO1W/YAq8h7LRmbAYfqfYuOOQQisdpMFyGGqnBLiVbKZ1
         ScA8Ku55jRXWjZwE1o5FEE2UXzSbKx4RWM5nGSRTu3l6/dW6P5th7XpSOuTmMbABTZlS
         E9olmlccQ9H8IAwz6jhKCzkp35lh3tKfmCaM3XQDPEP1LSDyDlXnQsokSdNQliGL2vDy
         sjl8cBkPAjuwramOjhX9wvMZJn+D/LzxIjMZ9yT/jFQ/F9vcFOX9cP/1/dahcEa3uzJt
         5ANIBPgG+jxFPInkAYD0MGloDvY+URgS7aFAVK8UoWbF9eLjIUEqczStT5r6eHOn4ztD
         9kVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UDIi2tn/jW45JlzLwka+iMgd0+6GUIxvFhMsFDelJOM=;
        b=JxhV9nc5j3OXjmqIJZQhrCuMr2eO+1YDUKluOWvjznOnxwZoOCMWRTW3nYUn9ZCllH
         zUSiVhe5oPplIFGukltH1T03Wn+p32XpUjwQrqWPb6oYGYa2Errm2JABV7RWq/gMlBQU
         Pz3r/OBmLR9Gfas2bqSqZqX64FY2Eqrgd9d3pprjnnSf6Zip5wUn0b21xmQ9zTofA39G
         ui9/niqPD64c8rdvqTnhynt61dBFrMMCEdAOJYjIjytehD64OEtnicF2RGX+2c2NeLmK
         sOQo8iBn5Iun7lPMflu2kwvhs+tn+rtKAj5KkWVdsoEy3zE0qOELekjHb7JFHXY6+ZZf
         HAKw==
X-Gm-Message-State: APt69E1KJsFxDYONqPVNMLEvhMbuwAbiAd8OwH71xrlxGp/h6FLXgF34
        93+xAfIkd8Ara72aNcwpyZOR3gBf
X-Google-Smtp-Source: AAOMgpfrJsvm3NjH4aUBL9+2wbg9QzcFOCh0nBM23CQcR6DxUMReQHbQRtDm7OvbUzZig4x4pwEtlw==
X-Received: by 2002:aca:42:: with SMTP id 63-v6mr2427273oia.154.1530717019128;
        Wed, 04 Jul 2018 08:10:19 -0700 (PDT)
Received: from localhost ([12.130.117.108])
        by smtp.gmail.com with ESMTPSA id h22-v6sm3328733otc.25.2018.07.04.08.10.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 08:10:17 -0700 (PDT)
Date:   Wed, 4 Jul 2018 14:56:23 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     matti.vaittinen@fi.rohmeurope.com,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, mazziesaccount@gmail.com,
        Arnd Bergmann <arnd@arndb.de>,
        Sebastian Reichel <sre@kernel.org>, chenjh@rock-chips.com,
        andrew.smirnov@gmail.com, Linus Walleij <linus.walleij@linaro.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-clk@vger.kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v7 1/4] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
Message-ID: <20180704145623.zgei3ehrwdpcu26r@penguin>
References: <cover.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <7e1888375c979accc402e9ddd7316e528b2ac52c.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <CAFqH_51izuVgHukAORvwjZqGhxy85tdNdaHL9mOUnPnbCQmQjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqH_51izuVgHukAORvwjZqGhxy85tdNdaHL9mOUnPnbCQmQjA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On Tue, Jun 26, 2018 at 11:06:33AM +0200, Enric Balletbo Serra wrote:
> Hi Matti,
> 
> Thanks for the patch, a few comments below, some are feedback I
> received when I sent some patches to this subsystem.
> 
> Missatge de Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> del
> dia dt., 19 de juny 2018 a les 12:57:
> > +};
> > +
> > +/* bd71837 multi function cells */
> > +static struct mfd_cell bd71837_mfd_cells[] = {
> > +       {
> > +               .name = "bd71837-clk",
> > +       }, {
> > +               .name = "bd718xx-pwrkey",
> > +               .resources = &irqs[0],
> > +               .num_resources = ARRAY_SIZE(irqs),
> > +       }, {
> > +               .name = "bd71837-pmic",
> > +       },
> nit: no comma at the end

Actually, trailing comma is preferred on structures/arrays without
sentinels, because if one needs to add a new entry/new member, then in
the diff there will have only one new line added, instead of one line
being changed (adding now necessary comma) and one added.

Thanks.

-- 
Dmitry
