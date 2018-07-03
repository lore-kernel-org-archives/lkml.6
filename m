Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D2CC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651C921925
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 651C921925
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933112AbeGCHhM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:37:12 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:58268 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932441AbeGCHhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:37:10 -0400
Received: from [192.168.90.200] (10.18.20.235) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Tue, 3 Jul 2018
 15:36:20 +0800
Subject: Re: [PATCH 2/3] clk: meson: add sub EMMC clock dt-bindings IDs
To:     Boris Brezillon <boris.brezillon@bootlin.com>
References: <20180703145716.31860-1-yixun.lan@amlogic.com>
 <20180703145716.31860-3-yixun.lan@amlogic.com>
 <20180703092107.51497a8f@bbrezillon>
CC:     <yixun.lan@amlogic.com>, Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>, <linux-clk@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
From:   Yixun Lan <yixun.lan@amlogic.com>
Message-ID: <4b88c509-27ea-2605-023b-de208921e157@amlogic.com>
Date:   Tue, 3 Jul 2018 15:36:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180703092107.51497a8f@bbrezillon>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.20.235]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Broris

 thanks for your quick response, and see my comments below

On 07/03/18 15:21, Boris Brezillon wrote:
> On Tue, 3 Jul 2018 14:57:15 +0000
> Yixun Lan <yixun.lan@amlogic.com> wrote:
> 
>> Add two clock bindings IDs which provided by the EMMC clock controller,
>> These two clocks will be used by EMMC or NAND driver.
>>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>> ---
>>  include/dt-bindings/clock/emmc-clkc.h | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>  create mode 100644 include/dt-bindings/clock/emmc-clkc.h
>>
>> diff --git a/include/dt-bindings/clock/emmc-clkc.h b/include/dt-bindings/clock/emmc-clkc.h
>> new file mode 100644
>> index 000000000000..d9972c400e58
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/emmc-clkc.h
>> @@ -0,0 +1,14 @@
>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
>> +/*
>> + * Meson EMMC sub clock tree IDs
>> + *
>> + * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
>> + */
>> +
>> +#ifndef __EMMC_CLKC_H
>> +#define __EMMC_CLKC_H
>> +
>> +#define CLKID_EMMC_C_MUX				0
> 
> Looks like the MUX clk is the parent of the DIV one, and I guess the clk
> driver is able to select the best parent+div pair for a requested rate.
> Do you really need to expose the MUX to users?
> 

Yes, It's true, the mux is parent of the div clock.

while testing for the NAND driver, I find it's kind of loose about the
parent of the clock, so selecting the div (and let CCF decide freely) is
actually works fine

but for the EMMC driver, especially when running at high clock, it's
kind of picky about the parent of the clock, so the driver may want to
manually choose the parent of the mux clock (example fclk_div2 here).
That's why I'm exporting this clock ID.


>> +#define CLKID_EMMC_C_DIV				1
>> +
>> +#endif
> 
> .
> 

