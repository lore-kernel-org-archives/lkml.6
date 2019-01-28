Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D5FC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE3E2148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfA1HiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 02:38:16 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34273 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfA1HiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 02:38:15 -0500
Received: by mail-lf1-f65.google.com with SMTP id p6so11109588lfc.1;
        Sun, 27 Jan 2019 23:38:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5ztKXrdnKNLY25+ilUDivYEMC2QmNk3kk4RYuvHn6dw=;
        b=XRHnZUHzLmofyjMk0HCFrW/z5k2kpGHmlGgmPtxTEKMrKlK1hdhsJV8q4iTpXKyt4z
         /dLVtXQ9L8/r0USNCFFAnDnYXslmiD6zVcbpNRgUDuAnPLojD/kCYJC8nF6cPsyz3iN4
         kUzHkjNFUS3Kx3Vnudupt7Pyg0FekNPLXAsE9BY6szNDycKYGSkglOGy/t/oHbb5VVuy
         XYIrMRvbl71hfqGgpkSzXVipn28YIp0/Ddxg7B4juoc67R0VVmJQwM1oZUzbyyrRLBvS
         Gdppcaq1+SWdLCGU1wxBTO3bPJZ3X26adfEp47w5dygaFpmwBK4/a0jX154Cip37cAVB
         7mog==
X-Gm-Message-State: AJcUukeF6cgmopI+V/vTx0gmzH9nXwVPvVThSOKUPeeBQb0KYNPnDNqg
        MhSSv2o6hIt9vhgpb2ddpfE=
X-Google-Smtp-Source: ALg8bN5mkGY9S4brwRB4G1vTKubD+fEvYY5GjiimeT/Ey5sKXogr+4vilFH1XcQtq6Z3gUM92d4k/A==
X-Received: by 2002:a19:be16:: with SMTP id o22mr16027746lff.22.1548661092545;
        Sun, 27 Jan 2019 23:38:12 -0800 (PST)
Received: from localhost.localdomain (dytkl7s9vpj00trvf9g2y-4.rev.dnainternet.fi. [2001:14bb:410:9dbf:b161:fde8:3a24:e96c])
        by smtp.gmail.com with ESMTPSA id x24-v6sm3141954ljc.54.2019.01.27.23.38.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 23:38:11 -0800 (PST)
Date:   Mon, 28 Jan 2019 09:38:03 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     mazziesaccount@gmail.com, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com, robh+dt@kernel.org,
        mark.rutland@arm.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        linux@roeck-us.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [RFC PATCH v2 00/10] support ROHM BD70528 PMIC
Message-ID: <20190128073803.GA2030@localhost.localdomain>
References: <20190125110110.GA29171@localhost.localdomain>
 <20190128071936.GD4678@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190128071936.GD4678@dell>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Lee, All

On Mon, Jan 28, 2019 at 07:19:36AM +0000, Lee Jones wrote:
> On Fri, 25 Jan 2019, Matti Vaittinen wrote:
> 
> > Patch series introducing support for ROHM BD70528 PMIC
> > 
> > Please note that patch 1 breaks compilation without patches 2 and 3
> > 
> > ROHM BD70528 is a programmable Power Management IC for battery
> > powered 'ultra low power' systems like the pre-announced NXP
> > i.MX7 ULP. This patch series introduces support for the PMIC.
> 
> It looks like you've sent this set un-threaded, which means as people
> reply to the patches, they are going to be spread out into the four
> winds (in Inbox terms).

Sigh. Sorry for trouble then. I must've forgotten the --thread from
git format-patch. You can skip the v2 if it's all scattered out, I
will address issues spotted by Guenter and send out the v3 - and this
time I make sure to use --thread =)

Br,
    Matti Vaittinen

> 
> -- 
> Lee Jones [李琼斯]
> Linaro Services Technical Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
