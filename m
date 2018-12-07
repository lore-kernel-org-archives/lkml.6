Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A36C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299BA2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="TRQffJba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 299BA2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbeLGLlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 06:41:19 -0500
Received: from onstation.org ([52.200.56.107]:56340 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbeLGLlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 06:41:18 -0500
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 934E317A;
        Fri,  7 Dec 2018 11:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1544182877;
        bh=0vdZPa0deaLEyw0U5A/jA1efxicecND19j3Bg06yXWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TRQffJba6w+cUIuOeGx6RSLb70LuCRnLt7ulBevqZjklMg1Q9E9s4h2iL2uchSLwO
         h/MNbzc8q5AHwPGYQuZuNl6OLz7wg+VGMbKgIG+DFmum606qHPF1/sjM4YQSR32UjX
         kLGcjR9ueziPkDQHjkc4n9O7GSMIOXSCR+GZFmaQ=
Date:   Fri, 7 Dec 2018 06:41:17 -0500
From:   Brian Masney <masneyb@onstation.org>
To:     andy.gross@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        jonathan@marek.ca, sre@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, bjorn.andersson@linaro.org,
        linus.walleij@linaro.org
Subject: Re: [PATCH v2 6/7] ARM: dts: qcom: msm8974: add gpio-ranges
Message-ID: <20181207114117.GA30737@basecamp>
References: <20181101001149.13453-1-masneyb@onstation.org>
 <20181101001149.13453-7-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101001149.13453-7-masneyb@onstation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 08:11:48PM -0400, Brian Masney wrote:
> This adds the gpio-ranges property to pm8941_gpios so that the GPIO
> pins are initialized by the GPIO framework and not pinctrl. This fixes
> a circular dependency so GPIO hogging can be used on this board.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>

Hi Andy,

All of the dependencies for USB have been merged into their respective
trees. Patches 6 and 7 in this series are the only two that are
outstanding for your consideration.

I know that I'm still waiting for a review from Dmitry regarding the new
vibrator driver [1] and we're nearing the end of the development cycle.
In case he runs into an issue with that driver, I verified that I can use
git am to apply patches 6 and 7 in this series for USB, and the patch
for WiFi [2] without the bindings for the vibrator. I'm hoping to get as
much of this merged into this kernel development cycle as possible.

[1] https://lore.kernel.org/lkml/20181025012937.2154-1-masneyb@onstation.org/
[2] https://lore.kernel.org/lkml/20181104215034.3677-1-masneyb@onstation.org/

Thanks,

Brian
