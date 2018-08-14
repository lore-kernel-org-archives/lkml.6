Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1490C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B426B2172C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B426B2172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732324AbeHNP26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:28:58 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55393 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728978AbeHNP25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:28:57 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 48C4D207CD; Tue, 14 Aug 2018 14:41:54 +0200 (CEST)
Received: from localhost (unknown [37.169.111.59])
        by mail.bootlin.com (Postfix) with ESMTPSA id D638D2072C;
        Tue, 14 Aug 2018 14:41:43 +0200 (CEST)
Date:   Tue, 14 Aug 2018 14:41:35 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     Rob Herring <robh@kernel.org>, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, mark.rutland@arm.com,
        davem@davemloft.net, kishon@ti.com, andrew@lunn.ch,
        f.fainelli@gmail.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, allan.nielsen@microsemi.com,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net-next 02/10] dt-bindings: net: ocelot: remove hsio
 from the list of register address spaces
Message-ID: <20180814124135.GK943@piout.net>
References: <cover.aa759035f6eefdd0bb2a5ae335dab5bd5399bd46.1532954208.git-series.quentin.schulz@bootlin.com>
 <3558e538b55a2249b0a179c04c27e9d3715bbbaa.1532954208.git-series.quentin.schulz@bootlin.com>
 <20180813223103.GA16669@rob-hp-laptop>
 <20180814064953.vboz2gryq4jff34n@qschulz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180814064953.vboz2gryq4jff34n@qschulz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/2018 08:49:53+0200, Quentin Schulz wrote:
> Understood but it's an intermediate patch. Later (patch 8), the SerDes
> muxing "controller" is added as a child to this node. There most likely
> will be some others in the future (temperature sensor for example).
> 
> Furthermore, there's already a simple-mfd without children in this file:
> https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/mips/mscc.txt#L19
> 
> How should we handle this case?
> 

There were child nodes in previous version of the binding. You can
remove simple-mfd now. The useful registers that are not used by any
drivers are gpr and chipid.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
