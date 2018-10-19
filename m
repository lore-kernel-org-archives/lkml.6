Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DE3ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 05:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 765642083E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 05:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 765642083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbeJSNyu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 09:54:50 -0400
Received: from hermes.aosc.io ([199.195.250.187]:50090 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726968AbeJSNyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 09:54:50 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 2D46B15D401;
        Fri, 19 Oct 2018 05:50:12 +0000 (UTC)
Date:   Fri, 19 Oct 2018 13:50:07 +0800
In-Reply-To: <153988319489.5275.13596491306786109572@swboyd.mtv.corp.google.com>
References: <20181018070729.52943-1-icenowy@aosc.io> <153988319489.5275.13596491306786109572@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v2] clk: sunxi-ng: enable so-said LDOs for A64 SoC's pll-mipi clock
To:     linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
CC:     linux-sunxi@googlegroups.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <AF7A4F82-D6B1-4F86-ACF1-2786E990C0B6@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年10月19日 GMT+08:00 上午1:19:54, Stephen Boyd <sboyd@kernel.org> 写到:
>Quoting Icenowy Zheng (2018-10-18 00:07:29)
>> In the user manual of A64 SoC, the bit 22 and 23 of pll-mipi control
>> register is called "LDO{1,2}_EN", and according to the BSP source
>code
>> from Allwinner , the LDOs are enabled during the clock's enabling
>> process.
>> 
>> The clock failed to generate output if the two LDOs are not enabled.
>> 
>> Add the two bits to the clock's gate bits, so that the LDOs are
>enabled
>> when the PLL is enabled.
>> 
>> Fixes: c6a0637460c2 ("clk: sunxi-ng: Add A64 clocks")
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>
>Looks OK to me from not knowing anything about this driver. Shall I
>pick
>directly into clk-next for next release?

I prefer to wait for an ACK from Maxime.

>
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
