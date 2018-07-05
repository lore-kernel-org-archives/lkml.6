Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEC8C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A52623EA1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="Ai3bwL12"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A52623EA1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753419AbeGEN3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:29:22 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166]:28839 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753155AbeGEN3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1530797359;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=m8N4JxyY6IMQNfNjmRlg7tt4IJnQcv38ln2WSFjJMhM=;
        b=Ai3bwL12ge9Jl9FbaOFV/JwOH2hwIIMGXY/miQsLtk9lJ1iVI3gJmuiqmXHXdyuN2H
        ZeJHIZ8LFAk7fDhYHZlaal9HRoLnWZ7HXUjJwtRbm0B3PRdk4SUkCa/sEMPrvbwkaTuf
        Xjy1GEKUBAqg/T6qmO20Ub2g2OMe59YcDvacb0yLmnt2X4NHY1delKzT/ucdXbDMCvG6
        Tjt9lUyMLL6vO2CZ+e69selnj0OCKCv2UC33XxQDWh6/U0ZWN+udu4o7alhPx17pTbpN
        FLYrQhxGcvVESGSk5tjTwlN1i3Ej7b9A8I/SaArKdaBvxQxgnAe/cWXlQx/y+xzrFHPs
        Yfrw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw87WiucxqETvxPQ=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 43.12 DYNA|AUTH)
        with ESMTPSA id 307753u65DSf5Hs
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 5 Jul 2018 15:28:41 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCHv3 0/5] pinctrl fixes for generic functions and groups
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20180705091018.60524-1-tony@atomide.com>
Date:   Thu, 5 Jul 2018 15:28:41 +0200
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Christ van Willegen <cvwillegen@gmail.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Sean Wang <sean.wang@mediatek.com>
Content-Transfer-Encoding: 7bit
Message-Id: <927EBDA8-8A94-4D7D-9EEF-32A02F5346BD@goldelico.com>
References: <20180705091018.60524-1-tony@atomide.com>
To:     Tony Lindgren <tony@atomide.com>,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony and Linus,

> Am 05.07.2018 um 11:10 schrieb Tony Lindgren <tony@atomide.com>:
> 
> Here is a resend of fixes for a race issues for generic group and
> functions reported by H. Nikolaus Schaller <hns@goldelico.com>.

Thanks for adding me.

I have tested these patches on our OMAP3 based device where the problem
was quite reproducible and testable by adding some printk. With
these patches it seems now to be correct. Each group selector is
assigned only once, even if driver probing fails and is redone later.

Code review of the call paths has convinced us that we now have
proper mutex around the radix tree function calls and races are
no longer a problem.

So you can add my

	Tested-By: H. Nikolaus Schaller <hns@goldelico.com>

BR and thanks,
Nikolaus

> 
> Regards,
> 
> Tony
> 
> 
> Changes since v2:
> 
> - Added Nikolaus to Cc as Reported-by did not do it
> 
> Changes since v1:
> 
> - Check if a function or group already exists as suggested by
>  Andy Shevchenko
> 
> - Make sure we always have a valid name for functions and groups
>  as suggested by Christ van Willegen
> 
> - Prettify rza1 variables as suggested by Jacopo Mondi
> 
> Tony Lindgren (5):
>  pinctrl: core: Return selector to the pinctrl driver
>  pinctrl: pinmux: Return selector to the pinctrl driver
>  pinctrl: single: Fix group and function selector use
>  pinctrl: rza1: Fix selector use for groups and functions
>  pinctrl: core: Remove broken remove_last group and pinmux functions
> 
> drivers/pinctrl/core.c           | 35 ++++++++++--
> drivers/pinctrl/core.h           |  6 ---
> drivers/pinctrl/pinctrl-rza1.c   | 24 +++++----
> drivers/pinctrl/pinctrl-single.c | 91 +++++++++++++++++++-------------
> drivers/pinctrl/pinmux.c         | 16 ++++--
> drivers/pinctrl/pinmux.h         |  7 ---
> 6 files changed, 112 insertions(+), 67 deletions(-)
> 
> -- 
> 2.17.1

