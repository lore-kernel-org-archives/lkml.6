Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257CAC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF8321EA0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6Vopnwue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF8321EA0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732529AbeHISIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 14:08:37 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:60022 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731062AbeHISIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 14:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=0l4VFTV4SKU1AZWUzXX+VlHcSV59UxgK9GEEs7SeLcQ=;
        b=6Vopnwue01N76CkXJholiCGmBrbo0n0dadLdSyZamMoHPDXnDwWsqIXsRCEtM6S2j4fGmwJuPN1J0qy3RWIH6vQPc2jBeLSNn2ep0h9ceD4rD9kx4gI0d1ss+4RF3yOhdSifLLUuuDu9C/Q71LcQ4PfqBbkc7MsjM1tiS7CuOtw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fnn5d-00067W-BP; Thu, 09 Aug 2018 17:43:05 +0200
Date:   Thu, 9 Aug 2018 17:43:05 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Richard Genoud <richard.genoud@gmail.com>
Cc:     Aditya Prayoga <aditya@kobol.io>, linux-gpio@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Gauthier Provost <gauthier@kobol.io>,
        Alban Browaeys <alban.browaeys@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Gilmore <dennis@ausil.us>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>
Subject: Re: [PATCH RESEND 2/2] gpio: mvebu: Allow to use non-default PWM
 counter
Message-ID: <20180809154305.GE20006@lunn.ch>
References: <1533522556-55055-1-git-send-email-aditya@kobol.io>
 <1533522556-55055-3-git-send-email-aditya@kobol.io>
 <20180806135257.GB6584@lunn.ch>
 <9d12abba-0be8-bce7-45d5-99659cbe0915@sorico.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d12abba-0be8-bce7-45d5-99659cbe0915@sorico.fr>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm not sure that the logic:
> 1. Default counter assigned to the bank
> 2. Unused counter that is assigned to other bank
> 3. Fallback to default counter
> is the best one.

Hi Richard

It it totally broken, as you point out. That is why i said it needs to
be limited to two PWMs.

> IMHO, I would either:
> - allow only 2 pwm and no more (but that's a pity)
> - allow lots of fans, but once 2 different speeds are set, return
>   EINVAL for another different speed (even if it's on another bank)

This second option also breaks the Linux PWM model.

What you should be thinking about is extending the Linux PWM model so
that one PWM can drive more than one pin.

     Andrew

