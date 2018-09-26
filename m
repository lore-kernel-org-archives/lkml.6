Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FEDC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79AD42152F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79AD42152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbeIZXvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:51:14 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57894 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbeIZXvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:51:13 -0400
Received: from localhost (unknown [IPv6:2603:3023:50c:85e1:b5c5:ae11:3e54:6a07])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3B387144A237A;
        Wed, 26 Sep 2018 10:37:13 -0700 (PDT)
Date:   Wed, 26 Sep 2018 10:37:12 -0700 (PDT)
Message-Id: <20180926.103712.516726977452765505.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, quentin.schulz@bootlin.com,
        alexandre.belloni@bootlin.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] phy: mscc: fix printf format
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180926132021.2933754-1-arnd@arndb.de>
References: <20180926132021.2933754-1-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 26 Sep 2018 10:37:13 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 26 Sep 2018 15:20:11 +0200

> gcc points out that the length of the temporary buffer may not be sufficient for
> large numbers of leds:
> 
> drivers/net/phy/mscc.c: In function 'vsc85xx_probe':
> drivers/net/phy/mscc.c:460:45: error: '-mode' directive writing 5 bytes into a region of size between 0 and 9 [-Werror=format-overflow=]
>    ret = sprintf(led_dt_prop, "vsc8531,led-%d-mode", i);
>                                              ^~~~~
> drivers/net/phy/mscc.c:460:9: note: 'sprintf' output between 19 and 28 bytes into a destination of size 22
>    ret = sprintf(led_dt_prop, "vsc8531,led-%d-mode", i);
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> While we can make a reasonable assumption that the number of LEDs is small,
> the cost of making the buffer a little bigger is insignificant as well.
> 
> Fixes: 11bfdabb7ff5 ("net: phy: mscc: factorize code for LEDs mode")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
