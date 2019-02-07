Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349F4C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ACE121917
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfBGTPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:15:11 -0500
Received: from bmailout2.hostsharing.net ([83.223.90.240]:56061 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfBGTPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 14:15:11 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 1B6562800B489;
        Thu,  7 Feb 2019 20:15:09 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id AA3A28372B; Thu,  7 Feb 2019 20:15:08 +0100 (CET)
Date:   Thu, 7 Feb 2019 20:15:08 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v2 4/9] driver core: Fix handling of runtime PM flags in
 device_link_add()
Message-ID: <20190207191508.pa7g5c2vhxksrtio@wunner.de>
References: <1952449.TVsm6CJCTy@aspire.rjw.lan>
 <3655840.AXlINldeOc@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3655840.AXlINldeOc@aspire.rjw.lan>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 01:49:14AM +0100, Rafael J. Wysocki wrote:
> After commit ead18c23c263 ("driver core: Introduce device links
> reference counting"), if there is a link between the given supplier
> and the given consumer already, device_link_add() will refcount it
> and return it unconditionally without updating its flags.  It is
> possible, however, that the second (or any subsequent) caller of
> device_link_add() for the same consumer-supplier pair will pass
> DL_FLAG_PM_RUNTIME, possibly along with DL_FLAG_RPM_ACTIVE, in flags
> to it and the existing link may not behave as expected then.
[...]
> Fixes: ead18c23c263 ("driver core: Introduce device links reference counting")

I think this should be:

Fixes: 21d5c57b3726 ("PM / runtime: Use device links")

Thanks,

Lukas
