Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676B3C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B662411D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ebcGOB7D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16B662411D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753349AbeGEFwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 01:52:34 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38930 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753213AbeGEFwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 01:52:30 -0400
Received: by mail-wm0-f67.google.com with SMTP id p11-v6so8682583wmc.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 22:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jyIQEaoICbiXUCpuBNhpF4yuWN/hRZQN98U4Ey3mK90=;
        b=ebcGOB7DRoMh+fI0MiUR3w1fz3M1uAzM6NPLHERfwIFPFHknSQ6/ysO9VKqgK2e/qc
         tSrUzrEYdzX7Ku034YeEyUSprHaAup8AQFH8AgvWEuR+JrDuyMPV58e3Pw6CZ2bDIXBH
         sJz9iFxw/lGAuUUahQRRlqt27/sAay5/xxZp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jyIQEaoICbiXUCpuBNhpF4yuWN/hRZQN98U4Ey3mK90=;
        b=qa/2FVueFnWpB27i+0nat+QTsjkOAcUXmw4B12R+8bKy9OGecQO45ZOG9a5Mvqj21A
         DZXYN7Vzbls9TXOm9niU+hkfUKRG8VuJ94jrSP5tZctaucl2uTdNE50bZzxC9kT9UbtD
         qHyfppKmBaE/WG3eI06XoDchGna3I9eZk0qa2pAvDMsw+nA+ritwfkQ9gwWlDS9xgnvJ
         Lbb+qzO8BmUCwzyZ+ZZF99oS8VVUoXKbb4+qePKBBBnjAolp1T/PI3BB4MHa9Av6OIpc
         zmSQ/sBolAxw8D/TJJ0364V0iElIAbAkgCrlxnULCmVhdNWrlRD3UqQKRauG1a9Xoz73
         bBBQ==
X-Gm-Message-State: APt69E1zZ02gFV+MTLDT8LJaBWSx8xhJQFAiBMUy0H70n7vLEOhor95M
        lTU8j6UGCOLDC+9ISwu48EtYKg==
X-Google-Smtp-Source: AAOMgpfW7JVITCkBcOvNV1uuPzc0znuYVMObH11OMwTC2NdQxnTwQzQLspiDGcbsUN/ooCAWOQw9UQ==
X-Received: by 2002:a1c:1c92:: with SMTP id c140-v6mr1875196wmc.155.1530769948803;
        Wed, 04 Jul 2018 22:52:28 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id q17-v6sm7039091wrr.7.2018.07.04.22.52.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 22:52:28 -0700 (PDT)
Date:   Thu, 5 Jul 2018 06:52:26 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        matti.vaittinen@fi.rohmeurope.com,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sebastian Reichel <sre@kernel.org>, chenjh@rock-chips.com,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-clk@vger.kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v7 1/4] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
Message-ID: <20180705055226.GJ496@dell>
References: <cover.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <7e1888375c979accc402e9ddd7316e528b2ac52c.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <CAFqH_51izuVgHukAORvwjZqGhxy85tdNdaHL9mOUnPnbCQmQjA@mail.gmail.com>
 <20180704145623.zgei3ehrwdpcu26r@penguin>
 <CAFqH_50UshTTc0Cv0wBhUoPdm0jZVgcvRKr3qzb=M-jCcMhdtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFqH_50UshTTc0Cv0wBhUoPdm0jZVgcvRKr3qzb=M-jCcMhdtA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Jul 2018, Enric Balletbo Serra wrote:

> Missatge de Dmitry Torokhov <dmitry.torokhov@gmail.com> del dia dc., 4
> de jul. 2018 a les 17:10:
> >
> > Hi Enric,
> >
> > On Tue, Jun 26, 2018 at 11:06:33AM +0200, Enric Balletbo Serra wrote:
> > > Hi Matti,
> > >
> > > Thanks for the patch, a few comments below, some are feedback I
> > > received when I sent some patches to this subsystem.
> > >
> > > Missatge de Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> del
> > > dia dt., 19 de juny 2018 a les 12:57:
> > > > +};
> > > > +
> > > > +/* bd71837 multi function cells */
> > > > +static struct mfd_cell bd71837_mfd_cells[] = {
> > > > +       {
> > > > +               .name = "bd71837-clk",
> > > > +       }, {
> > > > +               .name = "bd718xx-pwrkey",
> > > > +               .resources = &irqs[0],
> > > > +               .num_resources = ARRAY_SIZE(irqs),
> > > > +       }, {
> > > > +               .name = "bd71837-pmic",
> > > > +       },
> > > nit: no comma at the end
> >
> > Actually, trailing comma is preferred on structures/arrays without
> > sentinels, because if one needs to add a new entry/new member, then in
> > the diff there will have only one new line added, instead of one line
> > being changed (adding now necessary comma) and one added.

[...]

> Dmitry, I really appreciate this kind of comments, especially when
> there is a justification, so I can learn more and more to do better
> patches.

+1

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
