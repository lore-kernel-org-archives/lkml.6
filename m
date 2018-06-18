Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086C4C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 04:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4BDA20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 04:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lMhR3E4K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4BDA20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754358AbeFREs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 00:48:26 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:53125 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754091AbeFREsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 00:48:24 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllnx210.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5I4lF2l002662;
        Sun, 17 Jun 2018 23:47:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1529297235;
        bh=xNcwflilxW1Kk0mIp4ngJyHM8wf4ca9xFVfr8EgedWA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=lMhR3E4K4Sd+ULemrkPuu/aJOnW8YfKXS55YGMp9m9KuwWWPjyTOF505gyHxXhr+Y
         Zn8ug3SMqpSNMhr8D9a3CWe9Qd3gPBaXL6Wj4G80ZSIVz0RErtF8yAQ3j+TtFITfum
         m92lMkZtMmWXQUSNznvVMaZXJF46NNfznKr4rAPo=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5I4lFRA017885;
        Sun, 17 Jun 2018 23:47:15 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Sun, 17
 Jun 2018 23:47:15 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Sun, 17 Jun 2018 23:47:15 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5I4l9pq028653;
        Sun, 17 Jun 2018 23:47:10 -0500
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
 <89b599d3-c43a-255f-8da6-9bea6cf53a5d@lechnology.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <513d20f6-da4f-1e3e-7d11-4a0f1193b13d@ti.com>
Date:   Mon, 18 Jun 2018 10:17:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <89b599d3-c43a-255f-8da6-9bea6cf53a5d@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Sunday 17 June 2018 09:18 PM, David Lechner wrote:
> Hi Sekhar,
> 
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
>> Thanks,
>> Sekhar
>>
> 
> Are you going to pick up the arch patches from this series now that
> the 4.18 merge window is closed?
> 
> All of the clk patches landed in 4.18.

yes!

Thanks,
Sekhar
