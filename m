Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1247CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4BC3207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="erx/Bv2w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbfBUNKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:10:41 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:33026 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfBUNKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:10:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=rvg5xZrap2dxqBePFc3qSIGCcNyDLU0fG30yT0OKrg0=; b=erx/Bv2wpvrCPE/HcVm6Xt3nxZ
        TixkKwC43G4JqtP4RVz0Z4cvdEV0bynVjt2UltHTsxDsbU/pOzfU3H5y4Mt1BPkmASXPn0G3UcngA
        w4IeYnBe+z8W86vviyVYud6uk4qgz/3tJ1+ES/4BYaPq5bpPxQM98jE6GNvmkNXseqN0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gwo7Z-0001fi-Jk; Thu, 21 Feb 2019 14:10:37 +0100
Date:   Thu, 21 Feb 2019 14:10:37 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Marcel Reichmuth <Marcel.Reichmuth@netmodule.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH] net: dsa: add missing phy address offset
Message-ID: <20190221131037.GA5653@lunn.ch>
References: <20190220181426.2970-1-marcel.reichmuth@netmodule.com>
 <d4e6e37b-01c2-3141-8e30-b7e8c252c0ef@gmail.com>
 <20190220193122.GA5302@lunn.ch>
 <20190221075333.t7vikxznp3l6ello@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221075333.t7vikxznp3l6ello@debian>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Thank you very much for your hints. Yes that works indeed too. I
> just assumed it was intended to work automatically with the 
> built-in phys as it does with the other switches I am using.

Hi Marcel

The basic assumption is there is a one to one mapping of port number
to PHY address. All the other Marvell switch have this mapping.

Since the needed flexibility exists to support this, and Marvell has
not repeated this odd design, i decided not to do anything about it in
code.

	Andrew
