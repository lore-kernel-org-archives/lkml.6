Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE28FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F742206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="X83jQld2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F742206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeK2LcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 06:32:07 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:53574 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726895AbeK2LcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 06:32:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=431V7crGIX5Va3EkcqE6WGALMVWLfA515TMUtB4/LP8=;
        b=X83jQld2V+5mSjrVlDlsgczU6JqbVVH0lDCTUudcQSCYii/2Kuk5CTpl3Frzi6GxRifRRMzsd7R1Xu1HqFCo+OgR9WOLE8oZMHM9lohzvh8XtW1OEf5v4Xq1FmxAT4hdek40eJpMrd2lrlx+AbZYn5ocHZl4Cb/7Yrh2KWVpQsU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gSAC3-0002d8-9U; Thu, 29 Nov 2018 01:28:35 +0100
Date:   Thu, 29 Nov 2018 01:28:35 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: ti: cpsw: allow to configure min tx
 packet size
Message-ID: <20181129002835.GB5037@lunn.ch>
References: <20181125234315.28313-1-grygorii.strashko@ti.com>
 <20181126022711.GD32164@lunn.ch>
 <7a194258-2888-2268-42d1-27ac513a5c8a@ti.com>
 <20181128044913.GB6730@lunn.ch>
 <6047b35d-d3c2-14f7-b42d-754b581a3c55@ti.com>
 <20181128220211.GA5037@lunn.ch>
 <0b70091e-3747-ee8f-15d6-4532e210278e@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b70091e-3747-ee8f-15d6-4532e210278e@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 04:43:40PM -0600, Grygorii Strashko wrote:
> Hi Andrew,
> 
> On 11/28/18 4:02 PM, Andrew Lunn wrote:
> >> This is dynamic configuration related to ALE VLAN entries and
> >> I do not see the way to support its auto-detection with current driver,
> >> unfortunately.
> > 
> > I think you can subscribe to switchdev events which will tell you.
> 
> Thanks a lot for your review and comments.
> 
> Unfortunately, we still do not have switchdev in place, but i need to resolve
> existing issue somehow. This patch is small, local to CPSW fix which can be
> backported to stable. So, if possible, and no strong objection, could we proceed with it?

Hi Grygorii

David is the person who generally says no to kernel module
parameters. You should ask him.

    Andrew
