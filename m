Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7411C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8BB222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437766AbfBNIxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:53:01 -0500
Received: from shell.v3.sk ([90.176.6.54]:59871 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389867AbfBNIxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:53:01 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id F1833100ED6;
        Thu, 14 Feb 2019 09:52:57 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id PWQjJmebuczF; Thu, 14 Feb 2019 09:52:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 409DD100EFE;
        Thu, 14 Feb 2019 09:52:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LamlzKzO1lnT; Thu, 14 Feb 2019 09:52:54 +0100 (CET)
Received: from nedofet.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 38350100ED6;
        Thu, 14 Feb 2019 09:52:54 +0100 (CET)
Message-ID: <50fa8c81950e8bb2583a65bfd920bdf574c9abc1.camel@v3.sk>
Subject: Re: [PATCH] gpio: pxa: avoid attempting to set pin direction via
 pinctrl on MMP2
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>
Date:   Thu, 14 Feb 2019 09:52:52 +0100
In-Reply-To: <CACRpkdYyT20Um+5bDAiZAfB-A3M+q5DpUQS31+CkLUSb+qpQOw@mail.gmail.com>
References: <20190213230618.1907-1-lkundrak@v3.sk>
         <CACRpkdYyT20Um+5bDAiZAfB-A3M+q5DpUQS31+CkLUSb+qpQOw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-14 at 09:13 +0100, Linus Walleij wrote:
> On Thu, Feb 14, 2019 at 12:06 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
> 
> > Similarly to PXA3xx, pinctrl-single can't set pin direction on MMP2 either.
> > See also: commit 9dabfdd84bdfa ("gpio: pxa: disable pinctrl calls for
> > PXA3xx")
> > 
> > Fixes: a770d946371e ("gpio: pxa: add pin control gpio direction and request")
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> Patch applied for fixes.
> 
> Should this even go into stable?

I would tend to think it should.

This caused a regression for MMP2 platforms that don't use a pinctrl
driver, and none of them do.

On the other hand it went unnoticed since v4.5.

I've seen stable maintainers pick up fixes even when stable@ wasn't
Cc'd. I guess they apply some heuristics and perhaps look at Fixes:
tags to identify bugfixes?

> Yours,
> Linus Walleij

Lubo

