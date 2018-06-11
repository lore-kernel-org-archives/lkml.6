Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ucbKBagVHltddAAAmS7hNA
	; Mon, 11 Jun 2018 06:26:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DBADE608CD; Mon, 11 Jun 2018 06:26:53 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PYtLa1//"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 56A8D60385;
	Mon, 11 Jun 2018 06:26:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 56A8D60385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932346AbeFKG0u (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 02:26:50 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:21427 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753926AbeFKG0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 02:26:48 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllnx210.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5B6PwEX025738;
        Mon, 11 Jun 2018 01:25:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1528698358;
        bh=EmgaaNKWxHLS1kRMBjrfucamRy4RkOE8ZsMgcReL0HQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=PYtLa1//dCoF/1r7GSasa6BchH4hlYRZe41Eogc6lp6tY1GRk0PIickCCE31tVKCK
         thEj6FU77rGbPMDRYzjbYHuBIfUXTLGi3ZhcCeWcHe2N7sfX8qT6KWvKRZPM6g1Ynp
         xAdHuAe7o4iI+FJ4ZaQhCUJR9jT1Cy/aFfuxayA4=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5B6PwJm009007;
        Mon, 11 Jun 2018 01:25:58 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 11
 Jun 2018 01:25:58 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 11 Jun 2018 01:25:57 -0500
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5B6Psg1032619;
        Mon, 11 Jun 2018 01:25:54 -0500
Subject: Re: [PATCH v3 4/6] bus: ti-sysc: Add support for software reset
To: Tony Lindgren <tony@atomide.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <mark.rutland@arm.com>,
        <paul@pwsan.com>, <t-kristo@ti.com>, <robh+dt@kernel.org>,
        <bcousson@baylibre.com>
References: <20180606060826.14671-1-faiz_abbas@ti.com>
 <20180606060826.14671-5-faiz_abbas@ti.com>
 <20180607073530.GH5738@atomide.com>
 <a169ba7f-53f2-cf9a-a9ee-daffd6b53279@ti.com>
 <20180608062158.GI5738@atomide.com>
 <acdfef83-8778-e8f4-e423-ed04a9a8a649@ti.com>
 <20180611060957.GN5738@atomide.com>
From: Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <f460481f-85a9-2a41-a894-6f25122dee8a@ti.com>
Date: Mon, 11 Jun 2018 11:57:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180611060957.GN5738@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday 11 June 2018 11:39 AM, Tony Lindgren wrote:
> * Faiz Abbas <faiz_abbas@ti.com> [180611 06:09]:
>> Hi Tony,
>>
>> On Friday 08 June 2018 11:51 AM, Tony Lindgren wrote:
>>> * Faiz Abbas <faiz_abbas@ti.com> [180607 10:24]:
>>>> Hi,
>>>>
>>>> On Thursday 07 June 2018 01:05 PM, Tony Lindgren wrote:
>>>>> * Faiz Abbas <faiz_abbas@ti.com> [180606 06:14]:
>>>>>> +static int sysc_reset(struct sysc *ddata)
>>>>>> +{
>>>>>> +	int offset = ddata->offsets[SYSC_SYSCONFIG];
>>>>>> +	int val = sysc_read(ddata, offset);
>>>>>> +
>>>>>> +	val |= (0x1 << ddata->cap->regbits->srst_shift);
>>>>>> +	sysc_write(ddata, offset, val);
>>>>>> +
>>>>>> +	/* Poll on reset status */
>>>>>> +	if (ddata->cfg.quirks & SYSC_QUIRK_RESET_STATUS) {
>>>>>> +		offset = ddata->offsets[SYSC_SYSSTATUS];
>>>>>> +
>>>>>> +		return readl_poll_timeout(ddata->module_va + offset, val,
>>>>>> +				(val & ddata->cfg.syss_mask) == 0x0,
>>>>>> +				100, MAX_MODULE_SOFTRESET_WAIT);
>>>>>> +	}
>>>>>> +
>>>>>> +	return 0;
>>>>>> +}
>>>>>
>>>>> I wonder if we should also add SYSS_QUIRK_RESET_STATUS in
>>>>> addition to SYSC_QUIRK_RESET status to make it easy to
>>>>> read the right register?
>>>>
>>>> I assumed SYSC_QUIRK is the prefix to indicate the ti-sysc driver not
>>>> the register. Are there layouts in which the reset status bit is in the
>>>> sysconfig register rather than the sysstatus register?
>>>
>>> Yes we can have reset status bit in either syss or syssconfig register.
>>
>> You mean sysstatus and sysconfig right?
> 
> Yup.
> 
>>> We detect that in sysc_init_syss_mask() but we should also set something
>>> at that point to make it clear which reset to use. But as we don't need
>>> the quirk flag, it's probably set a function pointer after the detection.
>>> So how about let's have two functions sysc_reset() and sysc_syss_reset()
>>> and then we can implement sysc_syss_reset() in a separate patch after
>>> testing it when we have a non-platform data using example for
>>> sysc_syss_reset().
>>>
>>
>> Shouldn't the function I add be called sysc_syss_reset()? The reset
>> status bit is in the sysstatus.
> 
> Yes
> 

Great. I thought I completely misunderstood you. But I don't see what
adding another function will accomplish. A QUIRK flag used in the same
function would work well enough.

Regards,
Faiz
