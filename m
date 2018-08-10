Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749ABC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BAD9223F0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RUS0Fb3L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BAD9223F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbeHJQGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 12:06:34 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:32802 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727534AbeHJQGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 12:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=BCEE/5CVfdoojEUAQozl0oARt8CCxX6AVEL/4iKUJes=;
        b=RUS0Fb3LBp8cC/2nZPrxKzWn51dKIGmMbNLD+ANj7WcJk6qIc27fQiqRc162agBOrLpVDp2JAxjU1EdkO3uDG2RGPD8MCsirtzDbbb6OfaQaxYPo7orP5rPZ4nWfK/LDwjQ3NX1uXMLOn6y3FaJb2cbHZIcoJgQz+9mvQ9fKeVo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fo7ah-00033W-5C; Fri, 10 Aug 2018 15:36:31 +0200
Date:   Fri, 10 Aug 2018 15:36:31 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: mvneta: fix mvneta_config_rss on armada
 3700
Message-ID: <20180810133631.GA11350@lunn.ch>
References: <20180810113627.5dec5d40@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810113627.5dec5d40@xhacker.debian>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 11:36:27AM +0800, Jisheng Zhang wrote:
> The mvneta Ethernet driver is used on a few different Marvell SoCs.
> Some SoCs have per cpu interrupts for Ethernet events, the driver uses
> a per CPU napi structure for this case. Some SoCs such as armada 3700
> have a single interrupt for Ethernet events, the driver uses a global
> napi structure for this case.
> 
> Current mvneta_config_rss() always operates the per cpu napi structure.
> Fix it by operating a global napi for "single interrupt" case, and per
> cpu napi structure for remaining cases.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> Fixes: 2636ac3cc2b4 ("net: mvneta: Add network support for Armada 3700 SoC")

Looks reasonable.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
