Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE647C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 21:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F726213A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 21:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F726213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbeJFEkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 00:40:02 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46768 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbeJFEkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 00:40:01 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1c06::4572])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 98E3C13ADF961;
        Fri,  5 Oct 2018 14:39:25 -0700 (PDT)
Date:   Fri, 05 Oct 2018 14:39:24 -0700 (PDT)
Message-Id: <20181005.143924.1849227852256176976.davem@davemloft.net>
To:     quentin.schulz@bootlin.com
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, kishon@ti.com, andrew@lunn.ch,
        f.fainelli@gmail.com, allan.nielsen@microchip.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net-next v4 00/11] mscc: ocelot: add support for SerDes
 muxing configuration
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181004122208.32272-1-quentin.schulz@bootlin.com>
References: <20181004122208.32272-1-quentin.schulz@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 05 Oct 2018 14:39:26 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@bootlin.com>
Date: Thu,  4 Oct 2018 14:21:57 +0200

> The Ocelot switch has currently an hardcoded SerDes muxing that suits only
> a particular use case. Any other board setup will fail to work.
> 
> To prepare for upcoming boards' support that do not have the same muxing,
> create a PHY driver that will handle all possible cases.
> 
> A SerDes can work in SGMII, QSGMII or PCIe and is also muxed to use a
> given port depending on the selected mode or board design.
> 
> The SerDes configuration is in the middle of an address space (HSIO) that
> is used to configure some parts in the MAC controller driver, that is why
> we need to use a syscon so that we can write to the same address space from
> different drivers safely using regmap.
> 
> This breaks backward compatibility but it's fine because there's only one
> board at the moment that is using what's modified in this patch series.
> This will break git bisect.
> 
> Even though this patch series is about SerDes __muxing__ configuration, the
> DT node is named serdes for the simple reason that I couldn't find any
> mention to SerDes anywhere else from the address space handled by this
> driver.

Series applied to net-next, thanks.
