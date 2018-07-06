Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E015C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD6C2404E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kzfuFtc4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDD6C2404E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753915AbeGFGLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 02:11:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38892 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753450AbeGFGJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 02:09:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id j33-v6so2936968wrj.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 23:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=yMPJ05UJcGz0/o82QhLnAmPfSIQ92WRD+uhmFDxC+7s=;
        b=kzfuFtc4LNLWJKlrhfWiGb6kBN8WfPXY7Qx1uLCMg+ePVkL3bqqXWcvuVeB4eQZMrz
         tNEne2Z5p0N9KM/hcYomBPKKCrKVFAIUEw+Q7owEqdMZWQ8y494IkXh9CNOSfyBI36k2
         sYjwTnkOustJ+W7rpOV0kd/mvy3dYbk3Mn2Gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yMPJ05UJcGz0/o82QhLnAmPfSIQ92WRD+uhmFDxC+7s=;
        b=LV8Zp5ZxtcvbMCGHChYgWpQYqT5x8gwEmEs9ZsKQmP9faEiuvFGgxZGGKOmUQ+S4uP
         VdP/vJkMFqaC61o2WgCBz1PYwMIw5Oo8hJQ9YnAESKzmsZbdzDd9Dbwu7H7CKGh0bNNN
         JcXb/+VQkMQ+rqz/mvk9QXbRyVEiclxKuvh+eU2GGyV1u4QYqbNyhvJjgF1StPMJa0iz
         i5ZvlWq25dXeTaVMSwvuOLdvLfi5qKJr3mnpvhwsEVzOrl3vCvEyFHLc2QtboNaEEX/f
         0O1lV2fsmee27WloX3z0xS+1a8Fx5TyEffSCgaAROwDzopM9qpejGwNgFNbDKcZcflA/
         LDDA==
X-Gm-Message-State: APt69E0/UditUu6X+T+4Onlu6l10UHWcp+8gISmkJzBfAarbiXbG2Ypj
        QQjAy7L1CNDPjNMHog1wpomDTQ==
X-Google-Smtp-Source: AAOMgpcAImLdMNcm0+8Ive59rXHGeE6So7wG2gY7Tex9nZBp4BWX8kyvgv5kVXbWJAwkkXfJa9C2GA==
X-Received: by 2002:adf:b112:: with SMTP id l18-v6mr6994660wra.101.1530857356354;
        Thu, 05 Jul 2018 23:09:16 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id g125-v6sm8949553wmf.16.2018.07.05.23.09.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 23:09:15 -0700 (PDT)
Date:   Fri, 6 Jul 2018 07:09:13 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     matti.vaittinen@fi.rohmeurope.com,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, sboyd@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
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
Subject: Re: [PATCH v10 1/2] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
Message-ID: <20180706060913.GU496@dell>
References: <cover.1530800707.git.matti.vaittinen@fi.rohmeurope.com>
 <e737bb13d17b75ea5e55f59005ef3181d428e704.1530800707.git.matti.vaittinen@fi.rohmeurope.com>
 <CAFqH_53DbfFTRt2xST6RXg_qu0+LayXjQL2y024We1LHGB3yQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFqH_53DbfFTRt2xST6RXg_qu0+LayXjQL2y024We1LHGB3yQA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Jul 2018, Enric Balletbo Serra wrote:

> Missatge de Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> del
> dia dj., 5 de jul. 2018 a les 16:32:
> >
> > ROHM BD71837 PMIC MFD driver providing interrupts and support
> > for three subsystems:
> > - clk
> > - Regulators
> > - input/power-key
> >
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > ---
> >  drivers/mfd/Kconfig              |  13 ++
> >  drivers/mfd/Makefile             |   1 +
> >  drivers/mfd/rohm-bd718x7.c       | 198 +++++++++++++++++++++++
> >  include/linux/mfd/rohm-bd718x7.h | 333 +++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 545 insertions(+)
> >  create mode 100644 drivers/mfd/rohm-bd718x7.c
> >  create mode 100644 include/linux/mfd/rohm-bd718x7.h

[snipping ~550 lines of code]

> The main changes I requested are done so I think you can maintain my
> reviewed-by.
> 
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Thanks for your review, it's much appreciated.

In future would you mind trimming your mails back to only include
relevant sections please?  Going through ~550 lines of code page by
page trying to find your response was a little painful.  TIA.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
