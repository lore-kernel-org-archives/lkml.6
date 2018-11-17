Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4B1C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 03:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A53B20989
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 03:52:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A53B20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbeKQOHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 09:07:44 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:48300 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbeKQOHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 09:07:44 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 639AE13F619C0;
        Fri, 16 Nov 2018 19:52:30 -0800 (PST)
Date:   Fri, 16 Nov 2018 19:52:29 -0800 (PST)
Message-Id: <20181116.195229.1845361281767840031.davem@davemloft.net>
To:     ms@dev.tdt.de
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch, f.fainelli@gmail.com
Subject: Re: [PATCH v2] net: phy: mdio-gpio: fix access that may sleep
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181114063703.13379-1-ms@dev.tdt.de>
References: <20181114061703.11026-1-ms@dev.tdt.de>
        <20181114063703.13379-1-ms@dev.tdt.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 16 Nov 2018 19:52:30 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schiller <ms@dev.tdt.de>
Date: Wed, 14 Nov 2018 07:37:03 +0100

> @@ -162,6 +162,11 @@ static int mdio_gpio_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	if (gpiod_cansleep(bitbang->mdc) || gpiod_cansleep(bitbang->mdio)
> +		|| gpiod_cansleep(bitbang->mdo))

Please fix the formatting here, operators like "||" and "&&" never begin
a line, they must always finish a line.
