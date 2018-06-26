Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6637DC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E8D326AD5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Hj1Ox2Eu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E8D326AD5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965277AbeFZM5o (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 08:57:44 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:37076 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965077AbeFZM5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 08:57:42 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelnx194.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5QCuaRd009654;
        Tue, 26 Jun 2018 07:56:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530017796;
        bh=h+ba3SBoqesjXRvrCnsBOulnTji2/MF6egfPo0XzV+o=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Hj1Ox2Eufoeox1VirJrAmi0X4G1r41HyLl3rB6303hdKQN1lykawkxr/TXNrONxqJ
         14oCK7ItWOtgwFbtsHOjVurcbZ/f+nNXl/FVyAVLdaoIMIRfMEfrhwTAcRDCpdVkxi
         RnOaUDAcimUPFueCxSgLvcD9TVoOBZIDDLBw7lVU=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5QCuaA9028003;
        Tue, 26 Jun 2018 07:56:36 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 26
 Jun 2018 07:56:35 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 26 Jun 2018 07:56:35 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5QCuVfb007095;
        Tue, 26 Jun 2018 07:56:32 -0500
Subject: =?UTF-8?Q?Re:_[PATCH_v11_00/27]_ARM:_davinci:_convert_to_common_clo?=
 =?UTF-8?B?Y2sgZnJhbWV3b3Jr4oCL?=
To:     David Lechner <david@lechnology.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, <linux-kernel@vger.kernel.org>
References: <20180518164829.27052-1-david@lechnology.com>
 <850a0ec9-53aa-02a5-ecbd-e068b13b2764@ti.com>
 <9ca9d240-f556-cb4f-1a58-4a55c379a02f@lechnology.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <a45f20fe-61f1-6c10-c44d-655f9960d824@ti.com>
Date:   Tue, 26 Jun 2018 18:26:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <9ca9d240-f556-cb4f-1a58-4a55c379a02f@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 May 2018 11:51 PM, David Lechner wrote:
> On 05/22/2018 04:38 AM, Sekhar Nori wrote:
>> Hi David,
>>
>> On Friday 18 May 2018 10:18 PM, David Lechner wrote:
>>> This series converts mach-davinci to use the common clock framework.
>>>
>>> The series works like this, the first 3 patches fix some issues with
>>> the clock
>>> drivers that have already been accepted into the mainline kernel.
>>>
>>> Then, starting with "ARM: davinci: pass clock as parameter to
>>> davinci_timer_init()", we get the mach code ready for the switch by
>>> adding the
>>> code needed for the new clock drivers and adding #ifndef
>>> CONFIG_COMMON_CLK
>>> around the legacy clocks so that we can switch easily between the old
>>> and the
>>> new.
>>>
>>> "ARM: davinci: switch to common clock framework" actually flips the
>>> switch
>>> to start using the new clock drivers. Then the next 8 patches remove all
>>> of the old clock code.
>>>
>>> The final four patches add device tree clock support to the one SoC that
>>> supports it.
>>>
>>> This series has been tested on TI OMAP-L138 LCDK (both device tree
>>> and legacy
>>> board file).
>>
>> If you do end up sending a v12, you can leave out the mach-davinci
>> portions unless there are any changes you need to make. I will pick them
>> up from this series once the driver dependencies are merged.
>>
>> I do hope the drivers/clk/* changes can be merged from v4.18.
>>
> 
> I have resent all of the clk patches (including all of the ones I listed as
> dependencies in addition to the three remaining in this series) under the
> cover "clk: davinci: outstanding fixes​".
> 
> I also found that we need to add power-domains properties to the PWM nodes
> in "ARM: dts: da850: Add clocks". I probably should just take your advice
> and just globally added them even if they are not documented for some types
> ofnodes.

I think doing it en masse will be controversial. Just add it to PWM
nodes for now (I am assuming the binding documentation agrees).

I have applied this series so please send any more changes as follow-on
patches.

Thanks
Sekhar
