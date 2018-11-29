Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07210C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5D4206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="U+MF9e9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B5D4206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeK2MKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 07:10:37 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:53614 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726297AbeK2MKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 07:10:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=wq4nl2nQ/OGdIF6ySrUoZrn26UGzW40GXC4e7dOZ22o=;
        b=U+MF9e9vRhsWLxTF6wBeIyojC7B3mdOORf5ecfI4iYGTWk6zhr1D3jrit5MPb9PlLvLE1ORTo9Lc6RX2XlYQgvUAiV1H+pOcpCwpjDVNzc5yd3gpVio3tsxmuW8nrLNjIWzqDz7ZssYg/cbECYa0mOg5ZqVQb4jqdCMQjABgUfg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gSAnD-0002wJ-4K; Thu, 29 Nov 2018 02:06:59 +0100
Date:   Thu, 29 Nov 2018 02:06:59 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: dsa: Fix tagging attribute location
Message-ID: <20181129010659.GD5037@lunn.ch>
References: <20181128214012.16397-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128214012.16397-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 01:40:04PM -0800, Florian Fainelli wrote:
> While introducing the DSA tagging protocol attribute, it was added to the DSA
> slave network devices, but those actually see untagged traffic (that is their
> whole purpose). Correct this mistake by putting the tagging sysfs attribute
> under the DSA master network device where this is the information that we need.
> 
> While at it, also correct the sysfs documentation mistake that missed the
> "dsa/" directory component of the attribute.
> 
> Fixes: 98cdb4807123 ("net: dsa: Expose tagging protocol to user-space")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
