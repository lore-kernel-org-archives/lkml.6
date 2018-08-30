Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC89C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 03:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57AEC20661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 03:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CY6Jxtln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57AEC20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbeH3HLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 03:11:13 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:47116 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727233AbeH3HLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 03:11:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=TLjna5aAksDlVHfZD4DWmmJFtxT58JUG7x746DUvTiQ=;
        b=CY6JxtlnmMQ+lYyz2WEXMDZPr61wD1MxgpXhVRmCuNpsUg2K0MuSxizxIAza/8v6F8OTApGO8f2sCciZ5cFk27EbZUheZyEbhnI62OAjWsIa8iuxKy9ydE3gEjh8Q9ZO5mNaxRQUafI/0/TzGi50/Gm57WsZMn4qBaBGVwn7nSc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fvDMU-0004rG-Px; Thu, 30 Aug 2018 05:11:10 +0200
Date:   Thu, 30 Aug 2018 05:11:10 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     davem@davemloft.net, keescook@chromium.org, f.fainelli@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        alex.williams@ni.com
Subject: Re: [PATCH net-next 2/3] net: nixge: Add support for having nixge as
 subdevice
Message-ID: <20180830031110.GC16896@lunn.ch>
References: <20180830004046.9417-1-mdf@kernel.org>
 <20180830004046.9417-3-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830004046.9417-3-mdf@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 05:40:45PM -0700, Moritz Fischer wrote:
> Add support for instantiating nixge as subdevice using
> fixed-link and platform data to configure it.
> 
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
> 
> Hi,
> 
> not this patch is still in the early stages,
> and as the rest of this series goes on top of [1].
> 
> The actual platform data might still change since
> the parent device driver is still under development.

Hi Moritz

Could you tell us more about the parent device. I'm guessing PCIe.  Is
it x86 so no device tree? Are there cases where it does not have a PHY
connected? What is connected instead? SFP? A switch? Can there be
multiple PHYs on the MDIO bus?

Answering these questions will help decide how best to structure this.

	 Andrew
