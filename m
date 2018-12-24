Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8480BC64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 17:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2564921850
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 17:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbeLXRF2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 12:05:28 -0500
Received: from mail.bootlin.com ([62.4.15.54]:34098 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbeLXRF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 12:05:27 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7B76E20A46; Mon, 24 Dec 2018 18:05:25 +0100 (CET)
Received: from localhost (alyon-652-1-163-36.w109-212.abo.wanadoo.fr [109.212.74.36])
        by mail.bootlin.com (Postfix) with ESMTPSA id 40DD62070E;
        Mon, 24 Dec 2018 18:05:15 +0100 (CET)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Marek Behun <marek.behun@nic.cz>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Marcin Wojtas <mw@semihalf.com>
Subject: Re: [PATCH 1/3] pinctrl: armada-37xx: Correct mpp definitions
References: <20181221173259.8372-1-gregory.clement@bootlin.com>
        <20181221173259.8372-2-gregory.clement@bootlin.com>
        <20181222033213.43642e0f@nic.cz>
Date:   Mon, 24 Dec 2018 18:05:15 +0100
In-Reply-To: <20181222033213.43642e0f@nic.cz> (Marek Behun's message of "Sat,
        22 Dec 2018 03:32:13 +0100")
Message-ID: <87efa6c0tw.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,
 
 On sam., déc. 22 2018, Marek Behun <marek.behun@nic.cz> wrote:

> On Fri, 21 Dec 2018 18:32:57 +0100
> Gregory CLEMENT <gregory.clement@bootlin.com> wrote:
>
>> +	PIN_GRP_GPIO("pcie1", 3, 1, BIT(5), "pcie"),
>> +	PIN_GRP_GPIO("pcie1_clkreq", 4, 1, BIT(9), "pcie"),
>
> If the pair is split to clkreq and reset, shouldn't the first be called
> pcie1_reset?

I considered this but chose to keep pcie1 in order to preserve backward
compatibility.

I agree that it is debatable, because without the fix the old device
tree can't work. However I find it better preserving the initial intent
of an existing device tree.

By talking about it, I think about an other option, keeping pcie1 name
to setup the pins 39 and 40 how it was documented. And introducing
pcie1_reset and pcie1_clkreq for new binding. however I don't know how
it could be handle by the pinctrl framework.

Gregory

> Marek

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
