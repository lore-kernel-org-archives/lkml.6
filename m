Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5046C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3342174E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C3342174E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbeHMOjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 10:39:36 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:23875 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728712AbeHMOjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 10:39:36 -0400
Received: from [10.18.19.215] (10.18.19.215) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Mon, 13 Aug
 2018 19:57:54 +0800
Subject: Re: [PATCH v2 2/2] arm64: dts: meson-g12a: add initial g12a s905d2
 SoC DT support
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
References: <1534160901-22889-1-git-send-email-jianxin.pan@amlogic.com>
 <1534160901-22889-3-git-send-email-jianxin.pan@amlogic.com>
 <97a8213c1dd3a22b4f98c959d4a2c2bfbd432e9d.camel@baylibre.com>
From:   Jianxin Pan <jianxin.pan@amlogic.com>
Message-ID: <5f35952e-38de-4c4f-0a3f-42ff0ffab46f@amlogic.com>
Date:   Mon, 13 Aug 2018 19:57:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <97a8213c1dd3a22b4f98c959d4a2c2bfbd432e9d.camel@baylibre.com>
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

On 8/13/2018 7:52 PM, Jerome Brunet wrote:
> On Mon, 2018-08-13 at 19:48 +0800, Jianxin Pan wrote:
>> Try to add basic DT support for the Amlogic's Meson-G12A S905D2 SoC,
>> which describe components as follows: Reserve Memory, CPU, GIC, IRQ,
>> Timer, UART. It's capable of booting up into the serial console.
>>
>> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
>> ---
>>  arch/arm64/boot/dts/amlogic/Makefile            |   1 +
>>  arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts |  22 +++
>>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi     | 172 ++++++++++++++++++++++++
>>  3 files changed, 195 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
>>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
>>
>> +
>> +	timer {
>> +		compatible = "arm,armv8-timer";
>> +		interrupts = <GIC_PPI 13
>> +			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 14
>> +			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 11
>> +			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 10
>> +			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>;
>> +	};
> 
> t* should be after s*
OK, I will fix it. Thanks for your review
> 
>> +
>> +	soc {
>> +		compatible = "simple-bus";
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
> 
> .
> 

