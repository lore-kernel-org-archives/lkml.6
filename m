Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22856C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E50022081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E50022081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbeKATvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 15:51:48 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38996 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbeKATvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 15:51:48 -0400
Received: from ip5f5a86be.dynamic.kabel-deutschland.de ([95.90.134.190] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gIAXF-0000oD-Gl; Thu, 01 Nov 2018 11:49:09 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Michal Simek <monstr@monstr.eu>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Xu Wei <xuwei5@hisilicon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Koen Kooi <koen.kooi@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Pavel Machek <pavel@ucw.cz>,
        Andy Gross <andy.gross@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        ezequiel@collabora.com, linux-leds@vger.kernel.org
Subject: Re: [PATCH v3 0/7] Standardize onboard LED support for 96Boards
Date:   Thu, 01 Nov 2018 11:49:08 +0100
Message-ID: <1590147.nMxYQPWRVN@diego>
In-Reply-To: <CACRpkdarkLuErC_F4ALqOB5Wuf7TnDXmWZVKvfR7iGvOy=j++g@mail.gmail.com>
References: <20181029094245.7886-1-manivannan.sadhasivam@linaro.org> <CAHTX3dJTXtuA0i-ffPjoiWuxEcF_5JY55VJtWd9zxW4HxK1K3w@mail.gmail.com> <CACRpkdarkLuErC_F4ALqOB5Wuf7TnDXmWZVKvfR7iGvOy=j++g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 31. Oktober 2018, 22:17:29 CET schrieb Linus Walleij:
> On Wed, Oct 31, 2018 at 4:47 PM Michal Simek <monstr@monstr.eu> wrote:
> > No doubt about it that this is good. If this is there from day 1 all will
> > be good. I am just saying that we are all the time
> > saying that we shouldn't break userspace. Right now if there is single
> > application which uses existing names we are breaking it.
> 
> Yeah that's the problem, the approach is usually that if a tree falls
> in the forest and noone is there to hear it, then it doesn't make a
> sound.
> 
> But we can't assume someone is there as the safe default either.
> 
> I'd say apply it and see what happens, people are supposed to test.

At least for the Rockchip boards I'm somewhat confident, that they should
be new enough to not have anybody building cludges - especially as I think
LEDs might not be the most interesting device on such boards :-) .

So while I can apply the Rockchip patches, I'm still hoping for some
kind of consensus beforehand, least we roll it back after the fact  ;-) .

Heiko


