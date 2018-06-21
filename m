Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0DAC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1DEC20874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:38:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1DEC20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754201AbeFUBih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 21:38:37 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46768 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754018AbeFUBig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 21:38:36 -0400
Received: from localhost (unknown [61.102.160.116])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 162D114708778;
        Wed, 20 Jun 2018 18:38:32 -0700 (PDT)
Date:   Thu, 21 Jun 2018 10:30:28 +0900 (KST)
Message-Id: <20180621.103028.1089744235700408030.davem@davemloft.net>
To:     antoine.tenart@bootlin.com
Cc:     f.fainelli@gmail.com, andrew@lunn.ch, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, quentin.schulz@bootlin.com,
        allan.nielsen@microsemi.com
Subject: Re: [PATCH net] net: mscc: fix the injection header
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180620085046.2377-1-antoine.tenart@bootlin.com>
References: <20180620085046.2377-1-antoine.tenart@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 20 Jun 2018 18:38:36 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antoine Tenart <antoine.tenart@bootlin.com>
Date: Wed, 20 Jun 2018 10:50:46 +0200

> When injecting frames in the Ocelot switch driver an injection header
> (IFH) should be used to configure various parameters related to a given
> frame, such as the port onto which the frame should be departed or its
> vlan id. Other parameters in the switch configuration can led to an
> injected frame being sent without an IFH but this led to various issues
> as the per-frame parameters are then not used. This is especially true
> when using multiple ports for injection.
> 
> The IFH was injected with the wrong endianness which led to the switch
> not taking it into account as the IFH_INJ_BYPASS bit was then unset.
> (The bit tells the switch to use the IFH over its internal
> configuration). This patch fixes it.
> 
> In addition to the endianness fix, the IFH is also fixed. As it was
> (unwillingly) unused, some of its fields were not configured the right
> way.
> 
> Fixes: a556c76adc05 ("net: mscc: Add initial Ocelot switch support")
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>

Applied, thank you.
