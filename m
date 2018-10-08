Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057D6C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0A221471
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:29:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0A221471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbeJIAmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 20:42:23 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57004 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeJIAmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 20:42:22 -0400
Received: from localhost (c-67-183-145-105.hsd1.wa.comcast.net [67.183.145.105])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CEFAD144DD4F7;
        Mon,  8 Oct 2018 10:29:36 -0700 (PDT)
Date:   Mon, 08 Oct 2018 10:29:36 -0700 (PDT)
Message-Id: <20181008.102936.2115401220175323898.davem@davemloft.net>
To:     quentin.schulz@bootlin.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, allan.nielsen@microchip.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com
Subject: Re: [PATCH net-next v3 0/6] net: phy: mscc: various improvements
 to Microsemi PHY driver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181008100728.24959-1-quentin.schulz@bootlin.com>
References: <20181008100728.24959-1-quentin.schulz@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 08 Oct 2018 10:29:37 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@bootlin.com>
Date: Mon,  8 Oct 2018 12:07:22 +0200

> The Microsemi PHYs have multiple banks of registers (called pages).
> Registers can only be accessed from one page, if we need a register from
> another page, we need to switch the page and the registers of all other
> pages are not accessible anymore.
> 
> Basically, to read register 5 from page 0, 1, 2, etc., you do the same
> phy_read(phydev, 5); but you need to set the desired page beforehand.
> 
> In order to guarantee that two concurrent functions do not change the
> page, we need to do some locking per page. This can be achieved with the
> use of phy_select_page and phy_restore_page functions but phy_write/read
> calls in-between those two functions shall be replaced by their
> lock-free alternative __phy_write/read.
> 
> The Microsemi PHYs have several counters so let's make them available as PHY
> statistics.
> 
> The VSC 8530/31/40/41 also need to update their EEE init sequence in order to
> avoid packet losses and improve performance.
> 
> This patch series also makes some minor cosmetic changes to the driver.

Series applied, thank you.
