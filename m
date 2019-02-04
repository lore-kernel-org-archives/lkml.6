Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDC9C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA85420815
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ralV0nb1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbfBDQ7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 11:59:09 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:38222 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727057AbfBDQ7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 11:59:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=9N8TY0i2V+YP6xT0Vhw/uRnuKOAYll8O9RuzmZTyAs8=; b=ralV0nb1Iu5VbjbaTBc15q0Tyr
        RRuvhzv6RuVDmU12JCsWURbnSsBHEuhCoiRBwr9jvLEDP1VVdsvsNvbjTePl+avIoB3092bnQnmpi
        dXhvvnKyJKYcS6A8OIqTkdPqr8iGukfY5YaQYMaVQve8d9OUBZKYCMkbSuHlDpEjtRyM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gqhaI-0007Ma-KS; Mon, 04 Feb 2019 17:59:02 +0100
Date:   Mon, 4 Feb 2019 17:59:02 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] r8169: Avoid pointer aliasing
Message-ID: <20190204165902.GB24989@lunn.ch>
References: <20190204164213.30727-1-thierry.reding@gmail.com>
 <20190204164213.30727-2-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204164213.30727-2-thierry.reding@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 05:42:13PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Read MAC address 32-bit at a time and manually extract the individual
> bytes. This avoids pointer aliasing and gives the compiler a better
> chance of optimizing the operation.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
