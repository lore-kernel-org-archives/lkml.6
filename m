Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72186C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24ED020844
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24ED020844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933607AbeGIQnV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:43:21 -0400
Received: from foss.arm.com ([217.140.101.70]:34872 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932755AbeGIQnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:43:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA0C67A9;
        Mon,  9 Jul 2018 09:43:17 -0700 (PDT)
Received: from [10.1.206.75] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9FB23F589;
        Mon,  9 Jul 2018 09:43:15 -0700 (PDT)
Subject: Re: [PATCH v4 1/1] arm64: dts: mediatek: add mt6765 support
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1531116302-29921-1-git-send-email-mars.cheng@mediatek.com>
 <1531116302-29921-2-git-send-email-mars.cheng@mediatek.com>
 <7fb13f45-4e33-6efc-467b-c7256a40cbc9@gmail.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <d439eb7d-6365-7a0a-2969-1ddecc51defc@arm.com>
Date:   Mon, 9 Jul 2018 17:43:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <7fb13f45-4e33-6efc-467b-c7256a40cbc9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/18 11:20, Matthias Brugger wrote:
> 
> 
> On 09/07/18 08:05, Mars Cheng wrote:
>> This adds basic chip support for MT6765 SoC.
>>
>> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
>> ---
>>  arch/arm64/boot/dts/mediatek/Makefile       |    1 +
>>  arch/arm64/boot/dts/mediatek/mt6765-evb.dts |   33 ++++++
>>  arch/arm64/boot/dts/mediatek/mt6765.dtsi    |  156 +++++++++++++++++++++++++++
>>  3 files changed, 190 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6765-evb.dts
>>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6765.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
>> index ac17f60..7506b0d 100644
>> --- a/arch/arm64/boot/dts/mediatek/Makefile
>> +++ b/arch/arm64/boot/dts/mediatek/Makefile
>> @@ -1,6 +1,7 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt2712-evb.dtb
>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6755-evb.dtb
>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt6765-evb.dtb
>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-evb.dtb
>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
> 
> As you can see, we have a long list of SoCs which are poorly supported.
> I'm not very keen to just add another SoC which supports booting into a ramdisk
> using the serial console. Do you have a roadmap adding mainline support for this
> SoC?

Yes, that's a valid concern.

mt6755 and mt6795 are in a similar state, the latter after three years.
I'm all for supporting new SoCs, but this feels looks a box-ticking
exercise ("hey, look, our SoC is supported in mainline") which doesn't
help anyone.

My Ack still stands, but I'd definitely like to see some more complete
support before this patch goes in.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
