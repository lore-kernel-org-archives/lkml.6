Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBB6C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 22:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B41223D3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 22:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2dtK3Vi3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85B41223D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbeHKAzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 20:55:42 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:33144 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726957AbeHKAzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 20:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=zlkGxCB54wHR7Kon4bFixcRpjf/kjxAvcTvFYFpXlhM=;
        b=2dtK3Vi3YNoJ/TdGMes07BhGLp8XiAefkaXekKkJQuzs/ssOGSBAU9VYaxvzZcyd04u1VQ3uqjFCHX5Y4ebxybUA3sO5IxtuQg7Vd7gE/vQDKWi0tY1rEaWkwKLfrC4UYPpj8j3S65W/Xe5RsZqheyiCWrow+WjcNvaI4BHA7AQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1foFol-00052y-23; Sat, 11 Aug 2018 00:23:35 +0200
Date:   Sat, 11 Aug 2018 00:23:35 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     David Miller <davem@davemloft.net>
Cc:     Jisheng.Zhang@synaptics.com, thomas.petazzoni@free-electrons.com,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: mvneta: fix mvneta_config_rss on armada
 3700
Message-ID: <20180810222335.GD11955@lunn.ch>
References: <20180810113627.5dec5d40@xhacker.debian>
 <20180810.144031.861564620036768413.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810.144031.861564620036768413.davem@davemloft.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 02:40:31PM -0700, David Miller wrote:
> From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> Date: Fri, 10 Aug 2018 11:36:27 +0800
> 
> > The mvneta Ethernet driver is used on a few different Marvell SoCs.
> > Some SoCs have per cpu interrupts for Ethernet events, the driver uses
> > a per CPU napi structure for this case. Some SoCs such as armada 3700
> > have a single interrupt for Ethernet events, the driver uses a global
> > napi structure for this case.
> > 
> > Current mvneta_config_rss() always operates the per cpu napi structure.
> > Fix it by operating a global napi for "single interrupt" case, and per
> > cpu napi structure for remaining cases.
> > 
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > Fixes: 2636ac3cc2b4 ("net: mvneta: Add network support for Armada 3700 SoC")
> 
> Applied, thanks.

Hi David

Please can you queue up:

Fixes: 7a86f05faf11 ("net: ethernet: mvneta: Fix napi structure mixup on armada 3700")

and this patch for stable.

Thanks
	Andrew
