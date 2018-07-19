Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345AAC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47782084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E47782084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731538AbeGSPLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:11:25 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:17350 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbeGSPLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:11:24 -0400
Received: from [192.168.90.65] (61.173.0.103) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Thu, 19 Jul
 2018 22:27:15 +0800
From:   Yixun Lan <yixun.lan@amlogic.com>
Subject: Re: [PATCH 3/3] clk: meson-g12a: Add EE Clock controller driver
To:     Kevin Hilman <khilman@baylibre.com>
References: <1531134767-29927-1-git-send-email-jian.hu@amlogic.com>
 <1531134767-29927-4-git-send-email-jian.hu@amlogic.com>
 <CAFBinCBB9N_p6S_-dfiV=zDCf-RYnA3C-ir6oNLC7JAfdOqqiw@mail.gmail.com>
 <ec49c089-bccf-9aac-5d0f-43bc27770ad9@amlogic.com>
 <1531216472.2708.71.camel@baylibre.com> <7hfu0jmhbe.fsf@baylibre.com>
 <7e1cce0b-fc86-b900-2019-a85c5e5ba2ae@amlogic.com>
 <7h601be2vk.fsf@baylibre.com>
CC:     <yixun.lan@amlogic.com>, Jerome Brunet <jbrunet@baylibre.com>,
        <qianggui.song@amlogic.com>, Rob Herring <robh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <mturquette@baylibre.com>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <bo.yang@amlogic.com>,
        <sboyd@kernel.org>, <jian.hu@amlogic.com>,
        <xingyu.chen@amlogic.com>, <qiufang.dai@amlogic.com>,
        <linux-amlogic@lists.infradead.org>, <sunny.luo@amlogic.com>,
        <carlo@caione.org>, <linux-arm-kernel@lists.infradead.org>
Message-ID: <e1f0b672-65de-6afa-cec4-e2d910c58b7c@amlogic.com>
Date:   Thu, 19 Jul 2018 22:27:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <7h601be2vk.fsf@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [61.173.0.103]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/19/2018 10:06 PM, Kevin Hilman wrote:
> Yixun Lan <yixun.lan@amlogic.com> writes:
> 
> [...]
> 
>>>
>>> As Jerome said, I think consistency is an important goal, so leaving off
>>> the "meson-" for drivers/clk is fine with me.
>>>
>> ok
>>
>>> Also for consistency, for the rest of the drivers, keeping "meson-" is
>>> probably the right thing to do.
>>>
>> ok, for the above, you are talking about the already exist compatible
>> names? or the patches we will push in the future?
> 
> I'm talking about future patches.
> 
ok

>>> However, patches would be welcome to add compatibles without the "meson"
>>> for the rest of the drivers & documentation as well, but please do not
>>> remove any compatibles.
>>>
>> I assume you are talking about the patches in the future we will push?
>> to drop the "meson".
>>
>> I'm confused here, as the above two paragraphs conflict with each other
> 
> Yeah, what I wrote is confusing, sorry about that.
> 
> What I mean is that new patches should stay consistent with compatibles
> in their existing drivers/subsystems.  That means keeping the "meson-"
> prefix for everything except drivers/clk.
> 
sounds good to me.

> In addition to that, patches would be welcome for *adding* compatibles
> without "meson" to all the current drivers.
> 
not sure if I parse above correctly, so let me rephrase..

for "all the current drivers", do you mean all the drivers which already
accepted at mainline kernel, which are mmc, uart, spi, i2c ..

all of them follow "amlogic,meson-${SOC}-${FUNCTION}", so do you propose
to add compatbiles like "amlogic,${SOC}-${FUNCTION}" ?

take i2c for example, there is "amlogic,meson-axg-i2c" already, do you
want to add another "amlogic,axg-i2c" ? I feel this will adding more
confusion..

How about only following the "amlogic,${SOC}-${FUNCTION}" syntax in the
new added drivers in the future, for example NAND, PCIE driver which we
want to push (those drivers doesn't exist in current mainline kernel).


Yixun



