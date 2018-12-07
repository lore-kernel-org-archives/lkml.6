Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9ECC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 541AC20661
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:41:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 541AC20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbeLGKlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:41:31 -0500
Received: from mail-sz2.amlogic.com ([211.162.65.114]:20458 "EHLO
        mail-sz2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbeLGKla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:41:30 -0500
Received: from [10.28.18.115] (10.28.18.115) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Fri, 7 Dec 2018
 18:41:39 +0800
Subject: Re: [PATCH v7 2/2] mtd: rawnand: meson: add support for Amlogic NAND
 flash controller
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>
CC:     Boris Brezillon <boris.brezillon@bootlin.com>,
        <linux-mtd@lists.infradead.org>, Yixun Lan <yixun.lan@amlogic.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1542386439-30166-1-git-send-email-jianxin.pan@amlogic.com>
 <1542386439-30166-3-git-send-email-jianxin.pan@amlogic.com>
 <20181207102456.1dc67e07@xps13> <20181207104254.0ecfc1e5@xps13>
From:   Liang Yang <liang.yang@amlogic.com>
Message-ID: <ac486ae7-7997-6f35-f29c-267c9c6f0f8c@amlogic.com>
Date:   Fri, 7 Dec 2018 18:41:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181207104254.0ecfc1e5@xps13>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.28.18.115]
X-ClientProxiedBy: mail-sz2.amlogic.com (10.28.11.6) To mail-sz2.amlogic.com
 (10.28.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

Appreciate your time.
I will follow the nand/next and rework some next week as soon as possible.

On 2018/12/7 17:42, Miquel Raynal wrote:
> Hi Jianxin,
> 
> Miquel Raynal <miquel.raynal@bootlin.com> wrote on Fri, 7 Dec 2018
> 10:24:56 +0100:
> 
>> Hi Jianxin,
>>
>> Looks good to me overall, a few comments inline.
>>
>> Jianxin Pan <jianxin.pan@amlogic.com> wrote on Sat, 17 Nov 2018
>> 00:40:38 +0800:
>>
>>> From: Liang Yang <liang.yang@amlogic.com>
>>>
>>> Add initial support for the Amlogic NAND flash controller which found
>>> in the Meson-GXBB/GXL/AXG SoCs.
>>>
>>> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
>>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>>> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
>>> ---
>>>   drivers/mtd/nand/raw/Kconfig      |   10 +
>>>   drivers/mtd/nand/raw/Makefile     |    1 +
>>>   drivers/mtd/nand/raw/meson_nand.c | 1417 +++++++++++++++++++++++++++++++++++++
>>>   3 files changed, 1428 insertions(+)
>>>   create mode 100644 drivers/mtd/nand/raw/meson_nand.c
>>>
> 
> I forgot to mention, Boris has done more cleanup which breaks your
> patches, please have a look at the following commits in the nand/next
> branch, they will force you to do some light rework to get the driver
> building (especially, you should not export the ->select_chip hook anymore):
> 
> 7a08dbaedd36 mtd: rawnand: Move ->setup_data_interface() to nand_controller_ops
> f2abfeb2078b mtd: rawnand: Move the ->exec_op() method to nand_controller_ops
> 7d6c37e90cf9 mtd: rawnand: Deprecate the ->select_chip() hook
> 1770022ffa85 mtd: rawnand: ams-delta: Stop implementing ->select_chip()
> 653c57c7da08 mtd: rawnand: vf610: Stop implementing ->select_chip()
> 2ace451cae22 mtd: rawnand: tegra: Stop implementing ->select_chip()
> b25251414f6e mtd: rawnand: marvell: Stop implementing ->select_chip()
> 550b9fc4e3af mtd: rawnand: fsmc: Stop implementing ->select_chip()
> 02b4a52604a4 mtd: rawnand: Make ->select_chip() optional when ->exec_op() is implemented
> ae2294b10b0f mtd: rawnand: Pass the CS line to be selected in struct nand_operation
> 1d0178593d14 mtd: rawnand: Add nand_[de]select_target() helpers
> 
> Thanks,
> Miquèl
> 
> .
> 
