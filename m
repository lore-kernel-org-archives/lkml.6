Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53AEECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 870CE2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 870CE2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbeJSX5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 19:57:14 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:47289 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbeJSX5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 19:57:14 -0400
Received: from [192.168.0.111] (223.166.104.93) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Fri, 19 Oct
 2018 23:50:14 +0800
Subject: Re: [PATCH v5 2/3] clk: meson: add DT documentation for emmc clock
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
References: <1539839245-13793-1-git-send-email-jianxin.pan@amlogic.com>
 <1539839245-13793-3-git-send-email-jianxin.pan@amlogic.com>
 <153988248599.5275.8444799485095155762@swboyd.mtv.corp.google.com>
From:   Jianxin Pan <jianxin.pan@amlogic.com>
Message-ID: <efc5b030-f344-80ce-f57e-582207f436fe@amlogic.com>
Date:   Fri, 19 Oct 2018 23:50:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <153988248599.5275.8444799485095155762@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [223.166.104.93]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/19 1:08, Stephen Boyd wrote:
> Quoting Jianxin Pan (2018-10-17 22:07:24)
>> diff --git a/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
>> new file mode 100644
>> index 0000000..9e6d343
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
>> @@ -0,0 +1,31 @@
>> +* Amlogic MMC Sub Clock Controller Driver
>> +
>> +The Amlogic MMC clock controller generates and supplies clock to support
>> +MMC and NAND controller
>> +
>> +Required Properties:
>> +
>> +- compatible: should be:
>> +               "amlogic,gx-mmc-clkc"
>> +               "amlogic,axg-mmc-clkc"
>> +
>> +- #clock-cells: should be 1.
>> +- clocks: phandles to clocks corresponding to the clock-names property
>> +- clock-names: list of parent clock names
>> +       - "clkin0", "clkin1"
>> +
>> +Parent node should have the following properties :
> 
> The example only has one node. Can you add two nodes?
OK. This clock is used by nand and emmc. I will add a new example for emmc too.
Thank you for your review.
> 
>> +- compatible: "amlogic,axg-mmc-clkc", "syscon".
>> +- reg: base address and size of the MMC control register space.
>> +
>> +Example: Clock controller node:
>> +
>> +sd_mmc_c_clkc: clock-controller@7000 {
>> +       compatible = "amlogic,axg-mmc-clkc", "syscon";
>> +       reg = <0x0 0x7000 0x0 0x4>;
>> +       #clock-cells = <1>;
>> +
>> +       clock-names = "clkin0", "clkin1";
>> +       clocks = <&clkc CLKID_SD_MMC_C_CLK0>,
>> +                <&clkc CLKID_FCLK_DIV2>;
>> +};
> 
> .
> 

