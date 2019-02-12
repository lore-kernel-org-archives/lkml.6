Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45A4C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4C22186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="FuG2kIoV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbfBLKIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:08:12 -0500
Received: from onstation.org ([52.200.56.107]:59214 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728442AbfBLKIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:08:12 -0500
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 38FF51B;
        Tue, 12 Feb 2019 10:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1549966091;
        bh=uMSwPL4Rf7jH3R2LT99aOh4YdmxkGSz4+6p78X575wA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FuG2kIoVybvavE1Bl6d9QTnyOZqcteSHtsonvw0D/4f2tK/y7nwOMS7PIai6X2fmR
         b0xdXHQxxdgHY08eUd6WWQBBRuYaYvbyDYm6INRHkhfEaMeOHBUfqe33INU5Y/8Rip
         YRDHxU9p0hN5WyRiy/aT6hCIETmwxdD4x7YD/Skg=
Date:   Tue, 12 Feb 2019 05:08:10 -0500
From:   Brian Masney <masneyb@onstation.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] qcom: spmi-gpio: Fix boundary conditions IRQ domain
 translate
Message-ID: <20190212100810.GA12517@basecamp>
References: <20190212035205.23477-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212035205.23477-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 07:52:05PM -0800, Bjorn Andersson wrote:
> GPIOs on the SPMI PMIC are numbered 1..ngpio, so the boundary check in
> pmic_gpio_domain_translate() is off by one, correct this.
> 
> Fixes: ca69e2d165eb ("qcom: spmi-gpio: add support for hierarchical IRQ chip")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Brian Masney <masneyb@onstation.org>
