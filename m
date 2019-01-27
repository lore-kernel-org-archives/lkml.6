Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF39C282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 21:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593822133F
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 21:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbfA0VWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 16:22:54 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:38092 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbfA0VWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 16:22:53 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E053614BA7CEC;
        Sun, 27 Jan 2019 13:22:52 -0800 (PST)
Date:   Sun, 27 Jan 2019 13:22:50 -0800 (PST)
Message-Id: <20190127.132250.578158295862987283.davem@davemloft.net>
To:     miquel.raynal@bootlin.com
Cc:     andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        nadavh@marvell.com
Subject: Re: [PATCH net-next v2 0/2] mv88e6xxx DSA suspend to RAM support
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190125095507.29334-1-miquel.raynal@bootlin.com>
References: <20190125095507.29334-1-miquel.raynal@bootlin.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 27 Jan 2019 13:22:53 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 25 Jan 2019 10:55:05 +0100

> After a first attempt of bringing S2RAM support to the DSA switch, it
> has been reported that a part of the configuration was lost during the
> cycle. This second version adds a first patch that saves the rules in
> a per-chip list when they are applied, so that in the second patch we
> bring S2RAM support by also re-applying these rules.
 ...

It seems like the discussion on patch #1 has hit a brick wall.

The last suggestion was to use:

+       switch (mode) {
+       case PHY_INTERFACE_MODE_2500BASEX:
+               phydev->speed = SPEED_2500;
+               break;
+       case PHY_INTERFACE_MODE_10GKR:
+               phydev->speed = SPEED_10000;
+               break;
+

in dsa_port_fixed_link_register_of(), but that doesn't work
because swphy will fail without speed=1000 in the dts.

Well, whatever is decided, the commit message need to be updated
to explain why this course of action for the most immediate fix
was ultimately taken.

Thanks.
