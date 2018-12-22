Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16703C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 02:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE5EB2190A
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 02:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="yKb7uN5r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732861AbeLVCcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 21:32:22 -0500
Received: from mail.nic.cz ([217.31.204.67]:36231 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729161AbeLVCcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 21:32:21 -0500
Received: from localhost (unknown [172.20.6.218])
        by mail.nic.cz (Postfix) with ESMTPS id 66B4762921;
        Sat, 22 Dec 2018 03:32:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1545445939; bh=DVUaM5s/gkyyrDuwO8dMNt7yBZhE+5BJMFeRm8dxk20=;
        h=Date:From:To;
        b=yKb7uN5rYZl0gHYlqS80X1GJ8ilMdWkBkfaflcABVM6yYykNK1ooW044/ylQ2snjP
         5XQjs/2yWXrvGHtdyPhZDMmutCehy+jufr1QyDKAkSdIzEYbD2s2BoJJgAWn2tP3WK
         /lH12XapH+iHwMtsOxi9RhHdrLSTSDz+hPURzIeM=
Date:   Sat, 22 Dec 2018 03:32:13 +0100
From:   Marek Behun <marek.behun@nic.cz>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?UTF-8?B?TWlxdcOobA==?= Raynal <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Marcin Wojtas <mw@semihalf.com>
Subject: Re: [PATCH 1/3] pinctrl: armada-37xx: Correct mpp definitions
Message-ID: <20181222033213.43642e0f@nic.cz>
In-Reply-To: <20181221173259.8372-2-gregory.clement@bootlin.com>
References: <20181221173259.8372-1-gregory.clement@bootlin.com>
        <20181221173259.8372-2-gregory.clement@bootlin.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2018 18:32:57 +0100
Gregory CLEMENT <gregory.clement@bootlin.com> wrote:

> +	PIN_GRP_GPIO("pcie1", 3, 1, BIT(5), "pcie"),
> +	PIN_GRP_GPIO("pcie1_clkreq", 4, 1, BIT(9), "pcie"),

If the pair is split to clkreq and reset, shouldn't the first be called
pcie1_reset?
Marek
