Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F55C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE862157C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BE862157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbeI0Jnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 05:43:41 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:37744 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbeI0Jnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 05:43:40 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C96D9145796FF;
        Wed, 26 Sep 2018 20:27:35 -0700 (PDT)
Date:   Wed, 26 Sep 2018 20:27:35 -0700 (PDT)
Message-Id: <20180926.202735.1750846894178423857.davem@davemloft.net>
To:     maxime.chevallier@bootlin.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        antoine.tenart@bootlin.com, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, mw@semihalf.com,
        yelena@marvell.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next] net: mvneta: Add support for 2500Mbps SGMII
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180925135939.4816-1-maxime.chevallier@bootlin.com>
References: <20180925135939.4816-1-maxime.chevallier@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 26 Sep 2018 20:27:36 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Tue, 25 Sep 2018 15:59:39 +0200

> The mvneta controller can handle speeds up to 2500Mbps on the SGMII
> interface. This relies on serdes configuration, the lane must be
> configured at 3.125Gbps and we can't use in-band autoneg at that speed.
> 
> The main issue when supporting that speed on this particular controller
> is that the link partner can send ethernet frames with a shortened
> preamble, which if not explicitly enabled in the controller will cause
> unexpected behaviours.
> 
> This was tested on Armada 385, with the comphy configuration done in
> bootloader.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Applied.
