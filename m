Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CD0C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C0E2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548865327;
	bh=zDNBJOTp/LDdUY/fC6xzsXPDTSmaZ+2iEh69GyyPNuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YDnh03z3ab1LJiZsj4xXqUyYGvnzQPSbl/3IRRH6hWQEhQAruueR9gTdxFQgCUyRL
	 xtf/Z7F/1Ebgk9BAKhrCnsJ9s22dLTaFfERyOtdc3EkLdAYCLxqZz67S6JJkIeMz4J
	 vIwfo3zSOBQQOa7pKa9otOCu21gnDbEWyUovpnlw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbfA3QWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:22:06 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:32878 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfA3QWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:22:06 -0500
Received: by mail-oi1-f195.google.com with SMTP id c206so126125oib.0;
        Wed, 30 Jan 2019 08:22:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KN1aOOGffgyHdr/32v6SqWUL8gWXLKTH4oDU1/suvRA=;
        b=fcdDmuBNl66/M5BeW+3c63Gh3/6yg0+WrsuEYpILPjwR5W8Q7EZG//otlNbDktiTpP
         JcTiEEFzXSvQ7RsK0+pY6gmROnvkSiEFGCUj+hrW7sKYEnby1z+1ktr5rl0XX+T/dMe+
         OunCILMt9GR1Z95GT13KyMq5sQOqQKj+guszupH4FYPdHe+iuZU6ZMWsAHJvEgpv/Ovb
         /2UEbWS8+B1YlzQhxhUz8f0YWiQsRDbox8H8givbR8fTwnj3iprb/AEigcMSHJgDDBdI
         /9ICbM0KUs5+ZpSyaU/li6bddFanGwYJ9VSZRAz7tdhcD9O7TKr5RXSalYCCdgsf2GJg
         tF2A==
X-Gm-Message-State: AHQUAuZcgse9jNVgf6CGIItdwJ8Eraf44FZl8tboy0C8RySgsyoWkuX9
        Ipbo4uDfOpObjlwMh3UgTw==
X-Google-Smtp-Source: AHgI3IYDHzc1okMvkTuFmyyJ3jddXAwbzHWN9WsfAOKvP0GGvj9I52uGbMLR5RytVLmhuFgMtnkOUA==
X-Received: by 2002:aca:d78b:: with SMTP id o133mr12135907oig.232.1548865325100;
        Wed, 30 Jan 2019 08:22:05 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w4sm698235otm.46.2019.01.30.08.22.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 08:22:04 -0800 (PST)
Date:   Wed, 30 Jan 2019 10:22:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Erin Lo <erin.lo@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        devicetree@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, yingjoe.chen@mediatek.com,
        mars.cheng@mediatek.com, eddie.huang@mediatek.com,
        linux-clk@vger.kernel.org, Ben Ho <Ben.Ho@mediatek.com>,
        Seiya Wang <seiya.wang@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Mengqi Zhang <Mengqi.Zhang@mediatek.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Subject: Re: [PATCH v6 6/6] arm64: dts: Add Mediatek SoC MT8183 and
 evaluation board dts and Makefile
Message-ID: <20190130162204.GA1521@bogus>
References: <1548317240-44682-1-git-send-email-erin.lo@mediatek.com>
 <1548317240-44682-7-git-send-email-erin.lo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548317240-44682-7-git-send-email-erin.lo@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 04:07:20PM +0800, Erin Lo wrote:
> From: Ben Ho <Ben.Ho@mediatek.com>
> 
> Add basic chip support for Mediatek 8183, include
> pinctrl file, uart node with correct uart clocks, pwrap device
> 
> Add clock controller nodes, include topckgen, infracfg,
> apmixedsys and subsystem.
> 
> Signed-off-by: Ben Ho <Ben.Ho@mediatek.com>
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Mengqi Zhang <Mengqi.Zhang@mediatek.com>
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> ---


> +	sysirq: intpol-controller@c530a80 {

interrupt-controller@...


Place all the MMIO peripherals under one or more simple-bus nodes.

Rob
