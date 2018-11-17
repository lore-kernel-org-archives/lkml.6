Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04863C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 07:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E742084C
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 07:04:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E742084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbeKQRT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 12:19:57 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:50946 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbeKQRT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 12:19:57 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2ECDF1402B912;
        Fri, 16 Nov 2018 23:04:14 -0800 (PST)
Date:   Fri, 16 Nov 2018 23:04:13 -0800 (PST)
Message-Id: <20181116.230413.585228813283302740.davem@davemloft.net>
To:     ms@dev.tdt.de
Cc:     andrew@lunn.ch, sergei.shtylyov@cogentembedded.com,
        f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] net: phy: mdio-gpio: Fix working over slow
 can_sleep GPIOs
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181115052428.8133-1-ms@dev.tdt.de>
References: <20181114061703.11026-1-ms@dev.tdt.de>
        <20181115052428.8133-1-ms@dev.tdt.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 16 Nov 2018 23:04:14 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schiller <ms@dev.tdt.de>
Date: Thu, 15 Nov 2018 06:24:28 +0100

> Up until commit 7e5fbd1e0700 ("net: mdio-gpio: Convert to use gpiod
> functions where possible"), the _cansleep variants of the gpio_ API was
> used. After that commit and the change to gpiod_ API, the _cansleep()
> was dropped. This then results in WARN_ON() when used with GPIO
> devices which do sleep. Add back the _cansleep() to avoid this.
> 
> Fixes: 7e5fbd1e0700 ("net: mdio-gpio: Convert to use gpiod functions where possible")
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>

Ok it seems there was still discussion going on here and I accidently applied
v4 of this patch.

I'll revert it and wait for the review to conclude.
