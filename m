Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F63CC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40DB8248BC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="eqNjw6uV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZAMPjh8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40DB8248BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sholland.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934622AbeGCSmn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 14:42:43 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38845 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934381AbeGCSml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 14:42:41 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 17EFF2118B;
        Tue,  3 Jul 2018 14:42:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 03 Jul 2018 14:42:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=iTl8my03sf8tqf0lxcp/tUG1nXC3Q
        fQpSMggsOBjP2k=; b=eqNjw6uV102z65Zrmn5QwVJ1hg3sd0IZsoQLXP6CbvR/Z
        /cIJ7oD0u8sAMKf5fUrIPA5Z/wj+xRW0lLKQVqr0McxN0C6+oG9Xt7Yh0H6zp14o
        vyU8zbLRzqYIjo1rYwafAIEtS3VA9dwc1DDtfHEKMoBC2H8+vRwH5qfbD9Gf3CK+
        b0M1HPkaiZVZqT3EvYfQqG6tgEX10HaKgM4Y+JQpmChIb3kL8QAnbexwsUShVs54
        UcRcCsIyUIfyZO8qa7MrrgFTZ7IdMQexvVcXFWybKADCnjqebi1eS6tQtiNSScRj
        1dfSmd1VS9PaviQxsrE+KDPBL6w/pKvsskbMIqkgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=iTl8my
        03sf8tqf0lxcp/tUG1nXC3QfQpSMggsOBjP2k=; b=ZAMPjh8IOB03RZl8nJiaND
        iuMKYcNRJo/AwXb9piJp15noLb/JoA7H5z5lVK/6IXS9+pt3faOLPBywUHzNoSXz
        5mv8mGCV25Kl80bTyDNnW7fnPqWb5gEyCL1k2oh71aqvCtah1kvkiqfo05xc94YI
        Ho1afBkNkOodqzFC/ArIWxHMlqwisSeszcvpecmsO/tFJ3N9iB+Vl//R2psenBD+
        fYMZD934QjWrs5BKoZIoQwphq2xsicCAXIrRxz8rtjs5SGiiV4rPWGRmFW3qQr54
        TBwQFeejrzakPBk/KeE2/ccdNdlz6bVC3YQGW8e2yVXEIWOczJ/TTZUZ9mSTM/zA
        ==
X-ME-Proxy: <xmx:oMM7W5X-AtB74Dtdk4ncbOpBP_m7jQBlTq1AN6HFH3aehtAtnAovwg>
    <xmx:oMM7W46gzqly83HfvBCJmyqc9lEtuMup9aXsonKd-3s-SytVgXAx6Q>
    <xmx:oMM7W44619H-uzaVRsCYKXWOyEp0B-8Pu4ritI-1KZ4ges9HC-En1A>
    <xmx:oMM7W0FwQryhyMNAWCYcZQPbeSeKsW9QY2PgXZCiWfZ3Le5d6C4xbQ>
    <xmx:oMM7W3UIOzAqJHn2LZcsxeJtEFCDsdLwLnSw7RhvSohNi2gTYUPPLw>
    <xmx:ocM7W9q9YrYm1LKIL7shTCpM_Z39fb1vI6Kw-fVAIM0TMuS83TQiSg>
X-ME-Sender: <xms:oMM7W7Ja9vQFHDtkXcMWeEef3BWOH2Krd_Q3g4aSkpwXtY2cfXuQ3g>
Received: from [192.168.43.79] (mobile-107-77-172-55.mobile.att.net [107.77.172.55])
        by mail.messagingengine.com (Postfix) with ESMTPA id B9B55E444F;
        Tue,  3 Jul 2018 14:42:38 -0400 (EDT)
Subject: Re: [PATCH 0/2] Allwinner A64 timer workaround
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Mark Rutland <Mark.Rutland@arm.com>
References: <20180511022751.9096-1-samuel@sholland.org>
 <2c16d5ab-38f7-8f3e-875c-19e8032f440a@arm.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <bdfb1a31-2c4a-d258-7bf6-aaab8cee4663@sholland.org>
Date:   Tue, 3 Jul 2018 13:42:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <2c16d5ab-38f7-8f3e-875c-19e8032f440a@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/18 10:09, Marc Zyngier wrote:
> On 11/05/18 03:27, Samuel Holland wrote:
>> Hello,
>> 
>> Several people (including me) have experienced extremely large system
>> clock jumps on their A64-based devices, apparently due to the architectural
>> timer going backward, which is interpreted by Linux as the timer wrapping
>> around after 2^56 cycles.
>> 
>> Investigation led to discovery of some obvious problems with this SoC's 
>> architectural timer, and this patch series introduces what I believe is
>> the simplest workaround. More details are in the commit message for patch
>> 1. Patch 2 simply enables the workaround in the device tree.
> 
> What's the deal with this series? There was a couple of nits to address, and 
> I was more or less expecting a v2.

I got reports that people were still occasionally having clock jumps after
applying this series, so I wanted to attempt a more complete fix, but I haven't
had time to do any deeper investigation. I think this series is still beneficial
even if it's not a complete solution, so I'll come back with another patch on
top of this if/once I get it fully fixed.

I'll prepare a v2 with a bounded loop. Presumably, 3 * (max CPU Hz) / (24MHz
timer) ≈ 150 should be a conservative iteration limit?

Also, does this make sense to CC to stable?

Thanks,
Samuel
