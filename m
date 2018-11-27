Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175A3C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF11C2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF11C2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731034AbeK1D0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:26:18 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49533 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730444AbeK1D0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:26:18 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F3A3A20747; Tue, 27 Nov 2018 17:27:50 +0100 (CET)
Received: from localhost (unknown [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id C37042037D;
        Tue, 27 Nov 2018 17:27:40 +0100 (CET)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH 3/6] clk: mvebu: add CPU clock driver for Armada 7K/8K
References: <20180922181709.13007-1-gregory.clement@bootlin.com>
        <20180922181709.13007-4-gregory.clement@bootlin.com>
        <153980089252.5275.819540708953283855@swboyd.mtv.corp.google.com>
        <87y39tufwe.fsf@bootlin.com>
Date:   Tue, 27 Nov 2018 17:27:40 +0100
In-Reply-To: <87y39tufwe.fsf@bootlin.com> (Gregory CLEMENT's message of "Fri,
        16 Nov 2018 00:22:59 +0100")
Message-ID: <87wooymqo3.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,
 
 On ven., nov. 16 2018, Gregory CLEMENT <gregory.clement@bootlin.com> wrote:

>>> +static int ap_cpu_clock_probe(struct platform_device *pdev)
>>> +{
>>> +       int ret, nclusters = 0, cluster_index = 0;
>>> +       struct device *dev = &pdev->dev;
>>> +       struct device_node *dn, *np = dev->of_node;
>>> +       struct ap_cpu_clk *ap_cpu_clk;
>>> +       struct regmap *regmap;
>>> +
>>> +       regmap = syscon_node_to_regmap(np->parent);
>>
>> Can we just call dev_get_remap() on pdev->dev.parent?
>
> we could do regmap = dev_get_regmap(pdev->dev.parent, NULL); instead of
> this line. But is it really better?

Actually we can't, because we really depend on a syscon and at this
moment there is no regmap. It is the syscon_node_to_regmap function which
creates this regmap when needed.

Gregory

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
