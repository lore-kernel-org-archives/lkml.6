Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9881C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6A320C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F6A320C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeIYPJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:09:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53870 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbeIYPJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:09:22 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BA6641117;
        Tue, 25 Sep 2018 09:02:49 +0000 (UTC)
Date:   Tue, 25 Sep 2018 11:02:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Christ van Willegen <cvwillegen@gmail.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Sean Wang <sean.wang@mediatek.com>,
        Tony Lindgren <tony@atomide.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.18 164/235] pinctrl: pinmux: Return selector to the
 pinctrl driver
Message-ID: <20180925090247.GC22609@kroah.com>
References: <20180924113103.999624566@linuxfoundation.org>
 <20180924113121.469295005@linuxfoundation.org>
 <20180924230710.o7bqbw353few6pjw@xps.therub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924230710.o7bqbw353few6pjw@xps.therub.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 06:07:10PM -0500, Dan Rue wrote:
> On Mon, Sep 24, 2018 at 01:52:30PM +0200, Greg Kroah-Hartman wrote:
> > 4.18-stable review patch.  If anyone has any objections, please let me know.
> 
> I bisected a boot failure on an x15 (arm) board to this commit on
> 4.18.10-rc1. I'm also seeing issues on 4.14 and 4.18 with arm64 boards
> hikey and dragonboard 410c, but I have not investigated them yet (they
> could be unrelated).
> 
> I see there are fixes to this commit that have not been backported.
> Namely:
> 
> 823dd71f58eb ("pinctrl: ingenic: Fix group & function error checking")
> a203728ac6bb ("pinctrl: core: Return selector to the pinctrl driver")
> 
> However, I tried adding those two in but I still see the boot failure on
> x15.

Thanks for letting me know.  I've dropped this patch from the 4.14.y and
4.18.y queues.

I'll push out -rc2 versions in a bit as all of these seem to have had
problems...

thanks,

greg k-h
