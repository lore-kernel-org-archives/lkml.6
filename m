Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C15C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B33722507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ouw6vKPf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B33722507
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730619AbeKMKNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 05:13:36 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:60367 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727659AbeKMKNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 05:13:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=32tX/3IpEDa1zOS1Kk8JLpkmCT+ccBMeCfuLgONy1PE=;
        b=ouw6vKPfEmGxefSQqlGs0RDLwZptClMFdIQ3/vp5prUcdlT1tB/J+HPR9L0JXrrjGTfVhXtjkbrfwlOg/zCg5cS3U+8L8ObXpwV2ZP3Bn9EwPMZjGJMy2Hg9FhWv9MGnzWwnIdb7btd0SlEqtnf8pQh8wVooqu96I8ZAwp1t3G0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gMMP3-0004DW-BX; Tue, 13 Nov 2018 01:18:01 +0100
Date:   Tue, 13 Nov 2018 01:18:01 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Colin King <colin.king@canonical.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][net-next] net: phy: check if advertising is zero using
 linkmode_empty
Message-ID: <20181113001801.GD14047@lunn.ch>
References: <20181112234556.5291-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112234556.5291-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 11:45:56PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> A recent change modified variable advertising from a u32 to a link mode
> array and left the u32 zero comparison, so essential we now have an array
> being compared to null which is not the intention. Fix this by using the
> call to linkmode_empty to check if advertising is all zero.
> 
> Detected by CoverityScan, CID#1475424 ("Array compared against 0")
> 
> Fixes: 3c1bcc8614db ("net: ethernet: Convert phydev advertize and supported from u32 to link mode")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks Colin.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
