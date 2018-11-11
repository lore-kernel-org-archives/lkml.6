Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D914DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 17:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E1521104
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 17:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E1521104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbeKLD1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 22:27:14 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:37284 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729222AbeKLD1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 22:27:14 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A3ADC1474EB72;
        Sun, 11 Nov 2018 09:38:04 -0800 (PST)
Date:   Sun, 11 Nov 2018 09:38:03 -0800 (PST)
Message-Id: <20181111.093803.1220111720420778659.davem@davemloft.net>
To:     hkallweit1@gmail.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, netdev@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, richardcochran@gmail.com,
        carlo@caione.org, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH net-next v3 0/2] net: phy: replace PHY_HAS_INTERRUPT
 with a check for config_intr and ack_interrupt
From:   David Miller <davem@davemloft.net>
In-Reply-To: <203c4d9e-f39a-7a08-46c3-4ee6e61f181e@gmail.com>
References: <203c4d9e-f39a-7a08-46c3-4ee6e61f181e@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 11 Nov 2018 09:38:05 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiner Kallweit <hkallweit1@gmail.com>
Date: Fri, 9 Nov 2018 18:15:31 +0100

> Flag PHY_HAS_INTERRUPT is used only here for this small check. I think
> using interrupts isn't possible if a driver defines neither
> config_intr nor ack_interrupts callback. So we can replace checking
> flag PHY_HAS_INTERRUPT with checking for these callbacks.
> This allows to remove this flag from all driver configs.
> 
> v2:
> - add helper for check in patch 1
> - remove PHY_HAS_INTERRUPT from all drivers, not only Realtek
> - remove flag PHY_HAS_INTERRUPT completely
> 
> v3:
> - rebase patch 2

Series applied, but please sort out that one driver which is preventing
us requiring both config_intr && ack_interrupt.

Thanks.
