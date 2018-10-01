Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AE7C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A4F4208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9D2qS9j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A4F4208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbeJBDQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 23:16:19 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34076 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeJBDQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 23:16:19 -0400
Received: by mail-ot1-f68.google.com with SMTP id i12-v6so14578476otl.1;
        Mon, 01 Oct 2018 13:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cVjvaYwXb1HGdrLsWE8AuKxl5M7TUaHxZjnB36ft2nM=;
        b=U9D2qS9jYDtY1elLFnngu45sABN/KaydMtd8pH2rEyanA8RQ9gBGzTGUtIwmabRoMd
         DZrwfCRAbgJVstKKodU83ikId4Iq2AVkFXnM9tqW9zPvtEEtxdVRzSy+fTLh5LPN3Vrk
         WMIojz93z0RLNFS/91z7MFsthAH8JAgswFFDGF40hTIW4KNCX92kQBTGyWOW7HVwWP7V
         wq+OGVrI0uJkZEtPXHojmtGoBpwvSamDz+G1uowzcLSxUDOfM7gtwgl5otV1tfXK0mJI
         JilXbKCqVpsJtUNG+xNZHYGj/KDcB9+7xl2zItZgQuvVXtByp79XHUelXB7wgJFNf3Pi
         y1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cVjvaYwXb1HGdrLsWE8AuKxl5M7TUaHxZjnB36ft2nM=;
        b=Z+rfKwom2ybzvUy7IMiJbuS/42TDA5NRqmWib7HiET6244FVDg0v/kfHQcxJzFdoFW
         gNvB6fbxaFEEwC5vRlu+fEKpk8Ht13mj0eUd32c+XidGIXYsrQRBBQY8UyX1Ydo8EC8e
         ccykkPil6/32WmUfJ3zGC5qkHFF7qUOWZEVwCxWmebpe3t+zSqqueHhHx47pE0GRo9PS
         LoI6W7BZU9f+PJCTUTqoqlkJyK1DY+rNPWePRmYSz7yFLRKJMyuwwdQewd6HVvBv1Kh/
         0SY3f7+jnYU3jRk+DLxtuZDtIm317CG0bvWk8TGw+U7ZYR5uWMkxqdU8u8DWXgBHwxpn
         W+7A==
X-Gm-Message-State: ABuFfojPez1TEatx7a3N9j1h4mSe1Alyp3WLOOmbjq21+ewzM0A7UPuC
        UXBcz+fLlQ96DFo+MzaZ0qMxIKX3M1cZSN/IQWg=
X-Google-Smtp-Source: ACcGV616s/i7mpeaw4DwpSfKQl0g8CSZGr8UWYADqHrqL6Go7etTW7K6s2K0sIXXoRPh774RAXUr0+uMjsfpq6EVYhE=
X-Received: by 2002:a9d:209:: with SMTP id 9-v6mr7790679otb.228.1538426204424;
 Mon, 01 Oct 2018 13:36:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180906122436.25610-1-linus.walleij@linaro.org>
 <afd78fe6a5e168cc9190afe3e27d12286e0dfafa.camel@nxp.com> <CACRpkdbcBrjKar4CDg+yEVuCNE3RiGD61UkPasZ35SSmSNsUBA@mail.gmail.com>
In-Reply-To: <CACRpkdbcBrjKar4CDg+yEVuCNE3RiGD61UkPasZ35SSmSNsUBA@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 1 Oct 2018 17:37:02 -0300
Message-ID: <CAOMZO5BhjDk4u4Y4H7swKK0faWaZWL7sFHZC7=G8Em0-jusUHA@mail.gmail.com>
Subject: Re: [PATCH v7] regulator: fixed: Convert to use GPIO descriptor only
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        John Stultz <john.stultz@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fugang Duan <fugang.duan@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Yongcai Huang <anson.huang@nxp.com>,
        Tony Lindgren <tony@atomide.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, jmkrzyszt@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Mon, Oct 1, 2018 at 5:17 PM Linus Walleij <linus.walleij@linaro.org> wrote:

> > reg_enet_3v3: regulator-enet-3v3 {
> >         compatible = "regulator-fixed";
> >         pinctrl-names = "default";
> >         pinctrl-0 = <&pinctrl_enet_3v3>;
> >         regulator-name = "enet_3v3";
> >         regulator-min-microvolt = <3300000>;
> >         regulator-max-microvolt = <3300000>;
> >         gpios = <&gpio2 6 GPIO_ACTIVE_LOW>;
> > };
>
> This is a bit odd actually, the GPIO_ACTIVE_LOW flag will
> be ignored as you see:

Yes, the flag will be ignored by the regulator driver, but the dts
description is correct: it is an active low GPIO that turns on the
reg_enet_3v3 regulator.

The 'enable-active-high' flag needs to be passed to indicate an active
high polarity.

> > [    0.153171] reg_fixed_voltage_probe(179): regulator-enet-3v3 call gpiod_get_optional gflags=0x7 ena_gpio_invert
> > [    0.153218] regulator-enet-3v3 GPIO handle specifies active low - ignored
> > [    0.153233] of_gpio_flags_quirks(83): regulator-enet-3v3 set active low because !enable-active-high
>
> Because regulators don't specify active high/low in the second
> cell because of legacy bindings.
>
> So this should not be in the device tree anyway, it should be
> GPIO_ACTIVE_HIGH or just 0.

Then it would provide a wrong description that does not describe the reality.
