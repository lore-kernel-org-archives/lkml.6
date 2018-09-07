Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E23AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B3E2077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12B3E2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbeIGQtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 12:49:22 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:25602 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbeIGQtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 12:49:21 -0400
Received: from [10.18.19.215] (10.18.19.215) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Fri, 7 Sep 2018
 20:09:04 +0800
Subject: Re: [PATCH v3 0/2] arm64: dts: meson-g12a: Introduce new DT files for
 Meson-G12A SoC
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        <linux-amlogic@lists.infradead.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Jian Hu <jian.hu@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1534243121-33589-1-git-send-email-jianxin.pan@amlogic.com>
 <170648ffb748c7b3890f5d7293920873efd16e30.camel@baylibre.com>
From:   Jianxin Pan <jianxin.pan@amlogic.com>
Message-ID: <aebe4a85-94b0-90f9-d3c2-ed0764398a55@amlogic.com>
Date:   Fri, 7 Sep 2018 20:09:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <170648ffb748c7b3890f5d7293920873efd16e30.camel@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.19.215]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/2018 7:58 PM, Jerome Brunet wrote:
> On Tue, 2018-08-14 at 18:38 +0800, Jianxin Pan wrote:
>> This attempt will try to add new DT files to support Meson-G12A SoC.
>>
>> 1) first, Please notice that, in this patch series, the DT node about 16M reserved
>> memory for hwrom is removed, since it's not needed by G12A SoC.
>> 2) second, the pclk for uart_AO need to be fixed once G12A clock_ao driver is
>> merged. In this version, it rely on bootloader to enable the pclk gate which 
>> belong to AO clock domain. Please add clk_ignore_unused to bootargs.
>>
>> Changes since v2 [1]:
>>  - reorder subnodes
>>  - collect Rob's Reviewed-by
>>
>> Changes since v1 [0]:
>>  - fix signoff typo
>>  - order subnodes by addresses when there is one and alphabetically when there is none
>>
>> [0] https://lore.kernel.org/lkml/1533802951-49919-2-git-send-email-jianxin.pan@amlogic.com/
>>
>> Jianxin Pan (2):
>>   dt-bindings: arm: amlogic: Add Meson G12A binding
>>   arm64: dts: meson-g12a: add initial g12a s905d2 SoC DT support
>>
>>  Documentation/devicetree/bindings/arm/amlogic.txt |   6 +
>>  arch/arm64/boot/dts/amlogic/Makefile              |   1 +
>>  arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts   |  22 +++
>>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi       | 172 ++++++++++++++++++++++
>>  4 files changed, 201 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
>>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
>>
> 
> Series looks good as far as I can tell
> 
> Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
> 
> .
> 
Hi Kevin, this series are tested on latest v4.20/integ.
