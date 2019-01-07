Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE296C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58BAB2173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KtR5Kvku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbfAGSNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:13:04 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:35970 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbfAGSND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:13:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=piXEjdmPGwxF+VS7jI78KJFpecYVItjGIo7bAogP7ds=;
        b=KtR5Kvku3HgWlRlaPEKJg98/WZRQ2OpzxMxEpIKwjTuOkqNRXz84USLYIWjWxlIilRjTRloWEpiOBlY2so4DdwmsDIN3tsIHD9GyokNfySh7qR4cKvI2EwDEaM9KPgLpRzpgSDZdktrpYJfxARYcNKib6rSW60ukfjrdL94ror8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1ggZOW-00086d-8H; Mon, 07 Jan 2019 19:13:00 +0100
Date:   Mon, 7 Jan 2019 19:13:00 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH] phy: ti: Fix compilation failures without REGMAP
Message-ID: <20190107181300.GB27783@lunn.ch>
References: <20190107174753.GA4051@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190107174753.GA4051@ziepe.ca>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 05:48:00PM +0000, Jason Gunthorpe wrote:
> This driver requires regmap or the compile fails:
> 
> drivers/phy/ti/phy-gmii-sel.c:43:27: error: array type has incomplete element type ‘struct reg_field’
>   const struct reg_field (*regfields)[PHY_GMII_SEL_LAST];
> 
> Add it to kconfig.

Hi Jason

It looks like more of the TI drivers need REGMAP, but don't select it.
I assume you are using COMPILE_TEST, since TI_CPSW selects REGMAP?

  Andrew
