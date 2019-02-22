Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B9FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333F82075A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HfG78IL+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfBVNO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 08:14:29 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:34581 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbfBVNO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 08:14:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=duQaAMcVIT5tAyI6lvTeCuyWYCY08a4bE2PMB4OPKJc=; b=HfG78IL+lBGVwjVGDIeGzLAs6p
        8Uo3BhlTF21/LFCcuCpphcvq5NuV2BVANWOmwQYpVrQ661QXlHIY8ohZdhOKyHvhf/E9utqxhrfuu
        JOPXhl1KS7lTnlxP5U96rSZRp/NJ/jucq4jXpnmzeai9rP+fvLuAoISuGL4TxxZdQFwY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gxAen-0006KY-3D; Fri, 22 Feb 2019 14:14:25 +0100
Date:   Fri, 22 Feb 2019 14:14:25 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net,
        Vivien Didelot <vivien.didelot@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/4] net: dsa: mv88e6xxx: Fix -Wformat-security
 warnings
Message-ID: <20190222131425.GH5653@lunn.ch>
References: <20190222040929.16657-1-f.fainelli@gmail.com>
 <20190222040929.16657-3-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222040929.16657-3-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 08:09:27PM -0800, Florian Fainelli wrote:
> We are not specifying an explicit format argument but instead passing a
> string litteral which causes these two warnings to show up:
> 
> drivers/net/dsa/mv88e6xxx/chip.c: In function
> 'mv88e6xxx_irq_poll_setup':
> drivers/net/dsa/mv88e6xxx/chip.c:483:2: warning: format not a string
> literal and no format arguments [-Wformat-security]
>   chip->kworker = kthread_create_worker(0, dev_name(chip->dev));
>   ^~~~
> drivers/net/dsa/mv88e6xxx/ptp.c: In function 'mv88e6xxx_ptp_setup':
> drivers/net/dsa/mv88e6xxx/ptp.c:403:4: warning: format not a string
> literal and no format arguments [-Wformat-security]
>     dev_name(chip->dev));
>     ^~~~~~~~
>   LD [M]  drivers/net/dsa/mv88e6xxx/mv88e6xxx.o
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Hi Florian

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
