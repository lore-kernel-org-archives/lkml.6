Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EADC07E85
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 02:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3ED2081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 02:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F3ED2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbeLDCj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 21:39:28 -0500
Received: from mail-sh2.amlogic.com ([58.32.228.45]:42408 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbeLDCj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 21:39:28 -0500
Received: from [10.18.29.207] (10.18.29.207) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Tue, 4 Dec 2018
 10:39:34 +0800
Subject: Re: [PATCH v7 2/4] clk: meson: add DT documentation for emmc clock
 controller
To:     Stephen Boyd <sboyd@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Yixun Lan <yixun.lan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        <linux-clk@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1542284312-55418-1-git-send-email-jianxin.pan@amlogic.com>
 <1542284312-55418-3-git-send-email-jianxin.pan@amlogic.com>
 <154387713374.88331.16436869339024592009@swboyd.mtv.corp.google.com>
From:   Jianxin Pan <jianxin.pan@amlogic.com>
Message-ID: <b401f5bc-32e7-1693-0839-87ffa3dd5767@amlogic.com>
Date:   Tue, 4 Dec 2018 10:39:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <154387713374.88331.16436869339024592009@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.207]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 2018/12/4 6:45, Stephen Boyd wrote:
> Quoting Jianxin Pan (2018-11-15 04:18:30)
>> diff --git a/include/dt-bindings/clock/amlogic,mmc-clkc.h b/include/dt-bindings/clock/amlogic,mmc-clkc.h
>> new file mode 100644
>> index 0000000..162b949
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/amlogic,mmc-clkc.h
>> @@ -0,0 +1,17 @@
>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
>> +/*
>> + * Meson MMC sub clock tree IDs
>> + *
>> + * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
>> + * Author: Yixun Lan <yixun.lan@amlogic.com>
>> + */
>> +
>> +#ifndef __MMC_CLKC_H
>> +#define __MMC_CLKC_H
>> +
>> +#define CLKID_MMC_DIV                          1
> 
> Why does the define numbering start with 1 instead of 0?
>
The Clock ID 0 is used by  CLKID_MMC_MUX.
CLKID_MMC_MUX is an internal clock which defined in drivers/clk/meson/mmc-clkc.c, and it's the parent of CLKID_MMC_DIV.
 
>> +#define CLKID_MMC_PHASE_CORE                   2
>> +#define CLKID_MMC_PHASE_TX                     3
>> +#define CLKID_MMC_PHASE_RX                     4
>> +
> 
> .
> 

