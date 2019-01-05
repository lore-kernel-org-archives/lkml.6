Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA306C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 12:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E50213F2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 12:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="pojXthvg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfAEMvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 07:51:17 -0500
Received: from onstation.org ([52.200.56.107]:42732 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbfAEMvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 07:51:17 -0500
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 7266811;
        Sat,  5 Jan 2019 12:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1546692676;
        bh=vrBbVZ3wZNiNHLkB238+fTMNqvePi1wGBDAe/oVFE1k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pojXthvgayC9vMXX8pMEhRL5VhFkiqixlj03L9BS35QrBXrM5zV2VNkB1puEMMxvM
         1taLQ7DgVjmOLnSxEWUdKkT1+dASWsEDMjs5dmZdvGBis7adkuR4bLjKXQ3FXb+FY3
         5zOSmPnfRHEaZMlAutjI3xQss0opIvmLdhf5Y92s=
Date:   Sat, 5 Jan 2019 07:51:15 -0500
From:   Brian Masney <masneyb@onstation.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     andy.gross@linaro.org, bjorn.andersson@linaro.org,
        linus.walleij@linaro.org, marc.zyngier@arm.com,
        shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] qcom: spmi-gpio: add support for hierarchical IRQ
 chip
Message-ID: <20190105125115.GA2647@basecamp>
References: <20181229114755.8711-1-masneyb@onstation.org>
 <20181229114755.8711-3-masneyb@onstation.org>
 <154656291378.15366.8661245319757182529@swboyd.mtv.corp.google.com>
 <20190105120844.GA2298@basecamp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190105120844.GA2298@basecamp>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 05, 2019 at 07:08:44AM -0500, Brian Masney wrote:
> > I also seem to recall that GPIO numbering starts from 1 instead of
> > 0, so please keep that in mind.
> 
> I'm using the pinctrl numbering, which is zero based.
> 
> / # head /sys/kernel/debug/pinctrl/fc4cf000.spmi\:pm8941@0\:gpios@c000/pins 
> registered pins: 36
> pin 0 (gpio1) 
> pin 1 (gpio2) 
> pin 2 (gpio3) 
> pin 3 (gpio4) 
> pin 4 (gpio5) 
> pin 5 (gpio6) 
> pin 6 (gpio7) 
> pin 7 (gpio8) 
> pin 8 (gpio9) 

After more thought: the pin numbering from pinctrl is an implementation
detail that device tree should not be aware of. This needs to be the
GPIO pin number. I'll correct this in v2.

Brian
