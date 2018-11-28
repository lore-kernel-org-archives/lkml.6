Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABF8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 00:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD2620645
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 00:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zPE487lc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DD2620645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbeK1Lep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 06:34:45 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:51703 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbeK1Lep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 06:34:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=mTQhZreqpuPxzYXRH1hf+S6Fd0uPyK4KqwK7xu/Wj1M=;
        b=zPE487lcMeA6hF+3knn8P+SCVFP4I+5tDFPI0bvTg58yoaYVmKs+OkSngBY6Efya/auRlW38twSA+31LqwiVoLSzx3vYfJsq/NlS3cCqqiM594VRLu79cD6NxfbZZOQMPI/oXGjhNZ1oG1XJdW5L3LcvL2ghGFm3ZiOYEUmJ7TU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gRnoi-0000P2-2c; Wed, 28 Nov 2018 01:35:00 +0100
Date:   Wed, 28 Nov 2018 01:35:00 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Claudiu.Beznea@microchip.com
Cc:     harinik@xilinx.com, harini.katakam@xilinx.com,
        Nicolas.Ferre@microchip.com, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, shubhrajyoti.datta@xilinx.com,
        sai.pavan.boddu@xilinx.com
Subject: Re: [PATCH v2 1/4] net: macb: Check MDIO state before read/write and
 use timeouts
Message-ID: <20181128003500.GD26096@lunn.ch>
References: <1543216072-9623-1-git-send-email-harini.katakam@xilinx.com>
 <1543216072-9623-2-git-send-email-harini.katakam@xilinx.com>
 <5de882e3-65ac-7ff1-bb55-7537666dfc77@microchip.com>
 <20181126145210.GD12116@lunn.ch>
 <CAFcVECK=4e-+1u3X+OuLoAEicUtrkTX3C0wzAugMRcJSP0N-Vg@mail.gmail.com>
 <74937246-dc7d-db1c-df00-5db856192eac@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74937246-dc7d-db1c-df00-5db856192eac@microchip.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Then, do you think it would be better to have a new API part of struct
> mii_bus that drivers should register so that, the mii core to check if the
> bus is idle before lunching a new request?

I'm not sure that actually brings anything useful.  The core does not
benefit from it, and it does not make the driver simpler.

	Andrew

