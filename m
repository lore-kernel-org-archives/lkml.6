Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A01C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC3B2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RiZZwbFl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC3B2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbeK1Pte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 10:49:34 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:51918 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbeK1Pte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 10:49:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=JRDBDgqNOK89cYh5NPoNfShHsESVrbHQImOtgzq/agE=;
        b=RiZZwbFlmPiLdqpQ5G4312z5eNZLm8jCJ7fTUaC/ayhQSQu7SdVrosvJLLQ66HbQv8f44VcxzHTc7roaj5fDvSB6AYhCLPJO0veLe25MllKh8MHB3QrsohnP+4Jx4BkdiPSi+wygPbaHff54gMN5KMBDG5HXnVm11BgtVxSQeiE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gRrmj-0001ot-0g; Wed, 28 Nov 2018 05:49:13 +0100
Date:   Wed, 28 Nov 2018 05:49:13 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: ti: cpsw: allow to configure min tx
 packet size
Message-ID: <20181128044913.GB6730@lunn.ch>
References: <20181125234315.28313-1-grygorii.strashko@ti.com>
 <20181126022711.GD32164@lunn.ch>
 <7a194258-2888-2268-42d1-27ac513a5c8a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a194258-2888-2268-42d1-27ac513a5c8a@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> [1] https://e2e.ti.com/support/arm/sitara_arm/f/791/t/701669

Reading this, the interesting part is:

	My guess would be that the driver would have to track the
	configuration of the switch hardware to correctly pad the
	frame.

Have you tried that?

     Andrew
