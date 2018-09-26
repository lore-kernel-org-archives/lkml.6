Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828D1C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B9C12150D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B9C12150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbeIZXu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:50:28 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57866 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbeIZXu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:50:28 -0400
Received: from localhost (96-89-128-221-static.hfc.comcastbusiness.net [96.89.128.221])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D1764144A234F;
        Wed, 26 Sep 2018 10:36:27 -0700 (PDT)
Date:   Wed, 26 Sep 2018 10:36:27 -0700 (PDT)
Message-Id: <20180926.103627.366696832700107636.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, weiyongjun1@huawei.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: mdio-bcm-unimac: mark PM functions
 as __maybe_unused
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180926131418.2729391-1-arnd@arndb.de>
References: <20180926131418.2729391-1-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 26 Sep 2018 10:36:28 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 26 Sep 2018 15:14:10 +0200

> The newly added runtime-pm support causes a harmless warning
> when CONFIG_PM is disabled:
> 
> drivers/net/phy/mdio-bcm-unimac.c:330:12: error: 'unimac_mdio_resume' defined but not used [-Werror=unused-function]
>  static int unimac_mdio_resume(struct device *d)
> drivers/net/phy/mdio-bcm-unimac.c:321:12: error: 'unimac_mdio_suspend' defined but not used [-Werror=unused-function]
>  static int unimac_mdio_suspend(struct device *d)
> 
> Marking the functions as __maybe_unused is the easiest workaround
> and avoids adding #ifdef checks.
> 
> Fixes: b78ac6ecd1b6 ("net: phy: mdio-bcm-unimac: Allow configuring MDIO clock divider")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
