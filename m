Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC51C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 846E6222DD
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394467AbfBPEVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 23:21:40 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:49422 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfBPEVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 23:21:40 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 280B8106FCBE0;
        Fri, 15 Feb 2019 20:21:39 -0800 (PST)
Date:   Fri, 15 Feb 2019 20:21:38 -0800 (PST)
Message-Id: <20190215.202138.1915616474041185856.davem@davemloft.net>
To:     paul.kocialkowski@bootlin.com
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
        hkallweit1@gmail.com, michal.simek@xilinx.com,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH] net: phy: xgmiitorgmii: Support generic PHY status read
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190215161708.18645-1-paul.kocialkowski@bootlin.com>
References: <20190215161708.18645-1-paul.kocialkowski@bootlin.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 15 Feb 2019 20:21:39 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Date: Fri, 15 Feb 2019 17:17:08 +0100

> Some PHY drivers like the generic one do not provide a read_status
> callback on their own but rely on genphy_read_status being called
> directly.
> 
> With the current code, this results in a NULL function pointer call.
> Call genphy_read_status instead when there is no specific callback.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Applied, thanks.

Unfortunately I only noticed your updated version with the Fixes tag
after pushing this version out.  I'll be more careful next time :)
