Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1110C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 08:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87AA0208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 08:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87AA0208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbeKPSk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 13:40:28 -0500
Received: from mail-sz2.amlogic.com ([211.162.65.114]:56017 "EHLO
        mail-sz2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbeKPSk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 13:40:27 -0500
Received: from [10.28.18.44] (10.28.18.44) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Fri, 16 Nov
 2018 16:29:07 +0800
Subject: Re: [PATCH v6 2/2] mtd: rawnand: meson: add support for Amlogic NAND
 flash controller
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Rob Herring <robh@kernel.org>, Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Richard Weinberger <richard@nod.at>,
        Yixun Lan <yixun.lan@amlogic.com>,
        <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Jian Hu <jian.hu@amlogic.com>, <linux-mtd@lists.infradead.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        <linux-amlogic@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Wolfram Sang <wsa@the-dreams.de>
References: <1541090542-19618-1-git-send-email-jianxin.pan@amlogic.com>
 <1541090542-19618-3-git-send-email-jianxin.pan@amlogic.com>
 <20181105165321.7ea2b45f@bbrezillon>
 <a571904e-6296-bf62-e1fe-e25bf90040bb@amlogic.com>
 <20181106102851.61deb97a@bbrezillon>
 <ff02373e-c97b-182d-5b43-83d1e8f6d51a@amlogic.com>
 <20181106112206.65a70a81@bbrezillon> <20181112171351.4ac3506b@xps13>
 <20181112175416.247e3203@bbrezillon> <20181112184518.6c02ac6d@bbrezillon>
 <27769252-ac5e-e787-6792-d6a06e7af0e4@amlogic.com>
 <20181115140400.3934effe@xps13> <20181115140905.40011b4b@bbrezillon>
From:   Liang Yang <liang.yang@amlogic.com>
Message-ID: <7e36bf4c-69a1-a570-f086-75f8ad53d518@amlogic.com>
Date:   Fri, 16 Nov 2018 16:29:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181115140905.40011b4b@bbrezillon>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.18.44]
X-ClientProxiedBy: mail-sz2.amlogic.com (10.28.11.6) To mail-sz2.amlogic.com
 (10.28.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris and Miquel,

understand. i will move helpers into nfc driver to avoid some errors 
when sending the patch.

On 2018/11/15 21:09, Boris Brezillon wrote:
> On Thu, 15 Nov 2018 14:04:00 +0100
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
>> Hi Liang,
>>
>> Liang Yang <liang.yang@amlogic.com> wrote on Thu, 15 Nov 2018 19:25:07
>> +0800:
>>
>>> Hi Boris,
>>>
>>> I have implemented dma access base on these helpers you provided below.
>>> we prepare to send v7 version now, so when will these helpers be pushed?
>>
>> Thanks for your work. You can send the v7 so we will have a look at the
>> overall driver; but since we raised the DMA buffers issue we had a
>> discussion with Boris about how to handle them and I think we are going
>> to adopt the same solution as Wolfram in the I2C subsystem: manual
>> flagging. Sadly, this is probably the best we can do to ensure proper
>> DMA support.
>>
>> There is nothing set is stone yet but I started a small rework to
>> handle MTD operations differently (and add a DMA_SAFE flag), you can
>> have a look there [1]. Don't base your work on it for now as it is just
>> a preliminary version, subject to big changes.
> 
> In order to not block the driver, I'd suggest that you move the helper
> I proposed directly into your driver and prefix them with 'meson_'.
> 
> .
> 
